From: dianders@chromium.org (Doug Anderson)
Date: Fri, 30 May 2014 09:32:42 -0700
Subject: [PATCH v2] clk: exynos5420: Keep aclk66_peric enabled during boot
In-Reply-To: <1401398496-4624-1-git-send-email-dianders@chromium.org>
References: <1401398496-4624-1-git-send-email-dianders@chromium.org>
Message-ID: <1401467562-5585-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now if you've got earlyprintk enabled on exynos5420-peach-pit
then you'll get a hang on boot.  Here's why:

1. The i2c-s3c2410 driver will probe at subsys_initcall.  It will
   enable its clock and disable it.  This is the clock "i2c2".
2. The act of disabling "i2c2" will disable its parents.  In this case
   the parent is "aclk66_peric".  There are no other children of
   "aclk66_peric" officially enabled, so "aclk66_peric" will be turned
   off (despite being CLK_IGNORE_UNUSED, but that's by design).
3. The next time you try to earlyprintk you'll do so without the UART
   clock enabled.  That's because the UART clocks are also children of
   "aclk66_peric".  You'll hang.

There's no good place to put a clock enable for earlyprintk, which is
handled by a bunch of assembly code.  The best we can do is to handle
this in the clock driver.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
Changes in v2:
- Use GATE_A and clk_get().  Save the clock for putting later.
- Return 0 from exynos5420_clk_late_init().

 drivers/clk/samsung/clk-exynos5420.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 9d7d7ee..70b607a 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -890,8 +890,8 @@ static struct samsung_gate_clock exynos5x_gate_clks[] __initdata = {
 			GATE_BUS_TOP, 9, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "aclk66_psgen", "mout_user_aclk66_psgen",
 			GATE_BUS_TOP, 10, CLK_IGNORE_UNUSED, 0),
-	GATE(CLK_ACLK66_PERIC, "aclk66_peric", "mout_user_aclk66_peric",
-			GATE_BUS_TOP, 11, CLK_IGNORE_UNUSED, 0),
+	GATE_A(CLK_ACLK66_PERIC, "aclk66_peric", "mout_user_aclk66_peric",
+			GATE_BUS_TOP, 11, CLK_IGNORE_UNUSED, 0, "aclk66_peric"),
 	GATE(0, "aclk266_isp", "mout_user_aclk266_isp",
 			GATE_BUS_TOP, 13, 0, 0),
 	GATE(0, "aclk166", "mout_user_aclk166",
@@ -1172,11 +1172,22 @@ static struct of_device_id ext_clk_match[] __initdata = {
 	{ },
 };
 
+/* Keep these clocks on until late_initcall */
+struct boot_clock {
+	char *name;
+	struct clk *clk;
+};
+
+static struct boot_clock boot_clocks[] __initdata = {
+	{ .name = "aclk66_peric", },
+};
+
 /* register exynos5420 clocks */
 static void __init exynos5x_clk_init(struct device_node *np,
 		enum exynos5x_soc soc)
 {
 	struct samsung_clk_provider *ctx;
+	int i;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -1226,6 +1237,11 @@ static void __init exynos5x_clk_init(struct device_node *np,
 	}
 
 	exynos5420_clk_sleep_init();
+
+	for (i = 0; i < ARRAY_SIZE(boot_clocks); i++) {
+		boot_clocks[i].clk = clk_get(NULL, boot_clocks[i].name);
+		clk_prepare_enable(boot_clocks[i].clk);
+	}
 }
 
 static void __init exynos5420_clk_init(struct device_node *np)
@@ -1239,3 +1255,16 @@ static void __init exynos5800_clk_init(struct device_node *np)
 	exynos5x_clk_init(np, EXYNOS5800);
 }
 CLK_OF_DECLARE(exynos5800_clk, "samsung,exynos5800-clock", exynos5800_clk_init);
+
+static int __init exynos5420_clk_late_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(boot_clocks); i++) {
+		clk_disable_unprepare(boot_clocks[i].clk);
+		clk_put(boot_clocks[i].clk);
+	}
+
+	return 0;
+}
+late_initcall(exynos5420_clk_late_init);
-- 
1.9.1.423.g4596e3a
