From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 8 Jun 2012 18:42:55 +0200
Subject: [PATCH] ARM: Kirkwood: Fix crash when neither NAND nor SPI
In-Reply-To: <201206081534.13261.arnd@arndb.de>
References: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
 <201206081534.13261.arnd@arndb.de>
Message-ID: <20120608164255.GB674@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 03:34:13PM +0000, Arnd Bergmann wrote:
> On Friday 08 June 2012, Andrew Lunn wrote:
> > Both NAND and SPI make use of the RUNIT clk. However, if neither NAND
> > nor SPI is used in the system, RUNIT clock gets turned off, and the
> > SoC hard locks. It appears something else in the SoC, which is not
> > documented, is also using RUNIT. So prepare and enable RUNIT clock in
> > kirkwood_clk_init().
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> This looks bogus, because if you really need to enable that clock all
> the time, we don't even need a way to turn it off.

This is a generic gated clock, so the ability to turn it off comes
from the framework. The framework also turns off all clk which are
unused in a late init, unless flagged otherwise.

> Do you need a similar change with the 3.4 kernel before the big
> change to the clock framework? If not, I would guess that there
> is some other problem.

3.4 did not have code to ensure it was not turned off. 

However, all current systems have either SPI FLASH or NAND, since that
is how these devices boot. So, under normal conditions, this clock is
always used, and so never gets turned off as being unused. However,
while porting boards to DT, a few of us have hit situations where we
get the DT wrong, the spi/nand does not match, and the clock is unused
and so turned off. This is particularly true as we implement DT
support in the SPI and NAND drivers. This is not so easy to debug,
since it just stops, rather than panic when the root file system is
missing.

I also tried to save a little bit of power when the SPI device was
inactive, turning the clock off between transactions. This resulted in
the same lockup.

By preparing and enabling the clock, we reflect that there is probably
something else inside RUNIT, and it makes it easier to debug DT
bugs. The two alternatives would be to set the flag CLK_IGNORE_UNUSED,
or just leave it the way it is, now that DT SPI and NAND support is
mostly developed, and we are less likely to hit this situation.

       Andrew
