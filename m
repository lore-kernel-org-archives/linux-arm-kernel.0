From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 10:42:51 -0500
Subject: [PATCH V3 8/8] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <20130126134012.GE29973@lunn.ch>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
 <20130126123827.GA5786@lunn.ch> <5103D103.5040409@gmail.com>
 <20130126134012.GE29973@lunn.ch>
Message-ID: <20130126154251.GM1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 02:40:12PM +0100, Andrew Lunn wrote:
> On Sat, Jan 26, 2013 at 01:50:11PM +0100, Sebastian Hesselbarth wrote:
> > On 01/26/2013 01:38 PM, Andrew Lunn wrote:
> > >>diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> > >>index 73b76e4..7ab92e5 100644
> > >>--- a/arch/arm/mach-kirkwood/board-dt.c
> > >>+++ b/arch/arm/mach-kirkwood/board-dt.c
> > >>@@ -48,7 +48,7 @@ static void __init kirkwood_legacy_clk_init(void)
> > >>  	clkspec.args_count = 1;
> > >>
> > >>  	clkspec.args[0] = CGC_BIT_GE0;
> > >>-	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
> > >>+	orion_clkdev_add(NULL, "f1072000.egiga0",
> > >>  			 of_clk_get_from_provider(&clkspec));
> > >>
> > >>  	clkspec.args[0] = CGC_BIT_PEX0;
> > >>@@ -60,7 +60,7 @@ static void __init kirkwood_legacy_clk_init(void)
> > >>  			 of_clk_get_from_provider(&clkspec));
> > >>
> > >>  	clkspec.args[0] = CGC_BIT_GE1;
> > >>-	orion_clkdev_add(NULL, "mv643xx_eth_port.1",
> > >>+	orion_clkdev_add(NULL, "f1076000.egiga1",
> > >>  			 of_clk_get_from_provider(&clkspec));
> > >>  }
> > >>
> > >These changes break any platform not yet converted, eg my QNAP box now
> > >locks up solid.
> > >
> > >Something is not right here, or i'm not understanding something. DT
> > >devices should not need code like this, only devices not yet using
> > >DT....
> > 
> > Jason, Andrew,
> > 
> > have a look at dove_legacy_clk_init() in arch/arm/mach-dove/common.c.
> > This is how I handled non-DT clock aliases from DT provided clocks.
> > Maybe you can also use it for kirkwood.
> 
> Hi Sebastian
> 
> The code here is based on dove_legacy_clk_init(). However the change
> made by Jason is in order to make a DT device work, not an non-DT
> device.
> 
> The problem is the way the driver is getting the clock.
> 
> 	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));
> 
> clk_get() then calls
> 
>                 clk = of_clk_get_by_name(dev->of_node, con_id);
> 
>  * of_clk_get_by_name() - Parse and lookup a clock referenced by a device node
>  * @np: pointer to clock consumer node
>  * @name: name of consumer's clock input, or NULL for the first clock reference
> 
> So it is looking for a clock called "0" or "1" in the node. This does
> not exist, and so it falls. Jason's change then comes into affect and
> it finds the clkdev entries added above.

Exactly.

> I will change the driver to use of_clk_get() when passed an np.

something like this? (on top of this series):

btw - I just booted this and it is working...

$ cat ge0/clk_prepare_count
1
$ cat ge1/clk_prepare_count
1
$ 

--8<-------
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 7ab92e5..620c99f 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -47,10 +47,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	clkspec.np = np;
 	clkspec.args_count = 1;
 
-	clkspec.args[0] = CGC_BIT_GE0;
-	orion_clkdev_add(NULL, "f1072000.egiga0",
-			 of_clk_get_from_provider(&clkspec));
-
 	clkspec.args[0] = CGC_BIT_PEX0;
 	orion_clkdev_add("0", "pcie",
 			 of_clk_get_from_provider(&clkspec));
@@ -58,10 +54,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	clkspec.args[0] = CGC_BIT_PEX1;
 	orion_clkdev_add("1", "pcie",
 			 of_clk_get_from_provider(&clkspec));
-
-	clkspec.args[0] = CGC_BIT_GE1;
-	orion_clkdev_add(NULL, "f1076000.egiga1",
-			 of_clk_get_from_provider(&clkspec));
 }
 
 static void __init kirkwood_of_clk_init(void)
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 7048d7c..8fb92d4 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2895,6 +2895,7 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		struct device_node *np = NULL;
+		struct clk *clk = NULL;
 
 		/* when all users of this driver use FDT, we can remove this */
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
@@ -2912,6 +2913,12 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 		else
 			pd->phy_addr = MV643XX_ETH_PHY_ADDR_DEFAULT;
 
+		clk = of_clk_get(pdev->dev.of_node, 0);
+		if (!IS_ERR(clk)) {
+			clk_prepare_enable(clk);
+			clk_put(clk);
+		}
+
 		np = of_parse_phandle(pdev->dev.of_node, "mdio", 0);
 		if (np) {
 			pd->shared = of_find_device_by_node(np);
