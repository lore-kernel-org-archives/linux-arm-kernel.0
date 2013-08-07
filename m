From: pawel.moll@arm.com (Pawel Moll)
Date: Wed,  7 Aug 2013 16:09:48 +0100
Subject: [PATCH v2 5/5] ARM: vexpress/TC2: implement PM suspend method
In-Reply-To: <1375888188-30213-1-git-send-email-pawel.moll@arm.com>
References: <1375888188-30213-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1375888188-30213-6-git-send-email-pawel.moll@arm.com>
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
index cdc6068..ddd97dd 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -95,7 +95,7 @@ static int tc2_pm_power_up(unsigned int cpu, unsigned int cluster)
 	return 0;
 }
 
-static void tc2_pm_power_down(void)
+static void tc2_pm_down(u64 residency)
 {
 	unsigned int mpidr, cpu, cluster;
 	bool last_man = false, skip_wfi = false;
@@ -209,6 +209,22 @@ static void tc2_pm_power_down(void)
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
@@ -242,6 +258,7 @@ static void tc2_pm_powered_up(void)
 static const struct mcpm_platform_ops tc2_pm_power_ops = {
 	.power_up	= tc2_pm_power_up,
 	.power_down	= tc2_pm_power_down,
+	.suspend	= tc2_pm_suspend,
 	.powered_up	= tc2_pm_powered_up,
 };
 
-- 
1.8.1.2
