From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 21:36:54 +0200
Subject: [PATCH 07/10] MXS: Add USB PHY driver
In-Reply-To: <1334771194-18688-8-git-send-email-marex@denx.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-1-git-send-email-marex@denx.de>
 <1334771194-18688-8-git-send-email-marex@denx.de>
Message-ID: <20120418193654.GZ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 07:46:31PM +0200, Marek Vasut wrote:
> Add driver that controls the built-in USB PHY in the i.MX233/i.MX28. This
> enables the PHY upon powerup and shuts it down on shutdown.
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
>  drivers/usb/otg/Kconfig   |   10 ++
>  drivers/usb/otg/Makefile  |    1 +
>  drivers/usb/otg/mxs-phy.c |  305 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 316 insertions(+)
>  create mode 100644 drivers/usb/otg/mxs-phy.c
> 
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index e7c6325..1de1495 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -122,6 +122,16 @@ config USB_IMX_COMPOSITE
>  	  Composite driver that handles clock and memory mapping for
>  	  i.MX USB host and USB PHY.
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
> index e3feaca..56700b3 100644
> --- a/drivers/usb/otg/Makefile
> +++ b/drivers/usb/otg/Makefile
> @@ -21,4 +21,5 @@ obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
>  fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
>  obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
>  obj-$(CONFIG_USB_IMX_COMPOSITE)	+= imx-usb.o
> +obj-$(CONFIG_USB_MXS_PHY)	+= mxs-phy.o
>  obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
> +
> +struct mxs_usb_phy {
> +	struct usb_phy		phy;
> +
> +	struct work_struct	work;
> +
> +	struct clk		*clk;
> +	struct resource		*mem_res;
> +	void __iomem		*mem;
> +	int			irq;

irq is unused.

> +
> +static void mxs_usb_work(struct work_struct *w)
> +{
> +	struct mxs_usb_phy *phy = container_of(w, struct mxs_usb_phy, work);
> +	struct usb_otg *otg = phy->phy.otg;
> +	struct usb_hcd *hcd;
> +
> +	switch (otg->phy->state) {
> +	case OTG_STATE_A_HOST:
> +		if (otg->host) {
> +			hcd = bus_to_hcd(otg->host);
> +			usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +}

This function should be in imx-otg.

> +
> +static int __devinit mxs_phy_probe(struct platform_device *pdev)
> +{
> +	struct mxs_usb_phy *phy;
> +	void *retp;
> +	int ret;
> +
> +	/* Allocate PHY driver's private date. */
> +	phy = kzalloc(sizeof(*phy), GFP_KERNEL);

devm?

> +	if (!phy) {
> +		dev_err(&pdev->dev, "Failed to allocate USB PHY structure!\n");
> +		ret = -ENOMEM;
> +		goto err_alloc_phy;
> +	}
> +
> +	/* Allocate OTG structure. */
> +	phy->phy.otg = kzalloc(sizeof(*phy->phy.otg), GFP_KERNEL);

devm?

> +	if (!phy->phy.otg) {
> +		dev_err(&pdev->dev, "Failed to allocate USB OTG structure!\n");
> +		ret = -ENOMEM;
> +		goto err_alloc_otg;
> +	}
> +
> +	/* Claim the PHY clock. */
> +	phy->clk = clk_get(&pdev->dev, "phy");
> +	if (!phy->clk) {
> +		dev_err(&pdev->dev, "Failed to claim clock for USB PHY\n");
> +		ret = PTR_ERR(phy->clk);
> +		goto err_claim_phy_clock;
> +	}
> +
> +	/* Prepare PHY clock. */
> +	ret = clk_prepare(phy->clk);

It should be clear that a function named clk_prepare prepares the clock.
Please remove such comments.

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to prepare clock for USB PHY.\n");
> +		goto err_prepare_phy_clock;
> +	}
> +
> +	/* Get memory area for PHY from resources. */
> +	phy->mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!phy->mem_res) {
> +		dev_err(&pdev->dev, "Specify memory area for this USB PHY!\n");
> +		ret = -ENODEV;
> +		goto err_get_phy_resource;
> +	}
> +
> +	/* Request the memory region for this USB PHY. */
> +	retp = devm_request_mem_region(&pdev->dev, phy->mem_res->start,
> +			resource_size(phy->mem_res), pdev->name);

The 'm' in devm is for 'managed' which means that these resources are
automatically released on driver exit. You don't have to release them
manually. In fact you must not release them with the regular functions.
If you want to release them manually you have to use the devm variants.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
