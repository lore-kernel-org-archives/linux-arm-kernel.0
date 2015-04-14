From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Apr 2015 15:47:02 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <17844053.vZiPCu4un3@wuerfel>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
 <AC03A80E-49F8-4A08-9DDA-0B9F8B734F51@theobroma-systems.com>
 <17844053.vZiPCu4un3@wuerfel>
Message-ID: <20150414144702.GD14546@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 12:08:11PM +0200, Arnd Bergmann wrote:
> On Tuesday 14 April 2015 11:33:13 Dr.  Philipp Tomsich wrote:
> > After getting a good night?s sleep, the ?reuse the existing system call table? comment
> > makes a little more sense as I construe it as having just one merged system call table
> > for both LP64 and ILP32 and handling the differences through a different system call
> > numbering in unistd.h towards LP64 and ILP32 processes.
> > 
> > If this is the intended implementation, I am not fully sold on the benefit: having a private
> > copy of unistd.h for ARM64 seems to be a less readable and less maintenance-friendly
> > solution to having separate tables.
> > 
> > We?re open to input on this and?if merging the system call tables is the consensus?
> > would like to get the change underway as soon as possible.
> 
> There are multiple ways of doing this:

It doesn't look like they are exclusive options. For example you can use
(a) together with (c) or (d). Some more comments below:

> a) separate syscall table for arm64: as you say, this is the current approach,
>    and I'd like to avoid that too

What is the problem with this option? Is it cache locality affected by
having another table? A syscall table currently stands at around 2KB. We
could halve it by storing relative offsets but I don't think we would
notice much performance improvement.

> b) add syscalls for ilp32 as additional numbers in the normal lp64 version of
>    asm-generic/unistd.h, and share the binary tables between ilp32 and lp64
>    on aarch64

Does this mean that an ILP32 task can still call LP64-only syscalls? How
many new syscalls are we looking at? Would these ILP32 numbers be
interspersed with the LP64 ones or some high values (say bit 12 set)?
The former isn't workable since may leave gaps on LP64 architectures.
The latter could work better if the ILP32 specific options are not
sparse.

> c) change asm-generic/unistd.h to generate three possible tables: instead of
>    just native (lp64 or ilp32 depending on the arch), compat (support for
>    existing ilp32 binaries on some architectures, there would also be a
>    "modern" ilp32 variant that is a mix of the two, as your table today

I don't fully understand this. It looks to me like we need to generate
at least the LP64 and native ILP32 unistd.h anyway if we go for option a
or possibly b.

> d) don't use the asm-generic/unistd.h table for aarch64-ilp32 at all, but instead
>    reuse the table from arch/arm64/include/asm/unistd32.h

IMO, (d) only makes sense if we treat ILP32 as a temporary solution
(a.k.a. hack) hoping that such applications will be eventually built for
LP64. If we treat native ILP32 as a real long term alternative to LP64,
I would rather use the asm-generic/unistd.h for syscalls. For example,
use 'openat' instead of 'open' on the native ILP32 (based on the
assumption that ILP32 is a long term alternative).

Unless we are aware of performance impact with (a), that's my preferred
option with some form of (b) next.

The above is mainly about syscall numbers and tables but the ABI goes
beyond this. And the key point is whether we go for an AArch32-like ABI
(32-bit time_t) or we try to define one close to LP64. If we go for an
AArch32-like ABI, we'll have to use the compat layer for some of
syscalls and assess how many of the asm/compat.h structures are
different from the generic ones (I wouldn't expect many).

> I mainly want to avoid accidentally creating new ABIs for syscalls and ioctls:
> we have many drivers that today use ioctls with data structures derived from
> '__kernel_ulong_t' in some form, often by including a timespec or time_t in
> their own data structures. These are almost all broken today, because the
> data structures are a mix of the aarch32 and aarch64 variants, while the
> ioctl() system call in ilp32 always uses the aarch32 format by default.
> 
> An example here would be 
> 
> struct cyclades_idle_stats {
>     __kernel_time_t in_use;     /* Time device has been in use (secs) */
>     __kernel_time_t recv_idle;  /* Time since last char received (secs) */
>     __kernel_time_t xmit_idle;  /* Time since last char transmitted (secs) */
>     unsigned long  recv_bytes;  /* Bytes received */
>     unsigned long  xmit_bytes;  /* Bytes transmitted */
>     unsigned long  overruns;    /* Input overruns */
>     unsigned long  frame_errs;  /* Input framing errors */
>     unsigned long  parity_errs; /* Input parity errors */
> };
> 
> for a random ancient driver. Introducing a third set of data structures
> and syscalls for aarch64-ilp32 means that any driver doing something like
> this needs to be modified to support existing user space source code.

That's indeed a problem as ILP32 doesn't look like any of the other
options (the siginfo structure is another case that doesn't fit in any
of the ABI as long as time_t is 64-bit).

> If we stick to the normal compat32 implementation for all data structures
> and syscalls, we can support all drivers that work with aarch32 emulation
> today, as well as any one that gains support later on a regular compat32
> architecture (x86, powerpc, sparc, mips, arm, tile, parisc, s390), and
> we don't have to watch all new ioctl interfaces that get added to the
> kernel. Note that this does not just impact ioctl, but also things like
> setsockopts and drivers that communicate with user space through a
> mmapped data structure.

I'm fine with this but I would limit this compat32 similarity to data
structures rather than syscall numbers. Why do we need to support some
old syscalls when we can easily use new variants (e.g. open vs openat)?

> Using that existing table would also make it much easier to add support
> for additional C libraries, which then just have to implement the ELF
> format, but could reuse the arm32 kernel interfaces.

The existing compat32 ABI is a bit limiting on a 64-bit architecture. I
think we should really take advantage of the 64-bit register width and
avoid splitting 64-bit arguments in two registers. At which point, we
need a separate table anyway.

> Finally, there is a certain set of security issues from each new syscall
> we introduce. With the aarch32 syscall table, we have a higher degree
> of reuse of existing code, so we won't introduce security bugs that
> are only in one of the two ilp32 ABIs (aarch32 and aarch64).

Note that the current aarch32 compat ABI assumes that the top 32-bit of
every register is either zeroed or preserved by the architecture on
exception entry. We know that an AArch32 application cannot access the
top 32-bit of an AArch64 register. With native ILP32 however this is no
longer the case (it is running in AArch64 mode). I can't immediately
think of a problem (information leak) but it needs to be reviewed.

> One notable downside of this is that all system calls have to pass 64-bit
> arguments (i.e. loff_t) in two registers instead of one, to match the
> aarch32 calling conventions, but that would be limited to a small part
> of the libc implementation that already does the same thing for arm32.

There is this downside but I'm still not convinced what the advantages
of sharing the compat32 table are (not talking about the data structures
though, I'm fine with sharing those).

-- 
Catalin
