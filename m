From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Jul 2011 20:41:30 +0900
Subject: [PATCH 5/6] clk: Support multiple instances of the same clock
	provider
In-Reply-To: <20110711111153.GH3239@n2100.arm.linux.org.uk>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<1310352837-4277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1310352837-4277-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110711093439.GB3239@n2100.arm.linux.org.uk>
	<20110711105342.GE5092@opensource.wolfsonmicro.com>
	<20110711111153.GH3239@n2100.arm.linux.org.uk>
Message-ID: <20110711114127.GI5092@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 12:11:53PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 11, 2011 at 07:53:45PM +0900, Mark Brown wrote:
> > We do need some way to have some idea which clocks we're talking about,
> > and for off-SoC stuff passing around struct clk pointers is rather
> > painful.  At some point some bit of code is going to have to get hold of
> > the actual struct clk and then map it onto the devices using it.

> As I haven't seen any of this "passing around struct clk pointers" crap
> recently, I can only guess at what you're saying.  I thought all that
> had been solved with _proper_ use of clkdev.

The problem is getting the data into clkdev in the first place for the
off-SoC devices.

> clkdev can provide you with a struct clk for _any_ device in the system
> where its name is known at build time.

Right, on the consumer side it's all sorted and works really well.  The
trick is on the provider side where you need to have the clock available
to be able to add the mappings for it.

Perhaps I'm just missing something about how this should all work -
actually, the regulator solution probably works fine here.  Pass an
array of mappings into either the driver or the clock subsystem and have
them add the mappings when the provider registers.  Whichever way around
should just be some hooks in the new subsystem.
