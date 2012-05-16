From: marex@denx.de (Marek Vasut)
Date: Wed, 16 May 2012 15:35:44 +0200
Subject: [PATCH 5/8] MXS: Add USB PHY driver
In-Reply-To: <20120516050605.GB19137@b20223-02.ap.freescale.net>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
 <201205160630.15212.marex@denx.de>
 <20120516050605.GB19137@b20223-02.ap.freescale.net>
Message-ID: <201205161535.44525.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

> On Wed, May 16, 2012 at 06:30:14AM +0200, Marek Vasut wrote:
> > Dear Richard Zhao,
> > 
> > > Hi Marek,
> > > 
> > > On Tue, May 15, 2012 at 10:23:36AM +0200, Marek Vasut wrote:
> > > > Add driver that controls the built-in USB PHY in the i.MX233/i.MX28.
> > > > This enables the PHY upon powerup and shuts it down on shutdown.
> > > > 
> > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > Cc: Chen Peter-B29397 <B29397@freescale.com>
> > > > Cc: Detlev Zundel <dzu@denx.de>
> > > > Cc: Fabio Estevam <festevam@gmail.com>
> > > > Cc: Li Frank-B20596 <B20596@freescale.com>
> > > > Cc: Linux USB <linux-usb@vger.kernel.org>
> > > > Cc: Liu JunJie-B08287 <B08287@freescale.com>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > Cc: Shi Make-B15407 <B15407@freescale.com>
> > > > Cc: Stefano Babic <sbabic@denx.de>
> > > > Cc: Subodh Nijsure <snijsure@grid-net.com>
> > > > Cc: Wolfgang Denk <wd@denx.de>
> > > > ---
> > > > 
> > > >  drivers/usb/otg/Kconfig   |   10 ++
> > > >  drivers/usb/otg/Makefile  |    1 +
> > > >  drivers/usb/otg/mxs-phy.c |  313
> > > >  +++++++++++++++++++++++++++++++++++++++++++++
> > > 
> > > imx is more common.
> > 
> > But is this really present also in the mx3/mx5 chips ? Or is this only
> > mx233/mx28/mx6q specific ?
> 
> I don't mean phy only, but all naming in the series. mx23/28 (mxs) are
> still imx.

Sure, but mixing sigmatel stuff with mxc stuff is quite confusing.

[...]

> > > > +	otg->phy		= &phy->phy;
> > > > +	otg->set_vbus		= mxs_otg_set_vbus;
> > > > +	otg->set_host		= mxs_otg_set_host;
> > > > +	otg->set_peripheral	= mxs_otg_set_peripheral;
> > > > +
> > > > +	platform_set_drvdata(pdev, phy);
> > > > +
> > > > +	ATOMIC_INIT_NOTIFIER_HEAD(&phy->phy.notifier);
> > > > +
> > > > +	/* Register the transceiver with kernel. */
> > > > +	ret = usb_set_transceiver(&phy->phy);
> > > 
> > > In my code, I don't plan to call it for host phy, to achieve multi-phy
> > > support.
> > 
> > We're not sure how the multi-phy support will look like at all yet. I
> > think Peter and Filipe are in a tough dispute on that.
> 
> Using DT phandler, my code can connect phy and usb drivers. We might
> not have to pend on phy lib.
> Sure, somehow it cause dependency between phy driver and ci13xxx_imx
> driver. phy driver must set usb_phy as  drv data and ci13xxx_imx use
> it. It's one reason why I didn't put it to otg folder. The other reason
> is, otg folder may not be a good place to hold phy. Maybe drivers/usb/phy
> will be better?

That's exactly where I'd like to know Felipe's opinion. I don't think it's a 
good idea to create the dependency between this driver any PHY in any way. It 
kind-of defies the purpose of phy lib.

[...]

> > > > +static void __exit mxs_phy_exit(void)
> > > > +{
> > > > +	platform_driver_unregister(&mxs_phy_driver);
> > > > +}
> > > > +
> > > > +arch_initcall(mxs_phy_init);
> > > 
> > > postcor_initcall? It make possible hack in machine init code.
> > 
> > Good idea.
> > 
> > Thanks for the review, now how should we put these codes of ours
> > together? Will you integrate my code into yours or shall I do it the
> > other way around?
> 
> either way works for me. but I hope it support imx6 and use DT bindings
> and other things maybe in next branch.

Fine with me, I asked in the other patch where I can get the mx28 DT-enabled 
tree please?

> > Alas, I'd prefer for the PHY to stay separate in drivers/usb/otg,
> 
> I explained it above.
> 
> > maybe we can
> > also recycle some my mxs binding code for ci13xxx in some way or another,
> > as it has MXS specific hacks in it.
> 
> what hack do you mean?

The .notify_event stuff in my ci13xxx_mxs, where it reads the PCD bit.

> > I think the ci13xxx binding for the rest of i.MX
> > (aka mxc) will looks different, won't it? But either way, my mxs/ci13xxx
> > binding glue will have to wait until we finish negotiating the
> > phy_notify stuff with Greg.
> 
> Sure. At the same time, we may create new version patch and see response.

But if this ci13xxx_imx will only support mxs at first, it is kinda confusing.

> Thanks
> Richard
> 
> > > Thanks
> > > Richard
> > > 
> > > > +module_exit(mxs_phy_exit);
> > > > +
> > > > +MODULE_ALIAS("platform:mxs-usb-phy");
> > > > +MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> > > > +MODULE_DESCRIPTION("Freescale i.MX28 USB PHY driver");
> > > > +MODULE_LICENSE("GPL");
