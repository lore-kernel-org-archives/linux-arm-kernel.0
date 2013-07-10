From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 10 Jul 2013 17:41:50 +0530
Subject: [PATCH 1/4] clk: exynos-audss: add support for Exynos 5420
In-Reply-To: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
Message-ID: <1373458313-18970-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

The AudioSS block on Exynos 5420 has an additional clock gate for the
ADMA bus clock.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-on: https://gerrit.chromium.org/gerrit/57711
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 .../devicetree/bindings/clock/clk-exynos-audss.txt |    7 +++++--
 drivers/clk/samsung/clk-exynos-audss.c             |    8 ++++++++
 include/dt-bindings/clk/exynos-audss-clk.h         |    3 ++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
index a120180..3115930 100644
--- a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
+++ b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
@@ -8,8 +8,10 @@ Required Properties:
 
 - compatible: should be one of the following:
   - "samsung,exynos4210-audss-clock" - controller compatible with all Exynos4 SoCs.
-  - "samsung,exynos5250-audss-clock" - controller compatible with all Exynos5 SoCs.
-
+  - "samsung,exynos5250-audss-clock" - controller compatible with Exynos5250
+    SoCs.
+  - "samsung,exynos5420-audss-clock" - controller compatible with Exynos5420
+    SoCs.
 - reg: physical base address and length of the controller's register set.
 
 - #clock-cells: should be 1.
@@ -34,6 +36,7 @@ i2s_bus         6
 sclk_i2s        7
 pcm_bus         8
 sclk_pcm        9
+adma            10      Exynos5420
 
 Example 1: An example of a clock controller node is listed below.
 
diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 9b1bbd5..86d2606 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -121,6 +121,12 @@ void __init exynos_audss_clk_init(struct device_node *np)
 				"div_pcm0", CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 5, 0, &lock);
 
+	if (of_device_is_compatible(np, "samsung,exynos5420-audss-clock")) {
+		clk_table[EXYNOS_ADMA] = clk_register_gate(NULL, "adma",
+				"dout_srp", CLK_SET_RATE_PARENT,
+				reg_base + ASS_CLK_GATE, 9, 0, &lock);
+	}
+
 #ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&exynos_audss_clk_syscore_ops);
 #endif
@@ -131,3 +137,5 @@ CLK_OF_DECLARE(exynos4210_audss_clk, "samsung,exynos4210-audss-clock",
 		exynos_audss_clk_init);
 CLK_OF_DECLARE(exynos5250_audss_clk, "samsung,exynos5250-audss-clock",
 		exynos_audss_clk_init);
+CLK_OF_DECLARE(exynos5420_audss_clk, "samsung,exynos5420-audss-clock",
+		exynos_audss_clk_init);
diff --git a/include/dt-bindings/clk/exynos-audss-clk.h b/include/dt-bindings/clk/exynos-audss-clk.h
index 8279f42..0ae6f5a 100644
--- a/include/dt-bindings/clk/exynos-audss-clk.h
+++ b/include/dt-bindings/clk/exynos-audss-clk.h
@@ -19,7 +19,8 @@
 #define EXYNOS_SCLK_I2S	7
 #define EXYNOS_PCM_BUS		8
 #define EXYNOS_SCLK_PCM	9
+#define EXYNOS_ADMA		10
 
-#define EXYNOS_AUDSS_MAX_CLKS	10
+#define EXYNOS_AUDSS_MAX_CLKS	11
 
 #endif
-- 
1.7.4.4
