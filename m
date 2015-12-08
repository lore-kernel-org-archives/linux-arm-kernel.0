From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Dec 2015 17:27:29 +0000
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <56671214.30402@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-4-git-send-email-james.morse@arm.com>
 <20151207224805.GA20777@MBP.local> <20151208114321.GD19612@arm.com>
 <4EBA6141-5CFB-4CAC-97D2-26346AAA91F0@gmail.com>
 <56671214.30402@arm.com>
Message-ID: <20151208172729.GE27393@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 05:23:32PM +0000, James Morse wrote:
> On 08/12/15 16:02, Jungseok Lee wrote:
> > I've seen the following BUG log with CONFIG_DEBUG_SPINLOCK=y kernel.
> >  
> >  BUG: spinlock lockup suspected on CPU#1
> > 
> > Under that option, I cannot even complete a single kernel build successfully.
> > I hope I'm the only person to experience it. My Android machine is running
> > well for over 12 hours now with the below change.
> 
> I can't reproduce this, can you send me your .config file (off-list)? Do
> you have any other patches in your tree? What hardware are you using?

FWIW, I tried to reproduce it and hit something that looks slightly
different. Crash log below.

> > If I read the patches correctly, the dummy stack frame looks as follows.
> > 
> >   top ------------ <- irq_stack_ptr
> >       | dummy_lr |
> >       ------------
> >       |   x29    |
> >       ------------ <- new frame pointer (x29)
> >       |   x19    |
> >       ------------
> >       |   xzr    |
> >       ------------
> > 
> > So, we should refer to x19 in order to retrieve frame->sp. But, frame->sp is
> > xzr under the current implementation. I suspect this causes spinlock lockup.
> 
> This is the sort of place where it is too easy to make an off-by-one
> error, I will go through it all with the debugger again tomorrow.

Ok; I'll hold off pushing this into linux-next until we've worked out
what's going wrong.

> I'm not seeing this when testing on Juno. This would only affect the
> tracing code, are you running perf or ftrace at the same time?

I just set CONFIG_PROVE_LOCKING=y, but that likely turns on a bunch of
the tracing infrastructure.

Will

--->8

Unable to handle kernel paging request at virtual address 7fff6dd050
pgd = ffffffc0601de000
[7fff6dd050] *pgd=00000000f905b003, *pud=00000000f905b003, *pmd=00000000f90cd003, *pte=00a00009f52aabd3
Internal error: Oops: 9600000b [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 1365 Comm: networking Not tainted 4.4.0-rc3+ #1
Hardware name: ARM Juno development board (r0) (DT)
task: ffffffc0792be400 ti: ffffffc0790dc000 task.ti: ffffffc0790dc000
PC is at unwind_frame+0x74/0xa0
LR is at walk_stackframe+0x28/0x50
pc : [<ffffffc0000896bc>] lr : [<ffffffc000089710>] pstate: a00001c5
sp : ffffffc97fe5b8a0
x29: ffffffc97fe5b8a0 x28: ffffffc0792be400
x27: ffffffc000994000 x26: ffffffc000c0f000
x25: ffffffc0792beab0 x24: ffffffc0792beb00
x23: ffffffc000c18518 x22: ffffffc0016aa9a0
x21: ffffffc0000895a0 x20: ffffffc97fe5b8f8
x19: ffffffc97fe5b908 x18: 000000000000381b
x17: ffffffc0014b0130 x16: ffffffc00168f9d8
x15: 000000000000381a x14: ffffffc00136f8d8
x13: 0000000000000002 x12: 0000000000000000
x11: ffffffc975de1d00 x10: ffffffc001696000
x9 : 0000000000000000 x8 : 0000000000000001
x7 : ffffffc000bff8d8 x6 : 0000000000000000
x5 : 0000007fff6dced0 x4 : 0000007fff6dd060
x3 : 0000000000000000 x2 : 0000007fff6dd050
x1 : ffffffc97fe58060 x0 : ffffffc97fe5b908

Process networking (pid: 1365, stack limit = 0xffffffc0790dc020)
Stack: (0xffffffc97fe5b8a0 to 0xffffffc0790e0000)
Call trace:
[<ffffffc0000896bc>] unwind_frame+0x74/0xa0
[<ffffffc000089794>] save_stack_trace_tsk+0x5c/0xa8
[<ffffffc0000897f8>] save_stack_trace+0x18/0x20
[<ffffffc0000f9600>] save_trace+0x48/0x100
[<ffffffc0000fd690>] __lock_acquire+0x1bc8/0x1c48
[<ffffffc0000fdedc>] lock_acquire+0x4c/0x68
[<ffffffc00064f2b0>] _raw_spin_lock+0x40/0x58
[<ffffffc0001af9a8>] unfreeze_partials.isra.23+0x78/0x2c0
[<ffffffc0001afefc>] put_cpu_partial+0x16c/0x200
[<ffffffc0001b14c4>] __slab_free+0x2e4/0x430
[<ffffffc0001b1e1c>] kfree+0x1d4/0x1e8
[<ffffffc00013c9dc>] put_css_set_locked+0x114/0x168
[<ffffffc00013cd7c>] put_css_set+0xac/0xc0
[<ffffffc000143544>] cgroup_free+0x9c/0x108
[<ffffffc0000b41c0>] __put_task_struct+0x38/0x110
[<ffffffc0000b7b60>] delayed_put_task_struct+0x40/0x50
[<ffffffc000115d50>] rcu_process_callbacks+0x2f8/0x5f8
[<ffffffc0000bb0c4>] __do_softirq+0x13c/0x278
[<ffffffc0000860d4>] do_softirq_own_stack+0x84/0xc8
[<ffffffc0000bb3c0>] irq_exit+0xa0/0xd8
[<ffffffc000107b60>] __handle_domain_irq+0x60/0xb8
[<ffffffc0000824f0>] gic_handle_irq+0x58/0xa8
Exception stack(0x0000007fff6dc3e0 to 0x0000007fff6dc500)
c3e0: 0000007fff6dc420 000000558c8d6df8 000000558c8ed058 000000558c8ec000
c400: 0000000000000000 00000055c65b3105 00000055c65bed30 0000000000000000
c420: 0000007fff6dc440 000000558c8caef8 0000000000000000 0000007fff6dc47f
c440: 0000007fff6dc5f0 000000558c8cb3c4 0000000000000001 0000000000000000
c460: 0000000000000000 00000055c65b3105 00000055c65bed30 000000558c8d1b00
c480: 0000000000000000 0000000100000000 000000558c8ec548 00000055c65bed30
c4a0: 0000007fff6dc4b0 0000007fff6ddf82 0000007fff6dc7a8 0000000000000001
c4c0: 0000000000000000 0000000000000000 00000055c65b3105 00000055c65bed30
c4e0: 0000000000000000 00000055c65b77f8 000000558c8ec000 0000007fff6dc6c8
[<ffffffc000085b0c>] el0_irq_naked+0x4c/0x60
[<000000558c8d6d88>] 0x558c8d6d88
[<000000558c8d6df8>] 0x558c8d6df8
[<000000558c8caef8>] 0x558c8caef8
[<000000558c8cb3c4>] 0x558c8cb3c4
[<000000558c8ca2e4>] 0x558c8ca2e4
[<000000558c8ca2ac>] 0x558c8ca2ac
[<000000558c8ca924>] 0x558c8ca924
[<000000558c8cb5a0>] 0x558c8cb5a0
[<000000558c8ca2e4>] 0x558c8ca2e4
[<000000558c8cb738>] 0x558c8cb738
[<000000558c8ce92c>] 0x558c8ce92c
[<000000558c8ceb80>] 0x558c8ceb80
[<000000558c8cb1c0>] 0x558c8cb1c0
[<000000558c8ca2e4>] 0x558c8ca2e4
[<000000558c8ca2ac>] 0x558c8ca2ac
[<000000558c8ca3f0>] 0x558c8ca3f0
[<000000558c8ca3f0>] 0x558c8ca3f0
[<000000558c8ca52c>] 0x558c8ca52c
[<000000558c8ca2ac>] 0x558c8ca2ac
[<000000558c8d18b0>] 0x558c8d18b0
[<000000558c8c8604>] 0x558c8c8604
[<0000007f968fe9bc>] 0x7f968fe9bc
