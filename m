From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 27 Mar 2013 13:01:19 +0100
Subject: [PATCH 2/2] ARM: kirkwood: extend the kirkwood i2s driver for DT
 usage
In-Reply-To: <20130327112134.50ba5d61@armhf>
References: <20130326190539.494d96d9@armhf> <5151F8FE.5040005@gmail.com>
 <20130327112134.50ba5d61@armhf>
Message-ID: <20130327120119.GO631@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If you want to use some external clock given by, say, the si5351
> module, as all modules are loaded at the same time, the module
> kirkwood-i2s may be initialized before the si5351 and, so, the clock
> will not be seen as available.

If the DT says the clock should exist, and of_clk_get() fails, return
-EDEFER in the probe. The kernel will try again later once more
modules have been loaded.

> > If there is SoC specific data (e.g. burst_size) you can use
> > .data to pass it according to the compatible string:
> > 
> > static struct of_device_id kirkwood_i2s_of_match[] = {
> > 	{ .compatible = "marvell,kirkwood-i2s", .data = (void *)32 },
> > 	{ .compatible = "marvell,dove-i2s", .data = (void *)128 },
> > 	{ .compatible = "marvell,armada-370-i2s", .data = (void *)128 },
> > 	{ }
> > };
> 
> I don't like this solution: the burst value is hidden and hard coded.
> If a new machine uses this same driver, it is easier to change the DT
> instead of recompiling a whole kernel.

If its a new SoC family, its not a change to DT, its a whole new DT,
for that SoC family. There is no inheritance between SoC
families. There is no sharing between dove, kirkwood, 370 for .dts or
dtsi files. As far as i can see, burst is a SoC family property. So
will not be expected to change from board to board, which is the
typical use case for DT.

	Andrew
