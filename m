From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 31 Jan 2012 13:49:24 +0900
Subject: [PATCH 2/3] [CPUFREQ] EXYNOS4210: update the name of EXYNOS clock
 register
In-Reply-To: <1327985365-7070-1-git-send-email-kgene.kim@samsung.com>
References: <1327985365-7070-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1327985365-7070-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to replacing the name of EXYNOS clock registers,
this patch updates exynos4210-cpufreq.c file where it is used.

Cc: Jaecheol Lee <jc.lee@samsung.com>
Cc: Dave Jones <davej@redhat.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/cpufreq/exynos4210-cpufreq.c |   70 +++++++++++++++++-----------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
index 065da5b..fb148fa 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -121,25 +121,25 @@ static void exynos4210_set_clkdiv(unsigned int div_index)
 
 	tmp = exynos4210_clkdiv_table[div_index].clkdiv;
 
-	__raw_writel(tmp, S5P_CLKDIV_CPU);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STATCPU);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STATCPU);
 	} while (tmp & 0x1111111);
 
 	/* Change Divider - CPU1 */
 
-	tmp = __raw_readl(S5P_CLKDIV_CPU1);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_CPU1);
 
 	tmp &= ~((0x7 << 4) | 0x7);
 
 	tmp |= ((clkdiv_cpu1[div_index][0] << 4) |
 		(clkdiv_cpu1[div_index][1] << 0));
 
-	__raw_writel(tmp, S5P_CLKDIV_CPU1);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STATCPU1);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STATCPU1);
 	} while (tmp & 0x11);
 }
 
@@ -151,32 +151,32 @@ static void exynos4210_set_apll(unsigned int index)
 	clk_set_parent(moutcore, mout_mpll);
 
 	do {
-		tmp = (__raw_readl(S5P_CLKMUX_STATCPU)
-			>> S5P_CLKSRC_CPU_MUXCORE_SHIFT);
+		tmp = (__raw_readl(EXYNOS4_CLKMUX_STATCPU)
+			>> EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT);
 		tmp &= 0x7;
 	} while (tmp != 0x2);
 
 	/* 2. Set APLL Lock time */
-	__raw_writel(S5P_APLL_LOCKTIME, S5P_APLL_LOCK);
+	__raw_writel(EXYNOS4_APLL_LOCKTIME, EXYNOS4_APLL_LOCK);
 
 	/* 3. Change PLL PMS values */
-	tmp = __raw_readl(S5P_APLL_CON0);
+	tmp = __raw_readl(EXYNOS4_APLL_CON0);
 	tmp &= ~((0x3ff << 16) | (0x3f << 8) | (0x7 << 0));
 	tmp |= exynos4210_apll_pms_table[index];
-	__raw_writel(tmp, S5P_APLL_CON0);
+	__raw_writel(tmp, EXYNOS4_APLL_CON0);
 
 	/* 4. wait_lock_time */
 	do {
-		tmp = __raw_readl(S5P_APLL_CON0);
-	} while (!(tmp & (0x1 << S5P_APLLCON0_LOCKED_SHIFT)));
+		tmp = __raw_readl(EXYNOS4_APLL_CON0);
+	} while (!(tmp & (0x1 << EXYNOS4_APLLCON0_LOCKED_SHIFT)));
 
 	/* 5. MUX_CORE_SEL = APLL */
 	clk_set_parent(moutcore, mout_apll);
 
 	do {
-		tmp = __raw_readl(S5P_CLKMUX_STATCPU);
-		tmp &= S5P_CLKMUX_STATCPU_MUXCORE_MASK;
-	} while (tmp != (0x1 << S5P_CLKSRC_CPU_MUXCORE_SHIFT));
+		tmp = __raw_readl(EXYNOS4_CLKMUX_STATCPU);
+		tmp &= EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK;
+	} while (tmp != (0x1 << EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
 }
 
 bool exynos4210_pms_change(unsigned int old_index, unsigned int new_index)
@@ -198,10 +198,10 @@ static void exynos4210_set_frequency(unsigned int old_index,
 			exynos4210_set_clkdiv(new_index);
 
 			/* 2. Change just s value in apll m,p,s value */
-			tmp = __raw_readl(S5P_APLL_CON0);
+			tmp = __raw_readl(EXYNOS4_APLL_CON0);
 			tmp &= ~(0x7 << 0);
 			tmp |= (exynos4210_apll_pms_table[new_index] & 0x7);
-			__raw_writel(tmp, S5P_APLL_CON0);
+			__raw_writel(tmp, EXYNOS4_APLL_CON0);
 		} else {
 			/* Clock Configuration Procedure */
 			/* 1. Change the system clock divider values */
@@ -212,10 +212,10 @@ static void exynos4210_set_frequency(unsigned int old_index,
 	} else if (old_index < new_index) {
 		if (!exynos4210_pms_change(old_index, new_index)) {
 			/* 1. Change just s value in apll m,p,s value */
-			tmp = __raw_readl(S5P_APLL_CON0);
+			tmp = __raw_readl(EXYNOS4_APLL_CON0);
 			tmp &= ~(0x7 << 0);
 			tmp |= (exynos4210_apll_pms_table[new_index] & 0x7);
-			__raw_writel(tmp, S5P_APLL_CON0);
+			__raw_writel(tmp, EXYNOS4_APLL_CON0);
 
 			/* 2. Change the system clock divider values */
 			exynos4210_set_clkdiv(new_index);
@@ -253,24 +253,24 @@ int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
 	if (IS_ERR(mout_apll))
 		goto err_mout_apll;
 
-	tmp = __raw_readl(S5P_CLKDIV_CPU);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_CPU);
 
 	for (i = L0; i <  CPUFREQ_LEVEL_END; i++) {
-		tmp &= ~(S5P_CLKDIV_CPU0_CORE_MASK |
-			S5P_CLKDIV_CPU0_COREM0_MASK |
-			S5P_CLKDIV_CPU0_COREM1_MASK |
-			S5P_CLKDIV_CPU0_PERIPH_MASK |
-			S5P_CLKDIV_CPU0_ATB_MASK |
-			S5P_CLKDIV_CPU0_PCLKDBG_MASK |
-			S5P_CLKDIV_CPU0_APLL_MASK);
-
-		tmp |= ((clkdiv_cpu0[i][0] << S5P_CLKDIV_CPU0_CORE_SHIFT) |
-			(clkdiv_cpu0[i][1] << S5P_CLKDIV_CPU0_COREM0_SHIFT) |
-			(clkdiv_cpu0[i][2] << S5P_CLKDIV_CPU0_COREM1_SHIFT) |
-			(clkdiv_cpu0[i][3] << S5P_CLKDIV_CPU0_PERIPH_SHIFT) |
-			(clkdiv_cpu0[i][4] << S5P_CLKDIV_CPU0_ATB_SHIFT) |
-			(clkdiv_cpu0[i][5] << S5P_CLKDIV_CPU0_PCLKDBG_SHIFT) |
-			(clkdiv_cpu0[i][6] << S5P_CLKDIV_CPU0_APLL_SHIFT));
+		tmp &= ~(EXYNOS4_CLKDIV_CPU0_CORE_MASK |
+			EXYNOS4_CLKDIV_CPU0_COREM0_MASK |
+			EXYNOS4_CLKDIV_CPU0_COREM1_MASK |
+			EXYNOS4_CLKDIV_CPU0_PERIPH_MASK |
+			EXYNOS4_CLKDIV_CPU0_ATB_MASK |
+			EXYNOS4_CLKDIV_CPU0_PCLKDBG_MASK |
+			EXYNOS4_CLKDIV_CPU0_APLL_MASK);
+
+		tmp |= ((clkdiv_cpu0[i][0] << EXYNOS4_CLKDIV_CPU0_CORE_SHIFT) |
+			(clkdiv_cpu0[i][1] << EXYNOS4_CLKDIV_CPU0_COREM0_SHIFT) |
+			(clkdiv_cpu0[i][2] << EXYNOS4_CLKDIV_CPU0_COREM1_SHIFT) |
+			(clkdiv_cpu0[i][3] << EXYNOS4_CLKDIV_CPU0_PERIPH_SHIFT) |
+			(clkdiv_cpu0[i][4] << EXYNOS4_CLKDIV_CPU0_ATB_SHIFT) |
+			(clkdiv_cpu0[i][5] << EXYNOS4_CLKDIV_CPU0_PCLKDBG_SHIFT) |
+			(clkdiv_cpu0[i][6] << EXYNOS4_CLKDIV_CPU0_APLL_SHIFT));
 
 		exynos4210_clkdiv_table[i].clkdiv = tmp;
 	}
-- 
1.7.4.4
