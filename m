From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jan 2013 14:40:12 +0100
Subject: [PATCH V3 8/8] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <5103D103.5040409@gmail.com>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
 <20130126123827.GA5786@lunn.ch> <5103D103.5040409@gmail.com>
Message-ID: <20130126134012.GE29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 01:50:11PM +0100, Sebastian Hesselbarth wrote:
> On 01/26/2013 01:38 PM, Andrew Lunn wrote:
> >>diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> >>index 73b76e4..7ab92e5 100644
> >>--- a/arch/arm/mach-kirkwood/board-dt.c
> >>+++ b/arch/arm/mach-kirkwood/board-dt.c
> >>@@ -48,7 +48,7 @@ static void __init kirkwood_legacy_clk_init(void)
> >>  	clkspec.args_count = 1;
> >>
> >>  	clkspec.args[0] = CGC_BIT_GE0;
> >>-	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
> >>+	orion_clkdev_add(NULL, "f1072000.egiga0",
> >>  			 of_clk_get_from_provider(&clkspec));
> >>
> >>  	clkspec.args[0] = CGC_BIT_PEX0;
> >>@@ -60,7 +60,7 @@ static void __init kirkwood_legacy_clk_init(void)
> >>  			 of_clk_get_from_provider(&clkspec));
> >>
> >>  	clkspec.args[0] = CGC_BIT_GE1;
> >>-	orion_clkdev_add(NULL, "mv643xx_eth_port.1",
> >>+	orion_clkdev_add(NULL, "f1076000.egiga1",
> >>  			 of_clk_get_from_provider(&clkspec));
> >>  }
> >>
> >These changes break any platform not yet converted, eg my QNAP box now
> >locks up solid.
> >
> >Something is not right here, or i'm not understanding something. DT
> >devices should not need code like this, only devices not yet using
> >DT....
> 
> Jason, Andrew,
> 
> have a look at dove_legacy_clk_init() in arch/arm/mach-dove/common.c.
> This is how I handled non-DT clock aliases from DT provided clocks.
> Maybe you can also use it for kirkwood.

Hi Sebastian

The code here is based on dove_legacy_clk_init(). However the change
made by Jason is in order to make a DT device work, not an non-DT
device.

The problem is the way the driver is getting the clock.

	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));

clk_get() then calls

                clk = of_clk_get_by_name(dev->of_node, con_id);

 * of_clk_get_by_name() - Parse and lookup a clock referenced by a device node
 * @np: pointer to clock consumer node
 * @name: name of consumer's clock input, or NULL for the first clock reference

So it is looking for a clock called "0" or "1" in the node. This does
not exist, and so it falls. Jason's change then comes into affect and
it finds the clkdev entries added above.

I will change the driver to use of_clk_get() when passed an np.

  Andrew
