From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 20 May 2016 11:27:58 +0200
Subject: [PATCH 1/3] reset: Add support for the Amlogic Meson GXBB Reset
 Controller
In-Reply-To: <1463732875-23141-2-git-send-email-narmstrong@baylibre.com>
References: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
 <1463732875-23141-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <1463736478.4322.31.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Am Freitag, den 20.05.2016, 10:27 +0200 schrieb Neil Armstrong:
> This patch adds the platform driver for the Amlogic Meson GXBB Reset
> Controller.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/reset/Kconfig            |   6 ++
>  drivers/reset/Makefile           |   1 +
>  drivers/reset/reset-meson-gxbb.c | 129 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
>  create mode 100644 drivers/reset/reset-meson-gxbb.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index df37212..4ac5c4d 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -12,5 +12,11 @@ menuconfig RESET_CONTROLLER
>  
>  	  If unsure, say no.
>  
> +config MESON_GXBB_RESET
> +	tristate "Amlogic Meson GXBB Reset Driver"
> +	depends on (ARCH_MESON && RESET_CONTROLLER)

With the "reset: fix Kconfig menu to include reset drivers in sub-menu"
patch [1] applied this is wrapped in "if RESET_CONTROLLER ... endif", so
no need to depend on RESET_CONTROLLER.
Is there a reason to have this configurable at all, though?

[1] https://patchwork.kernel.org/patch/9000591/

> +	help
> +	  Build the Amlogic Meson GxBB reset driver.
> +
>  source "drivers/reset/sti/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index a1fc8ed..5ff83a1 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
> +obj-$(CONFIG_MESON_GXBB_RESET) += reset-meson-gxbb.o

Or drop CONFIG_MESON_GXBB_RESET and use CONFIG_ARCH_MESON directly.

[...]
> +static int meson_gxbb_reset_probe(struct platform_device *pdev)
> +{
> +	struct meson_gxbb_reset *data;
> +	struct resource *res;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->reg_base))
> +		return PTR_ERR(data->reg_base);
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = REG_COUNT * BITS_PER_REG;
> +	data->rcdev.ops = &meson_gxbb_reset_ops;
> +	data->rcdev.of_node = pdev->dev.of_node;
> +
> +	return reset_controller_register(&data->rcdev);

With the "reset: add devm_reset_controller_register API" patch [2]
applied you can use devm_reset_controller_register() here and remove the
meson_gxbb_reset_remove() function below.

[2] https://patchwork.kernel.org/patch/8988471/

> +}
> +
> +static int meson_gxbb_reset_remove(struct platform_device *pdev)
> +{
> +	struct meson_gxbb_reset *data = platform_get_drvdata(pdev);
> +
> +	reset_controller_unregister(&data->rcdev);
> +
> +	return 0;
> +}

Could be removed, then.

regards
Philipp
