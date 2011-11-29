From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 29 Nov 2011 10:57:37 +0000
Subject: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <20111129082139.GG27267@pengutronix.de>
References: <1322550565-29162-1-git-send-email-peter.chen@freescale.com>
 <20180.36084.962507.946237@ipc1.ka-ro>
 <35AB98346D25394A9354ED89C4D76587226AE3@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111129082139.GG27267@pengutronix.de>
Message-ID: <35AB98346D25394A9354ED89C4D76587226BD8@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: s.hauer at pengutronix.de [mailto:s.hauer at pengutronix.de]
> Sent: Tuesday, November 29, 2011 4:22 PM
> To: Chen Peter-B29397
> Cc: Lothar Wa?mann; stern at rowland.harvard.edu; gregkh at suse.de;
> amit.kucheria at canonical.com; linux-usb at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; u.kleine-koenig at pengutronix.de
> Subject: Re: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
> 
> On Tue, Nov 29, 2011 at 08:02:53AM +0000, Chen Peter-B29397 wrote:
> > >
> > > In the driver you would then do a clk_get() for those three clocks
> > > independent of the platform.
> > >
> > The reason why I add this patch is not for clk things, it is for:
> > 1. Coming device driver
> > 2. Handle things difference between SoC's. not only clk, others
> > like low power, wakeup, hsic, or other will comes in future.
> 
> The ehci is a standardized core. Please be *very* careful with what you
> add to this driver. As said in my other mail, the real differences are
> in the phys and the phy handling code should not be in the ehci-mxc
> driver at all.
> Rather than adding random phy code to the driver you should write phy
> drivers. If you still think that there is code missing in this driver
> please explain further.
> 
> Sascha
> 
Sascha, thanks for your comments.

In fact, this patch does not change any ehci logics. The changes for clock.c
are just let probe not return error with clk_get(dev, "usb"), as dev_id is changed.

Yes, this patch is not meaningful for current ehci-mxc, I do this patch just for
preparing submit further i.mx usb ehci driver.
- If I am going to submit mx28 usb ehci driver, the things like cpu_is_mx51 is not defined
for mxs platform
- So, refer to i.mx spi and sdhci-esdhc changing for platform_device_id, I made this patch.

If you think this patch is not meaningful at current stage, I will not go on.

For USB PHY's driver, I will discuss with linux-usb list first, then discuss with you how
to do it at i.mx platform. My current plan is refine phy.c which is from heikki's RFC, and
implement at i.mx51 bbg first, which has two phys (UTMI for OTG, and ULPI for host1). What do you
think?

> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
