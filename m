From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 14:42:43 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <9F7FC15C-EED1-4939-B66A-1BC3119E0D9C@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <20150414144702.GD14546@e104818-lin.cambridge.arm.com>
 <9F7FC15C-EED1-4939-B66A-1BC3119E0D9C@theobroma-systems.com>
Message-ID: <12636371.MavevVFsON@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 17:29:36 Dr. Philipp Tomsich wrote:
> 
> > On 14 Apr 2015, at 16:47, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
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

I don't think assuming that people who don't write 64-bit safe code
write code that follows C11 is realistic ;-)

A lot more code is broken by having a 64-bit time_t than would be
broken by making tv_nsec 64-bit.

> For time_t, I don?t see the need to have a 32bit type yet.
> As long as the the type is properly exposed through header files (and user
> programs can thus recreate the kernel?s data model), we should be safe.
> 
> Cases like the above data structure from an ioctl are clearly non-portable
> and would break today on any architecture that supports ABIs with different
> data models (say ILP32 and LP64)? so I would consider any attempt to
> support this as trying to remain ?bug-compatible?.  
> 
> There are plenty of good examples in the uapi that will be nicely portable 
> between ILP32 and LP64. Let?s take aio_abi.h (I?ve intentionally chosen this,
> as the userspace library libaio uses a broken redefinition instead of the 
> kernel header file) as an example:
> > /*
> > ...

structures that done in modern times by competent developers should all
be the same across the three ABIs, no need to worry about that.
The only worrying part is drivers that are written in an incompatible
form for whatever reason. These have become rarer in the recent years,
but we still see new ones getting merged, e.g. the Android binder.

> The key to any design decision should be that we 
>  (a) don?t break C11, POSIX or the Single UNIX Specification
>  (b) remain true to the definitions from the the AArch64 ILP32 ELF ABI 
> 	(which defines	64bit values transferable in registers to callees)

These are nice goals, but I don't think they primary objectives.
Getting things to work is much more important, and the timespec
definition among other things may end up not being standards compliant
in order to get there.

> Can we thus agree on the following for the next revision of the patch-set:
>  (1) We retain a 64bit time_t, but implement different sizes (between ILP32 and 
> 	LP64) for ?tv_nsec' in 'struct timespec??

I have a plan for addressing that, but it will likely take another year
before we can get consensus on the timespec layout for 64-bit time_t.
At the moment, it looks like the 64/64 layout has more support than the
64/pad/32 layout you are describing. Let's not rush this for aarch64
when there is a chance that we end up with a different layout on
native 32-bit machines.

>  (2) We use the 64bit system calls whereever possible (i.e. no register splitting).

I'm fine with using 64-bit registers for passing loff_t if we use the
asm-generic/unistd.h system call numbers.

	Arnd
