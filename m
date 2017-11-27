From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Nov 2017 10:19:13 +0000
Subject: [PATCH] arm: l2c: unlock ways when in non-secure mode
In-Reply-To: <DB6PR04MB322104DB1B2FCBD535AAA49488250@DB6PR04MB3221.eurprd04.prod.outlook.com>
References: <20171126122530.857-1-peng.fan@nxp.com>
 <20171126131812.GZ31757@n2100.armlinux.org.uk>
 <DB6PR04MB3221D60D0EC8D5B31869AA6588240@DB6PR04MB3221.eurprd04.prod.outlook.com>
 <20171127091937.GA31757@n2100.armlinux.org.uk>
 <DB6PR04MB322104DB1B2FCBD535AAA49488250@DB6PR04MB3221.eurprd04.prod.outlook.com>
Message-ID: <20171127101911.GC31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:43:41AM +0000, Peng Fan wrote:
> Hi Russell,
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk]
> > Sent: Monday, November 27, 2017 5:20 PM
> > To: Peng Fan <peng.fan@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > van.freenix at gmail.com; Mark Rutland <mark.rutland@arm.com>; Thomas
> > Gleixner <tglx@linutronix.de>; Chris Brandt <chris.brandt@renesas.com>; Will
> > Deacon <will.deacon@arm.com>
> > Subject: Re: [PATCH] arm: l2c: unlock ways when in non-secure mode
> > 
> > On Sun, Nov 26, 2017 at 11:56:10PM +0000, Peng Fan wrote:
> > > Hi Russell,
> > >
> > > > Subject: Re: [PATCH] arm: l2c: unlock ways when in non-secure mode
> > > >
> > > > On Sun, Nov 26, 2017 at 08:25:30PM +0800, Peng Fan wrote:
> > > > > To boot Linux in Non-secure mode with l2x0, the l2x0 controller is
> > > > > enabled in secure mode and ways locked to make it seems L2 cache
> > > > > disabled during linux boot process. So during l2x0 initialization,
> > > > > need to unlock the ways to make l2x0 could cache data/inst.
> > > >
> > > > Why was this chosen instead of doing what everyone else does?
> > >
> > > I am not aware of how other platform handles the l2x0 unlock in non
> > > secure mode. Could you please share with me what others choose?
> > 
> > That's not what I was asking.
> > 
> > Everyone else provides a way for the l2x0 controller to be enabled and disabled
> > from non-secure mode.
> 
> Thanks for the information. I see that some platforms implements l2c_write_sec.
> 
> > 
> > Why have you decided to enable the l2x0 controller and leave it enabled, and
> > then lock down all the cache ways - which means you need the kernel to do
> > something entirely different for your platform.
> 
> Currently we are running OP-TEE on i.MX6/7 with Linux in non-secure mode. See
> In https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/generic_entry_a32.S#L428
> Pl310 is enabled. And In
> https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/generic_entry_a32.S#L461
> pl310 locked before returning back to Linux.
> 
> I see ti platform not enabled pl310 in OP-TEE, leaving Linux to enable it. platform-sam/stm/ zynq7k/imx
> Have pl310 enabled in OP-TEE.
> 
> I could switch to use l2c_write_sec dedicated for i.MX. But I think this patch is also a valid point.
> What do you suggest?

What I'm concerned about is that there's a valid scenario where the L2
cache would be enabled and left enabled by the secure mode code - that
is if the secure mode wishes to take advantage of the L2 cache, and has
locked down some ways for its own use.

In this scenario, the secure world would have set the L2 cache up to
prevent the non-secure side unlocking those ways.  This would mean
that the NS_LOCKDOWN bit in the auxiliary control register would be
clear.  The PL310 TRM has this to say:

"On reset the Non-Secure Lockdown Enable bit is set to 0 and Lockdown
 Registers are not permitted to be modified by non-secure accesses. In
 that configuration, if a non-secure access tries to write to those
 registers, the write response returns a DECERR response."

which means that if we blindly try and unlock the ways, we will end
up triggering an exception, and that will crash the kernel.

Given that the kernel does _not_ handle this scenario today, I fail to
see why OP-TEE would decide that, on ARM by default, it will enable
the L2 cache and lock all ways.

As you have already found, at least OMAP has decided to do things
sensibly.  I fail to see why everyone else can't also decide to do the
sensible thing.

Please talk to the OP-TEE folk to see whether the OP-TEE behaviour can
be changed first.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
