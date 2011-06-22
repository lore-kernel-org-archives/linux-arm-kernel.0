From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Jun 2011 17:46:43 +0900
Subject: [PATCH 5/7] ARM: EXYNOS4: Add save/restore function for PLL
In-Reply-To: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1308732405-16664-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

The PLL restore routine supports waiting pll locking. If PLL is
enabled in restoring sequence, it should wait until PLL is locked.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/regs-clock.h |    9 ++
 arch/arm/mach-exynos4/pm.c                      |   96 ++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-exynos4/include/mach/regs-clock.h
index 6e311c1..64bdd24 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
@@ -25,6 +25,9 @@
 #define S5P_CLKDIV_STAT_RIGHTBUS	S5P_CLKREG(0x08600)
 #define S5P_CLKGATE_IP_RIGHTBUS		S5P_CLKREG(0x08800)
 
+#define S5P_EPLL_LOCK			S5P_CLKREG(0x0C010)
+#define S5P_VPLL_LOCK			S5P_CLKREG(0x0C020)
+
 #define S5P_EPLL_CON0			S5P_CLKREG(0x0C110)
 #define S5P_EPLL_CON1			S5P_CLKREG(0x0C114)
 #define S5P_VPLL_CON0			S5P_CLKREG(0x0C120)
@@ -120,6 +123,12 @@
 #define S5P_APLL_VAL_1000		((250 << 16) | (6 << 8) | 1)
 #define S5P_APLL_VAL_800		((200 << 16) | (6 << 8) | 1)
 
+#define S5P_EPLLCON0_ENABLE_SHIFT	(31)
+#define S5P_EPLLCON0_LOCKED_SHIFT	(29)
+
+#define S5P_VPLLCON0_ENABLE_SHIFT	(31)
+#define S5P_VPLLCON0_LOCKED_SHIFT	(29)
+
 #define S5P_CLKSRC_CPU_MUXCORE_SHIFT	(16)
 #define S5P_CLKMUX_STATCPU_MUXCORE_MASK	(0x7 << S5P_CLKSRC_CPU_MUXCORE_SHIFT)
 
diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index f4d52b5..b037fba 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -18,12 +18,15 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/io.h>
+#include <linux/err.h>
+#include <linux/clk.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
+#include <plat/pll.h>
 
 #include <mach/regs-irq.h>
 #include <mach/regs-gpio.h>
@@ -45,16 +48,22 @@ static struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = S5P_CLKSRC_MASK_DMC			, .val = 0x00010000, },
 };
 
+static struct sleep_save exynos4_epll_save[] = {
+	SAVE_ITEM(S5P_EPLL_CON0),
+	SAVE_ITEM(S5P_EPLL_CON1),
+};
+
+static struct sleep_save exynos4_vpll_save[] = {
+	SAVE_ITEM(S5P_VPLL_CON0),
+	SAVE_ITEM(S5P_VPLL_CON1),
+};
+
 static struct sleep_save exynos4_core_save[] = {
 	/* CMU side */
 	SAVE_ITEM(S5P_CLKDIV_LEFTBUS),
 	SAVE_ITEM(S5P_CLKGATE_IP_LEFTBUS),
 	SAVE_ITEM(S5P_CLKDIV_RIGHTBUS),
 	SAVE_ITEM(S5P_CLKGATE_IP_RIGHTBUS),
-	SAVE_ITEM(S5P_EPLL_CON0),
-	SAVE_ITEM(S5P_EPLL_CON1),
-	SAVE_ITEM(S5P_VPLL_CON0),
-	SAVE_ITEM(S5P_VPLL_CON1),
 	SAVE_ITEM(S5P_CLKSRC_TOP0),
 	SAVE_ITEM(S5P_CLKSRC_TOP1),
 	SAVE_ITEM(S5P_CLKSRC_CAM),
@@ -260,6 +269,8 @@ static void exynos4_pm_prepare(void)
 
 	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
 	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
+	s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
+	s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
 
 	tmp = __raw_readl(S5P_INFORM1);
 
@@ -307,12 +318,80 @@ void exynos4_scu_enable(void __iomem *scu_base)
 	flush_cache_all();
 }
 
+static unsigned long pll_base_rate;
+
+static void exynos4_restore_pll(void)
+{
+	unsigned long pll_con, locktime, lockcnt;
+	unsigned long pll_in_rate;
+	unsigned int p_div, epll_wait = 0, vpll_wait = 0;
+
+	if (pll_base_rate == 0)
+		return;
+
+	pll_in_rate = pll_base_rate;
+
+	/* EPLL */
+	pll_con = exynos4_epll_save[0].val;
+
+	if (pll_con & (1 << 31)) {
+		pll_con &= (PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT);
+		p_div = (pll_con >> PLL46XX_PDIV_SHIFT);
+
+		pll_in_rate /= 1000000;
+
+		locktime = (3000 / pll_in_rate) * p_div;
+		lockcnt = locktime * 10000 / (10000 / pll_in_rate);
+
+		__raw_writel(lockcnt, S5P_EPLL_LOCK);
+
+		s3c_pm_do_restore_core(exynos4_epll_save,
+					ARRAY_SIZE(exynos4_epll_save));
+		epll_wait = 1;
+	}
+
+	pll_in_rate = pll_base_rate;
+
+	/* VPLL */
+	pll_con = exynos4_vpll_save[0].val;
+
+	if (pll_con & (1 << 31)) {
+		pll_in_rate /= 1000000;
+		/* 750us */
+		locktime = 750;
+		lockcnt = locktime * 10000 / (10000 / pll_in_rate);
+
+		__raw_writel(lockcnt, S5P_VPLL_LOCK);
+
+		s3c_pm_do_restore_core(exynos4_vpll_save,
+					ARRAY_SIZE(exynos4_vpll_save));
+		vpll_wait = 1;
+	}
+
+	/* Wait PLL locking */
+
+	do {
+		if (epll_wait) {
+			pll_con = __raw_readl(S5P_EPLL_CON0);
+			if (pll_con & (1 << S5P_EPLLCON0_LOCKED_SHIFT))
+				epll_wait = 0;
+		}
+
+		if (vpll_wait) {
+			pll_con = __raw_readl(S5P_VPLL_CON0);
+			if (pll_con & (1 << S5P_VPLLCON0_LOCKED_SHIFT))
+				vpll_wait = 0;
+		}
+	} while (epll_wait || vpll_wait);
+}
+
 static struct sysdev_driver exynos4_pm_driver = {
 	.add		= exynos4_pm_add,
 };
 
 static __init int exynos4_pm_drvinit(void)
 {
+	struct clk *pll_base;
 	unsigned int tmp;
 
 	s3c_pm_init();
@@ -323,6 +402,13 @@ static __init int exynos4_pm_drvinit(void)
 	tmp |= ((0xFF << 8) | (0x1F << 1));
 	__raw_writel(tmp, S5P_WAKEUP_MASK);
 
+	pll_base = clk_get(NULL, "xtal");
+
+	if (!IS_ERR(pll_base)) {
+		pll_base_rate = clk_get_rate(pll_base);
+		clk_put(pll_base);
+	}
+
 	return sysdev_driver_register(&exynos4_sysclass, &exynos4_pm_driver);
 }
 arch_initcall(exynos4_pm_drvinit);
@@ -357,6 +443,8 @@ static void exynos4_pm_resume(void)
 
 	s3c_pm_do_restore_core(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
 
+	exynos4_restore_pll();
+
 	exynos4_scu_enable(S5P_VA_SCU);
 
 #ifdef CONFIG_CACHE_L2X0
-- 
1.7.1
