From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Feb 2011 12:11:39 +0000
Subject: [PATCH] ARM: pmu: avoid setting IRQ affinity on UP systems
Message-ID: <1297771899-23209-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can execute a CONFIG_SMP kernel on a uniprocessor system,
extra care has to be taken in the PMU IRQ affinity setting code to
ensure that we don't always fail to initialise.

This patch changes the CPU PMU initialisation code so that when we
only have a single IRQ, whose affinity can not be changed at the
controller, we report success (0) rather than -EINVAL.

Cc: Jamie Iles <jamie@jamieiles.com>
Reported-by: Avik Sil <avik.sil@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/pmu.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index b8af96e..2b65d10 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -97,22 +97,29 @@ set_irq_affinity(int irq,
 			   irq, cpu);
 	return err;
 #else
-	return 0;
+	return -EINVAL;
 #endif
 }
 
 static int
 init_cpu_pmu(void)
 {
-	int i, err = 0;
+	int i, irqs, err = 0;
 	struct platform_device *pdev = pmu_devices[ARM_PMU_DEVICE_CPU];
 
-	if (!pdev) {
-		err = -ENODEV;
-		goto out;
-	}
+	if (!pdev)
+		return -ENODEV;
+
+	irqs = pdev->num_resources;
+
+	/*
+	 * If we have a single PMU interrupt that we can't shift, assume that
+	 * we're running on a uniprocessor machine and continue.
+	 */
+	if (irqs == 1 && !irq_can_set_affinity(platform_get_irq(pdev, 0)))
+		return 0;
 
-	for (i = 0; i < pdev->num_resources; ++i) {
+	for (i = 0; i < irqs; ++i) {
 		err = set_irq_affinity(platform_get_irq(pdev, i), i);
 		if (err)
 			break;
-- 
1.7.0.4
