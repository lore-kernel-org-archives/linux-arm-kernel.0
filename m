From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 May 2010 16:31:57 +0100
Subject: [PATCH 3/5] USB: add clk structure for systems that support
	clkdev framework
In-Reply-To: <u2wc70ff3ad1005020821z5eb3eec5y5a64b1d5dd3652a@mail.gmail.com>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
	<1272810162-14858-3-git-send-email-saeed@marvell.com>
	<1272810162-14858-4-git-send-email-saeed@marvell.com>
	<20100502143602.GA4233@n2100.arm.linux.org.uk>
	<r2oc70ff3ad1005020805zc80ad8b9n1e56d4a0a6ce5b9c@mail.gmail.com>
	<20100502151425.GC4233@n2100.arm.linux.org.uk>
	<u2wc70ff3ad1005020821z5eb3eec5y5a64b1d5dd3652a@mail.gmail.com>
Message-ID: <20100502153157.GD4233@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 02, 2010 at 06:21:52PM +0300, saeed bishara wrote:
> On Sun, May 2, 2010 at 6:14 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > drivers/usb/host/ohci-s3c2410.c: ? ? ? ?2
> > drivers/usb/host/ohci-omap.c: ? ? ? ? ? 2
> > drivers/usb/host/r8a66597-hcd.c: ? ? ? ?1
> > drivers/usb/host/ehci-mxc.c: ? ? ? ? ? ?2
> > drivers/usb/host/ohci-da8xx.c: ? ? ? ? ?2
> > drivers/usb/host/ohci-pxa27x.c: ? ? ? ? 1
> > drivers/usb/host/ohci-pnx4008.c: ? ? ? ?1
> > drivers/usb/host/imx21-hcd.c: ? ? ? ? ? 1
> > drivers/usb/host/ohci-ep93xx.c: ? ? ? ? 1
> > drivers/usb/host/ehci-atmel.c: ? ? ? ? ?2
> > drivers/usb/host/ehci-omap.c: ? ? ? ? ? 5
> > drivers/usb/host/ohci-at91.c: ? ? ? ? ? 2
> >
> > So, five drivers need one clock, six drivers need two clocks, and one
> > driver needs five clocks. ?So maybe you should be catering for the
> > common case by providing two struct clk's, or maybe catering for the
> > maximal case of five clocks?
> well, I think that those drivers that have more than one clk can be
> redesigned by adding virtual clk for the the usb host, and the clk
> implementation for that soc should manage all the underlying physical
> clocks. I've looked at the omap,at91 and atmel, and it looks to me
> that this is doable. you see can see that the clk stuff in those
> driver has nothing to do with usb itself. what do you think?

Not happy with this for two reasons:
1. You're assuming that they can be managed as one entity; that doesn't seem
   true for some of the drivers.
2. I don't see any reason to force this complication into the clk layer for
   these platforms when they don't actually need it.

Due to (1), using your current approach will result in those drivers
scattering their clks across two structures, which as I've said in my
previous email would be confusing.

So I don't think this approach makes much sense.
