From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Wed, 14 Jul 2010 23:06:51 +0530
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100714170323.GF5933@sirena.org.uk>
References: <20100713161343.GA25342@bnru01.bnr.st.com>
	<20100713203852.GA1756@rakim.wolfsonmicro.main>
	<20100714145053.GA1689@bnru01.bnr.st.com>
	<20100714145748.GF31073@rakim.wolfsonmicro.main>
	<20100714153643.GB1689@bnru01.bnr.st.com>
	<20100714154726.GH31073@rakim.wolfsonmicro.main>
	<20100714160941.GC1689@bnru01.bnr.st.com>
	<20100714162048.GA27512@rakim.wolfsonmicro.main>
	<20100714164708.GD1689@bnru01.bnr.st.com>
	<20100714170323.GF5933@sirena.org.uk>
Message-ID: <20100714173650.GA21893@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> There's userspace-consumer.c for exposing the control for userspace.
No. I wasnt referring to a user space control of critical supplies.

> OK, but your current set of supplies is *very* suspect since you're
> offering all this control to lists of consumers that don't exist, and
As said, dont exist for *now*.

> you've got every single supply on the board varying at runtime.  This is
> unusual and normally means that someone's done what you were describing
> earlier and just put in the capabilities of the regulator rather than a
> set of constraints for the particular board.
The AB8500 is the companion chip for the DB8500. For our reference HW,
these set of regulator constraints map to the constraints for the
particular board.  But, someone deciding to use the AB8500 as standalone
can have his set of regulators integrated (leaving out much more than
what I did), set of constraints as deemed to be fit!

Probably, I should remove the REGULATOR_CHANGE_VOLTAGE flag for the fixed
supplies (as in the driver) to clear up any confusing link. Should I?

> This is normal, but for fairly obvious reasons the very lowest power
> states are generally handled outside of the regulator API at a hardware
> level via hardware signals to the regulator.  It's not normally part of
> the runtime constraints for use while the CPU is live.
Yes. But my point was that even at a lower level than kernel (BIOS/firmware?)
the switching would happen via SW. Please correct me if I am wrong!

> I'm not sure how you expect this to actually work in practice?  It's
> going to be pretty hard for a driver to do anything constructive if the
> power to the hardware gets cut, for example.  Unless you can guarantee
> that there will never be any use of the hardware without a driver with
> regulator support one driver's idea of optimal may not join up with what
> the other consumers need at all.
Very true. But, I think this will *enforce* drivers using/sharing
regulators to adhere to the framework to avoid surprises and sole-owner
misuses, which is good, now that the AB8500 regulators *are* supported.

> If you really can safely turn off all these supplies then presumably for
> the time being it'd be best to use regulator_has_full_constraints() so
> they can all be powered off at runtime now.
OOoops! I did have the patch for the platform data where I used this;
but dropped the patch for a later push. But, yes I am aware of this.
