From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 12:08:11 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <AC03A80E-49F8-4A08-9DDA-0B9F8B734F51@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
 <AC03A80E-49F8-4A08-9DDA-0B9F8B734F51@theobroma-systems.com>
Message-ID: <17844053.vZiPCu4un3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 11:33:13 Dr.  Philipp Tomsich wrote:
> Arnd,
> 
> After getting a good night?s sleep, the ?reuse the existing system call table? comment
> makes a little more sense as I construe it as having just one merged system call table
> for both LP64 and ILP32 and handling the differences through a different system call
> numbering in unistd.h towards LP64 and ILP32 processes.
> 
> If this is the intended implementation, I am not fully sold on the benefit: having a private
> copy of unistd.h for ARM64 seems to be a less readable and less maintenance-friendly
> solution to having separate tables.
> 
> We?re open to input on this and?if merging the system call tables is the consensus?
> would like to get the change underway as soon as possible.

There are multiple ways of doing this:

a) separate syscall table for arm64: as you say, this is the current approach,
   and I'd like to avoid that too
b) add syscalls for ilp32 as additional numbers in the normal lp64 version of
   asm-generic/unistd.h, and share the binary tables between ilp32 and lp64
   on aarch64
c) change asm-generic/unistd.h to generate three possible tables: instead of
   just native (lp64 or ilp32 depending on the arch), compat (support for
   existing ilp32 binaries on some architectures, there would also be a
   "modern" ilp32 variant that is a mix of the two, as your table today
d) don't use the asm-generic/unistd.h table for aarch64-ilp32 at all, but instead
   reuse the table from arch/arm64/include/asm/unistd32.h

I think you are referring to approach b) or c) above, but my preferred one
would actually be d).

> > On 14 Apr 2015, at 00:58, Dr. Philipp Tomsich <philipp.tomsich@theobroma-systems.com> wrote:
> > 
> >> 2. The ABI follows what x86 has their "x32" ABI. This never saw a lot of
> >> adoption and in retrospect the decision to have separate system calls seems
> >> to not have helped them. My feeling now is that if we add support for the
> >> ARM64 ILP32 ELF ABI, we should better stick to the existing system call ABI
> >> as close as possible and reuse the existing system call table. I realize
> >> that this is a bit controversial, but please let's talk about this now.
> > 
> > I see benefits and drawback to merging the system tables.  Our philosophy is
> > already somewhat different from x32 and from the original patch-series, as you
> > can see from the changes dealing with stack_t in the ?sys_rt_sigreturn' and 
> > ?setup_rt_frame? functions.  While these could have been duplicated and 
> > specialized for each ABI (as on x32), the attempt was made to keep these 
> > changes localized.
> > 
> > However, this approach can not always work: if you consider cases like 
> > ?sys_msgsnd? and ?compat_sys_msgsnd?, there?s little to no benefit in having
> > just a ?aarch64_sys_msgsnd?, which then calls either the LP64 or the compat
> > version of the underlying system call.  Having a second system call table 
> > helps to reduce the overheads in this case and keeps things readable.
> > 
> > This comes down to the fact, that a few calls will always be different due to
> > historical baggage in data structures shared between userspace and kernel:
> > 'struct msgbuf? immediatly comes to mind.
> > 
> > I would liken the situation with ARM64 more of MIPS64 with its 64bit ABI and 
> > its n32 ABI than to x32? but even there it?s two separate system call tables
> > (although sequentially concatenated).
> > 
> > In other words: I fail to see the benefit from keeping the existing table.
> > I you elaborate on how such a solution should look, I might be better able
> > to follow. 

I mainly want to avoid accidentally creating new ABIs for syscalls and ioctls:
we have many drivers that today use ioctls with data structures derived from
'__kernel_ulong_t' in some form, often by including a timespec or time_t in
their own data structures. These are almost all broken today, because the
data structures are a mix of the aarch32 and aarch64 variants, while the
ioctl() system call in ilp32 always uses the aarch32 format by default.

An example here would be 

struct cyclades_idle_stats {
    __kernel_time_t in_use;     /* Time device has been in use (secs) */
    __kernel_time_t recv_idle;  /* Time since last char received (secs) */
    __kernel_time_t xmit_idle;  /* Time since last char transmitted (secs) */
    unsigned long  recv_bytes;  /* Bytes received */
    unsigned long  xmit_bytes;  /* Bytes transmitted */
    unsigned long  overruns;    /* Input overruns */
    unsigned long  frame_errs;  /* Input framing errors */
    unsigned long  parity_errs; /* Input parity errors */
};

for a random ancient driver. Introducing a third set of data structures
and syscalls for aarch64-ilp32 means that any driver doing something like
this needs to be modified to support existing user space source code.

If we stick to the normal compat32 implementation for all data structures
and syscalls, we can support all drivers that work with aarch32 emulation
today, as well as any one that gains support later on a regular compat32
architecture (x86, powerpc, sparc, mips, arm, tile, parisc, s390), and
we don't have to watch all new ioctl interfaces that get added to the
kernel. Note that this does not just impact ioctl, but also things like
setsockopts and drivers that communicate with user space through a
mmapped data structure.

Using that existing table would also make it much easier to add support
for additional C libraries, which then just have to implement the ELF
format, but could reuse the arm32 kernel interfaces.

Finally, there is a certain set of security issues from each new syscall
we introduce. With the aarch32 syscall table, we have a higher degree
of reuse of existing code, so we won't introduce security bugs that
are only in one of the two ilp32 ABIs (aarch32 and aarch64).

One notable downside of this is that all system calls have to pass 64-bit
arguments (i.e. loff_t) in two registers instead of one, to match the
aarch32 calling conventions, but that would be limited to a small part
of the libc implementation that already does the same thing for arm32.

	Arnd
