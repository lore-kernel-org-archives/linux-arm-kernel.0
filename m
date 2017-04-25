From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 25 Apr 2017 10:43:42 +0200
Subject: [PATCH 2/2] reset: Add a Gemini reset controller
In-Reply-To: <20170424192802.27430-1-linus.walleij@linaro.org>
References: <20170424192802.27430-1-linus.walleij@linaro.org>
Message-ID: <1493109822.2394.15.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

thank you for the patch. A few comments and questions below:

On Mon, 2017-04-24 at 21:28 +0200, Linus Walleij wrote:
> The Cortina Systems Gemini reset controller is a simple
> 32bit register with self-deasserting reset lines. It is
> accessed using regmap over syscon.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/reset/Kconfig        |   7 +++
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-gemini.c | 112 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+)
>  create mode 100644 drivers/reset/reset-gemini.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index f4cdfe94b9ec..a82e1a78de25 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -27,6 +27,13 @@ config RESET_BERLIN
>  	help
>  	  This enables the reset controller driver for Marvell Berlin SoCs.
>  
> +config RESET_GEMINI
> +	bool "Gemini Reset Driver" if COMPILE_TEST
> +	default ARCH_GEMINI
> +	select MFD_SYSCON
> +	help
> +	  This enables the reset controller driver for Cortina Systems Gemini.
> +
>  config RESET_LPC18XX
>  	bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
>  	default ARCH_LPC18XX
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 2cd3f6c45165..99e90ad18545 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_STI) += sti/
>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
> +obj-$(CONFIG_RESET_GEMINI) += reset-gemini.o
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
> diff --git a/drivers/reset/reset-gemini.c b/drivers/reset/reset-gemini.c
> new file mode 100644
> index 000000000000..481facbb2709
> --- /dev/null
> +++ b/drivers/reset/reset-gemini.c
> @@ -0,0 +1,112 @@
> +/*
> + * Cortina Gemini Reset controller driver
> + * Copyright (c) 2017 Linus Walleij <linus.walleij@linaro.org>

No license statement, choice or oversight?

> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +
> +/**
> + * struct gemini_reset - gemini reset controller
> + * @map: regmap to access the containing system controller
> + * @dev: pointer back to device
> + * @rcdev: reset controller device
> + */
> +struct gemini_reset {
> +	struct regmap *map;
> +	struct device *dev;

dev is unused, can be dropped.

> +	struct reset_controller_dev rcdev;
> +};
> +
> +#define GEMINI_GLOBAL_SOFT_RESET 0x0c
> +
> +#define to_gemini_reset(p) \
> +	container_of((p), struct gemini_reset, rcdev)
> +
> +/*
> + * This is a self-deasserting reset controller.
> + */
> +static int gemini_reset(struct reset_controller_dev *rcdev,
> +			unsigned long id)
> +{
> +	struct gemini_reset *gr = to_gemini_reset(rcdev);
> +
> +	/* Manual says to always set BIT 30 to 1 */
> +	return regmap_write(gr->map,
> +			    GEMINI_GLOBAL_SOFT_RESET,
> +			    BIT(30) | BIT(id));

BIT(30) is called CPU1 reset in the DT binding, maybe add a #define?

> +}
> +
> +static int gemini_reset_status(struct reset_controller_dev *rcdev,
> +			     unsigned long id)
> +{
> +	struct gemini_reset *gr = to_gemini_reset(rcdev);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(gr->map, GEMINI_GLOBAL_SOFT_RESET, &val);
> +	if (ret)
> +		return ret;
> +
> +	return !!(val & BIT(id));
> +}
> +
> +static const struct reset_control_ops gemini_reset_ops = {
> +	.reset = gemini_reset,
> +	.status = gemini_reset_status,
> +};
> +
> +static int gemini_reset_probe(struct platform_device *pdev)
> +{
> +	struct gemini_reset *gr;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *parent_np = np->parent;
> +	int ret;
> +
> +	if (!parent_np) {

Is this even possible?

> +		dev_err(dev, "missing parent node\n");
> +		return -ENODEV;
> +	}
>+
> +	gr = devm_kzalloc(dev, sizeof(*gr), GFP_KERNEL);
> +	if (!gr)
> +		return -ENOMEM;
> +
> +	gr->dev = dev;

Can be dropped.

> +	gr->map = syscon_node_to_regmap(parent_np);
> +	if (IS_ERR(gr->map)) {
> +		dev_err(dev, "unable to get regmap");

It might be helpful to print the error code here.

> +		return PTR_ERR(gr->map);
> +	}
> +	gr->rcdev.owner = THIS_MODULE;
> +	gr->rcdev.nr_resets = 32;
> +	gr->rcdev.ops = &gemini_reset_ops;
> +	gr->rcdev.of_node = pdev->dev.of_node;
> +
> +	ret = devm_reset_controller_register(&pdev->dev, &gr->rcdev);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "registered Gemini reset controller\n");

This is a bit verbose. I'd remove it and shorten the last part to:

	return devm_reset_controller_register(&pdev->dev, &gr->rcdev);

> +	return 0;
> +}
> +
> +static const struct of_device_id gemini_reset_dt_ids[] = {
> +	{ .compatible = "cortina,gemini-reset", },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver gemini_reset_driver = {
> +	.probe	= gemini_reset_probe,
> +	.driver = {
> +		.name		= "gemini-reset",
> +		.of_match_table	= gemini_reset_dt_ids,
> +	},
> +};
> +builtin_platform_driver(gemini_reset_driver);

regards
Philipp
