From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-15?q?R=E9tornaz?=)
Date: Tue, 11 May 2010 13:05:43 +0200
Subject: [PATCH 1/1] ehci-mxc: Fix mx31 OTG host initialisation
In-Reply-To: <20100511063907.GU31199@pengutronix.de>
References: <1273515220-18909-1-git-send-email-philippe.retornaz@epfl.ch>
	<1273515220-18909-2-git-send-email-philippe.retornaz@epfl.ch>
	<20100511063907.GU31199@pengutronix.de>
Message-ID: <201005111305.44029.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi, 11 mai 2010 08.39:07, Sascha Hauer a ?crit :
> On Mon, May 10, 2010 at 08:13:40PM +0200, Philippe R?tornaz wrote:
> 
> > +	if (cpu_is_mx31() && pdev->id == 0) {
> > +		/* Wait for the controller to go idle */
> > +		for (i = 0; i < 10000; i++) {
> > +			if (readl(hcd->regs + USBSTS_OFFSET) & USBSTS_HCH)
> > +				break;
> > +			udelay(1);
> > +		}
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
> > +
> > +		/* Reset the usb controller */
> > +		temp = readl(hcd->regs + USBCMD_OFFSET);
> > +		writel(temp | USBCMD_RST, hcd->regs + USBCMD_OFFSET);
> > +
> > +		for (i = 0; i < 10000; i++) {
> > +			if (!(readl(hcd->regs + USBCMD_OFFSET) & USBCMD_RST))
> > +				break;
> > +			udelay(1);
> > +		}
> > +
> > +		if (i == 10000) {
> > +			dev_err(dev, "Timeout while reseting USB controller\n");
> > +			goto err_init;
> > +		}
> > +	}
> 
> You add the resetting of the controller after setting up USBMODE/PORTSC
> setup. Wouldn't it be possible to change the order so that we do not
> have to do it twice?

I tried and it does work on host2, but not on OTG. 

I did it this way so I don't change the behavior on other SoC or even on 
host2. 

> Also, I think the whole reset functionality should be a seperate
> function. I can imagine we'll need it elsewhere or on different SoCs in
> which case the if clause above gets complicated.

Ok.

Philippe
