From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Jun 2014 23:42:58 +0200
Subject: [PATCH 1/3] pwm: add Rockchip SoC PWM support
In-Reply-To: <1399504115-16257-2-git-send-email-b.galvani@gmail.com>
References: <1399504115-16257-1-git-send-email-b.galvani@gmail.com>
 <1399504115-16257-2-git-send-email-b.galvani@gmail.com>
Message-ID: <20140617214253.GA24743@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 01:08:33AM +0200, Beniamino Galvani wrote:
> This commit adds a driver for the PWM controller found on Rockchip
> RK29, RK30 and RK31 SoCs.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/pwm/Kconfig        |    8 ++
>  drivers/pwm/Makefile       |    1 +
>  drivers/pwm/pwm-rockchip.c |  180 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rockchip.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 5b34ff2..2e92245 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -197,6 +197,14 @@ config PWM_RENESAS_TPU
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-renesas-tpu.
>  
> +config PWM_ROCKCHIP
> +	tristate "Rockchip PWM support"
> +	depends on ARCH_ROCKCHIP
> +	depends on OF

It seems like ARCH_ROCKCHIP depends on OF already (via ARCH_MULTI_V7 and
ARCH_MULTIPLATFORM), so having the dependency explicitly here seems
redundant.

> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
[...]
> +#define PRESCALER		2
> +#define NSECS_PER_SEC		1000000000

You should use NSEC_PER_SEC from include/linux/time.h.

> +struct rockchip_pwm_chip {
> +	struct pwm_chip	chip;
> +	struct clk	*clk;
> +	void __iomem	*base;
> +};

I prefer no artificial padding within structure definitions.

> +static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       int duty_ns, int period_ns)
> +{
> +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> +	unsigned long clk_rate, period, duty;
> +	u64 div;
> +	int ret;
> +
> +	clk_rate = clk_get_rate(pc->clk);
> +
> +	/*
> +	 * Since period and duty cycle registers have a width of 32
> +	 * bits, every possible input period can be obtained using the
> +	 * default prescaler value for all practical clock rate values.
> +	 */
> +	div = clk_rate;
> +	div *= period_ns;

Perhaps shorten this to "div = clk_rate * period_ns;"?

> +	do_div(div, PRESCALER * NSECS_PER_SEC);
> +	period = div;
> +
> +	div = clk_rate;
> +	div *= duty_ns;

And this to "div = clk_rate * duty_ns;"?

> +	do_div(div, PRESCALER * NSECS_PER_SEC);
> +	duty = div;
> +
> +	ret = clk_enable(pc->clk);
> +	if (ret)
> +		return ret;
> +
> +	writel(period, pc->base + PWM_LRC);
> +	writel(duty, pc->base + PWM_HRC);
> +	writel(0, pc->base + PWM_CNTR);
> +
> +	clk_disable(pc->clk);
> +
> +	return 0;
> +}
[...]
> +static struct pwm_ops rockchip_pwm_ops = {

static const please.

> +	.config	= rockchip_pwm_config,

There's a tab between .config and = above. It should be a space.

> +static const struct of_device_id rockchip_pwm_dt_ids[] = {
> +	{ .compatible = "rockchip,rk2928-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_pwm_id_ids);

The name in the MODULE_DEVICE_TABLE doesn't match the array name above.
Does this even build?

> +static struct platform_driver rockchip_pwm_driver = {
> +	.driver = {
> +		.name = "rockchip-pwm",
> +		.owner = THIS_MODULE,

You no longer need to initialize this explicitly, module_platform_driver
does it for you.

> +		.of_match_table = rockchip_pwm_dt_ids,
> +	},
> +	.probe	= rockchip_pwm_probe,

There's another tab instead of space here.

> +	.remove = rockchip_pwm_remove,
> +};
> +module_platform_driver(rockchip_pwm_driver);
> +
> +MODULE_AUTHOR("Beniamino Galvani <b.galvani@gmail.com>");
> +MODULE_DESCRIPTION("Rockchip PWM driver");

Perhaps "Rockchip SoC PWM driver"?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/fc9d466f/attachment-0001.sig>
