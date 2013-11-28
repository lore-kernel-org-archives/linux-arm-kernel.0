From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 22:25:11 +0100
Subject: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131128212510.GC14689@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 09:36:55AM +0800, Xiubo Li wrote:
> The FTM PWM device can be found on Vybrid VF610 Tower and Layerscape LS-1 SoCs.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-fsl-ftm.c | 402 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 413 insertions(+)
>  create mode 100644 drivers/pwm/pwm-fsl-ftm.c

Sorry for taking so long. Overall this looks pretty good. A few minor
comments below.

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

Can you sort these alphabetically, please?

> +#include <dt-bindings/clock/vf610-clock.h>

This can stay separate, and I would even separate it from the others by
a blank line.

> +#define FTM_SC              0x00
> +#define FTMSC_CLK_MASK      0x03

Perhaps FTM_SC_CLK_MASK for consistency with the register name? Same for
all others below.

> +#define FTMSC_CLK_OFFSET    0x03

I think the more common suffix would be _SHIFT. _OFFSET is more
typically used for registers, not bitfields.

> +#define FTMSC_CLKSYS        (0x01 << 3)
> +#define FTMSC_CLKFIX        (0x02 << 3)
> +#define FTMSC_CLKEXT        (0x03 << 3)

Perhaps "<< 3" should be "<< FTM_SC_CLK_SHIFT"? And the names perhaps
FTM_SC_CLK_{SYS,FIX,EXT}? That somehow "namespaces" all of them.

> +#define FTMSC_PS_MASK       0x07
> +#define FTMSC_PS_OFFSET     0x00
> +
> +#define FTM_CNT             0x04
> +#define FTM_MOD             0x08
> +
> +#define FTM_CSC_BASE        0x0C
> +#define FTM_CSC(_channel) (FTM_CSC_BASE + ((_channel) * 8))
> +#define FTMCnSC_MSB         BIT(5)

Same here: FTMCnSC_MSB isn't immediately obvious to be a bit within the
FTM_CSC register. FTM_CSC_MSB is.

> +#define FTM_CNTIN_VAL       0x00

Do we really need this?

> +#define FTM_MAX_CHANNEL     8

This is used only once, so I prefer to just assign .npwm = 8 in the
driver's .probe() implementation.

> +static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	int ret;
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);

You could assign this when declaring the fpc variable to save two lines.

> +	ret = clk_prepare_enable(fpc->sys_clk);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

You can save another few lines by making this simply:

	return clk_prepare_enable(fpc->sys_clk);

> +static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);

Same comment here.

> +static int fsl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  int duty_ns, int period_ns)
> +{
> +	unsigned long period_cycles, duty_cycles;

I don't think there's a need for the _cycles suffix here.

> +	unsigned long cntin = FTM_CNTIN_VAL;

I don't understand why this is needed. FTM_CNTIN_VAL is defined as 0 and
you never change cntin subsequently, so why not just use the literal 0
instead?

> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	period_cycles = fsl_rate_to_cycles(fpc, period_ns);
> +	if (period_cycles > 0xFFFF) {
> +		dev_err(chip->dev, "required PWM period cycles(%lu) overflow "
> +				"16-bits counter!\n", period_cycles);
> +		return -EINVAL;
> +	}
> +
> +	duty_cycles = fsl_rate_to_cycles(fpc, duty_ns);
> +	if (duty_cycles >= 0xFFFF) {
> +		dev_err(chip->dev, "required PWM duty cycles(%lu) overflow "
> +				"16-bits counter!\n", duty_cycles);
> +		return -EINVAL;
> +	}

I'm not sure the error messages are all that useful. A -EINVAL error
code should make it pretty clear what the problem is.

> +	writel(FTMCnSC_MSB | FTMCnSC_ELSB, fpc->base + FTM_CSC(pwm->hwpwm));
> +
> +	writel(0xF0, fpc->base + FTM_OUTMASK);
> +	writel(0x0F, fpc->base + FTM_OUTINIT);

The purpose of this eludes me. These seem to be global (not specific to
channel pwm->hwpwm) registers, so why are they updated whenever a single
channel is reconfigured?

> +	writel(FTM_CNTIN_VAL, fpc->base + FTM_CNTIN);

This could become simply:

	writel(0, fpc->base + FTM_CNTIN);

> +	writel(period_cycles + cntin - 1, fpc->base + FTM_MOD);
> +	writel(duty_cycles + cntin, fpc->base + FTM_CV(pwm->hwpwm));

And these:

	writel(period - 1, fpc->base + FTM_MOD);
	writel(duty, fpc->base + FTM_CV(pwm->hwpwm));

Although now that I think about it, this seems broken. The period is set
in a global register, so I assume it is valid for all channels. What if
you want to use different periods for individual channels? The way I
read this the last one to be configured will win and change the period
to whatever it wants. Other channels won't even notice.

Is there a way to set the period per channel?

> +static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
> +{
> +	int ret;
> +	unsigned long reg;
> +
> +	if (fpc->counter_clk_enable++)
> +		return 0;

Are you sure this is safe? I think you'll need to use either an atomic
or a mutex to lock this.

> +	ret = clk_prepare_enable(fpc->counter_clk);
> +	if (ret)
> +		return ret;

In case clk_prepare_enable() fails, the counter_clk_enable will need to
be decremented in order to track the state correctly, doesn't it?

> +
> +	reg = readl(fpc->base + FTM_SC);
> +	reg &= ~((FTMSC_CLK_MASK << FTMSC_CLK_OFFSET) |
> +			(FTMSC_PS_MASK << FTMSC_PS_OFFSET));
> +	/* select counter clock source */

There should be an empty line between the above two.

> +	switch (fpc->counter_clk_select) {
> +	case VF610_CLK_FTM0:
> +		reg |= FTMSC_CLKSYS;
> +		break;
> +	case VF610_CLK_FTM0_FIX_SEL:
> +		reg |= FTMSC_CLKFIX;
> +		break;
> +	case VF610_CLK_FTM0_EXT_SEL:
> +		reg |= FTMSC_CLKEXT;
> +		break;
> +	default:
> +		break;
> +	}
> +	reg |= fpc->clk_ps;

And another one above this line.

> +	writel(reg, fpc->base + FTM_SC);

I think with the proper locking in place what you should do is increment
counter_clk_enable only here. That makes avoids having to decrement the
count on error.

Similarly in fsl_counter_clock_disable() you can postpone decrementing
the count until the very end.

> +static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	fsl_counter_clock_enable(fpc);

This can fail. Should the error be propagated?

> +
> +	return 0;
> +}
> +
> +static void fsl_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	fsl_counter_clock_disable(fpc);
> +}

Same here. Since you can't propagate the error, perhaps an error message
would be appropriate here?

Also for the locking above, perhaps a good solution would be to acquire
the lock around the calls to fsl_counter_clock_{enable,disable}() so
that they can safely assume that they are called with the lock held,
which will make their implementation a lot simpler.

So what you could do is this:

	static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
	{
		struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
		int ret;

		mutex_lock(&fpc->lock);
		ret = fsl_counter_clock_enable(fpc);
		mutex_unlock(&fpc->lock);

		return ret;
	}

And analogously for fsl_pwm_disable().

> +static int fsl_pwm_calculate_ps(struct fsl_pwm_chip *fpc)
> +{
> +	unsigned long long sys_rate, counter_rate, ratio;
> +
> +	sys_rate = clk_get_rate(fpc->sys_clk);
> +	if (!sys_rate)
> +		return -EINVAL;
> +
> +	counter_rate = clk_get_rate(fpc->counter_clk);
> +	if (!counter_rate) {
> +		fpc->counter_clk = fpc->sys_clk;
> +		fpc->counter_clk_select = VF610_CLK_FTM0;
> +		dev_warn(fpc->chip.dev,
> +				"the counter source clock is a dummy clock, "
> +				"so select the system clock as default!\n");
> +	}
> +
> +	switch (fpc->counter_clk_select) {
> +	case VF610_CLK_FTM0_FIX_SEL:
> +		ratio = 2 * counter_rate - 1;
> +		do_div(ratio, sys_rate);
> +		fpc->clk_ps = ratio;
> +		break;
> +	case VF610_CLK_FTM0_EXT_SEL:
> +		ratio = 4 * counter_rate - 1;
> +		do_div(ratio, sys_rate);
> +		fpc->clk_ps = ratio;
> +		break;
> +	case VF610_CLK_FTM0:
> +		fpc->clk_ps = 7;

Even though it doesn't matter here, you should still add a break.
Otherwise if you ever modify the code in the default case, you don't
have to remember to add it in then.

> +static int fsl_pwm_parse_clk_ps(struct fsl_pwm_chip *fpc)
> +{
> +	int ret;
> +	struct of_phandle_args clkspec;
> +	struct device_node *np = fpc->chip.dev->of_node;
> +
> +	fpc->sys_clk = devm_clk_get(fpc->chip.dev, "ftm0");
> +	if (IS_ERR(fpc->sys_clk)) {
> +		ret = PTR_ERR(fpc->sys_clk);
> +		dev_err(fpc->chip.dev,
> +				"failed to get \"ftm0\" clock %d\n", ret);
> +		return ret;
> +	}
> +
> +	fpc->counter_clk = devm_clk_get(fpc->chip.dev, "ftm0_counter");
> +	if (IS_ERR(fpc->counter_clk)) {
> +		ret = PTR_ERR(fpc->counter_clk);
> +		dev_err(fpc->chip.dev,
> +				"failed to get \"ftm0_counter\" clock %d\n",
> +				ret);
> +		return ret;
> +	}
> +
> +	ret = of_parse_phandle_with_args(np, "clocks", "#clock-cells", 1,
> +					&clkspec);
> +	if (ret)
> +		return ret;
> +
> +	fpc->counter_clk_select = clkspec.args[0];

This isn't at all pretty. But given that once you have access to a
struct clk there's no way to identify it, I don't know of a better
alternative.

> +
> +	return fsl_pwm_calculate_ps(fpc);
> +}
> +
> +static int fsl_pwm_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;

There's no need to initialize this.

> +	struct fsl_pwm_chip *fpc;
> +	struct resource *res;
> +
> +	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> +	if (!fpc)
> +		return -ENOMEM;
> +
> +	fpc->chip.dev = &pdev->dev;
> +	fpc->counter_clk_enable = 0;

You use kzalloc(), so this is already be zeroed out.

> +	ret = fsl_pwm_parse_clk_ps(fpc);
> +	if (ret < 0)
> +		return ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	fpc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(fpc->base)) {
> +		ret = PTR_ERR(fpc->base);
> +		return ret;

You can simply do "return PTR_ERR(fpc->base);" here.

> +	}
> +
> +	fpc->chip.ops = &fsl_pwm_ops;
> +	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
> +	fpc->chip.of_pwm_n_cells = 3;
> +	fpc->chip.base = -1;
> +	fpc->chip.npwm = FTM_MAX_CHANNEL;
> +	ret = pwmchip_add(&fpc->chip);

There should be a blank linke between the above two.

> +static int fsl_pwm_remove(struct platform_device *pdev)
> +{
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = platform_get_drvdata(pdev);

These can go on one line.

> +static const struct of_device_id fsl_pwm_dt_ids[] = {
> +	{ .compatible = "fsl,vf610-ftm-pwm", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, fsl_pwm_dt_ids);
> +
> +static struct platform_driver fsl_pwm_driver = {
> +	.driver = {
> +		.name = "fsl-ftm-pwm",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(fsl_pwm_dt_ids),

No need for of_match_ptr() since you depend on OF. And while at it, you
can drop the initialization of .owner as well, since the core takes care
of initializing that nowadays.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/1641a3ea/attachment.sig>
