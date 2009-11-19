From: shinel@foxmail.com (Shine Liu)
Date: Thu, 19 Nov 2009 13:46:55 +0800
Subject: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from
	Arnaud Patard.
In-Reply-To: <20091118232948.063635416@fluff.org.uk>
References: <20091118232939.201290297@fluff.org.uk>
	<20091118232948.063635416@fluff.org.uk>
Message-ID: <1258609615.2676.31.camel@shinel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,Ben

Besides Dmitry's comments,

On Wed, 2009-11-18 at 23:29 +0000, Ben Dooks wrote:

> +config TOUCHSCREEN_S3C2410
> +       tristate "Samsung S3C2410 touchscreen input driver"
> +       depends on ARCH_S3C2410 && INPUT && INPUT_TOUCHSCREEN
> +       select SERIO
> +       help
> +         Say Y here if you have the s3c2410 touchscreen.
> +
> +         If unsure, say N.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called s3c2410_ts.

S3C24XX_ADC should be added to the depends.

> +#include <linux/slab.h>

I think this is not really needed because kernel.h is included already.


> +
> +	ts.clock = clk_get(dev, "adc");
> +	if (IS_ERR(ts.clock)) {
> +		dev_err(dev, "cannot get adc clock source\n");
> +		return -ENOENT;
> +	}
> +
> +	clk_enable(ts.clock);
> +	dev_dbg(dev, "got and enabled clocks\n");

Well, we take 2410_ts as s3c adc client, so these work has been done in
s3c_adc_probe function of arch/arm/plat-s3c24xx.c

This should be duplicated.

And "#include <linux/clk.h>" is not needed because we don't use these
APIs


> + err_clk:
> +       clk_put(ts.clock);
> +       return ret;
> +}

Above reason and also for those "goto err_clk;"

> );
> +
> +	clk_disable(ts.clock);
> +	clk_put(ts.clock);

Same as above

> +
> +#ifdef CONFIG_PM
> +static int s3c2410ts_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	writel(TSC_SLEEP, ts.io + S3C2410_ADCTSC);
> +	disable_irq(ts.irq_tc);

Same as above

> +
> +static int s3c2410ts_resume(struct platform_device *pdev)
> +{
> +	struct s3c2410_ts_mach_info *info = pdev->dev.platform_data;
> +
> +	clk_enable(ts.clock);

Same as above


Cheers,

Shine
