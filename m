From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Feb 2015 17:33:46 +0000
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150213163013.GE23507@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
 <20150211192118.GC23507@brightrain.aerifal.cx>
 <20150212181735.GF25491@e104818-lin.cambridge.arm.com>
 <501530245.495972.1423767564997.JavaMail.open-xchange@oxbaltgw04.schlund.de>
 <20150213133355.GD3508@e104818-lin.cambridge.arm.com>
 <20150213163013.GE23507@brightrain.aerifal.cx>
Message-ID: <20150213173345.GA26217@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 11:30:13AM -0500, Rich Felker wrote:
> On Fri, Feb 13, 2015 at 01:33:56PM +0000, Catalin Marinas wrote:
> > On Thu, Feb 12, 2015 at 07:59:24PM +0100, Arnd Bergmann wrote:
> > > Catalin Marinas <catalin.marinas@arm.com> hat am 12. Februar 2015 um 19:17
> > > geschrieben:
> > > > The solution (for new ports) could be similar to the other such
> > > > solutions in the compat layer. A kernel internal structure which is
> > > > binary-compatible with the ILP32 user one (as exported by the kernel):
> > > >
> > > > struct ilp32_timespec_kernel_internal_only {
> > > > __kernel_time_t tv_sec; /* seconds */
> > > > int tv_nsec; /* nanoseconds */
> > > > };
> > > >
> > > > and a syscall wrapper which converts between ilp32_timespec and timespec
> > > > (take compat_sys_clock_settime as an example).
> > > 
> > > We then have to to this on all architectures, and not call it ilp32_timespec,
> > > but call it something else.
> > > 
> > > I would much prefer to only have two versions of each syscall that takes a
> > > timespec rather than three versions, or having a version that behaves
> > > differently based on the type of program calling it. On native 32-bit
> > > systems, we should have the native syscall taking the 16-byte structure
> > > (using long long __kernel_time64_t)
> > 
> > Can this also be 12 bytes in general if tv_nsec stays as 32-bit? The
> > size of such structure would be 16 bytes on ARM but I guess this depends
> > on long long the alignment requirements on specific architectures.
> 
> The only archs with modern relevance I'm aware of where 64-bit types
> are not aligned are i386 and, by a regretable but hard-to-fix mistake,
> or1k. I don't have much opinion on whether the 64-bit-time_t timespec
> should be 12 bytes or 16 bytes on such archs. From my perspective it's
> a new ABI anyway so I'd like to be able to fix the 64-bit alignment
> issue at the same time, in which case the question would go away, but
> I'm sure others (glibc) will prefer a more transitional approach with
> symbol versioning or feature test macros or something.

The good thing about 16-byte timespec64 with appropriate (endianness
aware) struct padding is that the kernel can write tv_nsec to user as a
64-bit value (long on a 64-bit kernel). It's only the reading from user
that the 32-bit needs to be sign-extended into the kernel structure.

> > > In the kernel, it comes down to a function like
> > > 
> > > int get_user_timespec64(struct timespec64 *ts, struct __kernel_timespec64 __user
> > > *uts, bool task_32bit)
> > > {
> > >        struct __kernel_timespec64 input;
> > > 
> > >        if (copy_from_user(&input, uts, sizeof(input))
> > >               return -EFAULT;
> > > 
> > >        ts->tv_sec = input.tv_sec;
> > >        if (task_32bit)
> > >                ts->tv_nsec = (int)input.tv_nsec;
> > >        else
> > >                ts->tv_nsec = input.tv_nsec;
> > > 
> > >        return 0;
> > > }
> > 
> > The only drawback is that native 64-bit and new 32-bit have the same
> > handling path, potentially slowing down the former (it may not be
> > noticeable).
> 
> Offhand, I would not consider a single predictable branch on syscall
> entry or return to be noticable relative to general syscall overhead.

It's not just a check+branch but accessing some TIF flag which requires
reading the current_thread_info()->flags and testing it. It is probably
lost in the noise, unless you do such calls in loop where you may notice
a slight variation (it depends on the branch predictor as well; on some
architecture we may be able to make use of unlikely(task_32bit)).

> > > The data structure definition is a little bit fragile, as it depends on
> > > user space not using the __BIT_ENDIAN symbol in a conflicting way. So
> > > far we have managed to keep that outside of general purpose headers, but
> > > it should at least blow up in an obvious way if it does, rather than
> > > breaking silently.
> > > 
> > > I still think it's more practical to keep the zeroing in user space though.
> > > In that case, we keep defining __kernel_timespec64 with a 'typedef long
> > > long __kernel_snseconds_t', and it's up to the libc to either use
> > > __kernel_timespec64 as its timespec, or to define a C11-compliant
> > > timespec itself and zero out the bits before passing the data to the kernel.
> > 
> > The problem with doing this in user space is syscall(2). If we don't
> > allow it, then it's fine to do the padding in libc.
> 
> It's already the case that callers have to tiptoe around syscall(2)
> usage on a per-arch basis for silly things like the convention for
> passing 64-bit arguments on 32-bit archs, different arg orders to work
> around 64-bit alignment and issues with too many args, and various
> legacy issues. So I think manual use of syscall(2) is a less-critical
> issue, though of course from a libc perspective I would very much like
> for the kernel to handle it right.

I think there is another problem with sign-extending tv_nsec in libc.
The prototype for functions like clock_settime(2) take a const struct
timespec *. There isn't anything to prevent such structure being in a
read-only section, even though it is unlikely. So libc would have to
duplicate the structure rather than just sign-extending tv_nsec in
place.

BTW, I'll be offline for a week (holiday) and I won't be able to follow
up on this thread.

-- 
Catalin
