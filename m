From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 21 May 2013 10:12:03 +0800
Subject: [PATCH 1/2] ARM: imx6q: call of_clk_init() to register fixed rate
 clocks
Message-ID: <1369102324-3084-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the fixed rate clocks are defined in device tree, we can just call
of_clk_init() to register them.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index a805911..1b883c7 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -276,21 +276,12 @@ int __init mx6q_clocks_init(void)
 	void __iomem *base;
 	int i, irq;
 
-	clk[dummy] = imx_clk_fixed("dummy", 0);
+	of_clk_init(NULL);
 
-	/* retrieve the freqency of fixed clocks from device tree */
-	for_each_compatible_node(np, NULL, "fixed-clock") {
-		u32 rate;
-		if (of_property_read_u32(np, "clock-frequency", &rate))
-			continue;
-
-		if (of_device_is_compatible(np, "fsl,imx-ckil"))
-			clk[ckil] = imx_clk_fixed("ckil", rate);
-		else if (of_device_is_compatible(np, "fsl,imx-ckih1"))
-			clk[ckih] = imx_clk_fixed("ckih", rate);
-		else if (of_device_is_compatible(np, "fsl,imx-osc"))
-			clk[osc] = imx_clk_fixed("osc", rate);
-	}
+	clk[dummy] = imx_clk_fixed("dummy", 0);
+	clk[ckil] = imx_obtain_fixed_clock("ckil", 0);
+	clk[ckih] = imx_obtain_fixed_clock("ckih1", 0);
+	clk[osc] = imx_obtain_fixed_clock("osc", 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	base = of_iomap(np, 0);
-- 
1.7.9.5
