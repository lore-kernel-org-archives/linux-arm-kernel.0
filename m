From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jul 2010 16:37:56 +0100
Subject: [PATCH] arm: show_regs dump stack when ARM_UNWIND enable
In-Reply-To: <20100720152431.GA17092@localhost.localdomain>
References: <20100720152431.GA17092@localhost.localdomain>
Message-ID: <1279640276.10002.35.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-20 at 23:24 +0800, janboe wrote:
> __backtrace is empty when ARM_UNWIND enable, so instead dump_stack
> 
> Signed-off-by: janboe <janboe.ye@gmail.com>
> ---
>  arch/arm/kernel/process.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index acf5e6f..e7ad878 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -271,7 +271,11 @@ void show_regs(struct pt_regs * regs)
>  	printk("\n");
>  	printk("Pid: %d, comm: %20s\n", task_pid_nr(current), current->comm);
>  	__show_regs(regs);
> +#ifdef CONFIG_ARM_UNWIND
> +	dump_stack();
> +#else
>  	__backtrace();
> +#endif
>  }

It looks like both dump_stack() and __backtrace() (with FRAME_POINTER)
have pretty much the same semantics. Maybe we could define __backtrace()
to just call dump_stack() when ARM_UNWIND.

-- 
Catalin
