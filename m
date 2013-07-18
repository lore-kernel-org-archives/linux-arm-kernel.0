From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Jul 2013 23:28:36 -0400
Subject: [PATCH 4/4] ARM: vexpress/TC2: implement PM suspend method
In-Reply-To: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374118116-16836-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nico@linaro.org>

Similar to power_down(), except that for a suspend, the firmware
mailbox address has to be set prior entering low power mode.

The residency argument is not used yet, so the last man always shuts
down the cluster for now.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/tc2_pm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index 26dbe782fb..dfb55d45b6 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -84,7 +84,7 @@ static int tc2_pm_power_up(unsigned int cpu, unsigned int cluster)
 	return 0;
 }
 
-static void tc2_pm_power_down(void)
+static void tc2_pm_down(u64 residency)
 {
 	unsigned int mpidr, cpu, cluster;
 	bool last_man = false, skip_wfi = false;
@@ -198,6 +198,22 @@ static void tc2_pm_power_down(void)
 	/* Not dead at this point?  Let our caller cope. */
 }
 
+static void tc2_pm_power_down(void)
+{
+	tc2_pm_down(0);
+}
+
+static void tc2_pm_suspend(u64 residency)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	ve_spc_set_resume_addr(cluster, cpu, virt_to_phys(mcpm_entry_point));
+	tc2_pm_down(residency);
+}
+
 static void tc2_pm_powered_up(void)
 {
 	unsigned int mpidr, cpu, cluster;
@@ -231,6 +247,7 @@ static void tc2_pm_powered_up(void)
 static const struct mcpm_platform_ops tc2_pm_power_ops = {
 	.power_up	= tc2_pm_power_up,
 	.power_down	= tc2_pm_power_down,
+	.suspend	= tc2_pm_suspend,
 	.powered_up	= tc2_pm_powered_up,
 };
 
-- 
1.8.1.2
