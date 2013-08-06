From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  6 Aug 2013 19:54:24 +0100
Subject: [PATCH 5/5] ARM: vexpress/TC2: implement PM suspend method
In-Reply-To: <1375815264-29414-1-git-send-email-pawel.moll@arm.com>
References: <1375815264-29414-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1375815264-29414-6-git-send-email-pawel.moll@arm.com>
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
index 1d4de8e..79cf4bc 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -85,7 +85,7 @@ static int tc2_pm_power_up(unsigned int cpu, unsigned int cluster)
 	return 0;
 }
 
-static void tc2_pm_power_down(void)
+static void tc2_pm_down(u64 residency)
 {
 	unsigned int mpidr, cpu, cluster;
 	bool last_man = false, skip_wfi = false;
@@ -199,6 +199,22 @@ static void tc2_pm_power_down(void)
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
@@ -232,6 +248,7 @@ static void tc2_pm_powered_up(void)
 static const struct mcpm_platform_ops tc2_pm_power_ops = {
 	.power_up	= tc2_pm_power_up,
 	.power_down	= tc2_pm_power_down,
+	.suspend	= tc2_pm_suspend,
 	.powered_up	= tc2_pm_powered_up,
 };
 
-- 
1.8.1.2
