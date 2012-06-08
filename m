From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 08 Jun 2012 18:42:41 +0100
Subject: [PATCH] ARM: Kirkwood: Fix crash when neither NAND nor SPI
In-Reply-To: <20120608164255.GB674@lunn.ch>
References: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
 <201206081534.13261.arnd@arndb.de> <20120608164255.GB674@lunn.ch>
Message-ID: <1339177361.9569.23.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-06-08 at 18:42 +0200, Andrew Lunn wrote:
> On Fri, Jun 08, 2012 at 03:34:13PM +0000, Arnd Bergmann wrote:
> > On Friday 08 June 2012, Andrew Lunn wrote:
> > > Both NAND and SPI make use of the RUNIT clk. However, if neither NAND
> > > nor SPI is used in the system, RUNIT clock gets turned off, and the
> > > SoC hard locks. It appears something else in the SoC, which is not
> > > documented, is also using RUNIT. So prepare and enable RUNIT clock in
> > > kirkwood_clk_init().
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > This looks bogus, because if you really need to enable that clock all
> > the time, we don't even need a way to turn it off.
> 
> This is a generic gated clock, so the ability to turn it off comes
> from the framework. The framework also turns off all clk which are
> unused in a late init, unless flagged otherwise.
> 
> > Do you need a similar change with the 3.4 kernel before the big
> > change to the clock framework? If not, I would guess that there
> > is some other problem.
> 
> 3.4 did not have code to ensure it was not turned off. 
> 
> However, all current systems have either SPI FLASH or NAND, since that
> is how these devices boot. So, under normal conditions, this clock is
> always used, and so never gets turned off as being unused.

What if your filesystems are on devices other than flash (I use an SD
card on my Sheevaplugs). In that case flash isn't used at all by the
Linux kernel and could be safely turned off. I'm not saying that this is
worth the hassle, just pointing out that flash may be unused by Linux on
some systems.

-- 
Tixy
