From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 10 Aug 2011 12:45:36 -0500
Subject: [PATCH v4] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on	ts72xx
In-Reply-To: <1307125685-5110-1-git-send-email-ynezz@true.cz>
References: <ADE657CA350FB648AAC2C43247A983F001F381FC4A7E@AUSP01VMBX24.collaborationhost.net>
	<1307125685-5110-1-git-send-email-ynezz@true.cz>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F388389683@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 03, 2011 11:28 AM, Petr ?tetiar wrote:
> 
> On all ep93xx based boards from Technologic Systems, there's CPLD watchdog
> available, so use this one to reset the board instead of the soft reset in
> CPU.  I've seen some weird lockups with the soft reset on ep93xx in the past,
> while the reset via CPLD watchdog seems to be rock solid (tm) and works fine
> so far.
> 
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> ---
>  arch/arm/mach-ep93xx/include/mach/system.h |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
> index 6d661fe..67ec430 100644
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
> +	if (board_is_ts7200() || board_is_ts7250() || board_is_ts7260() ||
> +	    board_is_ts7300() || board_is_ts7400()) {
> +		/* We use more reliable CPLD watchdog to perform the reset */
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

Petr,

This patch is still in Russell's patch tracker.  I just realized a possible
problem with it.

If any other ep93xx machine is selected along with MACH_TS72XX and the kernel
is booted on a non-ts72xx machine, the static mapping for the ts72xx CPLD will
not be done.  I believe this will cause a problem when doing the boad_is_*
calls due to the:

	__raw_readb(TS72XX_MODEL_VIRT_BASE)

I think the best solution is to remove the #include <mach/ts72xx.h> from this
patch and change this:

+	if (board_is_ts7200() || board_is_ts7250() || board_is_ts7260() ||
+	    board_is_ts7300() || board_is_ts7400()) {

To:

+	if (machine_is_ts72xx())

This will correctly evaluate is the kernel is booted on a MACH_TYPE_TS72XX
system.

Can you please update and test the patch?

Regards,
Hartley
