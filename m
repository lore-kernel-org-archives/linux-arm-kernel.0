From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 1 Nov 2011 11:36:14 -0500
Subject: [PATCH 3/5] ARM: restart: remove local_irq_disable() from
	within	arch_reset()
In-Reply-To: <E1RLGtg-0005IV-TG@rmk-PC.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<E1RLGtg-0005IV-TG@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DF7767A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 01, 2011 9:09 AM, Russell King wrote:
>
> IRQs are already disabled by the time arch_reset() is called, so these
> calls to local_irq_disable() instead arch_reset() are redundant.  Remove
> them.
>
> The following spatch was used:
> @ rule1 @ identifier fn; @@
> arch_reset = fn;
>
> @@ identifier rule1.fn, m, c; @@
> void fn(char m, const char *c)
> {
> <... when != local_irq_enable
> -local_irq_disable();
> ...>
> }
>
> @@ identifier m, c; @@
> arch_reset(char m, const char *c)
> {
> <... when != local_irq_enable
> -local_irq_disable();
> ...>
> }
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-ep93xx/include/mach/system.h  |    2 --

[...]

> diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
> index 6d661fe..bdf6c4f 100644
> --- a/arch/arm/mach-ep93xx/include/mach/system.h
> +++ b/arch/arm/mach-ep93xx/include/mach/system.h
> @@ -11,8 +11,6 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	local_irq_disable();
> -
>  	/*
>  	 * Set then clear the SWRST bit to initiate a software reset
>  	 */

For ep93xx.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
