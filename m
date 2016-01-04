From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2016 22:42:34 +0000
Subject: [PATCH 2/2] ARM: dts: imx6qdl-microsom-ar8035: Adjust Ethernet
 PHY reset duration
In-Reply-To: <1451934700-28060-2-git-send-email-festevam@gmail.com>
References: <1451934700-28060-1-git-send-email-festevam@gmail.com>
 <1451934700-28060-2-git-send-email-festevam@gmail.com>
Message-ID: <20160104224234.GR19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 05:11:40PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> As per the AR8035 datasheet:
> 
> "For a reliable power on reset, suggest to keep asserting the reset
> low long enough (10ms) to ensure the clock is stable and clock-to-reset
> 1ms requirement is satisfied."

This is questionable.  The quote you indicate above is "For a reliable
POWER ON RESET".  It depends what use this DT is being put to.  Given
that the only boot loader which is trustworthy on SoldRun hardware is
their uboot versions, and these don't use DT, I would say that the
only time that this is used is when the kernel is booting.

That reset is not a power on reset, the phy has been powered for a
comparitively long time by the time the kernel gets to use it.  So, I
think on balance I'm going to NAK this change until there is a reason
for it to be made - iow, when there _is_ a boot loader where the
requirement for this parameter to be used at power on is required.

However, I think that should be discussed, in particular whether
there should be a separate property for the power on reset duration.

The final argument against it is that most "power on reset" requirements
are to keep the reset signal asserted while the _power_ _and_ _clocks_
both stabilise.  By the time we get to running any code, the power must
have stabilised (otherwise the SoC won't be operating.)  Moreover, as
the SoC is responsible for providing the AR8035 with its clock, the
SoC must be sufficiently out of reset for its own clocks to have
stabilised internally.  The clock manager software (whatever it is)
is responsible for ensuring that when a clock output is enabled, the
user knows when the clock has stabilised.  So, a boot loader enabling
the clock output which drives the AR8035 should be aware of the point
at which the clock has stabilised, and at that time should start timing
out the reset delay specified in the _existing_ DT file, which is
sufficiently long to satisfy the clock-to-reset delay of 1ms.

So, on that second point, it's also a NAK.  That's two good reasons
why the existing DT specification here is actually correct.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
