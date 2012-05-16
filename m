From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 16 May 2012 11:33:38 +0800
Subject: [PATCH 5/8] MXS: Add USB PHY driver
In-Reply-To: <1337070219-3630-6-git-send-email-marex@denx.de>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
 <1337070219-3630-6-git-send-email-marex@denx.de>
Message-ID: <20120516033336.GA19137@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, May 15, 2012 at 10:23:36AM +0200, Marek Vasut wrote:
> Add driver that controls the built-in USB PHY in the i.MX233/i.MX28. This
> enables the PHY upon powerup and shuts it down on shutdown.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chen Peter-B29397 <B29397@freescale.com>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Li Frank-B20596 <B20596@freescale.com>
> Cc: Linux USB <linux-usb@vger.kernel.org>
> Cc: Liu JunJie-B08287 <B08287@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Shi Make-B15407 <B15407@freescale.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Subodh Nijsure <snijsure@grid-net.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  drivers/usb/otg/Kconfig   |   10 ++
>  drivers/usb/otg/Makefile  |    1 +
>  drivers/usb/otg/mxs-phy.c |  313 +++++++++++++++++++++++++++++++++++++++++++++
imx is more common.

>  3 files changed, 324 insertions(+)
>  create mode 100644 drivers/usb/otg/mxs-phy.c
> 
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 5c87db0..bc7625e 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -116,6 +116,16 @@ config FSL_USB2_OTG
>  	help
>  	  Enable this to support Freescale USB OTG transceiver.
>  
> +config USB_MXS_PHY
> +	tristate "Freescale i.MX28 USB PHY support"
> +	select USB_OTG_UTILS
> +	select USB_IMX_COMPOSITE
> +	help
> +	  Say Y here if you want to build Freescale i.MX28 USB PHY
> +	  driver in kernel.
> +
> +	  To compile this driver as a module, choose M here.
> +
>  config USB_MV_OTG
>  	tristate "Marvell USB OTG support"
>  	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
> diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
> index 41aa509..a844b8d 100644
> --- a/drivers/usb/otg/Makefile
> +++ b/drivers/usb/otg/Makefile
> @@ -20,4 +20,5 @@ obj-$(CONFIG_USB_MSM_OTG)	+= msm_otg.o
>  obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
>  fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
>  obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
> +obj-$(CONFIG_USB_MXS_PHY)	+= mxs-phy.o
>  obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
> diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
> new file mode 100644
> index 0000000..eb658ca
> --- /dev/null
> +++ b/drivers/usb/otg/mxs-phy.c
> @@ -0,0 +1,313 @@
> +/*
> + * drivers/usb/otg/mxs-phy.c
> + *
> + * Freescale i.MX28 USB PHY driver.
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
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +
> +#include <linux/usb.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/hcd.h>
> +#include <linux/usb/ehci_def.h>
> +
> +#include <mach/common.h>
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +#include <mach/mx28.h>
> +
> +/* MXS USB PHY register definitions. */
> +#define HW_USBPHY_PWD				0x00
> +
> +#define HW_USBPHY_CTRL				0x30
> +#define HW_USBPHY_CTRL_SET			0x34
> +#define HW_USBPHY_CTRL_CLR			0x38
> +#define HW_USBPHY_CTRL_TOG			0x3c
> +
> +#define BM_USBPHY_CTRL_SFTRST			(1 << 31)
> +#define BM_USBPHY_CTRL_CLKGATE			(1 << 30)
> +#define BM_USBPHY_CTRL_ENVBUSCHG_WKUP		(1 << 23)
> +#define BM_USBPHY_CTRL_ENIDCHG_WKUP		(1 << 22)
> +#define BM_USBPHY_CTRL_ENDPDMCHG_WKUP		(1 << 21)
> +#define BM_USBPHY_CTRL_WAKEUP_IRQ		(1 << 17)
> +#define BM_USBPHY_CTRL_ENIRQWAKEUP		(1 << 16)
> +#define BM_USBPHY_CTRL_ENUTMILEVEL3		(1 << 15)
> +#define BM_USBPHY_CTRL_ENUTMILEVEL2		(1 << 14)
> +#define BM_USBPHY_CTRL_ENIRQDEVPLUGIN		(1 << 11)
> +#define BM_USBPHY_CTRL_RESUME_IRQ		(1 << 10)
> +#define BM_USBPHY_CTRL_ENIRQRESUMEDETECT	(1 << 9)
> +#define BM_USBPHY_CTRL_ENOTGIDDETECT		(1 << 7)
> +#define BM_USBPHY_CTRL_ENDEVPLUGINDETECT	(1 << 4)
> +#define BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ	(1 << 3)
> +#define BM_USBPHY_CTRL_ENIRQHOSTDISCON		(1 << 2)
> +#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	(1 << 1)
> +
> +#define HW_USBPHY_STATUS			0x40
> +
> +#define BM_USBPHY_STATUS_OTGID_STATUS		(1 << 8)
> +#define BM_USBPHY_STATUS_DEVPLUGIN_STATUS	(1 << 6)
> +#define BM_USBPHY_STATUS_HOSTDISCON_STATUS	(1 << 3)
> +
> +struct mxs_usb_phy {
> +	struct usb_phy		phy;
> +	struct usb_otg		otg;
> +	struct clk		*clk;
> +	bool			discon;
> +};
> +
> +static int mxs_usb_phy_init(struct usb_phy *x)
> +{
> +	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
> +	uint32_t val;
> +
> +	/* Enable clock to the PHY. */
> +	clk_enable(phy->clk);
> +
> +	/* Reset the PHY block. */
> +	mxs_reset_block(x->io_priv + HW_USBPHY_CTRL);
I find mxs_reset_block is defined in platform code. It breaks multi-soc
in one image.
> +
> +	/* Power up the PHY. */
> +	writel(0, x->io_priv + HW_USBPHY_PWD);
> +
> +	/* Clear the wakeup IRQ before enabling them below. */
> +	writel(BM_USBPHY_CTRL_RESUME_IRQ | BM_USBPHY_CTRL_WAKEUP_IRQ,
> +		x->io_priv + HW_USBPHY_CTRL_CLR);
> +
> +	/* Enable FS/LS compatibility and wakeup IRQs. */
> +	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3 |
> +		BM_USBPHY_CTRL_ENIRQWAKEUP;
> +
> +	/* Enable IRQ sources. */
> +	val |= BM_USBPHY_CTRL_ENIDCHG_WKUP | BM_USBPHY_CTRL_ENDPDMCHG_WKUP |
> +		BM_USBPHY_CTRL_ENVBUSCHG_WKUP;
It's a little different from my steps. I copied it from fsl kernel.
Peter, maybe you can comment?
> +
> +	writel(val, x->io_priv + HW_USBPHY_CTRL_SET);
> +
> +	return 0;
> +}
> +
> +static void mxs_usb_phy_shutdown(struct usb_phy *x)
> +{
> +	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
> +	uint32_t val;
> +
> +	/* Clear the wakeup IRQ before disabling them below. */
> +	writel(BM_USBPHY_CTRL_RESUME_IRQ | BM_USBPHY_CTRL_WAKEUP_IRQ,
> +		x->io_priv + HW_USBPHY_CTRL_CLR);
> +
> +	/* Disable FS/LS compatibility and wakeup IRQs. */
> +	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3 |
> +		BM_USBPHY_CTRL_ENIRQWAKEUP;
> +
> +	/* Disable IRQ sources. */
> +	val |= BM_USBPHY_CTRL_ENIDCHG_WKUP | BM_USBPHY_CTRL_ENDPDMCHG_WKUP |
> +		BM_USBPHY_CTRL_ENVBUSCHG_WKUP;
> +
> +	writel(val, x->io_priv + HW_USBPHY_CTRL_CLR);
> +
> +	/*
> +	 * The interrupt must be disabled for at least 3 cycles of the
> +	 * standby clock (32kHz), that is 0.094 ms.
> +	 */
> +	udelay(100);
> +
> +	/* Gate off the PHY. */
> +	writel(BM_USBPHY_CTRL_CLKGATE, x->io_priv + HW_USBPHY_CTRL_SET);
> +
> +	/* Disable clock to the PHY. */
> +	clk_disable(phy->clk);
> +}
> +
> +static int mxs_otg_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{
> +	return 0;
> +}
> +
> +static int mxs_otg_set_peripheral(struct usb_otg *otg, struct usb_gadget *gg)
> +{
> +	return 0;
> +}
> +
> +static int mxs_otg_set_vbus(struct usb_otg *otg, bool enabled)
> +{
> +	return 0;
> +}
> +
> +static int mxs_usb_phy_notify(struct usb_phy *x, void *data)
> +{
> +	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
> +	struct mxs_ci13xxx_phy_notify *notify = data;
> +
> +	if (notify->discon == phy->discon)
> +		return 0;
> +
> +	phy->discon = notify->discon;
> +
> +	if (notify->discon) {
> +		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> +			x->io_priv + HW_USBPHY_CTRL_CLR);
> +	} else {
> +		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> +			x->io_priv + HW_USBPHY_CTRL_SET);
> +	}
I'm also thinking how to add the hack. Great work.
and, maybe it can be PHY_EVENT_CONNECT and PHY_EVENT_DISCONNECT rather
not void* ? It makes loose binding of phy and usb driver.
> +
> +	return 0;
> +}
> +
> +static int __devinit mxs_phy_probe(struct platform_device *pdev)
> +{
> +	struct mxs_usb_phy *phy;
> +	struct resource *mem_res;
> +	void *retp;
> +	int ret;
> +	struct usb_otg *otg;
> +
> +	/* Allocate PHY driver's private data. */
> +	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy) {
> +		dev_err(&pdev->dev, "Failed to allocate USB PHY structure!\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Get memory area for PHY from resources. */
> +	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem_res) {
> +		dev_err(&pdev->dev, "Specify memory area for this USB PHY!\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Request the memory region for this USB PHY. */
> +	retp = devm_request_mem_region(&pdev->dev, mem_res->start,
> +			resource_size(mem_res), pdev->name);
> +	if (!retp) {
> +		dev_err(&pdev->dev, "USB PHY memory area already in use!\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Map the memory region for USB PHY. */
> +	phy->phy.io_priv = devm_ioremap(&pdev->dev, mem_res->start,
> +				resource_size(mem_res));
devm_request_and_ioremap ?

> +	if (!phy->phy.io_priv) {
> +		dev_err(&pdev->dev, "Memory mapping of USB PHY failed!\n");
> +		return -EFAULT;
> +	}
> +
> +	/* Claim the PHY clock. */
> +	phy->clk = clk_get(&pdev->dev, "phy");
devm_clk_get ?
> +	if (!phy->clk) {
> +		dev_err(&pdev->dev, "Failed to claim clock for USB PHY!\n");
> +		return PTR_ERR(phy->clk);
> +	}
> +
> +	/* Prepare PHY clock. */
> +	ret = clk_prepare(phy->clk);
Why not put it in phy init? phy init has to be atomic?
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to prepare clock for USB PHY!\n");
> +		goto err_prepare_phy_clock;
> +	}
> +
> +	/* Setup the PHY structures. */
> +	phy->phy.dev		= &pdev->dev;
> +	phy->phy.label		= "mxs-usb-phy";
> +	phy->phy.init		= mxs_usb_phy_init;
> +	phy->phy.shutdown	= mxs_usb_phy_shutdown;
> +	phy->phy.notify		= mxs_usb_phy_notify;
> +	phy->phy.state		= OTG_STATE_UNDEFINED;
> +
> +	otg			= &phy->otg;
> +	phy->phy.otg		= otg;
> +
> +	otg->phy		= &phy->phy;
> +	otg->set_vbus		= mxs_otg_set_vbus;
> +	otg->set_host		= mxs_otg_set_host;
> +	otg->set_peripheral	= mxs_otg_set_peripheral;
> +
> +	platform_set_drvdata(pdev, phy);
> +
> +	ATOMIC_INIT_NOTIFIER_HEAD(&phy->phy.notifier);
> +
> +	/* Register the transceiver with kernel. */
> +	ret = usb_set_transceiver(&phy->phy);
In my code, I don't plan to call it for host phy, to achieve multi-phy
support.

> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't register transceiver, (%d)\n", ret);
> +		goto err_set_transceiver;
> +	}
> +
> +	return 0;
> +
> +err_set_transceiver:
> +	clk_unprepare(phy->clk);
> +err_prepare_phy_clock:
> +	clk_put(phy->clk);
> +	return ret;
> +}
> +
> +static int __devexit mxs_phy_remove(struct platform_device *pdev)
> +{
> +	struct mxs_usb_phy *phy = platform_get_drvdata(pdev);
> +
> +	/* Power down the PHY. */
> +	mxs_usb_phy_shutdown(&phy->phy);
> +
> +	/* Remove the transceiver. */
> +	usb_set_transceiver(NULL);
> +
> +	/* Stop the PHY clock. */
> +	clk_disable_unprepare(phy->clk);
> +	clk_put(phy->clk);
> +
> +	/* Free the rest. */
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mxs_phy_driver = {
> +	.probe		= mxs_phy_probe,
> +	.remove		= __devexit_p(mxs_phy_remove),
> +	.driver		= {
> +		.name	= "mxs-usb-phy",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init mxs_phy_init(void)
> +{
> +	return platform_driver_register(&mxs_phy_driver);
> +}
> +
> +static void __exit mxs_phy_exit(void)
> +{
> +	platform_driver_unregister(&mxs_phy_driver);
> +}
> +
> +arch_initcall(mxs_phy_init);
postcor_initcall? It make possible hack in machine init code.

Thanks
Richard
> +module_exit(mxs_phy_exit);
> +
> +MODULE_ALIAS("platform:mxs-usb-phy");
> +MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> +MODULE_DESCRIPTION("Freescale i.MX28 USB PHY driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
