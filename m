From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 6 Sep 2011 10:14:16 +0200
Subject: [PATCH] OMAP: hsmmc: Fix mux for non-OMAP pins
In-Reply-To: <1315296483-8442-1-git-send-email-weber@corscience.de>
References: <4E6538A1.5090204@gmail.com>
	<1315296483-8442-1-git-send-email-weber@corscience.de>
Message-ID: <20110906081416.GC28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Tue, Sep 06, 2011 at 10:08:03AM +0200, Thomas Weber wrote:
> The Devkit8000 uses a TWL4030 pin for card detection.
> Thats why the error:
> _omap_mux_init_gpio: Could not set gpio192
> occurs.
> 
> This patch checks that the pin is on OMAP before
> calling omap_mux_init_gpio.
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  arch/arm/mach-omap2/hsmmc.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index a9b45c7..783d0f1 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -214,10 +214,12 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
>  static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
>  			int controller_nr)
>  {
> -	if (gpio_is_valid(mmc_controller->slots[0].switch_pin))
> +	if (gpio_is_valid(mmc_controller->slots[0].switch_pin) && \
That backslash at the line end is not needed and looks ugly.

> +		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
>  		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
>  					OMAP_PIN_INPUT_PULLUP);
> -	if (gpio_is_valid(mmc_controller->slots[0].gpio_wp))
> +	if (gpio_is_valid(mmc_controller->slots[0].gpio_wp) && \
> +		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
>  		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
>  					OMAP_PIN_INPUT_PULLUP);
>  	if (cpu_is_omap34xx()) {

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
