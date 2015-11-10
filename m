From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 10 Nov 2015 17:13:03 +0530
Subject: [PATCH v4 8/9] ARM: EXYNOS: rearrange static and non-static functions
 of PMU driver
In-Reply-To: <1447155784-12667-1-git-send-email-pankaj.dubey@samsung.com>
References: <1447155784-12667-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1447155784-12667-9-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves exynos_sys_powerdown_conf function above all
static functions.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/pmu.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index e01bdf1..f300ac9 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -39,23 +39,6 @@ u32 pmu_raw_readl(u32 offset)
 	return readl_relaxed(pmu_base_addr + offset);
 }
 
-static void exynos_power_off(void)
-{
-	unsigned int tmp;
-
-	pr_info("Power down.\n");
-	tmp = pmu_raw_readl(EXYNOS_PS_HOLD_CONTROL);
-	tmp ^= (1 << 8);
-	pmu_raw_writel(tmp, EXYNOS_PS_HOLD_CONTROL);
-
-	/* Wait a little so we don't give a false warning below */
-	mdelay(100);
-
-	pr_err("Power down failed, please power off system manually.\n");
-	while (1)
-		;
-}
-
 void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
@@ -85,6 +68,23 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 	}
 }
 
+static void exynos_power_off(void)
+{
+	unsigned int tmp;
+
+	pr_info("Power down.\n");
+	tmp = pmu_raw_readl(EXYNOS_PS_HOLD_CONTROL);
+	tmp ^= (1 << 8);
+	pmu_raw_writel(tmp, EXYNOS_PS_HOLD_CONTROL);
+
+	/* Wait a little so we don't give a false warning below */
+	mdelay(100);
+
+	pr_err("Power down failed, please power off system manually.\n");
+	while (1)
+		;
+}
+
 static int pmu_restart_notify(struct notifier_block *this,
 		unsigned long code, void *unused)
 {
-- 
2.4.5
