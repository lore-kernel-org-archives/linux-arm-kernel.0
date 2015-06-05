From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Jun 2015 16:38:16 +0100
Subject: [PATCH] arm64: fix missing syscall trace exit
In-Reply-To: <5570DCA4.3050600@redhat.com>
References: <20150601102448.GG1641@arm.com>
 <1433293304-26539-1-git-send-email-jistone@redhat.com>
 <556E5454.9080400@redhat.com>
 <20150604100625.GI7557@n2100.arm.linux.org.uk>
 <55708783.2090909@redhat.com> <5570DCA4.3050600@redhat.com>
Message-ID: <20150605153816.GG7420@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 05, 2015 at 12:17:56AM +0100, Josh Stone wrote:
> Still, I don't think it's right to trace with interrupts disabled, so
> here's a version which enables them again first.  How does this look?
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 959fe87..988bea4 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -608,11 +608,16 @@ ENDPROC(cpu_switch_to)
>   */
>  ret_fast_syscall:
>         disable_irq                             // disable interrupts
> -       ldr     x1, [tsk, #TI_FLAGS]
> +       ldr     x1, [tsk, #TI_FLAGS]            // re-check for syscall tracing
> +       and     x2, x1, #_TIF_SYSCALL_WORK
> +       cbnz    x2, ret_fast_syscall_trace
>         and     x2, x1, #_TIF_WORK_MASK
>         cbnz    x2, fast_work_pending
>         enable_step_tsk x1, x2
>         kernel_exit 0, ret = 1
> +ret_fast_syscall_trace:
> +       enable_irq                              // enable interrupts
> +       b       __sys_trace_return
>  
>  /*
>   * Ok, we need to do extra processing, enter the slow path.

Looks good to me. Can you post as a stand-alone patch, with commit message
etc please?

> Off topic, here's the xgbe_tx_timer BUG.  As I mentioned, this happens
> even on a vanilla kernel, before I've run any of my tests.  I think this
> is a legitimate bug to call disable_irq() from a softirq timer.

Adding Tom, as he maintains the AMD xgbe driver (assuming that's what is
exploding here). I'm guessing you need s/disable_irq/disable_irq_nosync/.

Will

>   disable_irq -> synchronize_irq -> wait_event -> might_sleep
> 
> [   19.841911] BUG: sleeping function called from invalid context at kernel/irq/manage.c:110
> [   19.850081] in_atomic(): 1, irqs_disabled(): 0, pid: 1133, name: sed
> [   19.856434] INFO: lockdep is turned off.
> [   19.860349] CPU: 3 PID: 1133 Comm: sed Tainted: G        W       4.1.0-rc6-orig+ #5
> [   19.867999] Hardware name: Default string Default string/Default string, BIOS ROD0080B 03/18/2015
> [   19.876865] Call trace:
> [   19.879306] [<fffffe0000096e08>] dump_backtrace+0x0/0x16c
> [   19.884702] [<fffffe0000096f84>] show_stack+0x10/0x1c
> [   19.889746] [<fffffe000071408c>] dump_stack+0x84/0xbc
> [   19.894796] [<fffffe00000eab28>] ___might_sleep+0x15c/0x248
> [   19.900360] [<fffffe00000ead7c>] __might_sleep+0x54/0x94
> [   19.905685] [<fffffe0000121ee4>] synchronize_irq+0x2c/0x88
> [   19.911167] [<fffffe00001221ec>] disable_irq+0x1c/0x2c
> [   19.916304] [<fffffe00004d8fec>] xgbe_tx_timer+0x64/0x90
> [   19.921606] [<fffffe00001344b4>] call_timer_fn+0xd4/0x48c
> [   19.927002] [<fffffe00001351fc>] run_timer_softirq+0x240/0x440
> [   19.932833] [<fffffe00000c5014>] __do_softirq+0x118/0x608
> [   19.938221] [<fffffe00000c584c>] irq_exit+0x9c/0xdc
> [   19.943094] [<fffffe0000121200>] __handle_domain_irq+0x68/0xb4
> [   19.948916] [<fffffe0000090398>] gic_handle_irq+0x30/0x7c
> [   19.954310] Exception stack(0xfffffe001ef4bb20 to 0xfffffe001ef4bc40)
> [   19.960742] bb20: d6b401c0 fffffe03 01ea7600 fffffe00 1ef4bc60 fffffe00 00117a80 fffffe00
> [   19.968913] bb40: d6b401f0 fffffe03 0095f450 fffffe00 01ea7610 fffffe00 00000000 00000000
> [   19.977088] bb60: 1ef4bc10 fffffe00 1ef4bbe0 fffffe00 0109d468 fffffe00 00000000 00000000
> [   19.985262] bb80: d4a96880 fffffe03 00000000 00000000 1ef4bc80 fffffe00 00000000 756e694c
> [   19.993436] bba0: 00000006 00000004 00010000 00000000 98343c1c 000003ff 98343b44 000003ff
> [   20.001603] bbc0: 00226d00 fffffe00 983440dc 000003ff 00000000 00000000 d6b401c0 fffffe03
> [   20.009776] bbe0: 01ea7600 fffffe00 00fc0000 fffffe00 00fc2000 fffffe00 00fff3a0 fffffe00
> [   20.017950] bc00: 00000015 00000000 0000011a 00000000 00000038 00000000 00742000 fffffe00
> [   20.026125] bc20: 1ef48000 fffffe00 1ef4bc60 fffffe00 00228dd4 fffffe00 1ef4bc60 fffffe00
> [   20.034299] [<fffffe0000092ce8>] el1_irq+0x68/0x100
> [   20.039173] [<fffffe0000228dd0>] get_empty_filp+0xf8/0x1ec
> [   20.044658] [<fffffe00002363ec>] path_openat+0x34/0x644
> [   20.049874] [<fffffe0000237b18>] do_filp_open+0x2c/0x88
> [   20.055095] [<fffffe0000226bf8>] do_sys_open+0x13c/0x21c
> [   20.060397] [<fffffe0000226d0c>] SyS_openat+0xc/0x18
> 
> 
> 
