From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Apr 2012 08:39:24 +0200
Subject: [PATCH 08/11] MXS: Add imx-otg driver
In-Reply-To: <1335099567-21056-9-git-send-email-marex@denx.de>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-1-git-send-email-marex@denx.de>
 <1335099567-21056-9-git-send-email-marex@denx.de>
Message-ID: <20120423063924.GY3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2012 at 02:59:24PM +0200, Marek Vasut wrote:
> This driver handles claiming of clocks and memory areas. These are later
> properly delegated to it's child devices, the USB Host (ehci-mxs) and
> USB Gadget (ci13xxx-mxs).
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chen Peter-B29397 <B29397@freescale.com>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Li Frank-B20596 <B20596@freescale.com>
> Cc: Lin Tony-B19295 <B19295@freescale.com>
> Cc: Linux USB <linux-usb@vger.kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Subodh Nijsure <snijsure@grid-net.com>
> Cc: Tony Lin <tony.lin@freescale.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  drivers/usb/otg/Kconfig   |    6 +
>  drivers/usb/otg/Makefile  |    1 +
>  drivers/usb/otg/imx-otg.c |  282 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 289 insertions(+)
>  create mode 100644 drivers/usb/otg/imx-otg.c
> 
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 5c87db0..e7c6325 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -116,6 +116,12 @@ config FSL_USB2_OTG
>  	help
>  	  Enable this to support Freescale USB OTG transceiver.
>  
> +config USB_IMX_COMPOSITE
> +	bool
> +	help
> +	  Composite driver that handles clock and memory mapping for
> +	  i.MX USB host and USB PHY.
> +
>  config USB_MV_OTG
>  	tristate "Marvell USB OTG support"
>  	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
> diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
> index 41aa509..7d2c631 100644
> --- a/drivers/usb/otg/Makefile
> +++ b/drivers/usb/otg/Makefile
> @@ -20,4 +20,5 @@ obj-$(CONFIG_USB_MSM_OTG)	+= msm_otg.o
>  obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
>  fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
>  obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
> +obj-$(CONFIG_USB_IMX_COMPOSITE)	+= imx-otg.o
>  obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
> diff --git a/drivers/usb/otg/imx-otg.c b/drivers/usb/otg/imx-otg.c
> new file mode 100644
> index 0000000..249b6b5
> --- /dev/null
> +++ b/drivers/usb/otg/imx-otg.c
> @@ -0,0 +1,282 @@
> +/*
> + * drivers/usb/otg/imx-otg.c
> + *
> + * Freescale i.MX USB composite driver.
> + *
> + * Copyright (C) 2012 Marek Vasut <marex@denx.de>
> + * on behalf of DENX Software Engineering GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/usb.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/hcd.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/fsl/mxs-usb.h>
> +#include <linux/io.h>
> +
> +#include <mach/common.h>
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +
> +/*
> + * Allocate platform device with the DMA mask, this is borrowed from
> + * arch/arm/mach-mxs/devices.c
> + */
> +static struct platform_device *__devinit add_platform_device(
> +		const char *name, int id,
> +		const void *data, size_t size_data, u64 dmamask)
> +{
> +	int ret = -ENOMEM;
> +	struct platform_device *pdev;
> +
> +	pdev = platform_device_alloc(name, id);
> +	if (!pdev)
> +		goto err;
> +
> +	if (dmamask) {
> +		/*
> +		 * This memory isn't freed when the device is put,
> +		 * I don't have a nice idea for that though.  Conceptually
> +		 * dma_mask in struct device should not be a pointer.
> +		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
> +		 */
> +		pdev->dev.dma_mask =
> +			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> +		if (!pdev->dev.dma_mask)
> +			/* ret is still -ENOMEM; */
> +			goto err;
> +
> +		*pdev->dev.dma_mask = dmamask;
> +		pdev->dev.coherent_dma_mask = dmamask;
> +	}
> +
> +	if (data) {
> +		ret = platform_device_add_data(pdev, data, size_data);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret = platform_device_add(pdev);
> +	if (ret) {
> +err:
> +		if (dmamask)
> +			kfree(pdev->dev.dma_mask);
> +		platform_device_put(pdev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return pdev;
> +}
> +
> +static int __devinit imx_usb_probe(struct platform_device *pdev)
> +{
> +	struct imx_usb_platform_data *pdata = pdev->dev.platform_data;
> +	struct imx_usb *data;
> +	struct usb_phy *phy;
> +	int ret;
> +	void *retp = NULL;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "No platform data supplied!\n");
> +		return -ENODEV;
> +	}
> +
> +	phy = usb_get_transceiver();
> +	if (!phy)
> +		return -EPROBE_DEFER;
> +
> +	/*
> +	 * Until further notice, this claims all necessary resources.
> +	 */
> +
> +	/* Allocate driver's private date. */
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto err_alloc_data;
> +	}
> +
> +	/* Claim the Host clock. */
> +	data->clk = clk_get(&pdev->dev, "usb");
> +	if (IS_ERR(data->clk)) {
> +		dev_err(&pdev->dev, "Failed to claim clock for USB Host\n");
> +		ret = PTR_ERR(data->clk);
> +		goto err_claim_host_clock;
> +	}
> +
> +	/* Prepare Host clock. */
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to enable clock for USB Host.\n");
> +		goto err_prepare_host_clock;
> +	}
> +
> +	/* Get memory area for EHCI host from resources. */
> +	data->mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!data->mem_res) {
> +		dev_err(&pdev->dev, "Specify memory area for this USB Host!\n");
> +		ret = -ENODEV;
> +		goto err_get_host_resource;
> +	}
> +
> +	/* Request the memory region for this USB Host. */
> +	retp = devm_request_mem_region(&pdev->dev, data->mem_res->start,
> +			resource_size(data->mem_res), pdev->name);
> +	if (!retp) {
> +		dev_err(&pdev->dev, "USB Host memory area already in use!\n");
> +		ret = -EBUSY;
> +		goto err_get_host_mem;
> +	}
> +
> +	/* Map the memory region for USB Host. */
> +	data->mem = devm_ioremap(&pdev->dev, data->mem_res->start,
> +				resource_size(data->mem_res));
> +	if (!data->mem) {
> +		dev_err(&pdev->dev, "Memory mapping of USB Host failed!\n");
> +		ret = -EFAULT;
> +		goto err_map_host_mem;
> +	}
> +
> +	/* Get IRQ for EHCI host from resources. */
> +	data->irq = platform_get_irq(pdev, 0);
> +	if (data->irq < 0) {
> +		dev_err(&pdev->dev, "Specify IRQ for this USB Host!\n");
> +		ret = -ENODEV;
> +		goto err_get_host_irq;
> +	}
> +
> +	/*
> +	 * Now finally probe the Host driver!
> +	 */
> +	if (pdata->host_mode) {
> +		data->pdev_host = add_platform_device("mxs-ehci", -1,
> +							data, sizeof(*data),
> +							DMA_BIT_MASK(32));
> +		if (!data->pdev_host) {
> +			dev_err(&pdev->dev, "Failed registering Host!\n");
> +			ret = -ENODEV;
> +			goto err_register_host;
> +		}
> +	} else {
> +		data->pdev_gadget = add_platform_device("ci13xxx-mxs", -1,
> +							data, sizeof(*data),
> +							DMA_BIT_MASK(32));
> +		if (!data->pdev_gadget) {
> +			dev_err(&pdev->dev, "Failed registering Host!\n");
> +			ret = -ENODEV;
> +			goto err_register_gadget;
> +		}
> +	}
> +
> +	/*
> +	 * Initialize the transceiver
> +	 */
> +	phy = usb_get_transceiver();
> +	if (!phy) {
> +		dev_err(&pdev->dev, "Unable to find transceiver.\n");
> +		ret = -ENODEV;
> +		goto err_phy;
> +	}
> +
> +	ret = usb_phy_init(phy);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Unable init transceiver\n");
> +		ret = -ENODEV;
> +		goto err_phy_init;
> +	}
> +
> +	/* Set up the PORTSCx register */
> +	writel(0, data->mem + 0x144);
> +
> +	return 0;
> +
> +err_phy_init:
> +	if (phy)
> +		usb_put_transceiver(phy);
> +err_phy:
> +	if (data->pdev_gadget)
> +		platform_device_unregister(data->pdev_gadget);
> +err_register_gadget:
> +	if (data->pdev_host)
> +		platform_device_unregister(data->pdev_host);
> +err_register_host:
> +err_get_host_irq:
> +	iounmap(data->mem);
> +err_map_host_mem:
> +	release_mem_region(data->mem_res->start,
> +			resource_size(data->mem_res));
> +err_get_host_mem:
> +	data->mem_res = NULL;
> +err_get_host_resource:
> +	clk_disable_unprepare(data->clk);
> +err_prepare_host_clock:
> +	clk_put(data->clk);
> +err_claim_host_clock:
> +err_alloc_data:
> +	return ret;
> +}
> +
> +static int __devexit imx_usb_remove(struct platform_device *pdev)
> +{
> +	struct imx_usb *data = platform_get_drvdata(pdev);
> +
> +	if (data->pdev_gadget)
> +		platform_device_unregister(data->pdev_gadget);
> +
> +	if (data->pdev_host)
> +		platform_device_unregister(data->pdev_host);
> +
> +	iounmap(data->mem);
> +	release_mem_region(data->mem_res->start,
> +			resource_size(data->mem_res));

Again, you are using the managed versions of ioremap and
request_mem_region. The whole point of these functions is that these
resources are automatically released on driver exit (or failure at
probe).

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
