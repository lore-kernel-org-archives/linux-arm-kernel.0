From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Feb 2015 18:17:35 +0000
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211192118.GC23507@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
 <20150211192118.GC23507@brightrain.aerifal.cx>
Message-ID: <20150212181735.GF25491@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 02:21:18PM -0500, Rich Felker wrote:
> On Wed, Feb 11, 2015 at 05:39:19PM +0000, Catalin Marinas wrote:
> > On Tue, Feb 10, 2015 at 06:13:02PM +0000, Rich Felker wrote:
> > > I don't know if this has been discussed on libc-alpha yet or not, but
> > > I think we need to open a discussion of how it relates to open glibc
> > > bug #16437, which presently applies only to x32 (ILP32 ABI on x86_64):
> > > 
> > > https://sourceware.org/bugzilla/show_bug.cgi?id=16437
> > 
> > I'm trying to understand the problem first. Quoting from the bug above
> > (which I guess is quoted form C11):
> > 
> > "The range and precision of times representable in clock_t and time_t
> > are implementation-defined. The timespec structure shall contain at
> > least the following members, in any order.
> > 
> >          time_t tv_sec; // whole seconds -- >= 0
> >          long   tv_nsec; // nanoseconds -- [0, 999999999]"
> > 
> > So changing time_t to 64-bit is fine on x32. The timespec struct
> > exported by the kernel always uses a long for tv_nsec. However, glibc uses
> > __syscall_slong_t which ends up as 64-bit for x32 (I guess it mirrors
> > the __kernel_long_t definition).
> > 
> > So w.r.t. C11, the exported kernel timespec looks fine. But I think the
> > x32 kernel support (and the current ILP32 patches) assume a native
> > struct timespec with tv_nsec as 64-bit.
> 
> The exported kernel timespec is not fine if long is defined as a
> 32-bit type, which it is for x32 and the proposed aarch64-ILP32 ABIs.

The exported kernel headers comply with POSIX as they use long for
tv_nsec. The exported headers can be used in user space and with an
ILP32 ABI, long is 32-bit. The problem is the syscall handler which uses
the same structure in kernel where long is 64-bit. But this doesn't
change the fact that the exported header was still correct from a user
perspective.

The solution (for new ports) could be similar to the other such
solutions in the compat layer. A kernel internal structure which is
binary-compatible with the ILP32 user one (as exported by the kernel):

struct ilp32_timespec_kernel_internal_only {
	__kernel_time_t	tv_sec;			/* seconds */
	int		tv_nsec;		/* nanoseconds */
};

and a syscall wrapper which converts between ilp32_timespec and timespec
(take compat_sys_clock_settime as an example).

If the user structure has some padding (and as I've read in this thread
it is allowed), it could be even easier for the kernel. The padding
could be 32-bit before or after tv_nsec, depending on endianness.

-- 
Catalin
