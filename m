From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Aug 2011 13:58:58 +0100
Subject: [PATCH 2/2] ARM: perf: make name of arm_pmu_type consistent
In-Reply-To: <1312981138-17020-1-git-send-email-mark.rutland@arm.com>
References: <1312981138-17020-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1312981138-17020-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f12482c9 ("ARM: 6974/1: pmu: refactor reservation") changed
{release,reserve}_pmu to take an enum arm_pmu_type as a parameter, but
inconsistently named the parameter `type' or `device'. It would be nice
if these were consistent.

This patch makes use of enum arm_pmu_type consistent, always using
'device' as this is more common in usage.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h |    2 +-
 arch/arm/kernel/pmu.c      |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 8ae32ba..456117c 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -52,7 +52,7 @@ reserve_pmu(enum arm_pmu_type device);
  * a cookie.
  */
 extern int
-release_pmu(enum arm_pmu_type type);
+release_pmu(enum arm_pmu_type device);
 
 /**
  * init_pmu() - Initialise the PMU.
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index 2b70709..89cbdc5 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -27,22 +27,22 @@ static volatile long pmu_lock;
 static struct platform_device *pmu_devices[ARM_NUM_PMU_DEVICES];
 
 static int __devinit pmu_register(struct platform_device *pdev,
-					enum arm_pmu_type type)
+					enum arm_pmu_type device)
 {
-	if (type < 0 || type >= ARM_NUM_PMU_DEVICES) {
+	if (device < 0 || device >= ARM_NUM_PMU_DEVICES) {
 		pr_warning("received registration request for unknown "
-				"device %d\n", type);
+				"device %d\n", device);
 		return -EINVAL;
 	}
 
-	if (pmu_devices[type]) {
+	if (pmu_devices[device]) {
 		pr_warning("rejecting duplicate registration of PMU device "
-			"type %d.", type);
+			"type %d.", device);
 		return -ENOSPC;
 	}
 
-	pr_info("registered new PMU device of type %d\n", type);
-	pmu_devices[type] = pdev;
+	pr_info("registered new PMU device of type %d\n", device);
+	pmu_devices[device] = pdev;
 	return 0;
 }
 
-- 
1.7.0.4
