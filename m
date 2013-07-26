From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 26 Jul 2013 17:15:04 +0800
Subject: [PATCH 2/8] ARM: tegra: config the polarity of the request of sys
 clock
In-Reply-To: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
Message-ID: <1374830110-30685-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When suspending to LP1 mode, the SYSCLK will be clock gated. And different
board may have different polarity of the request of SYSCLK, this patch
configure the polarity from the DT for the board.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/pmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 8345fcd..018bc87 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -27,6 +27,8 @@
 #include "pmc.h"
 #include "sleep.h"
 
+#define TEGRA_POWER_SYSCLK_POLARITY	(1 << 10)  /* sys clk polarity */
+#define TEGRA_POWER_SYSCLK_OE		(1 << 11)  /* system clock enable */
 #define TEGRA_POWER_EFFECT_LP0		(1 << 14)  /* LP0 when CPU pwr gated */
 #define TEGRA_POWER_CPU_PWRREQ_POLARITY	(1 << 15)  /* CPU pwr req polarity */
 #define TEGRA_POWER_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
@@ -238,6 +240,20 @@ void tegra_pmc_suspend_init(void)
 	reg = tegra_pmc_readl(PMC_CTRL);
 	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
 	tegra_pmc_writel(reg, PMC_CTRL);
+
+	reg = tegra_pmc_readl(PMC_CTRL);
+
+	if (!pmc_pm_data.sysclkreq_high)
+		reg |= TEGRA_POWER_SYSCLK_POLARITY;
+	else
+		reg &= ~TEGRA_POWER_SYSCLK_POLARITY;
+
+	/* configure the output inverts while the request is tristated */
+	tegra_pmc_writel(reg, PMC_CTRL);
+
+	/* now enable the request */
+	reg |= TEGRA_POWER_SYSCLK_OE;
+	tegra_pmc_writel(reg, PMC_CTRL);
 }
 #endif
 
-- 
1.8.3.4
