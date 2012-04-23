From: marex@denx.de (Marek Vasut)
Date: Mon, 23 Apr 2012 04:17:12 +0200
Subject: [PATCH 09/11] MXS: Add USB PHY driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B793D9@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-10-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B793D9@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201204230417.13182.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chen Peter-B29397,

> > +
> > +#define HW_USBPHY_PWD				0x00
> > +
> > +#define HW_USBPHY_CTRL				0x30
> > +#define HW_USBPHY_CTRL_SET			0x34
> > +#define HW_USBPHY_CTRL_CLR			0x38
> > +#define HW_USBPHY_CTRL_TOG			0x3c
> > +
> > +#define BM_USBPHY_CTRL_SFTRST			(1 << 31)
> > +#define BM_USBPHY_CTRL_CLKGATE			(1 << 30)
> > +#define BM_USBPHY_CTRL_ENUTMILEVEL3		(1 << 15)
> > +#define BM_USBPHY_CTRL_ENUTMILEVEL2		(1 << 14)
> > +#define BM_USBPHY_CTRL_ENIRQDEVPLUGIN		(1 << 11)
> > +#define BM_USBPHY_CTRL_ENOTGIDDETECT		(1 << 7)
> > +#define BM_USBPHY_CTRL_ENDEVPLUGINDETECT	(1 << 4)
> > +#define BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ	(1 << 3)
> > +#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	(1 << 1)
> > +
> > +#define HW_USBPHY_STATUS			0x40
> > +
> > +#define BM_USBPHY_STATUS_OTGID_STATUS		(1 << 8)
> > +#define BM_USBPHY_STATUS_DEVPLUGIN_STATUS	(1 << 6)
> > +#define BM_USBPHY_STATUS_HOSTDISCON_STATUS	(1 << 3)
> > +
> > +/* FIXME */
> > +#define M28EVK_USBOTG_ENABLE	MXS_GPIO_NR(3, 12)
> > +
> 
> This is platform code, should not put at driver.
> 
> > +struct mxs_usb_phy {
> > +	struct usb_phy		phy;
> > +
> > +	struct work_struct	work;
> > +
> > +	struct clk		*clk;
> > +	struct resource		*mem_res;
> > +	void __iomem		*mem;
> > +	int			irq;
> > +	int			gpio_vbus;
> > +	int			gpio_vbus_inverted;
> > +
> > +	enum usb_otg_state	new_state;
> > +
> > +	bool			host_mode;
> > +};
> > +
> > +static int mxs_usb_set_host(struct usb_otg *otg, struct usb_bus *host)
> 
> should be at imx-otg.c

I don't understand why. This is clearly specific to this PHY driver.

> 
> > +
> > +static int mxs_usb_set_peripheral(struct usb_otg *otg, struct usb_gadget
> > *gg)
> 
> gg may not a good name, how about just gadget?
> should be at imx-otg.c

DTTO

> > +static void mxs_usb_work(struct work_struct *w)
> 
> It is OTG switch routine, and should be put imx-otg.c. Sascha also
> suggested before.

Fine by me, but until someone can clearly explain to me why PHY specific code 
should be in a shared file (even if it's completely unrelated to it), I see no 
point moving this.

> > +{
> > +	struct mxs_usb_phy *phy = container_of(w, struct mxs_usb_phy, work);
> > +	struct usb_otg *otg = phy->phy.otg;
> > +	struct usb_hcd *hcd;
> > +
> > +	switch (otg->phy->state) {
> > +	case OTG_STATE_A_HOST:
> > +		if (phy->new_state == OTG_STATE_UNDEFINED) {
> > +			hcd = bus_to_hcd(otg->host);
> > +			usb_remove_hcd(hcd);
> > +			otg->phy->state = phy->new_state;
> > +			/* Turn off VBUS */
> > +			gpio_set_value(phy->gpio_vbus,
> > +				phy->gpio_vbus_inverted);
> > +		}
> > +		break;
> > +	case OTG_STATE_B_PERIPHERAL:
> > +		if (phy->new_state == OTG_STATE_UNDEFINED) {
> > +			usb_del_gadget_udc(otg->gadget);
> > +			otg->phy->state = phy->new_state;
> > +		}
> > +		break;
> > +	case OTG_STATE_UNDEFINED:
> > +		/* Check desired state. */
> > +		switch (phy->new_state) {
> > +		case OTG_STATE_A_HOST:
> > +			if (!otg->host)
> > +				break;
> > +			otg->phy->state = phy->new_state;
> > +
> > +			/* Turn on VBUS */
> > +			gpio_set_value(phy->gpio_vbus,
> > +				!phy->gpio_vbus_inverted);
> > +
> > +			hcd = bus_to_hcd(otg->host);
> > +			usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
> > +			break;
> > +		case OTG_STATE_B_PERIPHERAL:
> > +			if (!otg->gadget)
> > +				break;
> > +			otg->phy->state = phy->new_state;
> > +			usb_add_gadget_udc(phy->phy.dev, otg->gadget);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> 
> Seems you forget one otg state: OTG_STATE_B_IDLE.
> 
> at device mode:
> OTG_STATE_UNDEFINED -> OTG_STATE_B_IDLE (nothing on port)
> OTG_STATE_B_PERIPHERAL -> OTG_STATE_B_IDLE (disconnect with host)

This OTG biz really needs further work. So far, we only support Host/Device.

> 
> > +static int mxs_usb_phy_init(struct usb_phy *x)
> > +{
> > +	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
> > +	uint32_t val;
> > +
> > +	/* Enable clock to the PHY. */
> > +	clk_enable(phy->clk);
> > +
> > +	/* Reset the PHY block. */
> > +	mxs_reset_block(phy->mem + HW_USBPHY_CTRL);
> > +
> > +	/* Power up the PHY. */
> > +	writel(0, phy->mem + HW_USBPHY_PWD);
> > +
> > +	/* Enable FS/LS compatibility. */
> > +	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3;
> > +
> > +	if (phy->host_mode)
> > +		val |= BM_USBPHY_CTRL_ENHOSTDISCONDETECT;
> > +	else
> > +		val |= BM_USBPHY_CTRL_ENIRQDEVPLUGIN |
> > +			BM_USBPHY_CTRL_ENOTGIDDETECT |
> > +			BM_USBPHY_CTRL_ENDEVPLUGINDETECT;
> 
> Please explain the meaning of above code?
> 
> > +static void mxs_usb_phy_shutdown(struct usb_phy *x)
> > +{
> > +	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
> > +
> 
> You need to set portsc.phcd=1 and power down phy using set 0xffffffff to
> HW_USBPHY_PWD.
> 
> > +	/* Gate off the PHY. */
> > +	writel(BM_USBPHY_CTRL_CLKGATE, phy->mem + HW_USBPHY_CTRL_SET);
> > +
> > +	/* Disable clock to the PHY. */
> > +	clk_disable(phy->clk);
> > +}
> > +
> > +static irqreturn_t mxs_phy_irq(int irq, void *data)
> > +{
> > +	struct mxs_usb_phy *phy = data;
> > +	uint32_t status = readl(phy->mem + HW_USBPHY_STATUS);
> > +
> > +	if (status & BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ)
> > +		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> > +			phy->mem + HW_USBPHY_CTRL_CLR);
> > +	else
> > +		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> > +			phy->mem + HW_USBPHY_CTRL_SET);
> > +
> 
> Have you tested several connect/disconnect operation with high speed
> device? - where you clear BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ?
> - This code will always run at every usb interrupt, in fact, high speed
> detector only needs to be set/clear with connect/disconnect.

I have yet to figure out how to actually detect host connect/disconnect in OTG 
mode while also detect Device connect/disconnect. Can you elaborate on what 
needs to be set in the CTRL register to generate these interrupts?

> > +	return IRQ_NONE;
> > +}
> > +
> > 
> > 
> > +
> > +static int __devexit mxs_phy_remove(struct platform_device *pdev)
> > +{
> > +	struct mxs_usb_phy *phy = platform_get_drvdata(pdev);
> > +
> > +	/* Stop the PHY work. */
> > +	cancel_work_sync(&phy->work);
> > +
> > +	/* Power down the PHY. */
> > +	mxs_usb_phy_shutdown(&phy->phy);
> > +
> > +	/* Remove the transceiver. */
> > +	usb_set_transceiver(NULL);
> > +
> > +	/* Shut off VBUS. */
> > +	gpio_set_value(phy->gpio_vbus, phy->gpio_vbus_inverted);
> > +	gpio_free(phy->gpio_vbus);
> > +
> > +	/* Free the IRQ requested by this device. */
> > +	free_irq(phy->irq, phy);
> > +
> > +	/* Free the IRQ requested by this device. */
> > +	free_irq(phy->irq, phy);
> > +
> 
> Two free_irq???

Rebase issue

> 
> > +	/* Stop the PHY clock. */
> > +	clk_disable_unprepare(phy->clk);
> > +	clk_put(phy->clk);
> > +
> > +	/* Free the rest. */
> > +	platform_set_drvdata(pdev, NULL);
> > +
> > +	return 0;
> > +}
> > +
