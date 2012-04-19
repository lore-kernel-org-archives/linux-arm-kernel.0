From: marex@denx.de (Marek Vasut)
Date: Fri, 20 Apr 2012 00:06:35 +0200
Subject: [PATCH 07/10] MXS: Add USB PHY driver
In-Reply-To: <20120418201642.GC3852@pengutronix.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <201204182202.02627.marex@denx.de> <20120418201642.GC3852@pengutronix.de>
Message-ID: <201204200006.35966.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

> On Wed, Apr 18, 2012 at 10:02:02PM +0200, Marek Vasut wrote:
> > Dear Sascha Hauer,
> > 
> > > > +static void mxs_usb_work(struct work_struct *w)
> > > > +{
> > > > +	struct mxs_usb_phy *phy = container_of(w, struct mxs_usb_phy,
> > > > work); +	struct usb_otg *otg = phy->phy.otg;
> > > > +	struct usb_hcd *hcd;
> > > > +
> > > > +	switch (otg->phy->state) {
> > > > +	case OTG_STATE_A_HOST:
> > > > +		if (otg->host) {
> > > > +			hcd = bus_to_hcd(otg->host);
> > > > +			usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
> > > > +		}
> > > > +		break;
> > > > +	default:
> > > > +		break;
> > > > +	}
> > > > +}
> > > 
> > > This function should be in imx-otg.
> > 
> > You mean imx-usb? What'd it do in there?
> 
> otg/imx-usb.c, yes (though I would prefer imx-otg.c)
> 
> It should be there because it's the imx-otg.c driver which manages the
> state. The phy driver is only a helper.

I believe the imx-otg should only call otg_set_host()/otg_set_peripheral() on 
the particular PHY, in this case mxs-usb-phy, correct? The mxs_usb_work() should 
stay in the PHY's driver, because it'll likely frob with the PHY's own registers 
once peripheral support is added.

> 
> Sascha

Best regards,
Marek Vasut
