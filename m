From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Mar 2017 11:02:16 +0000
Subject: [PATCH] arm64: add dump_stack to show_regs
In-Reply-To: <e84a5cf9-f4c4-2b27-ed59-363e2f8ab5bc@huawei.com>
References: <e84a5cf9-f4c4-2b27-ed59-363e2f8ab5bc@huawei.com>
Message-ID: <20170320110216.GB18585@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 19, 2017 at 03:15:25PM +0800, Ding Tianhong wrote:
> Recently I found that when the system trigger a soft lockup in interrupt,
> there is only showing the regs, but no stack trace, it is very difficult
> to locate the problem:
> 
> ===========================================
> 
> [10072.999437] NMI watchdog: BUG: soft lockup - CPU#16 stuck for 23s! [ksoftirqd/16:88]
> .....
> [10073.041254] CPU: 16 PID: 88 Comm: ksoftirqd/16 Tainted: G         4.x.x #1
> [10073.041258] Hardware name: xxxxx, BIOS 1.17 01/04/2017
> [10073.041261] task: ffff803f6cb06200 ti: ffff803f6cb50000 task.ti: ffff803f6cb50000
> [10073.041274] PC is at _raw_spin_unlock_irqrestore+0x24/0x30
> [10073.041280] LR is at blk_run_queue+0x3c/0x48
> [10073.041282] pc : [<ffff800000a3df14>] lr : [<ffff8000004f3a7c>] pstate: 60000145
> [10073.041285] sp : ffff803f6cb53b20
> [10073.041286] x29: ffff803f6cb53b20 x28: 0000000000001000
> [10073.041290] x27: 0000000000000000 x26: ffff800001226000
> [10073.041294] x25: 0000000000000000 x24: 0000000000000140
> [10073.041297] x23: ffff803f62e108c8 x22: ffff800001037000
> [10073.041302] x21: ffff843f66800040 x20: 0000000000000140
> [10073.041305] x19: ffff803f62e108c8 x18: 0000000000000007
> [10073.041309] x17: 000000000000000e x16: 0000000000000001
> [10073.041312] x15: 0000000000000019 x14: 0000000000000033
> [10073.041317] x13: 000000000000004c x12: 0000000000000000
> [10073.041320] x11: 0000000000001000 x10: 0000000000000010
> [10073.041323] x9 : ffff8000004f3a7c x8 : ffff803f69b59120
> [10073.041327] x7 : 0000000000000000 x6 : 0000000000000002
> [10073.041331] x5 : 0000000000000244 x4 : 00000000000244d9
> [10073.041334] x3 : ffff843f653ab918 x2 : 0000000000004074
> [10073.041337] x1 : 0000000000000140 x0 : ffff803f62e10e58
> 
> ===============================================
> 
> So add the general dump_stack to show_regs to support showing the stack.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  arch/arm64/kernel/process.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 043d373..60c5c26 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -212,6 +212,7 @@ void show_regs(struct pt_regs * regs)
>  {
>  	printk("\n");
>  	__show_regs(regs);
> +	dump_stack();
>  }

I don't think this is quite right.

I see that x86's show_regs() will dump a kernel stack, but it starts
from the stack described by the regs, not the stack used to call
dump_stack().

Also, for longjmp_break_handler() I think we only want the current
registers, and not the stack.

Thanks,
Mark.
