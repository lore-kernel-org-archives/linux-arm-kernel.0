From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Tue, 29 Nov 2011 20:21:14 +0100
Subject: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <35AB98346D25394A9354ED89C4D76587226BD8@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1322550565-29162-1-git-send-email-peter.chen@freescale.com>
 <20180.36084.962507.946237@ipc1.ka-ro>
 <35AB98346D25394A9354ED89C4D76587226AE3@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111129082139.GG27267@pengutronix.de>
 <35AB98346D25394A9354ED89C4D76587226BD8@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111129192114.GI27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 10:57:37AM +0000, Chen Peter-B29397 wrote:
> 
> > -----Original Message-----
> > From: s.hauer at pengutronix.de [mailto:s.hauer at pengutronix.de]
> > Sent: Tuesday, November 29, 2011 4:22 PM
> > To: Chen Peter-B29397
> > Cc: Lothar Wa?mann; stern at rowland.harvard.edu; gregkh at suse.de;
> > amit.kucheria at canonical.com; linux-usb at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; u.kleine-koenig at pengutronix.de
> > Subject: Re: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
> > 
> > On Tue, Nov 29, 2011 at 08:02:53AM +0000, Chen Peter-B29397 wrote:
> > > >
> > > > In the driver you would then do a clk_get() for those three clocks
> > > > independent of the platform.
> > > >
> > > The reason why I add this patch is not for clk things, it is for:
> > > 1. Coming device driver
> > > 2. Handle things difference between SoC's. not only clk, others
> > > like low power, wakeup, hsic, or other will comes in future.
> > 
> > The ehci is a standardized core. Please be *very* careful with what you
> > add to this driver. As said in my other mail, the real differences are
> > in the phys and the phy handling code should not be in the ehci-mxc
> > driver at all.
> > Rather than adding random phy code to the driver you should write phy
> > drivers. If you still think that there is code missing in this driver
> > please explain further.
> > 
> > Sascha
> > 
> Sascha, thanks for your comments.
> 
> In fact, this patch does not change any ehci logics. The changes for clock.c
> are just let probe not return error with clk_get(dev, "usb"), as dev_id is changed.
> 
> Yes, this patch is not meaningful for current ehci-mxc, I do this patch just for
> preparing submit further i.mx usb ehci driver.
> - If I am going to submit mx28 usb ehci driver, the things like cpu_is_mx51 is not defined
> for mxs platform
> - So, refer to i.mx spi and sdhci-esdhc changing for platform_device_id, I made this patch.
> 
> If you think this patch is not meaningful at current stage, I will not go on.
> 
> For USB PHY's driver, I will discuss with linux-usb list first, then discuss with you how
> to do it at i.mx platform. My current plan is refine phy.c which is from heikki's RFC, and
> implement at i.mx51 bbg first, which has two phys (UTMI for OTG, and ULPI for host1). What do you
> think?

We have to deal with a historically grown wrong hardware abstraction
here. What we have from a hardware point of view is a device consisting
of:

- A ehci core (theoretically optional, but seems to be always present)
- A Synopsys USB device core (optional), the one we currently have four
  different drivers for.
- A USB phy (mandatory, but may be nearly invisible from software). The
  phy may be an external ULPI phy, an internal phy in the SoC, or even
  selectable between both.

Currently we have a ehci-mxc driver which claims resources like mem
regions, interrupts and clocks. We also have the gadget driver
(currently the fsl_mxc_udc driver) which also claims the same resources.
Instead we should have a glue driver which claims the resources and
passes control over to either the host or the gadget driver. This glue
code should also connect the phy.

Looking at the code in mainline the msm driver is closest to what we
want to have. It claims the resources in msm_otg.c and passes control
over to the ehci or ci13xxx gadget driver depending on the USB id pin or
a platform decision. What's missing here is some plugin mechanism for
different phys. That's another historically grown thing that there is
only a single phy in the Kernel because there can be only one otg
instance and phys were thought to be present only in otg cores. Heikkis
patches work in the right direction here.

As a conclusion I think that there should be no platform or SoC specific
code in neither the ehci nor in the gadget driver. Also there shouldn't
be all these ehci-$SoC.c files in the tree. The way to get there could
be:

- Work on Heikkis patches so that we can register usb phys
- move the USB phy setup code from arch-imx to drivers/usb/phy
- factor out the common code from the msm_otg driver.
- create a imx-otg.c which only claims the resources and passes
  them to the otg common code. Sooner or later not even an imx-otg.c is
  necessary because we can use a devicetree based driver and then only
  the phy code will be SoC specific.

I'm sorry that there is no easy way to get proper USB support, but we
are way beyond the point where the current infrastructure scales.
In any way, there is no place for more SoC specific code in ehci-mxc.c.
Instead you should work on moving SoC code out of there.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
