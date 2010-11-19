From: AMartin@nvidia.com (Allen Martin)
Date: Fri, 19 Nov 2010 15:51:50 -0800
Subject: [PATCH] ARM: tegra: suspend: protect suspend functions with CONFIG_PM
Message-ID: <3C7A7ACA8617D24290826EC008B5CD0817D747F9EA@HQMAIL03.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Protect suspend/resume functions behind #ifdef CONFIG_PM.  This
prevents a compile error with CONFIG_PM turned off.

Signed-off-by: Allen Martin <amartin@nvidia.com>
---
 arch/arm/mach-tegra/suspend.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/suspend.c b/arch/arm/mach-tegra/suspend.c
index f691e90..ead053e 100644
--- a/arch/arm/mach-tegra/suspend.c
+++ b/arch/arm/mach-tegra/suspend.c
@@ -79,10 +79,12 @@ struct suspend_context {
 volatile struct suspend_context tegra_sctx;

 static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
+#ifdef CONFIG_PM
 static void __iomem *clk_rst = IO_ADDRESS(TEGRA_CLK_RESET_BASE);
 static void __iomem *flow_ctrl = IO_ADDRESS(TEGRA_FLOW_CTRL_BASE);
 static void __iomem *evp_reset = IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE)+0x100;
 static void __iomem *tmrus = IO_ADDRESS(TEGRA_TMRUS_BASE);
+#endif

 #define PMC_CTRL               0x0
 #define PMC_CTRL_LATCH_WAKEUPS (1 << 5)
@@ -251,6 +253,7 @@ static int create_suspend_pgtable(void)



+#ifdef CONFIG_PM
 /*
  * suspend_cpu_complex
  *
@@ -387,8 +390,6 @@ unsigned int tegra_suspend_lp2(unsigned int us)
        return remain;
 }

-#ifdef CONFIG_PM
-
 /* ensures that sufficient time is passed for a register write to
  * serialize into the 32KHz domain */
 static void pmc_32kwritel(u32 val, unsigned long offs)
--
1.7.2.3
