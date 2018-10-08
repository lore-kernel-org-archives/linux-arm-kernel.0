From: evgsyr@gmail.com (Eugene Syromyatnikov)
Date: Mon, 8 Oct 2018 09:11:49 +0200
Subject: ARM: Call syscall_trace_exit even when system call skipped
In-Reply-To: <20180929230337.GA3640@obsidian>
References: <20180203152112.2449-1-T.E.Baldwin99@members.leeds.ac.uk>
 <20180313235850.GA18373@altlinux.org>
 <CAGXu5jKY+uqi53YPhuptwb72zm=mpAaZ1YgCHN7BAGgXWyvqbw@mail.gmail.com>
 <162293d1df0.2772.8578bc6afb023d3c4d0bd68fb35b28aa@members.leeds.ac.uk>
 <CAGXu5jKVQu9BrL6S9XY_qpNqZOPmie7e=EEXcsJB9eX9wvs+kQ@mail.gmail.com>
 <20180929230337.GA3640@obsidian>
Message-ID: <CACGkJdt0CteRK84U9Qp0hCOxhOwHTmbkuDstxmVaAaPMedyHiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2018 at 1:03 AM Eugene Syromyatnikov <evgsyr@gmail.com> wrote:
>
> On Thu, Mar 15, 2018 at 01:14:31PM -0700, Kees Cook wrote:
> > On Thu, Mar 15, 2018 at 3:38 AM,  <T.E.Baldwin99@members.leeds.ac.uk> wrote:
> > > On 15 March 2018 00:45:01 Kees Cook <keescook@chromium.org> wrote:
> > >
> > >>>> --- a/arch/arm/kernel/entry-common.S
> > >>>> +++ b/arch/arm/kernel/entry-common.S
> > >>>> @@ -288,16 +288,15 @@ __sys_trace:
> > >>>>       cmp     scno, #-1                       @ skip the syscall?
> > >>>>       bne     2b
> > >>>>       add     sp, sp, #S_OFF                  @ restore stack
> > >>>> -     b       ret_slow_syscall
> > >>>>
> > >>>> -__sys_trace_return:
> > >>>> -     str     r0, [sp, #S_R0 + S_OFF]!        @ save returned r0
> > >>>> +__sys_trace_return_nosave:
> > >>>> +     enable_irq_notrace
> > >>
> > >>
> > >> Why is __sys_trace_return_nosave the correct destination here? The
> > >> original handle set up for lr a few lines above is for
> > >> __sys_trace_return. It's not clear to me why this change is made?
> > >
> > >
> > > __sys_trace_return stores the current r0 value on the stack which will
> > > reloaded on exit to user mode. However if skipping a system call r0 is -1
> > > and storing it would destroy the users r0 value, unlike the case where the
> > > system call is made and r0 is the return value.
> > >
> > > The enabling of interrupts is redundant for this purpose, the reuse of code
> > > is a size optimization.
> >
> > Ah right. Cool, thanks!
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Tested-by: Kees Cook <keescook@chromium.org>
>
> Tested-by: Eugene Syromyatnikov <evgsyr@gmail.com>

Hello, is anything else required regarding this patch? Thanks.

> Have checked the patch on an Orange Pi Zero board (Allwinner sun8i),
> kernel 4.14.73-sunxi armv7l (Armbian).
>
> Before the change, seccomp_ret_trap test from ldv/SECCOMP_RET_TRAP strace branch
> was failing with incorrect decoding of the second chdir() call:
>
> ---8<---
> FAIL: seccomp_ret_trap.gen
> ==========================
>
> --- .././seccomp_ret_trap.expected      2018-09-29 20:16:27.675951746 +0000
> +++ log 2018-09-29 21:09:49.669414847 +0000
> @@ -1,3 +1,3 @@
>  chdir(".") = 0
> -chdir("./") = 0
> +chdir(NULL) = 0
>  +++ exited with 0 +++
> seccomp_ret_trap.gen.test: failed test: ../../strace -a11 -esignal=none -echdir
> ../seccomp_ret_trap output mismatch
> FAIL seccomp_ret_trap.gen.test (exit status: 1)
> --->8---
>
> After the change, test passes and chdir() call after the filtered nanosleep()
> call is decoded correctly:
>
> ---8<---
> $ ./strace -echdir,nanosleep,exit_group tests/seccomp_ret_trap
> chdir(".")                              = 0
> nanosleep({tv_sec=0, tv_nsec=0}, NULL)  = 5143188
> --- SIGSYS {si_signo=SIGSYS, si_code=SYS_SECCOMP, si_call_addr=0xb6f6df42,
> si_syscall=__NR_nanosleep, si_arch=AUDIT_ARCH_ARM} ---
> chdir("./")                             = 0
> exit_group(0)                           = ?
> +++ exited with 0 +++
> --->8---
>
> > I assume Dmitry can add a Tested-by too?
> >
> > This seems good to go into the ARM patch tracker...
> >
> > -Kees
> >
> > --
> > Kees Cook
> > Pixel Security



-- 
Eugene Syromyatnikov
mailto:evgsyr at gmail.com
xmpp:esyr at jabber.{ru|org}
