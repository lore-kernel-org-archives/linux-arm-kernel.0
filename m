From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Jun 2013 04:19:33 +0300
Subject: [PATCH 1/3] usb: chipidea: add CSR SiRFSoC ci13xxx usb driver
In-Reply-To: <1370748338-13210-2-git-send-email-Baohua.Song@csr.com>
References: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
 <1370748338-13210-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130612011933.GA8331@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 11:25:36AM +0800, Barry Song wrote:
> From: Rong Wang <Rong.Wang@csr.com>
> 
> CSR SiRF SoCs licensed chipidea ci13xxx USB IP, this patch
> makes the chipidea drivers support CSR SiRF SoCS.
> 
> It also changes the Kconfig, only compile MSM and IMX if related
> drivers are enabled. Otherwise, we always need to enable all
> clients of chipidea drivers.
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Richard Zhao <richard.zhao@freescale.com>
> Signed-off-by: Rong Wang <Rong.Wang@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/usb/Kconfig                 |    1 +
>  drivers/usb/chipidea/Kconfig        |   25 ++++
>  drivers/usb/chipidea/Makefile       |    5 +-
>  drivers/usb/chipidea/ci13xxx_sirf.c |  223 +++++++++++++++++++++++++++++++++++
>  4 files changed, 252 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/usb/chipidea/ci13xxx_sirf.c
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 92e1dc9..9cbe1e0 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -49,6 +49,7 @@ config USB_ARCH_HAS_EHCI
>  	default y if ARCH_MMP
>  	default y if MACH_LOONGSON1
>  	default y if PLAT_ORION
> +	default y if ARCH_SIRF
>  	default PCI
>  
>  # some non-PCI HCDs implement xHCI
> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
> index b2df442..847b9f7 100644
> --- a/drivers/usb/chipidea/Kconfig
> +++ b/drivers/usb/chipidea/Kconfig
> @@ -31,4 +31,29 @@ config USB_CHIPIDEA_DEBUG
>  	help
>  	  Say Y here to enable debugging output of the ChipIdea driver.
>  
> +if USB_CHIPIDEA_UDC && USB_CHIPIDEA_HOST
> +
> +config USB_CHIPIDEA_SIRF
> +	depends on ARCH_SIRF
> +	bool "SiRF USB controller ChipIdea driver binding"
> +	default y
> +	help
> +	  Say Y here to enable sirf usb ChipIdea driver binding.
> +
> +config USB_CHIPIDEA_MSM
> +	depends on ARCH_MSM
> +	bool "MSM USB controller ChipIdea driver binding"
> +	default y
> +	help
> +	  Say Y here to enable msm usb ChipIdea driver binding.
> +
> +config USB_CHIPIDEA_IMX
> +	depends on ARCH_MXC || ARCH_MXS
> +	bool "i.MX USB controller ChipIdea driver binding"
> +	default y
> +	help
> +	  Say Y here to enable imx usb ChipIdea driver binding.
> +
> +endif
> +
>  endif
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index 4ab83e9..7004fde 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -9,7 +9,7 @@ ci_hdrc-$(CONFIG_USB_CHIPIDEA_DEBUG)	+= debug.o
>  
>  # Glue/Bridge layers go here
>  
> -obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
> +obj-$(CONFIG_USB_CHIPIDEA_MSM)	+= ci13xxx_msm.o
>  
>  # PCI doesn't provide stubs, need to check
>  ifneq ($(CONFIG_PCI),)
> @@ -17,5 +17,6 @@ ifneq ($(CONFIG_PCI),)
>  endif
>  
>  ifneq ($(CONFIG_OF_DEVICE),)
> -	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o usbmisc_imx.o
> +	obj-$(CONFIG_USB_CHIPIDEA_IMX)	+= ci13xxx_imx.o usbmisc_imx.o
> +	obj-$(CONFIG_USB_CHIPIDEA_SIRF)	+= ci13xxx_sirf.o
>  endif
> diff --git a/drivers/usb/chipidea/ci13xxx_sirf.c b/drivers/usb/chipidea/ci13xxx_sirf.c
> new file mode 100644
> index 0000000..1d84a2f
> --- /dev/null
> +++ b/drivers/usb/chipidea/ci13xxx_sirf.c
> @@ -0,0 +1,223 @@
> +/*
> + * USB Controller Driver for CSR SiRF SoC
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + * Rong Wang<Rong.Wang@csr.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/bitops.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +#include <linux/reset.h>
> +
> +#include <linux/usb/chipidea.h>
> +#include "ci.h"
> +
> +#define RSC_USB_UART_SHARE	0x0
> +#define USB1_MODE_SEL		BIT(2)
> +#define pdev_to_phy(pdev)	((struct usb_phy *)platform_get_drvdata(pdev))

sorry, no go. This is not the right way to handle USB PHYs.

> +static int sirfsoc_vbus_gpio;

this should be removed too, add it as a member of ci13xx_sirf_data.

> +struct ci13xxx_sirf_data {
> +	struct platform_device	*ci_pdev;

most likely you don't need the platform_device, you need the struct
device only.

> +	struct clk		*clk;
> +};
> +
> +static inline int ci13xxx_sirf_drive_vbus(int value)

NACK, you should pass your ci13xx_sirf_data as argument here.

> +{
> +	return gpio_direction_output(sirfsoc_vbus_gpio, value ? 0 : 1);
> +}
> +
> +static void ci13xxx_sirf_notify_event(struct ci13xxx *ci, unsigned event)
> +{
> +	switch (event) {
> +	case CI13XXX_CONTROLLER_RESET_EVENT:
> +		ci13xxx_sirf_drive_vbus(1);
> +		break;
> +	case CI13XXX_CONTROLLER_STOPPED_EVENT:
> +		ci13xxx_sirf_drive_vbus(0);
> +		break;
> +	default:
> +		dev_info(ci->dev, "Unknown Event\n");
> +		break;
> +	}
> +}
> +
> +static struct ci13xxx_platform_data ci13xxx_sirf_platdata = {
> +	.name			= "ci13xxx_sirf",
> +	.flags			= CI13XXX_DISABLE_STREAMING,
> +	.capoffset		= DEF_CAPOFFSET,
> +	.notify_event		= ci13xxx_sirf_notify_event,
> +};
> +
> +static struct of_device_id rsc_ids[] = {
> +	{ .compatible = "sirf,prima2-rsc", },
> +	{ /* sentinel */ }
> +};
> +
> +static int ci13xxx_sirf_probe(struct platform_device *pdev)
> +{
> +	struct platform_device *plat_ci, *phy_pdev;
> +	struct device_node *rsc_np, *phy_np;
> +	struct ci13xxx_sirf_data *data;
> +	struct usb_phy *phy;
> +	void __iomem *rsc_vbase;
> +	int ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		dev_err(&pdev->dev, "Failed to allocate ci13xxx_sirf_data!\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* 1. set usb controller clock */
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk)) {
> +		dev_err(&pdev->dev,
> +			"Failed to get clock, err=%ld\n", PTR_ERR(data->clk));
> +		return PTR_ERR(data->clk);
> +	}
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to prepare or enable clock, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* 2. software reset */
> +	ret = device_reset(&pdev->dev);
> +	if (ret)
> +		dev_info(&pdev->dev,
> +			"Failed to reset device, err=%d\n", ret);
> +
> +	/* 3. vbus configuration */
> +	sirfsoc_vbus_gpio = of_get_named_gpio(pdev->dev.of_node,
> +							"vbus-gpios", 0);
> +	if (sirfsoc_vbus_gpio < 0) {
> +		dev_err(&pdev->dev, "Can't get vbus gpio from DT\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +	ret = gpio_request(sirfsoc_vbus_gpio, "ci13xxx_sirf");
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to get gpio control\n");
> +		goto err;
> +	}
> +
> +	/* 4. rsc control */
> +	rsc_np = of_find_matching_node(NULL, rsc_ids);
> +	if (!rsc_np) {
> +		dev_err(&pdev->dev, "Failed to get rsc device node\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +	rsc_vbase = of_iomap(rsc_np, 0);
> +	if (!rsc_vbase) {
> +		dev_err(&pdev->dev, "Failed to iomap rsc memory\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	writel(readl(rsc_vbase + RSC_USB_UART_SHARE) | USB1_MODE_SEL,
> +					rsc_vbase + RSC_USB_UART_SHARE);
> +
> +	/* 5. set device dma mask */
> +	if (!pdev->dev.dma_mask) {
> +		pdev->dev.dma_mask = devm_kzalloc(&pdev->dev,
> +				      sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> +		if (!pdev->dev.dma_mask) {
> +			dev_err(&pdev->dev, "Failed to alloc dma_mask!\n");
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
> +		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
> +	}
> +
> +	/* 6. get phy for controller */
> +	phy_np = of_parse_phandle(pdev->dev.of_node, "sirf,ci13xxx-usbphy", 0);
> +	if (!phy_np) {
> +		dev_err(&pdev->dev, "Failed to get phy device node\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +	phy_pdev = of_find_device_by_node(phy_np);
> +	if (!phy_pdev) {
> +		dev_err(&pdev->dev, "Failed to get phy platform device\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +	phy = pdev_to_phy(phy_pdev);
> +	if (!phy || !try_module_get(phy_pdev->dev.driver->owner)) {
> +		dev_err(&pdev->dev, "Failed to get phy control\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +	usb_phy_init(phy);
> +	ci13xxx_sirf_platdata.phy = phy;
> +
> +	/* 7. register to ci13xxx core */
> +	plat_ci = ci13xxx_add_device(&pdev->dev,
> +				pdev->resource, pdev->num_resources,
> +				&ci13xxx_sirf_platdata);
> +	if (IS_ERR(plat_ci)) {
> +		dev_err(&pdev->dev, "ci13xxx_add_device failed!\n");
> +		return PTR_ERR(plat_ci);
> +	}
> +
> +	platform_set_drvdata(pdev, plat_ci);
> +
> +	pm_runtime_no_callbacks(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	dev_info(&pdev->dev, "Ready\n");

remove this dev_info()

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130612/0fae6d4c/attachment.sig>
