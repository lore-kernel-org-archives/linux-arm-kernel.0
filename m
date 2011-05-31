From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 31 May 2011 13:39:11 -0500
Subject: [PATCH v2] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on ts72xx
In-Reply-To: <1306866846-3167-1-git-send-email-ynezz@true.cz>
References: <ADE657CA350FB648AAC2C43247A983F001F381FC48C8@AUSP01VMBX24.collaborationhost.net>
	<1306866846-3167-1-git-send-email-ynezz@true.cz>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F381FC4955@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 31, 2011 11:34 AM, Petr ?tetiar wrote:
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
>  arch/arm/mach-ep93xx/include/mach/system.h |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
> index 6d661fe..8d31c4d 100644
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
> @@ -14,6 +17,15 @@ static inline void arch_reset(char mode, const char *cmd)
>  	local_irq_disable();
>  
>  	/*
> +	 * It's more reliable to use CPLD watchdog to perform the reset
> +	 */
> +	if (board_is_ts7200() || board_is_ts7250() || board_is_ts7260() ||
> +	    board_is_ts7300() || board_is_ts7400()) {
> +		__raw_writeb(0x5, TS72XX_WDT_FEED_PHYS_BASE);
> +		__raw_writeb(0x1, TS72XX_WDT_CONTROL_PHYS_BASE);
> +	}

Your missing the 'else' here.  Without it the ts-xxxx boards will fiddle with
the CPLD watchdog to do the reset but the SWRST bit might still get toggled if
the reset does not occur quick enough.  This might result in you still getting
the "weird" lockup.

> +
> +	/*
>  	 * Set then clear the SWRST bit to initiate a software reset
>  	 */
>  	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);

Regards,
Hartley
