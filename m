From: marex@denx.de (Marek Vasut)
Date: Wed, 16 May 2012 03:20:01 +0200
Subject: [PATCH v1 3/7] usb: chipidea: add imx on-soc utmi phy driver
In-Reply-To: <1337090303-16046-4-git-send-email-richard.zhao@freescale.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <1337090303-16046-4-git-send-email-richard.zhao@freescale.com>
Message-ID: <201205160320.01482.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  drivers/usb/chipidea/Makefile       |    4 +
>  drivers/usb/chipidea/phy-imx-utmi.c |  140
> +++++++++++++++++++++++++++++++++++ 2 files changed, 144 insertions(+), 0
> deletions(-)
>  create mode 100644 drivers/usb/chipidea/phy-imx-utmi.c
> 
> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> index cc34937..0f34c0c 100644
> --- a/drivers/usb/chipidea/Makefile
> +++ b/drivers/usb/chipidea/Makefile
> @@ -12,3 +12,7 @@ endif
>  ifneq ($(CONFIG_ARCH_MSM),)
>  	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
>  endif
> +
> +ifneq ($(CONFIG_ARCH_MXC),)
> +	obj-$(CONFIG_USB_CHIPIDEA)	+= phy-imx-utmi.o
> +endif
> diff --git a/drivers/usb/chipidea/phy-imx-utmi.c
> b/drivers/usb/chipidea/phy-imx-utmi.c new file mode 100644
> index 0000000..f7a0fe7
> --- /dev/null
> +++ b/drivers/usb/chipidea/phy-imx-utmi.c
> @@ -0,0 +1,140 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
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
> +#define DRIVER_NAME "imx_utmi"
> +
> +#define HW_USBPHY_PWD	(0x00000000)

Drop the braces here

> +#define HW_USBPHY_CTRL	0x00000030
> +
> +#define BM_USBPHY_CTRL_SFTRST 0x80000000
> +#define BM_USBPHY_CTRL_CLKGATE 0x40000000
> +#define BM_USBPHY_CTRL_ENUTMILEVEL3 0x00008000
> +#define BM_USBPHY_CTRL_ENUTMILEVEL2 0x00004000
> +
> +struct imx_utmi_phy {
> +	struct usb_phy phy;
> +	struct clk *clk;
> +};
> +
> +#define to_imx_phy(p) container_of((p), struct imx_utmi_phy, phy)
> +
> +static int imx_utmi_phy_init(struct usb_phy *phy)
> +{
> +	struct imx_utmi_phy *imx_phy;
> +	u32 reg;
> +
> +	imx_phy = to_imx_phy(phy);
> +
> +	clk_prepare_enable(imx_phy->clk);
> +
> +	reg = readl_relaxed(phy->io_priv + HW_USBPHY_CTRL);
> +	reg &= ~BM_USBPHY_CTRL_CLKGATE;
> +	writel_relaxed(reg, phy->io_priv + HW_USBPHY_CTRL);
> +
> +	/* Reset USBPHY module */
> +	reg = readl_relaxed(phy->io_priv + HW_USBPHY_CTRL);
> +	reg |= BM_USBPHY_CTRL_SFTRST;
> +	writel_relaxed(reg, phy->io_priv + HW_USBPHY_CTRL);
> +	udelay(10);
> +
> +	/* Remove CLKGATE and SFTRST */
> +	reg = readl_relaxed(phy->io_priv + HW_USBPHY_CTRL);
> +	reg &= ~(BM_USBPHY_CTRL_CLKGATE | BM_USBPHY_CTRL_SFTRST);
> +	writel_relaxed(reg, phy->io_priv + HW_USBPHY_CTRL);
> +	udelay(10);

You might want to check my PHY driver for the proper init sequence ... it uses 
mxs_reset_block() (or maybe there's already stmp_reset_block() ? )

> +
> +	/* Power up the PHY */
> +	writel_relaxed(0, phy->io_priv + HW_USBPHY_PWD);
> +	/* enable FS/LS device */
> +	reg = readl_relaxed(phy->io_priv + HW_USBPHY_CTRL);
> +	reg |= BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3;
> +	writel_relaxed(reg, phy->io_priv + HW_USBPHY_CTRL);

Well, you can retrieve this from my PHY driver ;-)

> +
> +	return 0;
> +}
> +
> +static void imx_utmi_phy_shutdown(struct usb_phy *phy)
> +{
> +	struct imx_utmi_phy *imx_phy;
> +
> +	imx_phy = to_imx_phy(phy);
> +	clk_disable_unprepare(imx_phy->clk);

You forgot to disable the PHY here ... pull it out of my patchset and be done 
with it ;-)

> +}
> +
> +static int imx_utmi_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct imx_utmi_phy *imx_phy;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "can't get device resources\n");
> +		return -ENOENT;
> +	}
> +
> +	base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!base)
> +		return -EBUSY;
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	imx_phy = devm_kzalloc(&pdev->dev, sizeof(*imx_phy), GFP_KERNEL);
> +	if (!imx_phy)
> +		return -ENOMEM;
> +
> +	imx_phy->phy.io_priv = base;
> +	imx_phy->phy.dev = &pdev->dev;
> +	imx_phy->phy.label = DRIVER_NAME;
> +	imx_phy->phy.init = imx_utmi_phy_init;
> +	imx_phy->phy.shutdown = imx_utmi_phy_shutdown;
> +	imx_phy->clk = clk;
> +	platform_set_drvdata(pdev, &imx_phy->phy);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_utmi_dt_ids[] = {
> +	{ .compatible = "fsl,imx6q-usbphy", },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver imx_utmi_driver = {
> +	.probe = imx_utmi_probe,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = imx_utmi_dt_ids,
> +	 },
> +};
> +
> +static int __init imx_utmi_init(void)
> +{
> +	return platform_driver_register(&imx_utmi_driver);
> +}
> +postcore_initcall(imx_utmi_init);
> +
> +static void __exit imx_utmi_exit(void)
> +{
> +	platform_driver_unregister(&imx_utmi_driver);
> +}

module_platform_driver() will make this clearer ... check my ci13xxx_mxs.c 
binding glue for usage.

> +module_exit(imx_utmi_exit);
