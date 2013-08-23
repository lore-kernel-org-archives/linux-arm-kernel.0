From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Aug 2013 11:05:24 +0200
Subject: [PATCH 1/4] pwm: add freescale ftm pwm driver support
In-Reply-To: <1377054462-6283-2-git-send-email-Li.Xiubo@freescale.com>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20130823090523.GF3535@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 11:07:39AM +0800, Xiubo Li wrote:
> Add freescale ftm pwm driver support. The ftm pwm device

I think the correct capitalizations are: "Freescale", "FTM" and "PWM".
There are other occurrences in the rest of the driver that I haven't
explicitly pointed out.

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 75840b5..247b4c3 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -62,6 +62,16 @@ config PWM_BFIN
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-bfin.
>  
> +config PWM_FTM

Perhaps name this PWM_FSL_FTM to match the driver name?

> +	tristate "Freescale FTM PWM support"
> +	depends on OF
> +	help
> +	  Generic FTM PWM framework driver for Freescale VF610 and
> +	  Layerscape LS-1 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ftm.

And fix this up to be "pwm-fsl-ftm".

> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
[...]
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/pwm.h>
> +#include <linux/of_address.h>
> +#include <linux/pinctrl/consumer.h>
> +
> +#define FTM_SC              0x00
> +#define FTMSC_CPWMS         (0x1 << 5)
> +#define FTMSC_CLK_MASK      0x03
> +#define FTMSC_CLK_OFFSET    0x03
> +#define FTMSC_CLKSYS        (0x01 << 3)
> +#define FTMSC_CLKFIX        (0x02 << 3)
> +#define FTMSC_CLKEXT        (0x03 << 3)
> +#define FTMSC_PS_MASK       0x07
> +#define FTMSC_PS_OFFSET     0x00
> +
> +#define FTM_CNT             0x04
> +#define FTM_MOD             0x08
> +
> +#define FTM_CSC_BASE        0x0C
> +#define FTM_CSC(_CHANNEL) \
> +	(FTM_CSC_BASE + (_CHANNEL * 0x08))

I prefer lowercase variables in macros:

	#define FTM_CSC(channel) \
		(FTM_CSC_BASE + (channel * 8))

> +#define FTMCnSC_MSB         (0x01 << 5)
> +#define FTMCnSC_MSA         (0x01 << 4)
> +#define FTMCnSC_ELSB        (0x01 << 3)
> +#define FTMCnSC_ELSA        (0x01 << 2)
> +#define FTM_PWMMODE         (FTMCnSC_MSB)
> +#define FTM_HIGH_TRUE       (FTMCnSC_ELSB)
> +#define FTM_LOW_TRUE        (FTMCnSC_ELSA)

What's the reason for redefining these? Can't you just use the FTMCnSC_*
defines directly?

> +#define FTM_CV(_CHANNEL) \
> +	(FTM_CV_BASE + (_CHANNEL * 0x08))

Same comment as for FTM_CSC above.

> +#define FTM_MAX_CHANNEL     0x08

There should be no need for this. The only place where you use this is
when assigning it to pwm_chip.npwm, so you may as well use the literal
there.

> +struct fsl_pwm {
> +	unsigned long period_cycles;
> +	unsigned long duty_cycles;
> +};
> +
> +struct fsl_pwm_chip {
> +	struct mutex lock;
> +
> +	struct platform_device *pdev;

You never use this platform_device. And you have to assign &pdev->dev to
the pwm_chip.dev anyway, so why not just use that consistently and drop
the pdev field?

> +	struct pwm_chip chip;
> +
> +	unsigned int	clk_ps;
> +	struct clk	*clk;
> +
> +	void __iomem	*base;
> +
> +	unsigned int	cpwm;
> +	struct fsl_pwm fpwms[FTM_MAX_CHANNEL];

Please don't do this. Use pwm_set_chip_data()/pwm_get_chip_data() to
associate per-channel specific data.

> +	/* pinctrl handles */

Nit: it's only a single handle.

> +	struct pinctrl          *pinctrl;

You also use tabs and spaces inconsistently here. I suggest you use a
single space between the data type and the field name, that way it's
much easier to stay consistent.

> +static int fsl_pwm_request_channel(struct pwm_chip *chip,
> +			       struct pwm_device *pwm)

The arguments on the trailing line aren't properly aligned. They should
be aligned with the arguments on the first line.

> +{
> +	int ret = 0;
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	ret = clk_prepare_enable(fpc->clk);

This should probably be just clk_prepare(). Or is there some reason why
you can't delay clk_enable() to the .enable() operation?

> +static int fsl_updata_config(struct fsl_pwm_chip *fpc,
> +			     struct pwm_device *pwm)

Parameter alignment again. Please also check all other functions.

> +{
> +	int i;

This should be unsigned int.

> +static unsigned long
> +fsl_rate_to_cycles(struct fsl_pwm_chip *fpc, int time_ns)

The above two lines are 78 characters when joined, so there's no need to
split them.

Perhaps time_ns should be "unsigned long"?

> +{
> +	unsigned long ps;
> +	unsigned long long c;
> +
> +	ps = (0x01 << fpc->clk_ps);

This is fairly short, so you could do it along with the variable
declaration. Also there's no need for the parentheses or the hexadecimal
prefix (0x01 == 1):

	unsigned long ps = 1 << fpc->clk_ps;

> +	/* The module clk is HZ/s, the time_ns parameter
> +	 * is based nanosecond, so here should divide
> +	 * 1000000000UL.
> +	 */

Block comments should be:

	/*
	 * ...
	 * ...
	 */

Also HZ/s isn't a valid unit for a clock frequency. And time_ns also has
the _ns suffix to designate the unit, so as a whole that comment doesn't
add any real information and can just as well be dropped.

> +static int fsl_pwm_config_channel(struct pwm_chip *chip,

I think you can safely drop the _channel suffix from the PWM operations.

> +			      struct pwm_device *pwm,
> +			      int duty_ns,
> +			      int period_ns)
> +{
> +	unsigned long period_cycles, duty_cycles;
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	if (WARN_ON(!test_bit(PWMF_REQUESTED, &pwm->flags)))
> +		return -ESHUTDOWN;

Erm... how do you think this could ever happen? Users need to request a
PWM to obtain a struct pwm_device, in which case PWMF_REQUESTED will
always be set. There are a few other occurrences throughout the rest of
the driver that I haven't pointed out explicitly.

> +	period_cycles = fsl_rate_to_cycles(fpc, period_ns);
> +	if (period_cycles > 0xFFFF) {
> +		dev_warn(&fpc->pdev->dev,
> +				"required PWM period cycles(%lu) "
> +				"overflow 16-bits counter!\n",
> +				period_cycles);
> +		period_cycles = 0xFFFF;
> +	}
> +
> +	duty_cycles = fsl_rate_to_cycles(fpc, duty_ns);
> +	if (duty_cycles >= 0xFFFF) {
> +		dev_warn(&fpc->pdev->dev,
> +				"required PWM duty cycles(%lu) "
> +				"overflow 16-bits counter!\n",
> +				duty_cycles);
> +		duty_cycles = 0xFFFF - 1;
> +	}
> +
> +	fpc->fpwms[pwm->hwpwm].period_cycles = period_cycles;
> +	fpc->fpwms[pwm->hwpwm].duty_cycles = duty_cycles;

You use these for the sole purpose of passing them into the
fsl_updata_config() function, so I wonder why you can't just pass them
as parameters and get rid of struct fsl_pwm as a bonus?

> +
> +	writel(FTM_PWMMODE | FTM_HIGH_TRUE,
> +			fpc->base + FTM_CSC(pwm->hwpwm));
> +
> +	writel(0xF0, fpc->base + FTM_OUTMASK);
> +	writel(0x0F, fpc->base + FTM_OUTINIT);
> +	writel(FTM_CNTIN_VAL, fpc->base + FTM_CNTIN);
> +
> +	mutex_lock(&fpc->lock);
> +	fsl_updata_config(fpc, pwm);

And now that I think about it: perhaps this was supposed to be called
fsl_update_config() instead of fsl_updat*a*_config()?

> +	mutex_unlock(&fpc->lock);
> +
> +	return 0;
> +}
> +
> +static int fsl_pwm_set_channel_polarity(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    enum pwm_polarity polarity)
> +{
> +	unsigned long reg;
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	reg = readl(fpc->base + FTM_POL);
> +	reg &= ~(0x01 << pwm->hwpwm);

This would be slightly more canonical as:

	reg &= ~BIT(pwm->hwpwm);

> +	reg |= (polarity << pwm->hwpwm);

And perhaps here it would be better to be explicit. I think it's
unlikely that enum pwm_polarity will even gain a third entry, but better
be safe than sorry:

	if (polarity == PWM_POLARITY_INVERSED)
		reg |= BIT(pwm->hwpwm);
	else
		reg &= ~BIT(pwm->hwpwm);

> +static int is_any_other_channel_enabled(struct pwm_chip *chip,
> +				    unsigned int cur)
> +{
> +	int i;
> +
> +	for (i = 0; i < chip->npwm; i++) {
> +		if (i == cur)
> +			continue;
> +		if (test_bit(PWMF_ENABLED, &chip->pwms[i].flags))
> +			return 1;
> +	}
> +
> +	return 0;
> +}

This can probably be better done using a reference/enable count. Instead
of having to iterate over all PWM channels of the chip and checking
their flags, just keep track of how many times .enable() and .disable()
are called.

To make it easier you can probably wrap that into two functions, such as
fsl_clock_enable() and fsl_clock_disable().

> +static int fsl_pwm_enable_channel(struct pwm_chip *chip,
> +			      struct pwm_device *pwm)
> +{
[...]
> +	if (is_any_other_channel_enabled(chip, pwm->hwpwm))
> +		return 0;

This is where you'd call fsl_clock_enable()...

> +	reg = readl(fpc->base + FTM_SC);
> +	reg &= ~((FTMSC_CLK_MASK << FTMSC_CLK_OFFSET) |
> +			(FTMSC_PS_MASK << FTMSC_PS_OFFSET));
> +	/* select system clock source */
> +	reg |= (FTMSC_CLKSYS | fpc->clk_ps);
> +	writel(reg, fpc->base + FTM_SC);

... and run this code in fsl_clock_enable() if the enable count is 0 to
select the system clock when the first PWM is enabled.

> +static void fsl_pwm_disable_channel(struct pwm_chip *chip,
> +				struct pwm_device *pwm)
> +{
[...]
> +	if (is_any_other_channel_enabled(chip, pwm->hwpwm))
> +		return;

Then call fsl_clock_disable() here...

> +	writel(0xFF, fpc->base + FTM_OUTMASK);
> +	reg = readl(fpc->base + FTM_SC);
> +	reg &= ~(FTMSC_CLK_MASK << FTMSC_CLK_OFFSET);
> +	writel(reg, fpc->base + FTM_SC);

... and run this code in fsl_clock_disable() if the enable count reaches
0 so that the clock is disabled when no PWM channels remain on.

> +static int fsl_pwm_parse_dt(struct fsl_pwm_chip *fpc)
> +{
[...]
> +	int ret = 0;
> +	u32 chs[FTM_MAX_CHANNEL];
> +	struct device_node *np = fpc->pdev->dev.of_node;
> +
> +	ret = of_property_read_u32(np, "fsl,pwm-clk-ps",
> +				   &fpc->clk_ps);
> +	if (ret < 0) {
> +		dev_err(&fpc->pdev->dev,
> +				"failed to get pwm "
> +				"clk prescaler : %d\n",
> +				ret);

Perhaps it's more useful to mention the missing property explicitly in
the error message:

		dev_err(fpc->chip.dev,
			"failed to parse \"fsl,pwm-clk-ps\" property: %d\n",
			ret);


> +		return ret;
> +	}
> +	if (fpc->clk_ps > 7 || fpc->clk_ps < 0)

clk_ps is unsigned and therefore can't be < 0. And a blank line would be
useful between the previous line ("}") and this line.

> +static int fsl_pwm_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct fsl_pwm_chip *fpc;
> +	struct resource *res;
> +
> +	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> +	if (!fpc) {
> +		dev_err(&pdev->dev,
> +				"failed to allocate memory\n");

I don't think that's very useful either. If this should indeed ever
fail, then the driver core will complain about the probe failing and
include the error code. Since it's the only location where you return
that error code you know immediately what went wrong.

> +		return -ENOMEM;
> +	}
> +
> +	mutex_init(&fpc->lock);
> +
> +	fpc->pdev = pdev;
> +
> +	ret = fsl_pwm_parse_dt(fpc);
> +	if (ret < 0)
> +		return ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	fpc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(fpc->base)) {
> +		dev_err(&pdev->dev,
> +				"failed to ioremap() registers\n");

No need for this error message. devm_ioremap_resource() prints out
errors already on failure.

> +	fpc->chip.dev = &pdev->dev;
> +	fpc->chip.ops = &fsl_pwm_ops;
> +	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
> +	fpc->chip.of_pwm_n_cells = 3;
> +	fpc->chip.base = -1;
> +
> +	ret = pwmchip_add(&fpc->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +				"failed to add ftm0 pwm chip %d\n",
> +				ret);

dev_err() will already include the device name in the error message, so
I don't think you need the "ftm0" here. Also make sure to use the
correct capitalization for "PWM". And there is no need to split this
over so many lines, it all fits on a single line just fine. There are
other occurrences of this, so please double-check.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/840a5c11/attachment.sig>
