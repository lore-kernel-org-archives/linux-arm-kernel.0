From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 20 Dec 2009 19:49:42 +0100
Subject: [PATCH 2/4] mfd: mc13783: When probing, unlock the mc13783
	before subsystems initialisation.
In-Reply-To: <1261316918.5224.15.camel@climbing-alby>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<1260811085.2022.135.camel@climbing-alby>
	<1261152746.3356.72.camel@climbing-alby>
	<20091219201816.GA28742@pengutronix.de>
	<1261316918.5224.15.camel@climbing-alby>
Message-ID: <20091220184941.GA13294@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

On Sun, Dec 20, 2009 at 02:48:38PM +0100, Alberto Panizzo wrote:
> > > PATCH 1 & 2 are fixes that can go to .33
> > I don't like patch 1.  I'd prefer that drivers touching
> > MC13783_REG_POWER_MISCELLANEOUS are aware of the bit in question and
> > wouldn't rely on mc13783-core.
> 
> Yes, but MC13783_REG_POWER_MISCELLANEOUS contains bit that control
> different aspect of mc13783 chip.
> GPO are regulator related, but those two bits in question maybe 
> apply to a power management driver, so this problem is a matter
> of mc13783-core.
maybe?
 
> Another possible solution, is to trace the writings to those two bits
> in mc13783_reg_rmw storing the value written an reproducing it in next
> mc13783_reg_rmw calls.
> But the problem for this is that we don't know if the bootloader 
> had initialised those with another non default value.
> Another problem is that if another driver make use of 
> mc13783_reg_write for modifying those bits, the state stored will
> be inconsistent.
The next best thing I would consider acceptable are dedicated functions
for MC13783_REG_POWER_MISCELLANEOUS.  I havn't checked what the register
in question is used for, but I think the bootloader isn't generally a
problem as Linux shouldn't rely on things setup by the bootloader (apart
from the things described in
http://www.arm.linux.org.uk/developer/booting.php of course).  And I
don't see a problem for in-kernel users of mc13783_reg_write to modify
the register.  If the mc13783-API is changed that
MC13783_REG_POWER_MISCELLANEOUS must only be modified by using (say)
mc13783_powermisc_rmw() it's a (probably uncatched) bug to use
mc13783_reg_write.

And patch 1 is definitly *not* material for .33, as there is currently
no user of MC13783_REG_POWER_MISCELLANEOUS in .33-rc1, so there is
nothing to fix.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
