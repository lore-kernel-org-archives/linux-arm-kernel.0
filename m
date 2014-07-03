From: balbi@ti.com (Felipe Balbi)
Date: Thu, 3 Jul 2014 17:41:46 -0500
Subject: [PATCH 1/2] mmc: hsmmc: Add reset gpio configuration option.
In-Reply-To: <1404420564-30245-1-git-send-email-marek@goldelico.com>
References: <1404420564-30245-1-git-send-email-marek@goldelico.com>
Message-ID: <20140703224146.GC2540@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 03, 2014 at 10:49:23PM +0200, Marek Belisko wrote:
> From: NeilBrown <neilb@suse.de>
> 
> If a 'gpio_reset' is specified, then hold it low while
> turning the power regulator on.
> This is needed for some wi2wi wireless modules, particularly
> when the regulator is held active by some other client.
> The wi2wi needs to be reset if power isn't actually removed, and
> the gpio can be used to do this.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  arch/arm/mach-omap2/hsmmc.c            |  7 ++++++-
>  arch/arm/mach-omap2/hsmmc.h            |  3 +++
>  drivers/mmc/host/omap_hsmmc.c          | 26 +++++++++++++++++++++++---
>  include/linux/platform_data/mmc-omap.h |  1 +
>  4 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 07d4c7b..046bfdd 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -172,6 +172,10 @@ static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
>  		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
>  		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
>  					OMAP_PIN_INPUT_PULLUP);
> +	if (gpio_is_valid(mmc_controller->slots[0].gpio_reset) &&
> +		(mmc_controller->slots[0].gpio_reset < OMAP_MAX_GPIO_LINES))
> +		omap_mux_init_gpio(mmc_controller->slots[0].gpio_reset,
> +					OMAP_PIN_OUTPUT);
>  	if (cpu_is_omap34xx()) {
>  		if (controller_nr == 0) {
>  			omap_mux_init_signal("sdmmc1_clk",
> @@ -270,6 +274,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
>  
>  	mmc->slots[0].switch_pin = c->gpio_cd;
>  	mmc->slots[0].gpio_wp = c->gpio_wp;
> +	mmc->slots[0].gpio_reset = c->gpio_reset;
>  
>  	mmc->slots[0].remux = c->remux;
>  	mmc->slots[0].init_card = c->init_card;
> @@ -389,7 +394,7 @@ void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
>  			continue;
>  
>  		mmc_pdata->slots[0].switch_pin = c->gpio_cd;
> -		mmc_pdata->slots[0].gpio_wp = c->gpio_wp;
> +		mmc_pdata->slots[0].gpio_reset = c->gpio_reset;
>  
>  		res = omap_device_register(pdev);
>  		if (res)
> diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
> index 7f2e790..16b2ac5 100644
> --- a/arch/arm/mach-omap2/hsmmc.h
> +++ b/arch/arm/mach-omap2/hsmmc.h
> @@ -24,6 +24,9 @@ struct omap2_hsmmc_info {
>  	bool	deferred;	/* mmc needs a deferred probe */
>  	int	gpio_cd;	/* or -EINVAL */
>  	int	gpio_wp;	/* or -EINVAL */
> +	int	gpio_reset;	/* or -EINVAL - reset is held low during
> +				 * power-on
> +				 */
>  	char	*name;		/* or NULL for default */
>  	struct platform_device *pdev;	/* mmc controller instance */
>  	int	ocr_mask;	/* temporary HACK */
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 9656726..4a264fc 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -300,6 +300,8 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>  	if (!host->vcc)
>  		return 0;
>  
> +	if (gpio_is_valid(mmc_slot(host).gpio_reset))
> +		gpio_set_value_cansleep(mmc_slot(host).gpio_reset, 0);
>  	if (mmc_slot(host).before_set_reg)
>  		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
>  
> @@ -365,6 +367,8 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>  
>  	if (mmc_slot(host).after_set_reg)
>  		mmc_slot(host).after_set_reg(dev, slot, power_on, vdd);
> +	if (gpio_is_valid(mmc_slot(host).gpio_reset))
> +		gpio_set_value_cansleep(mmc_slot(host).gpio_reset, 1);
>  
>  error_set_power:
>  	return ret;
> @@ -481,10 +485,22 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
>  	} else
>  		pdata->slots[0].gpio_wp = -EINVAL;
>  
> -	return 0;
> +	if (gpio_is_valid(pdata->slots[0].gpio_reset)) {
> +		ret = gpio_request(pdata->slots[0].gpio_reset, "mmc_reset");
> +		if (ret)
> +			goto err_free_wp;
> +		ret = gpio_direction_output(pdata->slots[0].gpio_reset, 1);
> +		if (ret)
> +			goto err_free_reset;
> +	} else
> +		pdata->slots[0].gpio_reset = -EINVAL;

looks like this should be implemented as a reset-gpio.c driver. This
piece of code would, then

	reset_assert(slot->reset);
	do_the_magic_dance();
	reset_deassert(slot->reset);

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/3326e218/attachment.sig>
