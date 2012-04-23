From: marex@denx.de (Marek Vasut)
Date: Mon, 23 Apr 2012 04:11:15 +0200
Subject: [PATCH 07/11] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B793FA@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-8-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B793FA@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201204230411.15634.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chen Peter-B29397,

> > NOTE: I still haven't figured out how to enable/disable the disconnection
> > detector, it can't be enabled all the time, so I toggle PHY stuff from
> > this
> > driver, which I doubt is correct.
> 
> Hi Marek, I have already explain how to use high speed disconnect detector
> in early email.
> 
> > +
> > +static irqreturn_t mxs_ehci_irq(struct usb_hcd *hcd)
> > +{
> > +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> > +	struct usb_phy *phy = usb_get_transceiver();
> > +	uint32_t status;
> > +	static uint32_t discon;
> > +
> > +	if (phy && phy->otg && phy->otg->set_vbus) {
> > +		status = ehci_readl(ehci, &ehci->regs->status);
> > +		status = !!(status & STS_PCD);
> > +		if (status != discon) {
> > +			discon = status;
> > +			phy->otg->set_vbus(phy->otg, status);
> > +		}
> > +	}
> 
> Conflict with your phy interrupt code.

Yes, this should have been removed, rebase issue. Damn

Best regards,
Marek Vasut
