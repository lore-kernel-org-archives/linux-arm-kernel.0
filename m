From: jason@lakedaemon.net (Jason)
Date: Mon, 5 Mar 2012 09:51:50 -0500
Subject: [GIT PULL v3] ARM: kirkwood: fdt: convert kirkwood init funcs
 to fdt
In-Reply-To: <201203051434.35132.arnd@arndb.de>
References: <20120305034113.GB5050@titan.lakedaemon.net>
 <20120305133242.GD5050@titan.lakedaemon.net>
 <201203051434.35132.arnd@arndb.de>
Message-ID: <20120305145150.GF5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 02:34:34PM +0000, Arnd Bergmann wrote:
> On Monday 05 March 2012, Jason wrote:
> > This is still bugging me.  If, say, orion_wdt.c is common to all of
> > plat-orion/ shouldn't it be in an 'orion.dtsi'?  With compatible =
> > "marvell,orion-wdt"?  Then, if hypothetically, kirkwood used the same
> > driver but had a small tweak, then kirkwood.dtsi would have
> > "marvell,kirkwood-wdt"?  Which would let the driver know that it needed
> > to apply the tweak because it was kirkwood.
> 
> Some drivers are common to all orion, but others are only used in some
> out of {orion5k,kirkwood,mv78xx0,dove}. You could of course have
> an orion.dtsi that is included in kirkwood.dtsi.

As Andrew just brought up, the drivers are common across all of them,
but the registers and irqs are different.  Which would seem to shoot
down the need for an orion.dtsi.

The registers/irqs are common across kirkwood, so the best place
probably is kirkwood.dtsi.

However, if they are placed in kirkwood.dtsi, having compatible =
"mrvl,88f6821-rtc" probably is not a good idea.  Not all kirkwoods have
the same dev_id.

> BTW, I just realized that the patches that Haojian Zhuang sent for
> pxa/mmp are using mrvl instead of marvell, and you should definitely
> be using the same identifier both both. By convention we use the
> stock ticker symbol as a unique identifier, which would be mrvl here.

Hehehe that was in the Manual, right?  ;-)

> > In this scenario, since kirkwood and dreamplug currently need no
> > modifications to the default wdt driver, they would just inherit
> > orion.dtsi's "marvell,orion-wdt", right?
> 
> I would still list both, so we are future-proof in case we need
> to modify the driver in the future but don't want to modify
> the device tree.

So, in kirkwood.dtsi, compatible = "mrvl,kirkwood-rtc", "mrvl,orion-rtc";

and, drivers without tweaks would match "mrvl,orion-rtc".

> > On the driver side, since it currently has no subarch or board specific
> > tweaks, then it is only good for the generic case,
> > "marvell,orion-wdt", and thus should only match it for now.
> 
> Yes.

Okay.

thx,

Jason.
