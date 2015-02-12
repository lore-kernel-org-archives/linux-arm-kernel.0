From: arnd@arndb.de (arnd at arndb.de)
Date: Thu, 12 Feb 2015 19:59:24 +0100 (CET)
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150212181735.GF25491@e104818-lin.cambridge.arm.com>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
 <20150211192118.GC23507@brightrain.aerifal.cx>
 <20150212181735.GF25491@e104818-lin.cambridge.arm.com>
Message-ID: <501530245.495972.1423767564997.JavaMail.open-xchange@oxbaltgw04.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Catalin Marinas <catalin.marinas@arm.com> hat am 12. Februar 2015 um 19:17
> geschrieben:
> On Wed, Feb 11, 2015 at 02:21:18PM -0500, Rich Felker wrote:
> > On Wed, Feb 11, 2015 at 05:39:19PM +0000, Catalin Marinas wrote:
> > > On Tue, Feb 10, 2015 at 06:13:02PM +0000, Rich Felker wrote:
> > > > I don't know if this has been discussed on libc-alpha yet or not, but
> > > > I think we need to open a discussion of how it relates to open glibc
> > > > bug #16437, which presently applies only to x32 (ILP32 ABI on x86_64):
> > > >
> > > > https://sourceware.org/bugzilla/show_bug.cgi?id=16437
> > >
> > > I'm trying to understand the problem first. Quoting from the bug above
> > > (which I guess is quoted form C11):
> > >
> > > "The range and precision of times representable in clock_t and time_t
> > > are implementation-defined. The timespec structure shall contain at
> > > least the following members, in any order.
> > >
> > > time_t tv_sec; // whole seconds -- >= 0
> > > long tv_nsec; // nanoseconds -- [0, 999999999]"
> > >
> > > So changing time_t to 64-bit is fine on x32. The timespec struct
> > > exported by the kernel always uses a long for tv_nsec. However, glibc uses
> > > __syscall_slong_t which ends up as 64-bit for x32 (I guess it mirrors
> > > the __kernel_long_t definition).
> > >
> > > So w.r.t. C11, the exported kernel timespec looks fine. But I think the
> > > x32 kernel support (and the current ILP32 patches) assume a native
> > > struct timespec with tv_nsec as 64-bit.
> >
> > The exported kernel timespec is not fine if long is defined as a
> > 32-bit type, which it is for x32 and the proposed aarch64-ILP32 ABIs.
>
> The exported kernel headers comply with POSIX as they use long for
> tv_nsec. The exported headers can be used in user space and with an
> ILP32 ABI, long is 32-bit. The problem is the syscall handler which uses
> the same structure in kernel where long is 64-bit. But this doesn't
> change the fact that the exported header was still correct from a user
> perspective.

This is not ILP32 specific really, we need to add the same set of syscalls
for all 32-bit systems, in addition to the existing ones that take
a 32-bit time_t.

> The solution (for new ports) could be similar to the other such
> solutions in the compat layer. A kernel internal structure which is
> binary-compatible with the ILP32 user one (as exported by the kernel):
>
> struct ilp32_timespec_kernel_internal_only {
> __kernel_time_t tv_sec; /* seconds */
> int tv_nsec; /* nanoseconds */
> };
>
> and a syscall wrapper which converts between ilp32_timespec and timespec
> (take compat_sys_clock_settime as an example).

We then have to to this on all architectures, and not call it ilp32_timespec,
but call it something else.

I would much prefer to only have two versions of each syscall that takes a
timespec rather than three versions, or having a version that behaves
differently based on the type of program calling it. On native 32-bit
systems, we should have the native syscall taking the 16-byte structure
(using long long __kernel_time64_t) along with the compatibility syscall
with a 8-byte structure for existing applications.

On 64-bit systems, the same syscall source can be used for the normal 16-byte
structure on native 64-bit tasks, ilp32 tasks (x32, aarch64-32), and future
compat32 (i386, aarch32, ...) tasks, while the syscall for the 8-byte structure
deals with legacy compat32 tasks that do not yet use __kernel_time64_t.

> If the user structure has some padding (and as I've read in this thread
> it is allowed), it could be even easier for the kernel. The padding
> could be 32-bit before or after tv_nsec, depending on endianness.

The problem as pointed out before is that if you do this, 32-bit tasks
need to have the padding word zeroed at some stage for data passed into
the kernel, while 64-bit tasks need to return an error if the upper half
of the tv_nsec word is nonzero, at least for interfaces that are documented
to do this.

This can be done either in the kernel or in the libc. In the kernel, it
comes down to a function like

int get_user_timespec64(struct timespec64 *ts, struct __kernel_timespec64 __user
*uts, bool task_32bit)
{
       struct __kernel_timespec64 input;

       if (copy_from_user(&input, uts, sizeof(input))
              return -EFAULT;

       ts->tv_sec = input.tv_sec;
       if (task_32bit)
               ts->tv_nsec = (int)input.tv_nsec;
       else
               ts->tv_nsec = input.tv_nsec;

       return 0;
}

with data types of

struct timespec64 {
       time64_t tv_sec;
       long tv_nsec;
};

struct __kernel_timespec64 {
       __kernel_time64_t tv_nsec;
#if (__BYTE_ORDER == __BIG_ENDIAN) && (__BITS_PER_LONG == 32)
       u32 __pad;     
#endif
       long tv_nsec;
#if (__BYTE_ORDER == __LITTLE_ENDIAN) && (__BITS_PER_LONG == 32)
       u32 __pad;
#endif
};

The data structure definition is a little bit fragile, as it depends on
user space not using the __BIT_ENDIAN symbol in a conflicting way. So
far we have managed to keep that outside of general purpose headers, but
it should at least blow up in an obvious way if it does, rather than
breaking silently.

I still think it's more practical to keep the zeroing in user space though.
In that case, we keep defining __kernel_timespec64 with a 'typedef long
long __kernel_snseconds_t', and it's up to the libc to either use
__kernel_timespec64 as its timespec, or to define a C11-compliant
timespec itself and zero out the bits before passing the data to the kernel.

     Arnd
