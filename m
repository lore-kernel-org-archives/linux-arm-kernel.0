From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 Jun 2012 23:33:12 +0200
Subject: [Patch v5 05/13] usb: otg: add basic mxs phy driver support
In-Reply-To: <1339590863-10564-6-git-send-email-richard.zhao@freescale.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-6-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120613213312.GD30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 08:34:15PM +0800, Richard Zhao wrote:
> mxs phy is used in Freescale i.MX SoCs, for example
> imx23, imx28, imx6Q. This patch adds the basic host
> support.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Peter Chen <peter.chen@freescale.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/mxs-phy.txt |   13 ++
>  drivers/usb/otg/Kconfig                           |    8 +
>  drivers/usb/otg/Makefile                          |    1 +
>  drivers/usb/otg/mxs-phy.c                         |  204 +++++++++++++++++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mxs-phy.txt
>  create mode 100644 drivers/usb/otg/mxs-phy.c
> 
> diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> new file mode 100644
> index 0000000..5835b27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> @@ -0,0 +1,13 @@
> +* Freescale MXS USB Phy Device
> +
> +Required properties:
> +- compatible: Should be "fsl,imx23-usbphy"
> +- reg: Should contain registers location and length
> +- interrupts: Should contain phy interrupt
> +
> +Example:
> +usbphy1: usbphy at 020c9000 {
> +	compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
> +	reg = <0x020c9000 0x1000>;
> +	interrupts = <0 44 0x04>;
> +};
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 5c87db0..3a9bc44 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -116,6 +116,14 @@ config FSL_USB2_OTG
>  	help
>  	  Enable this to support Freescale USB OTG transceiver.
>  
> +config USB_MXS_PHY
> +	tristate "Freescale MXS USB PHY support"
> +	select USB_OTG_UTILS
> +	help
> +	  Enable this to support the Freescale MXS USB PHY.
> +
> +	  MXS Phy is used by some of the i.MX SoCs, for example imx23/28/6x.
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
> index 0000000..a55aaed
> --- /dev/null
> +++ b/drivers/usb/otg/mxs-phy.c
> @@ -0,0 +1,204 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2012 Marek Vasut <marex@denx.de>
> + * on behalf of DENX Software Engineering GmbH
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/usb/otg.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#define DRIVER_NAME "mxs_phy"
> +
> +#define HW_USBPHY_PWD				0x00
> +#define HW_USBPHY_CTRL				0x30
> +#define HW_USBPHY_CTRL_SET			0x34
> +#define HW_USBPHY_CTRL_CLR			0x38
> +
> +#define BM_USBPHY_CTRL_SFTRST			BIT(31)
> +#define BM_USBPHY_CTRL_CLKGATE			BIT(30)
> +#define BM_USBPHY_CTRL_ENUTMILEVEL3		BIT(15)
> +#define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
> +#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
> +
> +struct mxs_phy {
> +	struct usb_phy phy;
> +	struct clk *clk;
> +	int connected:1;
> +};
> +
> +#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
> +
> +static void mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> +{
> +	void __iomem *base = mxs_phy->phy.io_priv;
> +
> +	writel_relaxed(BM_USBPHY_CTRL_CLKGATE, base + HW_USBPHY_CTRL_CLR);
> +
> +	/* Reset USBPHY module */
> +	writel_relaxed(BM_USBPHY_CTRL_SFTRST, base + HW_USBPHY_CTRL_SET);
> +	udelay(10);
> +
> +	/* Remove CLKGATE and SFTRST */
> +	writel_relaxed(BM_USBPHY_CTRL_CLKGATE | BM_USBPHY_CTRL_SFTRST,
> +			base + HW_USBPHY_CTRL_CLR);
> +	udelay(10);

Is stmp_reset_block() suitable for what you want to do here?

> +	base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!base)
> +		return -EBUSY;
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "can't get the clock!");

Please add the return value to these kind of messages.

> +		return PTR_ERR(clk);
> +	}
> +
> +	mxs_phy = devm_kzalloc(&pdev->dev, sizeof(*mxs_phy), GFP_KERNEL);
> +	if (!mxs_phy) {
> +		dev_err(&pdev->dev, "Failed to allocate USB PHY structure!\n");

This message is rather useless. It is really not expected for kzalloc
to fail. If it fails here you really have problems elsewhere and this
message won't help you debugging it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
