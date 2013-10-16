From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 13:08:17 +0200
Subject: [PATCH 8/9] clk: samsung: exynos4: Add remaining suspend/resume
 handling
In-Reply-To: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
References: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381921698-5060-9-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of now, part of Exynos4 clock suspend/resume handling is located
in mach-exynos/pm.c, which is not where code accessing CMU registers
should reside.

This patch implements all the necessary suspend/resume handling code
in Exynos4 clock driver to allow dropping that old code.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 74 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 694c755..ca2a940 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -201,6 +201,7 @@ static enum exynos4_soc exynos4_soc;
 #ifdef CONFIG_PM_SLEEP
 static struct samsung_clk_reg_dump *exynos4_save_common;
 static struct samsung_clk_reg_dump *exynos4_save_soc;
+static struct samsung_clk_reg_dump *exynos4_save_pll;
 
 /*
  * list of controller registers to be saved and restored during a
@@ -226,6 +227,17 @@ static unsigned long exynos4x12_clk_save[] __initdata = {
 	E4X12_MPLL_CON0,
 };
 
+static unsigned long exynos4_clk_pll_regs[] __initdata = {
+	EPLL_LOCK,
+	VPLL_LOCK,
+	EPLL_CON0,
+	EPLL_CON1,
+	EPLL_CON2,
+	VPLL_CON0,
+	VPLL_CON1,
+	VPLL_CON2,
+};
+
 static unsigned long exynos4_clk_regs[] __initdata = {
 	SRC_LEFTBUS,
 	DIV_LEFTBUS,
@@ -233,12 +245,6 @@ static unsigned long exynos4_clk_regs[] __initdata = {
 	SRC_RIGHTBUS,
 	DIV_RIGHTBUS,
 	GATE_IP_RIGHTBUS,
-	EPLL_CON0,
-	EPLL_CON1,
-	EPLL_CON2,
-	VPLL_CON0,
-	VPLL_CON1,
-	VPLL_CON2,
 	SRC_TOP0,
 	SRC_TOP1,
 	SRC_CAM,
@@ -299,23 +305,68 @@ static unsigned long exynos4_clk_regs[] __initdata = {
 	GATE_IP_CPU,
 };
 
+static const struct samsung_clk_reg_dump src_mask_suspend[] = {
+	{ .offset = SRC_MASK_TOP,		.value = 0x00000001, },
+	{ .offset = SRC_MASK_CAM,		.value = 0x11111111, },
+	{ .offset = SRC_MASK_TV,		.value = 0x00000111, },
+	{ .offset = SRC_MASK_LCD0,		.value = 0x00001111, },
+	{ .offset = SRC_MASK_MAUDIO,		.value = 0x00000001, },
+	{ .offset = SRC_MASK_FSYS,		.value = 0x01011111, },
+	{ .offset = SRC_MASK_PERIL0,		.value = 0x01111111, },
+	{ .offset = SRC_MASK_PERIL1,		.value = 0x01110111, },
+	{ .offset = SRC_MASK_DMC,		.value = 0x00010000, },
+};
+
+static const struct samsung_clk_reg_dump src_mask_suspend_e4210[] = {
+	{ .offset = E4210_SRC_MASK_LCD1,	.value = 0x00001111, },
+};
+
+#define PLL_ENABLED	(1 << 31)
+#define PLL_LOCKED	(1 << 29)
+
+static void exynos4_clk_wait_for_pll(u32 reg)
+{
+	u32 pll_con;
+
+	pll_con = readl(reg_base + reg);
+	if (!(pll_con & PLL_ENABLED))
+		return;
+
+	while (!(pll_con & PLL_LOCKED)) {
+		cpu_relax();
+		pll_con = readl(reg_base + reg);
+	}
+}
+
 static int exynos4_clk_suspend(void)
 {
 	samsung_clk_save(reg_base, exynos4_save_common,
 				ARRAY_SIZE(exynos4_clk_regs));
 
-	if (exynos4_soc == EXYNOS4210)
+	if (exynos4_soc == EXYNOS4210) {
 		samsung_clk_save(reg_base, exynos4_save_soc,
 					ARRAY_SIZE(exynos4210_clk_save));
-	else
+		samsung_clk_restore(reg_base, src_mask_suspend_e4210,
+					ARRAY_SIZE(src_mask_suspend_e4210));
+	} else {
 		samsung_clk_save(reg_base, exynos4_save_soc,
 					ARRAY_SIZE(exynos4x12_clk_save));
+	}
+
+	samsung_clk_restore(reg_base, src_mask_suspend,
+					ARRAY_SIZE(src_mask_suspend));
 
 	return 0;
 }
 
 static void exynos4_clk_resume(void)
 {
+	samsung_clk_restore(reg_base, exynos4_save_pll,
+				ARRAY_SIZE(exynos4_clk_pll_regs));
+
+	exynos4_clk_wait_for_pll(EPLL_CON0);
+	exynos4_clk_wait_for_pll(VPLL_CON0);
+
 	samsung_clk_restore(reg_base, exynos4_save_common,
 				ARRAY_SIZE(exynos4_clk_regs));
 
@@ -350,9 +401,16 @@ static void exynos4_clk_sleep_init(void)
 	if (!exynos4_save_soc)
 		goto err_common;
 
+	exynos4_save_pll = samsung_clk_alloc_reg_dump(exynos4_clk_pll_regs,
+					ARRAY_SIZE(exynos4_clk_pll_regs));
+	if (!exynos4_save_pll)
+		goto err_soc;
+
 	register_syscore_ops(&exynos4_clk_syscore_ops);
 	return;
 
+err_soc:
+	kfree(exynos4_save_soc);
 err_common:
 	kfree(exynos4_save_common);
 err_warn:
-- 
1.8.3.2
