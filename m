From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2011 10:35:56 +0100
Subject: [PATCH 3/4] ARM: pmu: add OF probing support
In-Reply-To: <4DEFA5E1.9010600@gmail.com>
References: <4DEFA5E1.9010600@gmail.com>
Message-ID: <1307957757-23001-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is based on an earlier patch from Rob Herring <rob.herring@calxeda.com>

> Add OF match table to enable OF style driver binding. The dts entry is like
> this:
>
> pmu {
> 	compatible = "arm,cortex-a9-pmu";
> 	interrupts = <100 101>;
> };
>
> The use of pdev->id as an index breaks with OF device binding, so set the type
> based on the OF compatible string.

This modification sets the PMU hardware type based on data embedded in the
binding, allowing easy addition of new PMU types in future.

Support for new PMU types not provided by devicetree can be added later using
platform_device_id tables in a similar fashion.

Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 
 Rob: would you be happy to merge this into your tree? or would you
 rather I sent it through Russell?

 Documentation/devicetree/bindings/arm/pmu.txt |   22 +++++++++++++++
 arch/arm/kernel/pmu.c                         |   35 ++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
new file mode 100644
index 0000000..739d00c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -0,0 +1,22 @@
+* ARM Performance Monitor Units
+
+ARM cores often have a PMU for counting cpu and cache events like cache misses
+and hits. The interface to the PMU is part of the ARM ARM. The ARM PMU
+representation in the device tree should be done as under:-
+
+Required properties:
+
+- compatible : should be one of
+	"arm,cortex-a9-pmu"
+	"arm,cortex-a8-pmu"
+	"arm,arm1176-pmu"
+	"arm,arm1136-pmu"
+- interrupts : 1 combined interrupt or 1 per core.
+
+Example:
+
+pmu {
+        compatible = "arm,cortex-a9-pmu";
+        interrupts = <100 101>;
+};
+
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index de6b1b0..d34cf88 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include <asm/pmu.h>
@@ -45,14 +46,46 @@ static int __devinit pmu_register(struct platform_device *pdev,
 	return 0;
 }
 
+#define OF_MATCH_PMU(name, type) {	\
+	.compatible = name,		\
+	.data = (void *) type,	\
+}
+
+#define OF_MATCH_CPU(name)	OF_MATCH_PMU(name, ARM_PMU_DEVICE_CPU)
+
+static struct of_device_id armpmu_of_device_ids[] = {
+	/* None for now. */
+	OF_MATCH_CPU("arm,cortex-a9-pmu"),
+	OF_MATCH_CPU("arm,cortex-a8-pmu"),
+	OF_MATCH_CPU("arm,arm1136-pmu"),
+	OF_MATCH_CPU("arm,arm1176-pmu"),
+	{},
+};
+
+enum arm_pmu_type armpmu_device_type(struct platform_device *pdev)
+{
+	const struct of_device_id	*of_id;
+
+	/* provided by of_device_id table */
+	if (pdev->dev.of_node) {
+		of_id = of_match_device(armpmu_of_device_ids, &pdev->dev);
+		BUG_ON(!of_id);
+		return (enum arm_pmu_type) of_id->data;
+	}
+
+	/* Provided by a 'legacy' platform_device */
+	return ARM_PMU_DEVICE_CPU;
+}
+
 static int __devinit armpmu_device_probe(struct platform_device *pdev)
 {
-	return pmu_register(pdev, ARM_PMU_DEVICE_CPU);
+	return pmu_register(pdev, armpmu_device_type(pdev));
 }
 
 static struct platform_driver armpmu_driver = {
 	.driver		= {
 		.name	= "arm-pmu",
+		.of_match_table = armpmu_of_device_ids,
 	},
 	.probe		= armpmu_device_probe,
 };
-- 
1.7.0.4
