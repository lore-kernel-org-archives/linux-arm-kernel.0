From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 17:44:07 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150414144702.GD14546@e104818-lin.cambridge.arm.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <17844053.vZiPCu4un3@wuerfel>
 <20150414144702.GD14546@e104818-lin.cambridge.arm.com>
Message-ID: <2485404.lBlHmzQPKN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 15:47:02 Catalin Marinas wrote:
> On Tue, Apr 14, 2015 at 12:08:11PM +0200, Arnd Bergmann wrote:
> > On Tuesday 14 April 2015 11:33:13 Dr.  Philipp Tomsich wrote:
> > > After getting a good night?s sleep, the ?reuse the existing system call table? comment
> > > makes a little more sense as I construe it as having just one merged system call table
> > > for both LP64 and ILP32 and handling the differences through a different system call
> > > numbering in unistd.h towards LP64 and ILP32 processes.
> > > 
> > > If this is the intended implementation, I am not fully sold on the benefit: having a private
> > > copy of unistd.h for ARM64 seems to be a less readable and less maintenance-friendly
> > > solution to having separate tables.
> > > 
> > > We?re open to input on this and?if merging the system call tables is the consensus?
> > > would like to get the change underway as soon as possible.
> > 
> > There are multiple ways of doing this:
> 
> It doesn't look like they are exclusive options. For example you can use
> (a) together with (c) or (d). Some more comments below:

I meant them to be exclusive, but you are right that the list
was not complete, and it's possible to interpret it different
from what I had in mind.

> > a) separate syscall table for arm64: as you say, this is the current approach,
> >    and I'd like to avoid that too
> 
> What is the problem with this option? Is it cache locality affected by
> having another table? A syscall table currently stands at around 2KB. We
> could halve it by storing relative offsets but I don't think we would
> notice much performance improvement.

No, I'm not worried about performance here, the main differences to b) and c)
here is that you have to maintain this list, and potentially duplicate it
for new 64-bit architectures coming in (x86, mips etc already have separate
copies, so that ship has sailed). I'd rather see that table being maintained
in asm-generic as architecture independent code than in arch/arm64.

The much bigger problem of data structures that are incompatible with both
existing ABIs is shared with approach b and c.

> > b) add syscalls for ilp32 as additional numbers in the normal lp64 version of
> >    asm-generic/unistd.h, and share the binary tables between ilp32 and lp64
> >    on aarch64
> 
> Does this mean that an ILP32 task can still call LP64-only syscalls? How
> many new syscalls are we looking at? Would these ILP32 numbers be
> interspersed with the LP64 ones or some high values (say bit 12 set)?
> The former isn't workable since may leave gaps on LP64 architectures.
> The latter could work better if the ILP32 specific options are not
> sparse.

This would be the same list that patch 19/24 of this series adds, 32
system calls in total, possibly a few more getting added over the
years.

> > c) change asm-generic/unistd.h to generate three possible tables: instead of
> >    just native (lp64 or ilp32 depending on the arch), compat (support for
> >    existing ilp32 binaries on some architectures, there would also be a
> >    "modern" ilp32 variant that is a mix of the two, as your table today
> 
> I don't fully understand this. It looks to me like we need to generate
> at least the LP64 and native ILP32 unistd.h anyway if we go for option a
> or possibly b.

With option b), we'd generate one table from asm-generic/unistd.h and
another one from asm/unistd32.h, as we do today. The first would be
shared between both aarch64 ABIs (and extended with 32 new calls) while
the second continues unmodified.

With option c), we'd use the asm-generic/unistd.h source to generate
two independent tables, similar to what we do in
arch/tile/kernel/{sys,compat}.c, and the first table would be the same
as it is today.

> > d) don't use the asm-generic/unistd.h table for aarch64-ilp32 at all, but instead
> >    reuse the table from arch/arm64/include/asm/unistd32.h
> 
> IMO, (d) only makes sense if we treat ILP32 as a temporary solution
> (a.k.a. hack) hoping that such applications will be eventually built for
> LP64. If we treat native ILP32 as a real long term alternative to LP64,
> I would rather use the asm-generic/unistd.h for syscalls. For example,
> use 'openat' instead of 'open' on the native ILP32 (based on the
> assumption that ILP32 is a long term alternative).
> 
> Unless we are aware of performance impact with (a), that's my preferred
> option with some form of (b) next.

Ok, let's call that option

e) Use the existing aarch32 data structures with the asm-generic/unistd.h
system call numbers.

This would solve the main problem of the data structures just like option
d), and the main user-visible change would be that the syscall numbers
are shifted compared to aarch32, which is a very minor aspect. We could
also deal with the ucontext better this way than what I suggested.

> The above is mainly about syscall numbers and tables but the ABI goes
> beyond this. And the key point is whether we go for an AArch32-like ABI
> (32-bit time_t) or we try to define one close to LP64. If we go for an
> AArch32-like ABI, we'll have to use the compat layer for some of
> syscalls and assess how many of the asm/compat.h structures are
> different from the generic ones (I wouldn't expect many).

It would be wildly different from the generic data structures, since we
can only use the compat code if the implementation is the same as on
aarch32. Essentially we have to define the headers so that all native
data structures match what is in arch/arm64/include/asm/compat.h,
which in turn is largely the same as arch/arm/include/uapi/asm/*.h.

Exceptions to this are asm/ptrace.h and asm/ucontext.h, which cannot
be shared.

> > If we stick to the normal compat32 implementation for all data structures
> > and syscalls, we can support all drivers that work with aarch32 emulation
> > today, as well as any one that gains support later on a regular compat32
> > architecture (x86, powerpc, sparc, mips, arm, tile, parisc, s390), and
> > we don't have to watch all new ioctl interfaces that get added to the
> > kernel. Note that this does not just impact ioctl, but also things like
> > setsockopts and drivers that communicate with user space through a
> > mmapped data structure.
> 
> I'm fine with this but I would limit this compat32 similarity to data
> structures rather than syscall numbers. Why do we need to support some
> old syscalls when we can easily use new variants (e.g. open vs openat)?

Fair enough.

> > Using that existing table would also make it much easier to add support
> > for additional C libraries, which then just have to implement the ELF
> > format, but could reuse the arm32 kernel interfaces.
> 
> The existing compat32 ABI is a bit limiting on a 64-bit architecture. I
> think we should really take advantage of the 64-bit register width and
> avoid splitting 64-bit arguments in two registers. At which point, we
> need a separate table anyway.

As mentioned, this concerns only 8 system calls in total, but I agree
that if we use the asm-generic syscall list, this would be the natural
choice.

> > Finally, there is a certain set of security issues from each new syscall
> > we introduce. With the aarch32 syscall table, we have a higher degree
> > of reuse of existing code, so we won't introduce security bugs that
> > are only in one of the two ilp32 ABIs (aarch32 and aarch64).
> 
> Note that the current aarch32 compat ABI assumes that the top 32-bit of
> every register is either zeroed or preserved by the architecture on
> exception entry. We know that an AArch32 application cannot access the
> top 32-bit of an AArch64 register. With native ILP32 however this is no
> longer the case (it is running in AArch64 mode). I can't immediately
> think of a problem (information leak) but it needs to be reviewed.

Hmm, interesting point. I'd have to think about this a bit more, but
I believe it is already solved:

- For input arguments, we have the COMPAT_SYSCALL_DEFINE wrappers that
  are meant to deal with this problem.
- For output arguments, the kernel controls the register contents,
  and I don't see a way that the function return value could leak
  data in the upper bits. All syscall return 'long', so it should
  be well-defined.

> > One notable downside of this is that all system calls have to pass 64-bit
> > arguments (i.e. loff_t) in two registers instead of one, to match the
> > aarch32 calling conventions, but that would be limited to a small part
> > of the libc implementation that already does the same thing for arm32.
> 
> There is this downside but I'm still not convinced what the advantages
> of sharing the compat32 table are (not talking about the data structures
> though, I'm fine with sharing those).

Ok

	Arnd
