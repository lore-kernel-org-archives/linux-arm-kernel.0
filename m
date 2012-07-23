From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 23 Jul 2012 08:52:35 +0200
Subject: [PATCH 1/2] PWM: ECAP: PWM driver support for ECAP APWM.
In-Reply-To: <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
Message-ID: <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 03:05:01PM +0530, Philip, Avinash wrote:
> ECAP hardware on AM33XX SOC supports auxiliary PWM (APWM) feature. This
> commit adds PWM driver support for ECAP hardware on AM33XX SOC.
> 
> In the ECAP hardware, each PWM pin can also be configured to be in
> capture mode. Current implementation only supports PWM mode of
> operation. Also, hardware supports sync between multiple PWM pins but
> the driver supports simple independent PWM functionality.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Reviewed-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
> :100644 100644 94e176e... f20b8f2... M	drivers/pwm/Kconfig
> :100644 100644 5459702... 7dd90ec... M	drivers/pwm/Makefile
> :000000 100644 0000000... 81efc9e... A	drivers/pwm/pwm-ecap.c
>  drivers/pwm/Kconfig    |   10 ++
>  drivers/pwm/Makefile   |    1 +
>  drivers/pwm/pwm-ecap.c |  255 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 266 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 94e176e..f20b8f2 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -85,4 +85,14 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
>  
> +config  PWM_ECAP
> +	tristate "ECAP PWM support"
> +	depends on SOC_AM33XX
> +	help
> +	  PWM driver support for the ECAP APWM controller found on AM33XX
> +	  TI SOC
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm_ecap.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 5459702..7dd90ec 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> +obj-$(CONFIG_PWM_ECAP)		+= pwm-ecap.o

Both the Kconfig and Makefile should have the entries ordered
alphabetically.

> diff --git a/drivers/pwm/pwm-ecap.c b/drivers/pwm/pwm-ecap.c
> new file mode 100644
> index 0000000..81efc9e
> --- /dev/null
> +++ b/drivers/pwm/pwm-ecap.c
> @@ -0,0 +1,255 @@
> +/*
> + * ECAP PWM driver
> + *
> + * Copyright (C) 2012 Texas Instruments, Inc. - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +
> +/* ECAP registers and bits definitions */
> +#define TSCTR			0x00
> +#define CTRPHS			0x04
> +#define CAP1			0x08
> +#define CAP2			0x0C
> +#define CAP3			0x10
> +#define CAP4			0x14
> +#define ECCTL1			0x28

These registers are not used. I guess there is some use to list all
registers here but on the other hand the majority are unused so they
just clutter the driver.

> +#define ECCTL2_APWM_POL_LOW	BIT(10)

This bit is never used.

> +#define ECEINT			0x2C
> +#define ECFLG			0x2E
> +#define ECCLR			0x30
> +#define REVID			0x5c

These are unused as well.

> +
> +#define DRIVER_NAME	"ecap"

You only use this once when defining the struct platform_driver, so
maybe you can just drop it.

> +
> +struct ecap_pwm_chip {
> +	struct pwm_chip	chip;
> +	unsigned int	clk_rate;
> +	void __iomem	*mmio_base;
> +	int		pwm_period_ns;
> +	int		pwm_duty_ns;
> +};

The pwm_period_ns and pwm_duty_ns don't seem to be used at all. Can they
be dropped?

> +
> +static inline struct ecap_pwm_chip *to_ecap_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct ecap_pwm_chip, chip);
> +}
> +
> +/*
> + * period_ns = 10^9 * period_cycles / PWM_CLK_RATE
> + * duty_ns   = 10^9 * duty_cycles / PWM_CLK_RATE
> + */
> +static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +		int duty_ns, int period_ns)
> +{
> +	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
> +	unsigned long long c;
> +	unsigned long period_cycles, duty_cycles;
> +	unsigned int reg_val;
> +
> +	if (period_ns < 0 || duty_ns < 0 || period_ns > NSEC_PER_SEC)
> +		return -ERANGE;
> +
> +	c = pc->clk_rate;
> +	c = c * period_ns;
> +	do_div(c, NSEC_PER_SEC);
> +	period_cycles = (unsigned long)c;
> +
> +	if (period_cycles < 1) {
> +		period_cycles = 1;
> +		duty_cycles = 1;
> +	} else {
> +		c = pc->clk_rate;
> +		c = c * duty_ns;
> +		do_div(c, NSEC_PER_SEC);
> +		duty_cycles = (unsigned long)c;
> +	}
> +
> +	pc->pwm_duty_ns = duty_ns;
> +	pc->pwm_period_ns = period_ns;
> +
> +	pm_runtime_get_sync(pc->chip.dev);
> +
> +	reg_val = readw(pc->mmio_base + ECCTL2);
> +
> +	/* Configure PWM mode & disable sync option */
> +	reg_val |= ECCTL2_APWM_MODE | ECCTL2_SYNC_SEL_DISA;
> +
> +	writew(reg_val, pc->mmio_base + ECCTL2);
> +
> +	if (!test_bit(PWMF_ENABLED, &pwm->flags)) {
> +		/* Update active registers if not running */
> +		writel(duty_cycles, pc->mmio_base + CAP2);
> +		writel(period_cycles, pc->mmio_base + CAP1);
> +	} else {
> +		/*
> +		 * Update shadow registers to configure period and
> +		 * compare values. This helps current PWM period to
> +		 * complete on reconfiguring
> +		 */
> +		writel(duty_cycles, pc->mmio_base + CAP4);
> +		writel(period_cycles, pc->mmio_base + CAP3);
> +	}
> +
> +	pm_runtime_put_sync(pc->chip.dev);
> +	return 0;
> +}
> +
> +static int ecap_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
> +	unsigned int reg_val;
> +
> +	/* Leave clock enabled on enabling PWM */
> +	pm_runtime_get_sync(pc->chip.dev);
> +
> +	/*
> +	 * Enable 'Free run Time stamp counter mode' to start counter
> +	 * and  'APWM mode' to enable APWM output
> +	 */
> +	reg_val = readw(pc->mmio_base + ECCTL2);
> +	reg_val |= ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE;

You already set the APWM_MODE bit in .config(), why is it needed here
again? Seeing that .disable() clears the bit as well, perhaps leaving it
clear in .config() is the better option.

> +	writew(reg_val, pc->mmio_base + ECCTL2);
> +	return 0;
> +}
> +
> +static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
> +	unsigned int reg_val;
> +
> +	/*
> +	 * Disable 'Free run Time stamp counter mode' to stop counter
> +	 * and 'APWM mode' to put APWM output to low
> +	 */
> +	reg_val = readw(pc->mmio_base + ECCTL2);
> +	reg_val &= ~(ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE);
> +	writew(reg_val, pc->mmio_base + ECCTL2);
> +
> +	/* Disable clock on PWM disable */
> +	pm_runtime_put_sync(pc->chip.dev);
> +}
> +
> +static void ecap_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
> +		dev_warn(chip->dev, "Removing PWM device without disabling\n");
> +		pm_runtime_put_sync(chip->dev);
> +	}
> +}

I wonder whether we want to have something like this in the PWM core at
some point. Maybe we should call .disable() automatically when they are
freed, or alternatively return -EBUSY if a PWM is freed but still
enabled. I think I prefer the latter. For now we can leave this in,
because I don't want to make any such core changes for 3.6 now that the
merge window is open.

> +
> +static struct pwm_ops ecap_pwm_ops = {
> +	.free		= ecap_pwm_free,
> +	.config		= ecap_pwm_config,
> +	.enable		= ecap_pwm_enable,
> +	.disable	= ecap_pwm_disable,
> +	.owner		= THIS_MODULE,
> +};

This should be "static const pwm_ops ...".

> +
> +static int __devinit ecap_pwm_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct resource *r;
> +	struct clk *clk;
> +	struct ecap_pwm_chip *pc;
> +
> +	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc) {
> +		dev_err(&pdev->dev, "failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	clk = devm_clk_get(&pdev->dev, "fck");
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "failed to get clock\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	pc->clk_rate = clk_get_rate(clk);
> +	if (!pc->clk_rate) {
> +		dev_err(&pdev->dev, "failed to get clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	pc->chip.dev = &pdev->dev;
> +	pc->chip.ops = &ecap_pwm_ops;
> +	pc->chip.base = -1;
> +	pc->chip.npwm = 1;

The cover letter mentions that the AM335x has 3 instances of the ECAP.
Is there any chance that they can be unified in one driver instance
(i.e. .npwm = 3?).

> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecap_reg");
> +	if (r == NULL) {

You use "if (!ptr)" everywhere else, maybe you should make this
consistent? Also the platform_get_resource_byname() is really only
useful for devices that have several register regions associated with
them. I don't know your hardware in detail, but I doubt that a PWM
device has more than one register region.

> +		dev_err(&pdev->dev, "no memory resource defined\n");
> +		return -ENODEV;
> +	}
> +
> +	pc->mmio_base = devm_request_and_ioremap(&pdev->dev, r);
> +	if (!pc->mmio_base) {
> +		dev_err(&pdev->dev, "failed to ioremap() registers\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	ret = pwmchip_add(&pc->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +	platform_set_drvdata(pdev, pc);
> +	dev_info(&pdev->dev, "PWM device initialized\n");

I think this can go away. If none of the above errors is shown you can
just assume that the PWM was initialized.

> +	return 0;
> +}
> +
> +static int __devexit ecap_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ecap_pwm_chip *pc = platform_get_drvdata(pdev);
> +	struct pwm_device *pwm;
> +
> +	if (WARN_ON(!pc))
> +		return -ENODEV;

Do you really want to be this verbose? This kind of check is very rare
anyway, but explicitly warning about it doesn't seems overkill. I think
the check can even be left out, since every possible error that would
lead to the driver data not being checked would already cause .probe()
to return < 0 and therefore .remove() won't ever be called anyway.

> +
> +	pwm = &pc->chip.pwms[0];

You don't use this variable.

Thierry

> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pwmchip_remove(&pc->chip);
> +	return 0;
> +}
> +
> +static struct platform_driver ecap_pwm_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +	},
> +	.probe = ecap_pwm_probe,
> +	.remove = __devexit_p(ecap_pwm_remove),
> +};
> +
> +module_platform_driver(ecap_pwm_driver);
> +
> +MODULE_DESCRIPTION("ECAP PWM driver");
> +MODULE_AUTHOR("Texas Instruments");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/75e99371/attachment-0001.sig>
