From: marex@denx.de (Marek Vasut)
Date: Tue, 24 Apr 2012 22:58:54 +0200
Subject: [PATCH 08/11] MXS: Add imx-otg driver
In-Reply-To: <20120424204947.GZ3852@pengutronix.de>
References: <1335099567-21056-1-git-send-email-marex@denx.de>
 <201204241949.37938.marex@denx.de> <20120424204947.GZ3852@pengutronix.de>
Message-ID: <201204242258.54799.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

> On Tue, Apr 24, 2012 at 07:49:37PM +0200, Marek Vasut wrote:
> > > > > > Why do you call this driver imx-otg when it is actually MXS
> > > > > > specific? How would you call a corresponding driver for the
> > > > > > remaining i.MX processors?
> > > > > 
> > > > > This is the driver for the all i.MX processors.
> > > > 
> > > > If it is for all i.MX processors, it shouldn't access MXS specific
> > > > registers, like:
> > > > +		writel(wakeup, x->io_priv + HW_USBPHY_CTRL_SET);
> > > 
> > > Indeed not. This should be done in the phy driver.
> > 
> > Ok, so now you figured out that all these set_host() set_peripheral()
> > work() calls should be back in the phy driver, not in the imx-otg? hm
> > ... so back to the V4 of the patchset?
> 
> Not really, you are just not allowed to put phy code into imx-otg.c,
> because the phy may be another one on a different SoC.
> 
> That said, I am a bit confused at the moment. There seems to be no
> method to activate the interrupt in the phy.

There is more to be confused about -- you don't get the host/device connection 
interrupt from the PHY, but you dig one of them from the EHCI host and the other 
from the EHCI host too -- which is pretty messed up already.

We can certainly use IRQF_SHARED to trap some of the interrupts in the PHY code, 
but that's still quite weird.

> Sascha

Best regards,
Marek Vasut
