From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Feb 2016 12:26:09 +0000
Subject: [PATCH v2 3/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <1454684330-892-4-git-send-email-james.morse@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <1454684330-892-4-git-send-email-james.morse@arm.com>
Message-ID: <20160218122608.GB2538@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 02:58:48PM +0000, James Morse wrote:
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
[...]
> @@ -308,6 +312,20 @@ static void tls_thread_switch(struct task_struct *next)
>  	: : "r" (tpidr), "r" (tpidrro));
>  }
>  
> +/* Restore the UAO state depending on next's addr_limit */
> +static void uao_thread_switch(struct task_struct *next)
> +{
> +	unsigned long next_sp = next->thread.cpu_context.sp;
> +
> +	if (IS_ENABLED(CONFIG_ARM64_UAO) &&
> +	    get_thread_info(next_sp)->addr_limit == KERNEL_DS)

Can you not use task_thread_info(next) directly instead of a new
get_thread_info()?

> +		asm(ALTERNATIVE("nop", SET_PSTATE_UAO(1), ARM64_HAS_UAO,
> +			        CONFIG_ARM64_UAO));
> +	else
> +		asm(ALTERNATIVE("nop", SET_PSTATE_UAO(0), ARM64_HAS_UAO,
> +				CONFIG_ARM64_UAO));
> +}

I think we still end up with some empty asm in this function even though
CONFIG_ARM64_UAO is disabled, I'm not sure the compiler will eliminate
it completely. If that's the case, maybe use two nested "if" blocks.

> +
>  /*
>   * Thread switching.
>   */
> @@ -327,6 +345,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	 */
>  	dsb(ish);
>  
> +	uao_thread_switch(next);

We should place this before the dsb(), together with the other switches.
The pstate change should be self synchronising.

-- 
Catalin
