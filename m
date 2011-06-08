From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  8 Jun 2011 16:28:30 +0100
Subject: [PATCH 1/2] ARM: pmu: refactor reservation
In-Reply-To: <1307546911-2714-1-git-send-email-mark.rutland@arm.com>
References: <1307546911-2714-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1307546911-2714-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, PMU platform_device reservation relies on some minor abuse
of the platform_device::id field for determining the type of PMU. This
is problematic for device tree based probing, where the ID cannot be
controlled.

This patch removes reliance on the id field, and depends on each PMU's
platform driver to figure out which type it is. As all PMUs handled by
the current platform_driver name "arm-pmu" are CPU PMUs, this
convention is hardcoded. New PMU types will require the addition of new
platform drivers (e.g. "arm-pmu-l2cc").

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 arch/arm/include/asm/pmu.h   |    2 +-
 arch/arm/kernel/perf_event.c |    4 ++--
 arch/arm/kernel/pmu.c        |   33 +++++++++++++++++++--------------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 7544ce6..67c70a3 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -52,7 +52,7 @@ reserve_pmu(enum arm_pmu_type device);
  * a cookie.
  */
 extern int
-release_pmu(struct platform_device *pdev);
+release_pmu(enum arm_pmu_type type);
 
 /**
  * init_pmu() - Initialise the PMU.
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index d53c0ab..a6c643f 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -435,7 +435,7 @@ armpmu_reserve_hardware(void)
 			if (irq >= 0)
 				free_irq(irq, NULL);
 		}
-		release_pmu(pmu_device);
+		release_pmu(ARM_PMU_DEVICE_CPU);
 		pmu_device = NULL;
 	}
 
@@ -454,7 +454,7 @@ armpmu_release_hardware(void)
 	}
 	armpmu->stop();
 
-	release_pmu(pmu_device);
+	release_pmu(ARM_PMU_DEVICE_CPU);
 	pmu_device = NULL;
 }
 
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index 2c79eec..87942b9 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -25,36 +25,41 @@ static volatile long pmu_lock;
 
 static struct platform_device *pmu_devices[ARM_NUM_PMU_DEVICES];
 
-static int __devinit pmu_device_probe(struct platform_device *pdev)
+static int __devinit pmu_register(struct platform_device *pdev,
+					enum arm_pmu_type type)
 {
-
-	if (pdev->id < 0 || pdev->id >= ARM_NUM_PMU_DEVICES) {
+	if (type < 0 || type >= ARM_NUM_PMU_DEVICES) {
 		pr_warning("received registration request for unknown "
-				"device %d\n", pdev->id);
+				"device %d\n", type);
 		return -EINVAL;
 	}
 
-	if (pmu_devices[pdev->id])
+	if (pmu_devices[type])
 		pr_warning("registering new PMU device type %d overwrites "
-				"previous registration!\n", pdev->id);
+				"previous registration!\n", type);
 	else
 		pr_info("registered new PMU device of type %d\n",
-				pdev->id);
+				type);
 
-	pmu_devices[pdev->id] = pdev;
+	pmu_devices[type] = pdev;
 	return 0;
 }
 
-static struct platform_driver pmu_driver = {
+static int __devinit armpmu_device_probe(struct platform_device *pdev)
+{
+	return pmu_register(pdev, ARM_PMU_DEVICE_CPU);
+}
+
+static struct platform_driver armpmu_driver = {
 	.driver		= {
 		.name	= "arm-pmu",
 	},
-	.probe		= pmu_device_probe,
+	.probe		= armpmu_device_probe,
 };
 
 static int __init register_pmu_driver(void)
 {
-	return platform_driver_register(&pmu_driver);
+	return platform_driver_register(&armpmu_driver);
 }
 device_initcall(register_pmu_driver);
 
@@ -77,11 +82,11 @@ reserve_pmu(enum arm_pmu_type device)
 EXPORT_SYMBOL_GPL(reserve_pmu);
 
 int
-release_pmu(struct platform_device *pdev)
+release_pmu(enum arm_pmu_type device)
 {
-	if (WARN_ON(pdev != pmu_devices[pdev->id]))
+	if (WARN_ON(!pmu_devices[device]))
 		return -EINVAL;
-	clear_bit_unlock(pdev->id, &pmu_lock);
+	clear_bit_unlock(device, &pmu_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(release_pmu);
-- 
1.7.0.4
