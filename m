From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Oct 2013 16:22:36 +0100
Subject: [PATCH RFC v4 1/6] arm64: support single-step and breakpoint
 handler hooks
In-Reply-To: <1382008671-4515-2-git-send-email-sandeepa.prabhu@linaro.org>
References: <1382008671-4515-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1382008671-4515-2-git-send-email-sandeepa.prabhu@linaro.org>
Message-ID: <20131025152236.GC10673@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandeepa,

This is getting there, thanks for persevering with it. I still have a few
minor comments though.

On Thu, Oct 17, 2013 at 12:17:46PM +0100, Sandeepa Prabhu wrote:
> AArch64 Single Steping and Breakpoint debug exceptions will be
> used by multiple debug framworks like kprobes & kgdb.
> 
> This patch implements the hooks for those frameworks to register
> their own handlers for handling breakpoint and single step events.
> 
> Reworked the debug exception handler in entry.S: do_dbg to route
> software breakpoint (BRK64) exception to do_debug_exception()
> 
> Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> ---
>  arch/arm64/include/asm/debug-monitors.h | 21 ++++++++
>  arch/arm64/kernel/debug-monitors.c      | 86 ++++++++++++++++++++++++++++++++-
>  arch/arm64/kernel/entry.S               |  2 +
>  3 files changed, 108 insertions(+), 1 deletion(-)

[...]

> @@ -215,7 +257,10 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>  		 */
>  		user_rewind_single_step(current);
>  	} else {
> -		/* TODO: route to KGDB */
> +		/* call registered single step handlers */

Don't bother with this comment (it's crystal clear from the code).

> +		if (call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
> +			return 0;
> +
>  		pr_warning("Unexpected kernel single-step exception at EL1\n");
>  		/*
>  		 * Re-enable stepping since we know that we will be
> @@ -227,11 +272,50 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>  	return 0;
>  }
>  
> +
> +static LIST_HEAD(break_hook);
> +DEFINE_RWLOCK(break_hook_lock);

This guy can be a plain old spinlock. That way, the readers have less
overhead but things still work because we only call a single hook function.

Will
