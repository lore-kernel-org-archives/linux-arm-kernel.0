From: ccross@android.com (Colin Cross)
Date: Sun, 23 Jan 2011 18:01:31 -0800
Subject: [PATCH v2 26/28] ARM: tegra: suspend: protect suspend functions with
	CONFIG_PM
In-Reply-To: <1295834493-5019-1-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
Message-ID: <1295834493-5019-27-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Allen Martin <amartin@nvidia.com>

Protect suspend/resume functions behind #ifdef CONFIG_PM.  This
prevents a compile error with CONFIG_PM turned off.

Signed-off-by: Allen Martin <amartin@nvidia.com>
Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/suspend.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/suspend.c b/arch/arm/mach-tegra/suspend.c
index be8c78f..8b32707 100644
--- a/arch/arm/mach-tegra/suspend.c
+++ b/arch/arm/mach-tegra/suspend.c
@@ -75,10 +75,12 @@ struct suspend_context {
 struct suspend_context tegra_sctx;
 
 static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
+#ifdef CONFIG_PM
 static void __iomem *clk_rst = IO_ADDRESS(TEGRA_CLK_RESET_BASE);
 static void __iomem *flow_ctrl = IO_ADDRESS(TEGRA_FLOW_CTRL_BASE);
 static void __iomem *evp_reset = IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100;
 static void __iomem *tmrus = IO_ADDRESS(TEGRA_TMRUS_BASE);
+#endif
 
 #define PMC_CTRL		0x0
 #define PMC_CTRL_LATCH_WAKEUPS	(1 << 5)
@@ -205,6 +207,7 @@ static int create_suspend_pgtable(void)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static noinline void restore_cpu_complex(void)
 {
 	unsigned int reg;
@@ -326,8 +329,6 @@ unsigned int tegra_suspend_lp2(unsigned int us)
 	return remain;
 }
 
-#ifdef CONFIG_PM
-
 /* ensures that sufficient time is passed for a register write to
  * serialize into the 32KHz domain */
 static void pmc_32kwritel(u32 val, unsigned long offs)
-- 
1.7.3.1
