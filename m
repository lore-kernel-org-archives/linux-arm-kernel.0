From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Jul 2010 19:42:51 +0100
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100714173650.GA21893@bnru01.bnr.st.com>
References: <20100713203852.GA1756@rakim.wolfsonmicro.main>
	<20100714145053.GA1689@bnru01.bnr.st.com>
	<20100714145748.GF31073@rakim.wolfsonmicro.main>
	<20100714153643.GB1689@bnru01.bnr.st.com>
	<20100714154726.GH31073@rakim.wolfsonmicro.main>
	<20100714160941.GC1689@bnru01.bnr.st.com>
	<20100714162048.GA27512@rakim.wolfsonmicro.main>
	<20100714164708.GD1689@bnru01.bnr.st.com>
	<20100714170323.GF5933@sirena.org.uk>
	<20100714173650.GA21893@bnru01.bnr.st.com>
Message-ID: <20100714184251.GG5933@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 11:06:51PM +0530, Sundar R IYER wrote:

> > OK, but your current set of supplies is *very* suspect since you're
> > offering all this control to lists of consumers that don't exist, and

> As said, dont exist for *now*.

This comes back to my point about the control only making sense when the
consumers are present - if you've got missing or partial consumer setup
done then control is questionable.

> Probably, I should remove the REGULATOR_CHANGE_VOLTAGE flag for the fixed
> supplies (as in the driver) to clear up any confusing link. Should I?

Yes.

> > This is normal, but for fairly obvious reasons the very lowest power
> > states are generally handled outside of the regulator API at a hardware
> > level via hardware signals to the regulator.  It's not normally part of
> > the runtime constraints for use while the CPU is live.

> Yes. But my point was that even at a lower level than kernel (BIOS/firmware?)
> the switching would happen via SW. Please correct me if I am wrong!

Well, ultimately it's always triggered by software but the actual signal
to the regulator is often a logic level output by the SoC as the
processor enters a low power state rather than an I2C/SPI write.

> > I'm not sure how you expect this to actually work in practice?  It's
> > going to be pretty hard for a driver to do anything constructive if the
> > power to the hardware gets cut, for example.  Unless you can guarantee
> > that there will never be any use of the hardware without a driver with
> > regulator support one driver's idea of optimal may not join up with what
> > the other consumers need at all.

> Very true. But, I think this will *enforce* drivers using/sharing
> regulators to adhere to the framework to avoid surprises and sole-owner
> misuses, which is good, now that the AB8500 regulators *are* supported.

If you think your users will be sympathetic to this approach then I
guess...  obviously, it does have the potential to go rather badly wrong
especially if there are some drivers without regulator support out
there.
