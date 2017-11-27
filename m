From: peng.fan@nxp.com (Peng Fan)
Date: Mon, 27 Nov 2017 09:43:41 +0000
Subject: [PATCH] arm: l2c: unlock ways when in non-secure mode
In-Reply-To: <20171127091937.GA31757@n2100.armlinux.org.uk>
References: <20171126122530.857-1-peng.fan@nxp.com>
 <20171126131812.GZ31757@n2100.armlinux.org.uk>
 <DB6PR04MB3221D60D0EC8D5B31869AA6588240@DB6PR04MB3221.eurprd04.prod.outlook.com>
 <20171127091937.GA31757@n2100.armlinux.org.uk>
Message-ID: <DB6PR04MB322104DB1B2FCBD535AAA49488250@DB6PR04MB3221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk]
> Sent: Monday, November 27, 2017 5:20 PM
> To: Peng Fan <peng.fan@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> van.freenix at gmail.com; Mark Rutland <mark.rutland@arm.com>; Thomas
> Gleixner <tglx@linutronix.de>; Chris Brandt <chris.brandt@renesas.com>; Will
> Deacon <will.deacon@arm.com>
> Subject: Re: [PATCH] arm: l2c: unlock ways when in non-secure mode
> 
> On Sun, Nov 26, 2017 at 11:56:10PM +0000, Peng Fan wrote:
> > Hi Russell,
> >
> > > Subject: Re: [PATCH] arm: l2c: unlock ways when in non-secure mode
> > >
> > > On Sun, Nov 26, 2017 at 08:25:30PM +0800, Peng Fan wrote:
> > > > To boot Linux in Non-secure mode with l2x0, the l2x0 controller is
> > > > enabled in secure mode and ways locked to make it seems L2 cache
> > > > disabled during linux boot process. So during l2x0 initialization,
> > > > need to unlock the ways to make l2x0 could cache data/inst.
> > >
> > > Why was this chosen instead of doing what everyone else does?
> >
> > I am not aware of how other platform handles the l2x0 unlock in non
> > secure mode. Could you please share with me what others choose?
> 
> That's not what I was asking.
> 
> Everyone else provides a way for the l2x0 controller to be enabled and disabled
> from non-secure mode.

Thanks for the information. I see that some platforms implements l2c_write_sec.

> 
> Why have you decided to enable the l2x0 controller and leave it enabled, and
> then lock down all the cache ways - which means you need the kernel to do
> something entirely different for your platform.

Currently we are running OP-TEE on i.MX6/7 with Linux in non-secure mode. See
In https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/generic_entry_a32.S#L428
Pl310 is enabled. And In
https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/generic_entry_a32.S#L461
pl310 locked before returning back to Linux.

I see ti platform not enabled pl310 in OP-TEE, leaving Linux to enable it. platform-sam/stm/ zynq7k/imx
Have pl310 enabled in OP-TEE.

I could switch to use l2c_write_sec dedicated for i.MX. But I think this patch is also a valid point.
What do you suggest?

Thanks,
Peng. 

> 
> --
> RMK's Patch system:
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> armlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=02%7C01%7Cpeng.fan%4
> 0nxp.com%7C35e84f76d1614037232008d535780198%7C686ea1d3bc2b4c6fa92c
> d99c5c301635%7C0%7C0%7C636473711907495083&sdata=8aFy%2Fhi6hXQLyrlO
> 93uABaplCKM6QOP5n9DvX7S1uJ4%3D&reserved=0
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
