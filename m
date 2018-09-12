From: james.morse@arm.com (James Morse)
Date: Wed, 12 Sep 2018 13:28:30 +0100
Subject: [PATCH v5 04/27] arm64: daifflags: Use irqflags functions for
 daifflags
In-Reply-To: <1535471497-38854-5-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-5-git-send-email-julien.thierry@arm.com>
Message-ID: <1031e4c9-9123-7a94-a59c-4249cf51adf4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 28/08/18 16:51, Julien Thierry wrote:
> Some of the work done in daifflags save/restore is already provided
> by irqflags functions. Daifflags should always be a superset of irqflags
> (it handles irq status + status of other flags). Modifying behaviour of
> irqflags should alter the behaviour of daifflags.
> 
> Use irqflags_save/restore functions for the corresponding daifflags
> operation.

> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
> index 22e4c83..8d91f22 100644
> --- a/arch/arm64/include/asm/daifflags.h
> +++ b/arch/arm64/include/asm/daifflags.h
> @@ -36,11 +36,8 @@ static inline unsigned long local_daif_save(void)
>  {
>  	unsigned long flags;
>  
> -	asm volatile(
> -		"mrs	%0, daif		// local_daif_save\n"
> -		: "=r" (flags)
> -		:
> -		: "memory");
> +	flags = arch_local_save_flags();

I clearly should have done this from the beginning!
(I thought there was some header-loop that prevented it, but I can't reproduce
that now!)


>  	local_daif_mask();
>  
>  	return flags;
> @@ -60,11 +57,9 @@ static inline void local_daif_restore(unsigned long flags)
>  {
>  	if (!arch_irqs_disabled_flags(flags))
>  		trace_hardirqs_on();
> -	asm volatile(
> -		"msr	daif, %0		// local_daif_restore"
> -		:
> -		: "r" (flags)
> -		: "memory");
> +
> +	arch_local_irq_restore(flags);

And I thought this only messed with the I bit, which it clearly doesn't.

Thanks for fixing these!

Reviewed-by: James Morse <james.morse@arm.com>
