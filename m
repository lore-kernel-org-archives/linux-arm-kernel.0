From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 10:29:40 +0000
Subject: [PATCH] arm64: use raw_smp_processor_id in stack backtrace dump
In-Reply-To: <1455053182-31404-1-git-send-email-yang.shi@linaro.org>
References: <1455053182-31404-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20160210102939.GD1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 01:26:22PM -0800, Yang Shi wrote:
> dump_backtrace may be called in kthread context, which is not bound to a single
> cpu, i.e. khungtaskd, then calling smp_processor_id may trigger the below bug
> report:

If we're preemptible here, it means that our irq_stack_ptr is potentially
bogus. Whilst this isn't an issue for kthreads, it does feel like we
could make this slightly more robust in the face of potential frame
corruption. Maybe just zero the IRQ stack pointer if we're in preemptible
context?

Will

> BUG: using smp_processor_id() in preemptible [00000000] code: khungtaskd/71
> caller is debug_smp_processor_id+0x1c/0x28
> CPU: 3 PID: 71 Comm: khungtaskd Not tainted 4.5.0-rc1 #144
> Hardware name: Freescale Layerscape 2085a RDB Board (DT)
> Call trace:
> [<ffffffc00008d120>] dump_backtrace+0x0/0x290
> [<ffffffc00008d3d4>] show_stack+0x24/0x30
> [<ffffffc0006bfd1c>] dump_stack+0x8c/0xd8
> [<ffffffc0006fe56c>] check_preemption_disabled+0x184/0x188
> [<ffffffc0006fe58c>] debug_smp_processor_id+0x1c/0x28
> [<ffffffc00008d1a4>] dump_backtrace+0x84/0x290
> [<ffffffc00008d3d4>] show_stack+0x24/0x30
> [<ffffffc00012aa5c>] sched_show_task+0x16c/0x280
> [<ffffffc0001f3df8>] watchdog+0x560/0x708
> [<ffffffc000111bb8>] kthread+0x1b0/0x1d0
> [<ffffffc0000864d0>] ret_from_fork+0x10/0x40
> 
> Replace it to raw version to prevent from the race condition.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
>  arch/arm64/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index cbedd72..9abe236 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -146,7 +146,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>  static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  {
>  	struct stackframe frame;
> -	unsigned long irq_stack_ptr = IRQ_STACK_PTR(smp_processor_id());
> +	unsigned long irq_stack_ptr = IRQ_STACK_PTR(raw_smp_processor_id());
>  	int skip;
>  
>  	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
> -- 
> 2.0.2
> 
