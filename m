From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sun, 20 Dec 2009 23:50:01 +0100
Subject: [PATCH 2/4] mfd: mc13783: When probing, unlock the mc13783
	before subsystems initialisation.
In-Reply-To: <20091220184941.GA13294@pengutronix.de>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<1260811085.2022.135.camel@climbing-alby>
	<1261152746.3356.72.camel@climbing-alby>
	<20091219201816.GA28742@pengutronix.de>
	<1261316918.5224.15.camel@climbing-alby>
	<20091220184941.GA13294@pengutronix.de>
Message-ID: <1261349401.5224.154.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Il giorno dom, 20/12/2009 alle 19.49 +0100, Uwe Kleine-K?nig ha scritto:
> Hi Alberto,
> 
> On Sun, Dec 20, 2009 at 02:48:38PM +0100, Alberto Panizzo wrote:
> > > > PATCH 1 & 2 are fixes that can go to .33
> > > I don't like patch 1.  I'd prefer that drivers touching
> > > MC13783_REG_POWER_MISCELLANEOUS are aware of the bit in question and
> > > wouldn't rely on mc13783-core.
> > 
> > Yes, but MC13783_REG_POWER_MISCELLANEOUS contains bit that control
> > different aspect of mc13783 chip.
> > GPO are regulator related, but those two bits in question maybe 
> > apply to a power management driver, so this problem is a matter
> > of mc13783-core.
> maybe?
>  
> > Another possible solution, is to trace the writings to those two bits
> > in mc13783_reg_rmw storing the value written an reproducing it in next
> > mc13783_reg_rmw calls.
> > But the problem for this is that we don't know if the bootloader 
> > had initialised those with another non default value.
> > Another problem is that if another driver make use of 
> > mc13783_reg_write for modifying those bits, the state stored will
> > be inconsistent.
> The next best thing I would consider acceptable are dedicated functions
> for MC13783_REG_POWER_MISCELLANEOUS.  I havn't checked what the register
> in question is used for, but I think the bootloader isn't generally a
> problem as Linux shouldn't rely on things setup by the bootloader (apart
> from the things described in
> http://www.arm.linux.org.uk/developer/booting.php of course).  And I
> don't see a problem for in-kernel users of mc13783_reg_write to modify
> the register.  If the mc13783-API is changed that
> MC13783_REG_POWER_MISCELLANEOUS must only be modified by using (say)
> mc13783_powermisc_rmw() it's a (probably uncatched) bug to use
> mc13783_reg_write.

Thanks for your point of view. What I proposed is a functionality cut
for mc13783 and I understand this.

MC13783_REG_POWER_MISCELLANEOUS contain configuration bits for GPO's
(two bits for everyone: "Enable" and "Controlled by Standby")
those two Power Gates Enable and VIBPINCTRL that behave the same as the
two Power Gates Enable.

GPO's are considered as regulators by the present driver in the term 
that they are thought to be used as external power supplies controllers.

Power Gates behave light different: PWGTnDRV are digital output 
controlled by hardware pins (PWGTnEN) and enabled (the hardware control)
by those two bits.

In this sense, can they be considered digital regulators too?

If yes, they can be controlled in the regulator driver and there can
be written a new mc13783_regulator_powermisc_rmw() function.

In the i.MX31 PDK board PWGT1DRV controls the MCU power supply and
PWGT2DRV control the L2 cache power supply. PWGTnEN are connected
to the corresponding i.MX31 Power Management interface outputs
in this way, in power saving mode, voltage for MCU is lowered at the
minimum and L2 cache is turned off.

> 
> And patch 1 is definitly *not* material for .33, as there is currently
> no user of MC13783_REG_POWER_MISCELLANEOUS in .33-rc1, so there is
> nothing to fix.
> 
> Best regards
> Uwe

You are right, there is no directly user, what I thought to fix is
the capability to enable / disable GPOs in the mc13783 that is a 
existent functionality for the present .33 regulator driver.

I must make much familiarity with the kernel developing process.

Thanks a lot!
Best regards
Alberto!
