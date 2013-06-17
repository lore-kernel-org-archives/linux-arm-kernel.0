From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:34:22 +0200
Subject: [PATCH v2 37/38] ARM: EXYNOS: Remove legacy L2X0 initialization
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-38-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Exynos is now supporting only DT-based boot, the old L2X0
initialization code is not needed anymore, so exynos4_l2x0_cache_init()
can be greatly simplified.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c | 48 ++++---------------------------------------
 1 file changed, 4 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 561890f..e886154 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -412,59 +412,19 @@ static int __init exynos_core_init(void)
 }
 core_initcall(exynos_core_init);
 
-#ifdef CONFIG_CACHE_L2X0
 static int __init exynos4_l2x0_cache_init(void)
 {
 	int ret;
 
-	if (soc_is_exynos5250() || soc_is_exynos5440())
-		return 0;
-
 	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
-	if (!ret) {
-		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
-		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
-		return 0;
-	}
-
-	if (!(__raw_readl(S5P_VA_L2CC + L2X0_CTRL) & 0x1)) {
-		l2x0_saved_regs.phy_base = EXYNOS4_PA_L2CC;
-		/* TAG, Data Latency Control: 2 cycles */
-		l2x0_saved_regs.tag_latency = 0x110;
-
-		if (soc_is_exynos4212() || soc_is_exynos4412())
-			l2x0_saved_regs.data_latency = 0x120;
-		else
-			l2x0_saved_regs.data_latency = 0x110;
-
-		l2x0_saved_regs.prefetch_ctrl = 0x30000007;
-		l2x0_saved_regs.pwr_ctrl =
-			(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN);
-
-		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
-
-		__raw_writel(l2x0_saved_regs.tag_latency,
-				S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
-		__raw_writel(l2x0_saved_regs.data_latency,
-				S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
-
-		/* L2X0 Prefetch Control */
-		__raw_writel(l2x0_saved_regs.prefetch_ctrl,
-				S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
-
-		/* L2X0 Power Control */
-		__raw_writel(l2x0_saved_regs.pwr_ctrl,
-				S5P_VA_L2CC + L2X0_POWER_CTRL);
-
-		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
-		clean_dcache_area(&l2x0_saved_regs, sizeof(struct l2x0_regs));
-	}
+	if (ret)
+		return ret;
 
-	l2x0_init(S5P_VA_L2CC, L2_AUX_VAL, L2_AUX_MASK);
+	l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
+	clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
 	return 0;
 }
 early_initcall(exynos4_l2x0_cache_init);
-#endif
 
 static int __init exynos_init(void)
 {
-- 
1.8.2.1
