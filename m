From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 Dec 2011 16:46:59 +0000
Subject: [PATCH] ARM: perf: don't assign platform_device on unsupported CPUs
Message-ID: <1322844419-22949-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the unlikely case that a platform registers a PMU platform_device
when running on a CPU that is unsupported by perf, we will encounter a
NULL dereference when trying to assign the platform_device to the
cpu_pmu structure.

This patch checks that the CPU is supported by perf before assigning
the platform_device.

Reported-by: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index c475379..4e6d1ed 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -640,6 +640,9 @@ static struct platform_device_id armpmu_plat_device_ids[] = {
 
 static int __devinit armpmu_device_probe(struct platform_device *pdev)
 {
+	if (!cpu_pmu)
+		return -ENODEV;
+
 	cpu_pmu->plat_device = pdev;
 	return 0;
 }
-- 
1.7.4.1
