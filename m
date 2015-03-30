From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 30 Mar 2015 17:53:22 +0200
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is enabled
 during suspend
In-Reply-To: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power
Management support v12") added pm support for the pl330 dma driver but
it makes the clock for the Exynos5420 MDMA0 DMA controller to be gated
during suspend and this clock needs to remain enabled in order to make
the system resume from a system suspend state.

To make sure that the clock is enabled during suspend, enable it prior
to entering a suspend state and disable it once the system has resumed.

Thanks to Abhilash Kesavan for figuring out that this was the issue.

Fixes: ae43b32 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/clk/samsung/clk-exynos5420.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 07d666cc6a29..2d39b629144a 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -151,6 +151,7 @@ enum exynos5x_plls {
 
 static void __iomem *reg_base;
 static enum exynos5x_soc exynos5x_soc;
+struct samsung_clk_provider *ctx;
 
 #ifdef CONFIG_PM_SLEEP
 static struct samsung_clk_reg_dump *exynos5x_save;
@@ -275,8 +276,18 @@ static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
 	{ .offset = GATE_IP_PERIC,		.value = 0xffffffff, },
 };
 
+/*
+ * list of clocks that have to be kept enabled during suspend/resume cycle.
+ */
+static unsigned int exynos5x_clk_suspend[] = {
+	CLK_MDMA0,
+};
+
 static int exynos5420_clk_suspend(void)
 {
+	int i;
+	struct clk *clk;
+
 	samsung_clk_save(reg_base, exynos5x_save,
 				ARRAY_SIZE(exynos5x_clk_regs));
 
@@ -287,11 +298,24 @@ static int exynos5420_clk_suspend(void)
 	samsung_clk_restore(reg_base, exynos5420_set_clksrc,
 				ARRAY_SIZE(exynos5420_set_clksrc));
 
+	for (i = 0; i < ARRAY_SIZE(exynos5x_clk_suspend); i++) {
+		clk = samsung_clk_lookup(ctx, exynos5x_clk_suspend[i]);
+		clk_prepare_enable(clk);
+	}
+
 	return 0;
 }
 
 static void exynos5420_clk_resume(void)
 {
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < ARRAY_SIZE(exynos5x_clk_suspend); i++) {
+		clk = samsung_clk_lookup(ctx, exynos5x_clk_suspend[i]);
+		clk_disable_unprepare(clk);
+	}
+
 	samsung_clk_restore(reg_base, exynos5x_save,
 				ARRAY_SIZE(exynos5x_clk_regs));
 
@@ -1255,8 +1279,6 @@ static const struct of_device_id ext_clk_match[] __initconst = {
 static void __init exynos5x_clk_init(struct device_node *np,
 		enum exynos5x_soc soc)
 {
-	struct samsung_clk_provider *ctx;
-
 	if (np) {
 		reg_base = of_iomap(np, 0);
 		if (!reg_base)
-- 
2.1.4
