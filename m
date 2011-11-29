From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Nov 2011 21:55:22 +0000
Subject: [PATCH 3/3] ARM: support syscall tracing
In-Reply-To: <CAK8d-a+o6A+E537o3i4JdzsXei2fbvqNcCLx_U8WyEMK-vL8Fg@mail.gmail.com>
References: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
 <1322584095-30439-4-git-send-email-stevenrwalter@gmail.com>
 <20111129174604.GL9581@n2100.arm.linux.org.uk>
 <CAK8d-a+o6A+E537o3i4JdzsXei2fbvqNcCLx_U8WyEMK-vL8Fg@mail.gmail.com>
Message-ID: <20111129215522.GN9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 01:12:50PM -0500, Steven Walter wrote:
> Yes, I like how the assembler counts the number of syscalls for you.
> However, every other architecture uses either a bare number or
> __NR_last_syscall+1 for defining NR_syscalls.
> 
> > You're also exporting it to userspace. ?It has no business being in
> > userspace.
> 
> That was unintentional, I'll fix.
> 
> > Lastly, it's wrong. ?__NR_SYSCALL_BASE may be 0 or 0x90000 depending on
> > the ABI selected. ?If it's 0x90000, will tracepoint stuff work or will it
> > explode because of a stupidly large table somewhere?
> 
> Right you are.  Didn't consider that.  Does that mean that
> syscall_get_nr() should return the offset from __NR_SYSCALL_BASE, so
> that it will be strictly less than NR_syscalls?

strace sees the 0x90000 offset today, so tracehook is going to be
compatible with our existing APIs, tracehook needs to keep seeing
that offset.

However, I suspect that's incompatible with tracehook as it stands
today - especially when we might be running a kernel with OABI compat
support enabled (which means you'll get 0x90000+ syscalls for OABI and
0+ syscalls for EABI.)

> > kernel/trace/trace_syscalls.c: ? ? ?for (i = 0; i < NR_syscalls; i++) {
> >
> > and
> >
> > kernel/trace/trace_syscalls.c:static DECLARE_BITMAP(enabled_perf_enter_syscalls, NR_syscalls);
> > kernel/trace/trace_syscalls.c:static DECLARE_BITMAP(enabled_perf_exit_syscalls,NR_syscalls);
> >
> > all point at this being very wrong.
> 
> Initially I was going to assign the assembler version of NR_syscalls
> to a symbol which could be referenced from C.  However, putting the C
> declaration for the variable in unistd.h made the assembler unhappy.
> Is it kosher to have C stuff in unistd.h?  Since there was no prior
> example of it, I assumed not.  However, perhaps I could just hide it
> from the assembler with some kind of #ifdef?

#ifndef __ASSEMBLY__

but, as I say, the number of syscalls which the kernel implements is
defined by the size of the table in calls.S, not by the list in
unistd.h.  We may allocate a number and put it in unistd.h to reserve
it before we have a final implementation.
