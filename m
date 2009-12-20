From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sun, 20 Dec 2009 14:48:38 +0100
Subject: [PATCH 2/4] mfd: mc13783: When probing, unlock the mc13783
	before subsystems initialisation.
In-Reply-To: <20091219201816.GA28742@pengutronix.de>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<1260811085.2022.135.camel@climbing-alby>
	<1261152746.3356.72.camel@climbing-alby>
	<20091219201816.GA28742@pengutronix.de>
Message-ID: <1261316918.5224.15.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il giorno sab, 19/12/2009 alle 21.18 +0100, Uwe Kleine-K?nig ha
scritto: 
> Hello,
> 
> On Fri, Dec 18, 2009 at 05:12:26PM +0100, Alberto Panizzo wrote:
> > Ping :)
> > 
> > PATCH 1 & 2 are fixes that can go to .33
> I don't like patch 1.  I'd prefer that drivers touching
> MC13783_REG_POWER_MISCELLANEOUS are aware of the bit in question and
> wouldn't rely on mc13783-core.
> 
> Best regards
> Uwe
> 

Yes, but MC13783_REG_POWER_MISCELLANEOUS contains bit that control
different aspect of mc13783 chip.
GPO are regulator related, but those two bits in question maybe 
apply to a power management driver, so this problem is a matter
of mc13783-core.

Another possible solution, is to trace the writings to those two bits
in mc13783_reg_rmw storing the value written an reproducing it in next
mc13783_reg_rmw calls.
But the problem for this is that we don't know if the bootloader 
had initialised those with another non default value.
Another problem is that if another driver make use of 
mc13783_reg_write for modifying those bits, the state stored will
be inconsistent.

And so? what kind of solution can you suggest?

I am working to support i.MX31 PDK board that make a strong use of mc13783
and GPO's controls important power supplies.

Alberto!
