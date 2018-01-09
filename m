From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Jan 2018 16:59:02 +0900
Subject: [RFC PATCH 5/9] soc: samsung: pm: Add support for suspend-to-ram of
 Exynos5433
In-Reply-To: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
References: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <CGME20180109075905epcas2p1fe6b554b646dbc80e04273ad6dd8489c@epcas2p1.samsung.com>
Message-ID: <1515484746-10656-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the specific exynos_pm_data instance for Exynos5433
in order to support the suspend-to-ram. Exynos5433 SoC need to write
the 'cpu_resume' poiter address and the specific magic number
for suspend mode.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/soc/samsung/exynos-pm.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/soc/samsung/exynos-pm.c b/drivers/soc/samsung/exynos-pm.c
index 45d84bbe5e61..70d949ba5cab 100644
--- a/drivers/soc/samsung/exynos-pm.c
+++ b/drivers/soc/samsung/exynos-pm.c
@@ -12,6 +12,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/syscore_ops.h>
 #include <linux/suspend.h>
+#include <linux/psci.h>

 #include <asm/cpuidle.h>
 #include <asm/io.h>
@@ -123,7 +124,44 @@ static void exynos_pm_finish(void)
 #define exynos_pm_data_arm_ptr(data)	NULL
 #endif

+static int exynos5433_pm_suspend(unsigned long unused)
+{
+	/*
+	 * Exynos5433 uses PSCI v0.1 which provides the only one
+	 * entry point (psci_ops.cpu_suspend) for both cpuidle and
+	 * suspend-to-RAM. Also, PSCI v0.1 needs the specific 'power_state'
+	 * parameter for the suspend mode. In order to enter suspend mode,
+	 * Exynos5433 calls the 'psci_ops.cpu_suspend' with '0x3010000'
+	 * power_state parameter.
+	 *
+	 * '0x3010000' means that both cluster and system are going to enter
+	 * the power-down state as following:
+	 * - [25:24] 0x3 : Indicate the cluster and system.
+	 * - [16]    0x1 : Indicate power-down state.
+	 */
+	return psci_ops.cpu_suspend(0x3010000, __pa_symbol(cpu_resume));
+}
+
+static int exynos5433_pm_suspend_enter(suspend_state_t state)
+{
+	if (!sysram_ns_base_addr)
+		return -EINVAL;
+
+	__raw_writel(virt_to_phys(cpu_resume), sysram_ns_base_addr + 0x8);
+	__raw_writel(EXYNOS_SLEEP_MAGIC, sysram_ns_base_addr + 0xc);
+
+	return cpu_suspend(0, exynos5433_pm_suspend);
+}
+
+const struct exynos_pm_data exynos5433_pm_data = {
+	.enter		= exynos5433_pm_suspend_enter,
+};
+
 static const struct of_device_id exynos_pm_of_device_ids[] = {
+	{
+		.compatible = "samsung,exynos5433-pmu",
+		.data = exynos_pm_data_arm_ptr(exynos5433_pm_data),
+	},
 	{ /*sentinel*/ },
 };

--
1.9.1
