From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 31 May 2011 14:24:04 -0500
Subject: [PATCH v3] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on ts72xx
In-Reply-To: <1306868578-3883-1-git-send-email-ynezz@true.cz>
References: <ADE657CA350FB648AAC2C43247A983F001F381FC4955@AUSP01VMBX24.collaborationhost.net>
	<1306868578-3883-1-git-send-email-ynezz@true.cz>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F381FC498E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 31, 2011 12:03 PM, Petr ?tetiar wrote:
> On all ep93xx based boards from Technologic Systems, there's CPLD watchdog
> available, so use this one to reset the board instead of the soft reset in
> CPU.  I've seen some weird lockups with the soft reset on ep93xx in the past,
> while the reset via CPLD watchdog seems to be rock solid (tm) and works fine
> so far.
> 
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> ---
>  arch/arm/mach-ep93xx/include/mach/system.h |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
> index 6d661fe..2969786 100644
> --- a/arch/arm/mach-ep93xx/include/mach/system.h
> +++ b/arch/arm/mach-ep93xx/include/mach/system.h
> @@ -2,7 +2,10 @@
>   * arch/arm/mach-ep93xx/include/mach/system.h
>   */
>  
> +#include <linux/io.h>
> +
>  #include <mach/hardware.h>
> +#include <mach/ts72xx.h>
>  
>  static inline void arch_idle(void)
>  {
> @@ -13,11 +16,16 @@ static inline void arch_reset(char mode, const char *cmd)
>  {
>  	local_irq_disable();
>  
> -	/*
> -	 * Set then clear the SWRST bit to initiate a software reset
> -	 */
> -	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> -	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> +	/* It's more reliable to use CPLD watchdog to perform the reset */
> +	if (board_is_ts7200() || board_is_ts7250() || board_is_ts7260() ||
> +	    board_is_ts7300() || board_is_ts7400()) {
> +		__raw_writeb(0x5, TS72XX_WDT_FEED_PHYS_BASE);
> +		__raw_writeb(0x1, TS72XX_WDT_CONTROL_PHYS_BASE);
> +	} else {
> +		/* Set then clear the SWRST bit to initiate a software reset */
> +		ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> +		ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> +	}
>  
>  	while (1)
>  		;

That looks better.

I pulled out the ts-7200 manual to verify the watchdog reset.  Your feeding
the watchdog then changing the timeout period to 250ms.  Without the "else"
the syscon would have tried to reset the board when the SWRST bit is toggled.

I have no way of testing this patch (no ts boards) but as long as Ryan has no
objections you have my:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
