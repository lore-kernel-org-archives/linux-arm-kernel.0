From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Apr 2015 17:55:00 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <9F7FC15C-EED1-4939-B66A-1BC3119E0D9C@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
 <AC03A80E-49F8-4A08-9DDA-0B9F8B734F51@theobroma-systems.com>
 <17844053.vZiPCu4un3@wuerfel>
 <20150414144702.GD14546@e104818-lin.cambridge.arm.com>
 <9F7FC15C-EED1-4939-B66A-1BC3119E0D9C@theobroma-systems.com>
Message-ID: <20150414165459.GG14546@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 05:29:36PM +0200, Dr. Philipp Tomsich wrote:
> > On 14 Apr 2015, at 16:47, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> I mainly want to avoid accidentally creating new ABIs for syscalls and ioctls:
> >> we have many drivers that today use ioctls with data structures derived from
> >> '__kernel_ulong_t' in some form, often by including a timespec or time_t in
> >> their own data structures. These are almost all broken today, because the
> >> data structures are a mix of the aarch32 and aarch64 variants, while the
> >> ioctl() system call in ilp32 always uses the aarch32 format by default.
> >> 
> >> An example here would be 
> >> 
> >> struct cyclades_idle_stats {
> >>    __kernel_time_t in_use;     /* Time device has been in use (secs) */
> >>    __kernel_time_t recv_idle;  /* Time since last char received (secs) */
> >>    __kernel_time_t xmit_idle;  /* Time since last char transmitted (secs) */
> >>    unsigned long  recv_bytes;  /* Bytes received */
> >>    unsigned long  xmit_bytes;  /* Bytes transmitted */
> >>    unsigned long  overruns;    /* Input overruns */
> >>    unsigned long  frame_errs;  /* Input framing errors */
> >>    unsigned long  parity_errs; /* Input parity errors */
> >> };
> >> 
> >> for a random ancient driver. Introducing a third set of data structures
> >> and syscalls for aarch64-ilp32 means that any driver doing something like
> >> this needs to be modified to support existing user space source code.
> > 
> > That's indeed a problem as ILP32 doesn't look like any of the other
> > options (the siginfo structure is another case that doesn't fit in any
> > of the ABI as long as time_t is 64-bit).
> 
> I believe we?ve already arrived at the conclusion that timespec needs to be
> changed from what Andrew and I had submitted. 
> 
> Let?s go back to the underlying definition of timespec:
> 	"The range and precision of times representable in clock_t and time_t are 
> 	implementation-defined. The timespec structure shall contain at least the
> 	 following members, in any order.
> 
> 	         time_t tv_sec; // whole seconds -- >= 0
> 	         long   tv_nsec; // nanoseconds -- [0, 999999999]?
> 
> So tv_nsec needs to be 32bit on ILP32, as we would otherwise break the C
> language.  Any program that assumes that tv_nsec is sizeof(long) would be
> correct and it would be unexpected and surprising behaviour [even though it
> would be consider a good programming style] if one would need to explicitly 
> ask for the sizeof(ts.tv_nsec). Having the same problem on x32 doesn?t seem 
> like a good justification to do the same.

>From a standards perspective, that's clear, and I'm fine with not making
the same choice as x32. I think on x32 it was a side-effect of glibc
defining tv_nsec as __syscall_slong_t and the kernel defining
__kernel_long_t to 64-bit.

> For time_t, I don?t see the need to have a 32bit type yet.
> As long as the the type is properly exposed through header files (and user
> programs can thus recreate the kernel?s data model), we should be safe.

The problem with a 64-bit time_t is that the timespec structure looks
like neither compat32 nor native 64-bit. If we make the AArch32 and
native ILP32 exclusive and build time, it makes it easier, otherwise we
need to support a third ABI in the kernel.

> The key to any design decision should be that we 
>  (a) don?t break C11, POSIX or the Single UNIX Specification
>  (b) remain true to the definitions from the the AArch64 ILP32 ELF ABI 
> 	(which defines	64bit values transferable in registers to callees)

I think these are fine.

> Can we thus agree on the following for the next revision of the patch-set:
>  (1) We retain a 64bit time_t, but implement different sizes (between ILP32 and 
> 	LP64) for ?tv_nsec' in 'struct timespec??
>  (2) We use the 64bit system calls whereever possible (i.e. no register splitting).

As I mentioned above, timespec and possibly other structures no longer
like any of the existing ABIs. Do we know how many syscalls are
affected?

The alternative is 32-bit time_t which makes it easier to use the compat
syscall implementations (not numbers). It also depends on how we plan to
fix the 2038 problem. For new 32-bit only architectures, are we going to
require them to use a 64-bit time_t or we get alternative time64_t and
timespec64 specs?

-- 
Catalin
