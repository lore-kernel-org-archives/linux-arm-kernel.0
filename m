From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 17 Nov 2014 13:23:21 +0100
Subject: [PATCHv9 1/2] pwm: Add Allwinner SoC support
In-Reply-To: <1415200545-26238-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1415200545-26238-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1415200545-26238-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20141117122319.GI25699@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 04:15:44PM +0100, Alexandre Belloni wrote:
> This adds a generic PWM framework driver for the PWM controller
> found on Allwinner SoCs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/pwm/Kconfig     |   9 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-sun4i.c | 366 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 376 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun4i.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 3865dfb9ed08..424359d3cbb1 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -262,6 +262,15 @@ config PWM_STI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sti.
>  
> +config PWM_SUN4I
> +	tristate "Allwinner PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST

I think you're going to need a bunch of other dependencies here, too.
HAS_IOMEM and COMMON_CLK at least, I'd expect.

> +	help
> +	  Generic PWM framework driver for Allwinner SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sunxi.

According to the Makefile extract below it'll be called pwm-sun4i.

> +
>  config PWM_TEGRA
>  	tristate "NVIDIA Tegra PWM support"
>  	depends on ARCH_TEGRA
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c458606c3755..d607804deea1 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
> +obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
[...]
> +static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    int duty_ns, int period_ns)
[...]
> +{
> +	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
> +	u32 clk_rate, prd, dty, val, clk_gate;
> +	u64 div = 0;
> +	unsigned int prescaler = 0;
> +	int err;
> +
> +	clk_rate = clk_get_rate(sun4i_pwm->clk);
> +
> +	if (sun4i_pwm->data->has_prescaler_bypass) {
> +		/* First, test without any prescaler when available */
> +		prescaler = PWM_PRESCAL_MASK;
> +		/*
> +		 * When not using any prescaler, the clock period in nanoseconds
> +		 * is not an integer so round it half up instead of
> +		 * truncating to get less surprising values.
> +		 */
> +		div = clk_rate * (u64)period_ns + NSEC_PER_SEC/2;

The cast here looks odd. Perhaps a better way would be to make clk_rate
a u64 so that type promotion rules will automatically cast here for you.

> +		do_div(div, NSEC_PER_SEC);
> +		if (div - 1 > PWM_PRD_MASK)
> +			prescaler = 0;
> +	}
> +
> +	if (prescaler == 0) {
> +		/* Go up from the first divider */
> +		for (prescaler = 0; prescaler < PWM_PRESCAL_MASK; prescaler++) {
> +			if (!prescaler_table[prescaler])
> +				continue;
> +			div = clk_rate / prescaler_table[prescaler];
> +			div = div * (u64)period_ns;

Type promotion rules should make the explicit cast unnecessary.

> +	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
> +	for (i = 0; i < pwm->chip.npwm; i++) {
> +		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
> +			pwm->chip.pwms[i].polarity = PWM_POLARITY_INVERSED;
> +	}

There's no need for the braces here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/4864010f/attachment.sig>
