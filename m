From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 17 Nov 2015 09:11:42 -0500
Subject: [PATCH] arm64: kernel: pause/unpause function graph tracer in
 cpu_suspend()
In-Reply-To: <1447761051-811-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1447761051-811-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20151117091142.49a70517@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015 11:50:51 +0000
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:


> Fixes: 819e50e25d0c ("arm64: Add ftrace support")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> Cc: Will Deacon <will.deacon@arm.com>
> Cc: <stable@vger.kernel.org> # 3.16+
> ---
>  arch/arm64/kernel/suspend.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
> index fce95e1..521448d 100644
> --- a/arch/arm64/kernel/suspend.c
> +++ b/arch/arm64/kernel/suspend.c
> @@ -1,3 +1,4 @@
> +#include <linux/ftrace.h>
>  #include <linux/percpu.h>
>  #include <linux/slab.h>
>  #include <asm/cacheflush.h>
> @@ -71,6 +72,13 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
>  	local_dbg_save(flags);
>  
>  	/*
> +	 * Function graph tracer state gets incosistent when the kernel
> +	 * calls functions that never return (aka suspend finishers) hence
> +	 * disable graph tracing during their execution.
> +	 */
> +	pause_graph_tracing();
> +
> +	/*
>  	 * mm context saved on the stack, it will be restored when
>  	 * the cpu comes out of reset through the identity mapped
>  	 * page tables, so that the thread address space is properly
> @@ -111,6 +119,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
>  			hw_breakpoint_restore(NULL);
>  	}
>  
> +	unpause_graph_tracing();
>  	/*
>  	 * Restore pstate flags. OS lock and mdscr have been already
>  	 * restored, so from this point onwards, debugging is fully
