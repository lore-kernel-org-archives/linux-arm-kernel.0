From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 22 Oct 2012 08:34:23 +0200
Subject: [PATCH 2/3] PWM: vt8500: Update vt8500 PWM driver support
In-Reply-To: <1350643135-13197-2-git-send-email-linux@prisktech.co.nz>
References: <1350643135-13197-1-git-send-email-linux@prisktech.co.nz>
 <1350643135-13197-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121022063423.GA17181@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 11:38:54PM +1300, Tony Prisk wrote:
> This patch updates pwm-vt8500.c to support devicetree probing and
> make use of the common clock subsystem.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/pwm/pwm-vt8500.c |   79 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 51 insertions(+), 28 deletions(-)

On the whole, this looks like a great cleanup. A few minor issues
inline.

I should start with the subject: please keep lowercase pwm: as the
prefix for consistency. Uppercase PWM is used to refer to PWM devices in
prose.

Also I'd rather see the clock subsystem changes and device tree changes
in separate patches, but since both are rather intertwined I won't force
the issue.

> diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
> index ad14389..c2a71ee 100644
> --- a/drivers/pwm/pwm-vt8500.c
> +++ b/drivers/pwm/pwm-vt8500.c
> @@ -1,7 +1,8 @@
>  /*
>   * drivers/pwm/pwm-vt8500.c
>   *
> - *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> + * Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -21,14 +22,24 @@
>  #include <linux/io.h>
>  #include <linux/pwm.h>
>  #include <linux/delay.h>
> +#include <linux/clk.h>
>  
>  #include <asm/div64.h>
>  
> -#define VT8500_NR_PWMS 4
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +
> +/*
> + * SoC architecture allocates register space for 4 PWMs but only
> + * 2 are currently implemented.
> + */
> +#define VT8500_NR_PWMS	2
>  
>  struct vt8500_chip {
>  	struct pwm_chip chip;
>  	void __iomem *base;
> +	struct clk *clk;
>  };
>  
>  #define to_vt8500_chip(chip)	container_of(chip, struct vt8500_chip, chip)
> @@ -52,7 +63,7 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned long long c;
>  	unsigned long period_cycles, prescale, pv, dc;
>  
> -	c = 25000000/2; /* wild guess --- need to implement clocks */
> +	c = clk_get_rate(vt8500->clk);
>  	c = c * period_ns;
>  	do_div(c, 1000000000);
>  	period_cycles = c;
> @@ -107,12 +118,22 @@ static struct pwm_ops vt8500_pwm_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> -static int __devinit pwm_probe(struct platform_device *pdev)
> +static const struct of_device_id vt8500_pwm_dt_ids[] = {
> +	{ .compatible = "via,vt8500-pwm", },
> +	{ /* Sentinel */ }
> +};
> +
> +static int __devinit vt8500_pwm_probe(struct platform_device *pdev)

Since you're changing this line anyway, maybe you should drop __devinit
(and __devexit for the .remove() callback). HOTPLUG is always enabled
nowadays and will go away eventually, in which case these will need to
be removed anyway.

>  {
>  	struct vt8500_chip *chip;
> -	struct resource *r;
> +	struct device_node *np = pdev->dev.of_node;
>  	int ret;
>  
> +	if (!np) {
> +		dev_err(&pdev->dev, "invalid devicetree node\n");
> +		return -EINVAL;
> +	}
> +

This effectively makes DT support mandatory. Shouldn't you be adding a
"depends on OF" into the Kconfig section in that case?

>  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>  	if (chip == NULL) {
>  		dev_err(&pdev->dev, "failed to allocate memory\n");
> @@ -123,26 +144,32 @@ static int __devinit pwm_probe(struct platform_device *pdev)
>  	chip->chip.ops = &vt8500_pwm_ops;
>  	chip->chip.base = -1;
>  	chip->chip.npwm = VT8500_NR_PWMS;
> +	chip->clk = of_clk_get(np, 0);

I thought this was supposed to work transparently across OF and !OF
configurations by using just clk_get() or devm_clk_get()? I guess that
if the driver depends on OF, then this would be moot, but we should
probably stick to the standard usage anyway.

Furthermore, of_clk_get() doesn't seem to be managed, so you'd need to
add explicit clk_put() in the error cleanup paths. One more argument in
favour of using devm_clk_get() instead.

> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (r == NULL) {
> -		dev_err(&pdev->dev, "no memory resource defined\n");
> -		return -ENODEV;
> +	if (!chip->clk) {
> +		dev_err(&pdev->dev, "clock source not specified\n");
> +		return -EINVAL;
>  	}
>  
> -	chip->base = devm_request_and_ioremap(&pdev->dev, r);
> -	if (chip->base == NULL)
> +	chip->base = of_iomap(np, 0);

No need to change this. It should work with the standard calls as well.

> +	if (!chip->base) {
> +		dev_err(&pdev->dev, "memory resource not available\n");
>  		return -EADDRNOTAVAIL;
> +	}
> +
> +	clk_prepare_enable(chip->clk);

Why does the clock need to be enabled here? Shouldn't it be postponed to
the last possible moment to save power?

>  
>  	ret = pwmchip_add(&chip->chip);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add pwmchip\n");
>  		return ret;
> +	}
>  
>  	platform_set_drvdata(pdev, chip);
>  	return ret;
>  }
>  
> -static int __devexit pwm_remove(struct platform_device *pdev)
> +static int __devexit vt8500_pwm_remove(struct platform_device *pdev)
>  {
>  	struct vt8500_chip *chip;
>  
> @@ -150,28 +177,24 @@ static int __devexit pwm_remove(struct platform_device *pdev)
>  	if (chip == NULL)
>  		return -ENODEV;
>  
> +	clk_disable_unprepare(chip->clk);
> +

Again, shouldn't it be more efficient power-wise to disable this as soon
as the last PWM device is disabled?

>  	return pwmchip_remove(&chip->chip);
>  }
>  
> -static struct platform_driver pwm_driver = {
> +static struct platform_driver vt8500_pwm_driver = {
> +	.probe		= vt8500_pwm_probe,
> +	.remove		= __devexit_p(vt8500_pwm_remove),

__devexit_p can also be removed.

>  	.driver		= {
>  		.name	= "vt8500-pwm",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = vt8500_pwm_dt_ids,
>  	},
> -	.probe		= pwm_probe,
> -	.remove		= __devexit_p(pwm_remove),
>  };
>  
> -static int __init pwm_init(void)
> -{
> -	return platform_driver_register(&pwm_driver);
> -}
> -arch_initcall(pwm_init);
> -
> -static void __exit pwm_exit(void)
> -{
> -	platform_driver_unregister(&pwm_driver);
> -}
> -module_exit(pwm_exit);
> +module_platform_driver(vt8500_pwm_driver);
>  
> -MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("VT8500 PWM Driver");
> +MODULE_AUTHOR("Tony Prisk <linux@prisktech.co.nz>");
> +MODULE_LICENSE("GPL v2");

IANAL, but I think you need the approval of all authors of this code
before changing the license. But I see that the file header actually
says that this code is GPL v2, so maybe this change could be considered
a bugfix. =)

> +MODULE_DEVICE_TABLE(of, vt8500_pwm_dt_ids);

I think it is customary to put this right after the device table
definition.

> -- 
> 1.7.9.5
> 
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121022/9ea2d26e/attachment.sig>
