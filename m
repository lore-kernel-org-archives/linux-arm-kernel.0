From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 22:16:42 +0200
Subject: [PATCH 07/10] MXS: Add USB PHY driver
In-Reply-To: <201204182202.02627.marex@denx.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-8-git-send-email-marex@denx.de>
 <20120418193654.GZ3852@pengutronix.de>
 <201204182202.02627.marex@denx.de>
Message-ID: <20120418201642.GC3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 10:02:02PM +0200, Marek Vasut wrote:
> Dear Sascha Hauer,
> 
> > > +static void mxs_usb_work(struct work_struct *w)
> > > +{
> > > +	struct mxs_usb_phy *phy = container_of(w, struct mxs_usb_phy, work);
> > > +	struct usb_otg *otg = phy->phy.otg;
> > > +	struct usb_hcd *hcd;
> > > +
> > > +	switch (otg->phy->state) {
> > > +	case OTG_STATE_A_HOST:
> > > +		if (otg->host) {
> > > +			hcd = bus_to_hcd(otg->host);
> > > +			usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
> > > +		}
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +}
> > 
> > This function should be in imx-otg.
> 
> You mean imx-usb? What'd it do in there?

otg/imx-usb.c, yes (though I would prefer imx-otg.c)

It should be there because it's the imx-otg.c driver which manages the
state. The phy driver is only a helper.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
