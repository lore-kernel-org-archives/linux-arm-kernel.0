From: ipaton0@gmail.com (Iain Paton)
Date: Tue, 15 Apr 2014 10:15:15 +0100
Subject: [RFC PATCH] imx6: imx6duallite/solo i2c4 clock
Message-ID: <534CF8A3.3010404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm working on a board using the imx6solo that implements i2c4 and while 
building the devicetree it became clear that the devicetree fragment for 
i2c4 in imx6dl.dtsi it's missing the necessary clock.

Investigating further turned up that the ecspi5 clock in CCM_CCGR1 on the 
quad/dual is replaced with the i2c4 clock on duallite/solo.

Would the following patch be sufficient to allow correct use of this clock?

I'm not familiar enough with the clock framework to be sure I'm not missing
something here, but have tested this patch on the board and found it to work.

The board is element14's RIoTboard http://www.riotboard.org and I have dts
mostly ready to submit for it pending resolving this and a couple of other 
minor things, and assuming Eric doesn't beat me to it.

Iain

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index b0e7f9d..2961b16 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -352,7 +352,13 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[ecspi2]       = imx_clk_gate2("ecspi2",        "ecspi_root",        base + 0x6c, 2);
 	clk[ecspi3]       = imx_clk_gate2("ecspi3",        "ecspi_root",        base + 0x6c, 4);
 	clk[ecspi4]       = imx_clk_gate2("ecspi4",        "ecspi_root",        base + 0x6c, 6);
-	clk[ecspi5]       = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
+	if (cpu_is_imx6dl())
+		/*
+		 * ecspi5 is replaced with i2c4 on imx6dl & imx6s
+		 */
+		clk[ecspi5] = imx_clk_gate2("i2c4",        "ipg_per",           base + 0x6c, 8);
+	else
+		clk[ecspi5] = imx_clk_gate2("ecspi5",      "ecspi_root",        base + 0x6c, 8);
 	clk[enet]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
 	clk[esai]         = imx_clk_gate2("esai",          "esai_podf",         base + 0x6c, 16);
 	clk[gpt_ipg]      = imx_clk_gate2("gpt_ipg",       "ipg",               base + 0x6c, 20);
