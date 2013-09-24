From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 23 Sep 2013 17:21:17 -0700
Subject: [PATCH V2 5/6] clk: exynos-audss: add support for Exynos 5420
In-Reply-To: <1379982078-23381-1-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1379982078-23381-1-git-send-email-abrestic@chromium.org>
Message-ID: <1379982078-23381-5-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AudioSS block on Exynos 5420 has an additional clock gate for the
ADMA bus clock.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes since v1:
 - added type enum and made comparison against that instead of compatibility
   string
---
 .../devicetree/bindings/clock/clk-exynos-audss.txt |  7 +++--
 drivers/clk/samsung/clk-exynos-audss.c             | 35 ++++++++++++++++++----
 include/dt-bindings/clk/exynos-audss-clk.h         |  3 +-
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
index 85b9e28..180e883 100644
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
@@ -49,6 +51,7 @@ i2s_bus         6
 sclk_i2s        7
 pcm_bus         8
 sclk_pcm        9
+adma            10      Exynos5420
 
 Example 1: An example of a clock controller node using the default input
 	   clock names is listed below.
diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index afb53de..8ccf3788 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -19,6 +19,12 @@
 
 #include <dt-bindings/clk/exynos-audss-clk.h>
 
+enum exynos_audss_clk_type {
+	TYPE_EXYNOS4210,
+	TYPE_EXYNOS5250,
+	TYPE_EXYNOS5420,
+};
+
 static DEFINE_SPINLOCK(lock);
 static struct clk **clk_table;
 static void __iomem *reg_base;
@@ -59,6 +65,16 @@ static struct syscore_ops exynos_audss_clk_syscore_ops = {
 };
 #endif /* CONFIG_PM_SLEEP */
 
+static const struct of_device_id exynos_audss_clk_of_match[] = {
+	{ .compatible = "samsung,exynos4210-audss-clock",
+	  .data = (void *)TYPE_EXYNOS4210, },
+	{ .compatible = "samsung,exynos5250-audss-clock",
+	  .data = (void *)TYPE_EXYNOS5250, },
+	{ .compatible = "samsung,exynos5420-audss-clock",
+	  .data = (void *)TYPE_EXYNOS5420, },
+	{},
+};
+
 /* register exynos_audss clocks */
 static int exynos_audss_clk_probe(struct platform_device *pdev)
 {
@@ -67,6 +83,13 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 	const char *sclk_pcm_p = "sclk_pcm0";
 	struct clk *pll_ref, *pll_in, *cdclk, *sclk_audio, *sclk_pcm_in;
 	struct resource *res;
+	const struct of_device_id *match;
+	enum exynos_audss_clk_type variant;
+
+	match = of_match_node(exynos_audss_clk_of_match, pdev->dev.of_node);
+	if (!match)
+		return -EINVAL;
+	variant = (enum exynos_audss_clk_type)match->data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg_base = devm_ioremap_resource(&pdev->dev, res);
@@ -145,6 +168,12 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 				sclk_pcm_p, CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 5, 0, &lock);
 
+	if (variant == TYPE_EXYNOS5420) {
+		clk_table[EXYNOS_ADMA] = clk_register_gate(NULL, "adma",
+				"dout_srp", CLK_SET_RATE_PARENT,
+				reg_base + ASS_CLK_GATE, 9, 0, &lock);
+	}
+
 #ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&exynos_audss_clk_syscore_ops);
 #endif
@@ -168,12 +197,6 @@ static int exynos_audss_clk_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id exynos_audss_clk_of_match[] = {
-	{ .compatible = "samsung,exynos4210-audss-clock", },
-	{ .compatible = "samsung,exynos5250-audss-clock", },
-	{},
-};
-
 static struct platform_driver exynos_audss_clk_driver = {
 	.driver	= {
 		.name = "exynos-audss-clk",
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
1.8.4
