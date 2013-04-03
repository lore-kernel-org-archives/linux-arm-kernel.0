From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 4 Apr 2013 00:02:43 +0800
Subject: [PATCH] ARM: imx: provide twd clock lookup from device tree
Message-ID: <1365004963-27957-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While booting from device tree, imx6q used to provide twd clock lookup
by calling clk_register_clkdev() in clock driver.  However, the commit
bd60345 (ARM: use device tree to get smp_twd clock) forces DT boot to
look up the clock from device tree.  It causes the failure below when
twd driver tries to get the clock, and hence kernel has to calibrate the
local timer frequency.

 smp_twd: clock not found -2
 ...
 Calibrating local timer... 396.13MHz.

Fix the regression by providing twd clock lookup from device tree, and
remove the unused twd clk_register_clkdev() call from clock driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Arnd, Olof,

This is a fix for 3.9.

Shawn

 arch/arm/boot/dts/imx6qdl.dtsi |    1 +
 arch/arm/mach-imx/clk-imx6q.c  |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 06ec460..281a223 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -91,6 +91,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
 			interrupts = <1 13 0xf01>;
+			clocks = <&clks 15>;
 		};
 
 		L2: l2-cache at 00a02000 {
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 2f9ff93..22a3021 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -443,7 +443,6 @@ int __init mx6q_clocks_init(void)
 
 	clk_register_clkdev(clk[gpt_ipg], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
-	clk_register_clkdev(clk[twd], NULL, "smp_twd");
 	clk_register_clkdev(clk[cko1_sel], "cko1_sel", NULL);
 	clk_register_clkdev(clk[ahb], "ahb", NULL);
 	clk_register_clkdev(clk[cko1], "cko1", NULL);
-- 
1.7.9.5
