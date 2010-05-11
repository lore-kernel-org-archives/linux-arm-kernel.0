From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Tue, 11 May 2010 13:06:39 +0200
Subject: [PATCH 1/1] ehci-mxc: Fix mx31 OTG host initialisation
In-Reply-To: <20100510183509.GP30801@buzzloop.caiaq.de>
References: <1273515220-18909-1-git-send-email-philippe.retornaz@epfl.ch>
	<1273515220-18909-2-git-send-email-philippe.retornaz@epfl.ch>
	<20100510183509.GP30801@buzzloop.caiaq.de>
Message-ID: <201005111306.40034.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi, 10 mai 2010 20.35:09, Daniel Mack a ?crit :
> On Mon, May 10, 2010 at 08:13:40PM +0200, Philippe R?tornaz wrote:
> > On mx31 the OTG host initialisation fail if you need to have
> > an ULPI transfert to initialize the PHY.
> >
> > In order to be able to communicate with the PHY a complete reset
> > of the usb host is needed. After the PHY initialization the host
> > usb configuration registers need to be rewritten to avoid a host
> > controller lockup.
> 
> Given that things are wired up correctly on the board, yes. Many boards
> don't, as they copy-pasted the schematics which got it wrong.

Can you elaborate a bit more ? I don't see how you could do it another way 
with an isp1504 and an external power switch.

> 
> Anyway, if it helps you, it should go in. Some commenty below ...
> 
> > +	/* i.Mx31 OTG host has a bug, if you don't do a reset, then ULPI
> > +	 * transfert timeout. */
> > +	if (cpu_is_mx31() && pdev->id == 0) {
> > +		/* Wait for the controller to go idle */
> > +		for (i = 0; i < 10000; i++) {
> > +			if (readl(hcd->regs + USBSTS_OFFSET) & USBSTS_HCH)
> > +				break;
> > +			udelay(1);
> > +		}
> 
> Please use a #defined value rather than the 10000 magic.

Ok.

> Also, use cpu_relax() instead of the udelay(1).

I don't argee because if I use cpu_relax() it will make the timeout cpu 
frequency dependant. With the udelay it is clear that the timeout is about 
10ms.
But of course, I can do the change if this is really the way to do it.

> 
> > +		if (i == 10000) {
> > +			dev_err(dev, "Timeout while stopping USB controller\n");
> > +			goto err_init;
> > +		}
> > +
> > +		/* Stop the usb controller */
> > +		temp = readl(hcd->regs + USBCMD_OFFSET);
> > +		writel(temp & (~USBCMD_RS), hcd->regs + USBCMD_OFFSET);
> > +
> > +		for (i = 0; i < 10000; i++) {
> > +			if (!(readl(hcd->regs + USBCMD_OFFSET) & USBCMD_RS))
> > +				break;
> > +			udelay(1);
> > +		}
> > +
> > +		if (i == 10000) {
> > +			dev_err(dev, "Timeout while stopping USB controller\n");
> > +			goto err_init;
> > +		}
> 
> This seems to be done all over the place. Wouldn't a static inline
> function simplify the code a lot here?

Ok.

Philippe
