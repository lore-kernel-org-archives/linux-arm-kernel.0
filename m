From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 May 2017 15:55:35 +0100
Subject: [PATCH 1/2] arm64: Call __show_regs directly
In-Reply-To: <1494251815-55961-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1494251815-55961-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20170508145535.GF5480@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I see these patches are effectively a v2 of [1].

Please cite prior patch series when posting updates. The context really
helps review.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/494840.html

On Mon, May 08, 2017 at 09:56:54PM +0800, Kefeng Wang wrote:
> Call __show_regs directly in longjmp_break_handler() and
> __do_user_fault(), it is to prepare for dump stack when
> softlockup detected.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

The above doesn't explain the problem clearly. How about:

  Generic code expects show_regs() to also dump the stack, but arm64's
  show_reg() does not do this. Some arm64 callers of show_regs() *only*
  want the registers dumped, without the stack.

  To enable generic code to work as expected, we need to make
  show_regs() dump the stack. Where we only want the registers dumped,
  we must use __show_regs().

  This patch updates code to use __show_regs() where only registers are
  desired. A subsequent patch will modify show_regs().

... with that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/kernel/probes/kprobes.c | 4 ++--
>  arch/arm64/mm/fault.c              | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index c5c4594..d849d98 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -522,9 +522,9 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>  		pr_err("current sp %lx does not match saved sp %lx\n",
>  		       orig_sp, stack_addr);
>  		pr_err("Saved registers for jprobe %p\n", jp);
> -		show_regs(saved_regs);
> +		__show_regs(saved_regs);
>  		pr_err("Current registers\n");
> -		show_regs(regs);
> +		__show_regs(regs);
>  		BUG();
>  	}
>  	unpause_graph_tracing();
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 37b95df..c3f2b10 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -250,7 +250,7 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  			tsk->comm, task_pid_nr(tsk), inf->name, sig,
>  			addr, esr);
>  		show_pte(tsk->mm, addr);
> -		show_regs(regs);
> +		__show_regs(regs);
>  	}
>  
>  	tsk->thread.fault_address = addr;
> -- 
> 1.7.12.4
> 
