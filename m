From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Apr 2012 12:43:11 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120411103107.GG3163@opensource.wolfsonmicro.com>
References: <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
 <20120411091548.GD3163@opensource.wolfsonmicro.com>
 <20120411092147.GW24211@n2100.arm.linux.org.uk>
 <20120411093253.GF3163@opensource.wolfsonmicro.com>
 <20120411094136.GX24211@n2100.arm.linux.org.uk>
 <20120411103107.GG3163@opensource.wolfsonmicro.com>
Message-ID: <20120411114311.GZ24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 11:31:07AM +0100, Mark Brown wrote:
> On Wed, Apr 11, 2012 at 10:41:36AM +0100, Russell King - ARM Linux wrote:
> > clkdev is just a mechanism to obtain a struct clk for a particular input
> > on a particular device.  Nothing more, nothing less.  So how does this
> > detail about how the struct clk ultimate gets used concern clkdev?
> 
> It shouldn't.  
> 
> The main point I'm trying to make is that if we're adding an alternative
> mechanism to the direct pointers for specifying the bindings to clkdev
> (which is broadly the point of the original patch, AFAICT based on a
> desire to split the mapping out from the definitions) then having it rely
> on device tree in the first instance means we'll just need to solve the
> same problem again for non-DT systems.  Richard was saying that the
> problem Sascha was trying to solve is irrelevant because we can rely on
> device tree but device tree is not widely available enough for that.

Err what?  Look, it's very very simple.

clkdev is all about translating a device + connection ID to a struct clk
pointer.  That's all, nothing more, nothing less.

What I see going on is that people want to translate a device + connection
ID to some other name, and use this other name to look up a struct clk.
Utterly idiotic and pointless.  Whether it be OF or not OF.

It's a crazy absurd idea.  At some point, you have to do some kind of
lookup and return a struct clk.  Why the hell have this insane double
mapping?

Look, solving the DT problem with clkdev is really simple.  You have the
DT node for the struct device, so you can look up DT properties associated
with that device.  Properties have a name, and you can use the connection
ID to translate into a DT property name to be looked up - eg, clk_%s.
This can return a phandle or whatever else which could then be translated
into a struct clk if you're representing each clk as a node in DT.

Nice and simple, no need for any additional crappy translation what so
ever - and, oh my god, it reduces the amount of list based searching
required to do the translation.

And it also allows non-DT to work just fine provided you register your
clk lookups _after_ you know the struct clk pointers which is exactly what
happens today.

Now, if getting the struct clk pointers is insanely difficult because of
the design of the common clk stuff, then that's where the problem lies,
and that problem needs to be fixed, and clkdev does not need to be bodged
around to fix a problem which is not relevant to it.
