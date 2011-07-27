From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 27 Jul 2011 10:03:15 +0200
Subject: [PATCH v3 5/6] ARM: mxs: add usb phy operations
In-Reply-To: <1311744574-3610-6-git-send-email-tony.lin@freescale.com>
References: <1311744574-3610-1-git-send-email-tony.lin@freescale.com>
	<1311744574-3610-6-git-send-email-tony.lin@freescale.com>
Message-ID: <20110727080315.GN20587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 01:29:33PM +0800, Tony Lin wrote:
> add usb phy register definitions and functions
> usb host driver will use these callback functions
> to initialize usb phy and change working mode
> 
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> ---
>  arch/arm/mach-mxs/Kconfig           |    1 +
>  arch/arm/mach-mxs/Makefile          |    1 +
>  arch/arm/mach-mxs/mxs_usb.c         |  288 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/regs-usbphy-mxs.h |  240 +++++++++++++++++++++++++++++
>  4 files changed, 530 insertions(+), 0 deletions(-)
> 
> +}
> +static int fsl_usb_host_init(struct platform_device *pdev)
> +{
> +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> +
> +	ppriv->phy_regs = ioremap(MX28_USBPHY1_BASE_ADDR, SZ_8K);
> +	ppriv->ctrl_regs = ioremap(MX28_USBCTRL1_BASE_ADDR, SZ_8K);

Did I mention that the i.MX28 has *two* USB controllers?

> +	if (!ppriv->phy_regs || !ppriv->ctrl_regs) {
> +		iounmap(ppriv->phy_regs);
> +		iounmap(ppriv->ctrl_regs);
> +		return -ENOMEM;
> +	}

So you call iounmap(0) here.

> +	ppriv->usb_clk = clk_get(&pdev->dev, "usb1");
> +	if (IS_ERR(ppriv->usb_clk)) {
> +		iounmap(ppriv->phy_regs);
> +		iounmap(ppriv->ctrl_regs);
> +		return PTR_ERR(ppriv->usb_clk);

In the kernel community we are not afraid of 'goto'.

> +	}
> +	clk_enable(ppriv->usb_clk);
> +
> +	ppriv->usb_phy_clk = clk_get(&pdev->dev, "usb1_phy");
> +	if (IS_ERR(ppriv->usb_phy_clk)) {
> +		clk_disable(ppriv->usb_clk);
> +		clk_put(ppriv->usb_clk);
> +		iounmap(ppriv->phy_regs);
> +		iounmap(ppriv->ctrl_regs);
> +		return PTR_ERR(ppriv->usb_phy_clk);
> +	}
> +	clk_enable(ppriv->usb_phy_clk);
> +
> +	phy_clock_gate(ppriv, true);
> +	return fsl_usbh_init(pdev);
> +}
> +
> +static int fsl_usb_host_uninit(struct platform_device *pdev)
> +{
> +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> +
> +	phy_clock_gate(ppriv, false);
> +	clk_disable(ppriv->usb_phy_clk);
> +	clk_put(ppriv->usb_phy_clk);
> +	clk_disable(ppriv->usb_clk);
> +	clk_put(ppriv->usb_clk);
> +	iounmap(ppriv->phy_regs);
> +	iounmap(ppriv->ctrl_regs);
> +
> +	return 0;
> +}
> +
> +static struct mxs_usb_private_date usbh_private = {
> +	.internal_phy_clk_already_on = 0,
> +};

unitialized fields in static initializers are zero anyway.
Remove all this ppriv crap. clk_enable/disable will do the
reference counting for you.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
