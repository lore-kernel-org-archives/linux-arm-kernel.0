From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jun 2011 15:40:03 +0100
Subject: [PATCHv2 3/4] ARM: pmu: add OF probing support
In-Reply-To: <1308148804-5518-1-git-send-email-mark.rutland@arm.com>
References: <1308148804-5518-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1308148804-5518-4-git-send-email-mark.rutland@arm.com>
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

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt |   22 ++++++++++++++++
 arch/arm/kernel/pmu.c                         |   34 ++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletions(-)
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
index de6b1b0..2ce00be 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include <asm/pmu.h>
@@ -45,14 +46,45 @@ static int __devinit pmu_register(struct platform_device *pdev,
 	return 0;
 }
 
+#define OF_MATCH_PMU(_name, _type) {	\
+	.compatible = _name,		\
+	.data = (void *)_type,		\
+}
+
+#define OF_MATCH_CPU(name)	OF_MATCH_PMU(name, ARM_PMU_DEVICE_CPU)
+
+static struct of_device_id armpmu_of_device_ids[] = {
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
+		return (enum arm_pmu_type)of_id->data;
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
