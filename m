From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 31 May 2011 18:47:57 +1000
Subject: [PATCH 4/4] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on ts72xx
In-Reply-To: <1306665346-26657-5-git-send-email-ynezz@true.cz>
References: <1306665346-26657-1-git-send-email-ynezz@true.cz>
	<1306665346-26657-5-git-send-email-ynezz@true.cz>
Message-ID: <4DE4AB3D.2010305@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/05/11 20:35, Petr ?tetiar wrote:
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
>  arch/arm/mach-ep93xx/include/mach/system.h |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
> index 6d661fe..4d02ddd 100644
> --- a/arch/arm/mach-ep93xx/include/mach/system.h
> +++ b/arch/arm/mach-ep93xx/include/mach/system.h
> @@ -3,6 +3,10 @@
>   */
>  
>  #include <mach/hardware.h>
> +#ifdef CONFIG_MACH_TS72XX
> +#include <linux/io.h>
> +#include <mach/ts72xx.h>
> +#endif
>  
>  static inline void arch_idle(void)
>  {
> @@ -13,11 +17,22 @@ static inline void arch_reset(char mode, const char *cmd)
>  {
>  	local_irq_disable();
>  
> +#ifdef CONFIG_MACH_TS72XX
> +	/*
> +	 * It's more reliable to use CPLD watchdog to perform the reset
> +	 */
> +	if (board_is_ts7200() || board_is_ts7250() || board_is_ts7260() ||
> +	    board_is_ts7300() || board_is_ts7400()) {
> +		__raw_writeb(0x5, TS72XX_WDT_FEED_PHYS_BASE);
> +		__raw_writeb(0x1, TS72XX_WDT_CONTROL_PHYS_BASE);
> +	}
> +#else
>  	/*
>  	 * Set then clear the SWRST bit to initiate a software reset
>  	 */
>  	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
>  	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
> +#endif

Do we need the ifdef here? Isn't the if (board_is_xxx) test enough?

~Ryan
