From: rogerq@ti.com (Roger Quadros)
Date: Wed, 7 Oct 2015 10:45:50 +0300
Subject: [PATCH 2/2] memory: omap-gpmc: expand the description of the
 debug facility
In-Reply-To: <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5614CDAE.6070604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/15 23:07, Uwe Kleine-K?nig wrote:
> Most register values for the chip select setup depend on the frequency
> of the fck clock.
> So add a hint that the values setup by the bootloader might differ from
> the right setup for Linux if the bootloader uses a different frequency.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/memory/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index c6a644b22af4..1414dd53be57 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -64,6 +64,9 @@ config OMAP_GPMC_DEBUG
>  	  Enables verbose debugging mostly to decode the bootloader provided
>  	  timings. Enable this during development to configure devices
>  	  connected to the GPMC bus.
> +	  Note that you cannot just tweak your device tree until the registers
> +	  setup by linux match what the bootloader did because that one might
> +	  use a different fck frequency influencing most register settings.

Looks like we can't know for sure the GPMC fclk used at the bootloader
else we could have just printed the GPMC fclk pre and post gpmc settings.

How about this instead?

NOTE: Apart from matching the register setup with the bootloader you also need to
match the GPMC FCLK frequency used by the bootloader else the GPMC timings
won't be identical with the bootloader timings.

Also you might need to build this patch on top of
http://article.gmane.org/gmane.linux.kernel/2054796

>  
>  config MVEBU_DEVBUS
>  	bool "Marvell EBU Device Bus Controller"
> 

cheers,
-roger
