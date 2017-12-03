From: peng.fan@nxp.com (Peng Fan)
Date: Sun, 3 Dec 2017 11:20:48 +0000
Subject: [PATCH] arm: l2c: unlock ways when in non-secure mode
In-Reply-To: <DB6PR04MB3221EDB9EEF8F2606FC292B5883A0@DB6PR04MB3221.eurprd04.prod.outlook.com>
References: <20171126122530.857-1-peng.fan@nxp.com>
 <20171126131812.GZ31757@n2100.armlinux.org.uk>
 <DB6PR04MB3221D60D0EC8D5B31869AA6588240@DB6PR04MB3221.eurprd04.prod.outlook.com>
 <20171127091937.GA31757@n2100.armlinux.org.uk>
 <DB6PR04MB322104DB1B2FCBD535AAA49488250@DB6PR04MB3221.eurprd04.prod.outlook.com>
 <20171127101911.GC31757@n2100.armlinux.org.uk>
 <DB6PR04MB3221EDB9EEF8F2606FC292B5883A0@DB6PR04MB3221.eurprd04.prod.outlook.com>
Message-ID: <DB6PR04MB32211AC670BCAD49CB9F2F38883F0@DB6PR04MB3221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> > > > > >
> > > > > > On Sun, Nov 26, 2017 at 08:25:30PM +0800, Peng Fan wrote:
> > > > > > > To boot Linux in Non-secure mode with l2x0, the l2x0
> > > > > > > controller is enabled in secure mode and ways locked to make
> > > > > > > it seems L2 cache disabled during linux boot process. So
> > > > > > > during l2x0 initialization, need to unlock the ways to make
> > > > > > > l2x0 could
> > cache data/inst.
> > > > > >
> > > > > > Why was this chosen instead of doing what everyone else does?
> > > > >
> > > > > I am not aware of how other platform handles the l2x0 unlock in
> > > > > non secure mode. Could you please share with me what others choose?
> > > >
> > > > That's not what I was asking.
> > > >
> > > > Everyone else provides a way for the l2x0 controller to be enabled
> > > > and disabled from non-secure mode.
> > >
> > > Thanks for the information. I see that some platforms implements
> > l2c_write_sec.
> > >
> > > >
> > > > Why have you decided to enable the l2x0 controller and leave it
> > > > enabled, and then lock down all the cache ways - which means you
> > > > need the kernel to do something entirely different for your platform.
> > >
> > > Currently we are running OP-TEE on i.MX6/7 with Linux in non-secure
> > > mode. See In
> > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fg
> > > it
> > > hub.com%2FOP-
> > TEE%2Foptee_os%2Fblob%2Fmaster%2Fcore%2Farch%2Farm%2Fkern
> > >
> > el%2Fgeneric_entry_a32.S%23L428&data=02%7C01%7Cpeng.fan%40nxp.com%
> > 7C32
> > >
> >
> e10e1e643f4def0d9508d535805486%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> > C0%
> > >
> >
> 7C0%7C636473747645673295&sdata=ZGaxxhs8mPNcqk5l2aSiStkPRFNxLzFFj45w
> > kj%
> > > 2Ff%2Fu4%3D&reserved=0
> > > Pl310 is enabled. And In
> > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fg
> > > it
> > > hub.com%2FOP-
> > TEE%2Foptee_os%2Fblob%2Fmaster%2Fcore%2Farch%2Farm%2Fkern
> > >
> > el%2Fgeneric_entry_a32.S%23L461&data=02%7C01%7Cpeng.fan%40nxp.com%
> > 7C32
> > >
> >
> e10e1e643f4def0d9508d535805486%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> > C0%
> > >
> >
> 7C0%7C636473747645673295&sdata=rO1LG3639lfclvtgzZRTTPcSAGDQNG0Clqb
> > D1wC
> > > 4wGk%3D&reserved=0
> > > pl310 locked before returning back to Linux.
> > >
> > > I see ti platform not enabled pl310 in OP-TEE, leaving Linux to
> > > enable it. platform-sam/stm/ zynq7k/imx Have pl310 enabled in OP-TEE.
> > >
> > > I could switch to use l2c_write_sec dedicated for i.MX. But I think
> > > this patch is
> > also a valid point.
> > > What do you suggest?
> >
> > What I'm concerned about is that there's a valid scenario where the L2
> > cache would be enabled and left enabled by the secure mode code - that
> > is if the secure mode wishes to take advantage of the L2 cache, and
> > has locked down some ways for its own use.
> >
> > In this scenario, the secure world would have set the L2 cache up to
> > prevent the non-secure side unlocking those ways.  This would mean
> > that the NS_LOCKDOWN bit in the auxiliary control register would be
> > clear.  The PL310 TRM has this to say:
> >
> > "On reset the Non-Secure Lockdown Enable bit is set to 0 and Lockdown
> > Registers are not permitted to be modified by non-secure accesses. In
> > that configuration, if a non-secure access tries to write to those
> > registers, the write response returns a DECERR response."
> >
> > which means that if we blindly try and unlock the ways, we will end up
> > triggering an exception, and that will crash the kernel.

Just have a follow up question. If implementing l2c_write_sec, the kernel image
could not  only running in non-secure world. If we want the image to support
running in secure and non-secure world, do you have any suggestions about
the l2c things?

Thanks,
Peng.

> 
> Currently, we set auxiliary control register to let NS could unlock. BIT26 set to 1.
> But you bring a valid point is if TEE would like to lock down some ways for its
> own use, l2c_write_sec should be used, to avoid Linux to directly unlock.
> 
> >
> > Given that the kernel does _not_ handle this scenario today, I fail to
> > see why OP-TEE would decide that, on ARM by default, it will enable
> > the L2 cache and lock all ways.
> >
> > As you have already found, at least OMAP has decided to do things
> > sensibly.  I fail to see why everyone else can't also decide to do the sensible
> thing.
> 
> Most platforms just set BIT26 to allow non-secure unlock ways without
> considering reserving ways dedicated to TEE.
> 
> i.MX also has BIT26 set, so if l2c_init is not a good place, do you think moving
> unlock to imx_init_l2cache is ok? But this means "enabling(unlock)" L2C earlier
> which is before l2c_init
> 
> >
> > Please talk to the OP-TEE folk to see whether the OP-TEE behaviour can
> > be changed first.
> 
> +OP-TEE maintainers Etienne, Jens
> Do you have comments on this?
> 
> Thanks,
> Peng.
> 
> >
> > --
> > RMK's Patch system:
> >
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> >
> armlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=02%7C01%7Cpeng.fan%4
> >
> 0nxp.com%7C32e10e1e643f4def0d9508d535805486%7C686ea1d3bc2b4c6fa92c
> >
> d99c5c301635%7C0%7C0%7C636473747645673295&sdata=4i8a6dYNkHlMXiYQZ
> > N9Ej4b68q%2FZfMCZvIUfJtFy0Jc%3D&reserved=0
> > FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down
> > 630kbps up According to speedtest.net: 8.21Mbps down 510kbps up
