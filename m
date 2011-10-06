From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 6 Oct 2011 17:02:00 +0100
Subject: [PATCH 2/2] hw_random: add driver for atmel true hardware random
	number generator
In-Reply-To: <1317915694-27564-2-git-send-email-jacmet@sunsite.dk>
References: <1317915694-27564-1-git-send-email-jacmet@sunsite.dk>
	<1317915694-27564-2-git-send-email-jacmet@sunsite.dk>
Message-ID: <20111006160200.GF1931@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

A couple of minor nits inline, but otherwise looks nice to me!

Jamie

On Thu, Oct 06, 2011 at 05:41:34PM +0200, Peter Korsgaard wrote:
> diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
> new file mode 100644
> index 0000000..c69eccb
> --- /dev/null
> +++ b/drivers/char/hw_random/atmel-rng.c
> @@ -0,0 +1,168 @@
> +/*
> + * Copyright (c) 2011 Peter Korsgaard <jacmet@sunsite.dk>
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/hw_random.h>
> +#include <linux/platform_device.h>
> +
> +#define TRNG_CR		0x00
> +#define TRNG_ISR	0x1c
> +#define TRNG_ODATA	0x50
> +
> +#define TRNG_KEY	0x524e4700 /* RNG */
> +
> +struct atmel_trng {
> +	struct clk *clk;
> +	void __iomem *base;
> +};
> +
> +static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
> +			   bool wait)
> +{
> +	struct atmel_trng *trng = (struct atmel_trng *)rng->priv;
> +	u32 *data = buf;
> +
> +	/* data ready? */
> +	if (readl(trng->base + TRNG_ODATA) & 1) {
> +		*data = readl(trng->base + TRNG_ODATA);
> +		return 4;
> +	} else
> +		return 0;
> +}
> +
> +static struct hwrng atmel_trng = {
> +	.name	= "atmel-trng",
> +	.read	= atmel_trng_read,
> +};

Could you do:

struct atmel_trng {
	struct clk *clk;
	void __iomem *base;
	struct hwrng rng;
};

#define to_atmel_trng(rng) \
	container_of(rng, struct amtel_trng, rng)

which would allow you to support more than one TRNG (although unlikely) 
but also means you don't need the cast for priv.

> +static int atmel_trng_probe(struct platform_device *pdev)
> +{
> +	struct atmel_trng *trng;
> +	struct resource *res;
> +	int ret;
> +
> +	if (atmel_trng.priv) {
> +		dev_err(&pdev->dev, "multiple instances not supported\n");
> +		return -EBUSY;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	trng = devm_kzalloc(&pdev->dev, sizeof(*trng), GFP_KERNEL);
> +	if (!trng)
> +		return -ENOMEM;
> +
> +	if (!devm_request_mem_region(&pdev->dev, res->start,
> +				     resource_size(res), pdev->name))
> +		return -EBUSY;
> +
> +	trng->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!trng->base)
> +		return -EBUSY;
> +
> +	trng->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(trng->clk))
> +		return PTR_ERR(trng->clk);
> +
> +	ret = clk_enable(trng->clk);
> +	if (ret)
> +		goto err_enable;
> +
> +	writel(TRNG_KEY | 1, trng->base + TRNG_CR);
> +
> +	atmel_trng.priv = (unsigned long)trng;
> +
> +	ret = hwrng_register(&atmel_trng);
> +	if (ret)
> +		goto err_register;
> +
> +	platform_set_drvdata(pdev, trng);
> +
> +	return 0;
> +
> +err_register:
> +	atmel_trng.priv = 0;
> +	clk_disable(trng->clk);
> +err_enable:
> +	clk_put(trng->clk);
> +
> +	return ret;
> +}
> +
> +static int __devexit atmel_trng_remove(struct platform_device *pdev)
> +{
> +	struct atmel_trng *trng = platform_get_drvdata(pdev);
> +
> +	hwrng_unregister(&atmel_trng);
> +
> +	writel(TRNG_KEY, trng->base + TRNG_CR);
> +	clk_disable(trng->clk);
> +	clk_put(trng->clk);
> +
> +	atmel_trng.priv = 0;

I think this should have a platform_set_drvdata(pdev, NULL) too.
