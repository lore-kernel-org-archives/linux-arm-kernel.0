From: robherring2@gmail.com (Rob Herring)
Date: Tue,  7 Jun 2011 09:22:19 -0500
Subject: [PATCH 1/3] ARM: pmu: add OF probing support
In-Reply-To: <1307456541-11026-1-git-send-email-robherring2@gmail.com>
References: <1307456541-11026-1-git-send-email-robherring2@gmail.com>
Message-ID: <1307456541-11026-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add OF match table to enable OF style driver binding. The dts entry is like
this:

pmu {
	compatible = "arm,cortex-a9-pmu";
	interrupts = <100 101>;
};

The use of pdev->id as an index breaks with OF device binding, so set the type
based on the OF compatible string.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt |   22 ++++++++++++++++++++++
 arch/arm/kernel/pmu.c                         |   23 ++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)
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
index 2c79eec..41bc972 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -27,27 +27,40 @@ static struct platform_device *pmu_devices[ARM_NUM_PMU_DEVICES];
 
 static int __devinit pmu_device_probe(struct platform_device *pdev)
 {
+	enum arm_pmu_type type = pdev->id;
 
-	if (pdev->id < 0 || pdev->id >= ARM_NUM_PMU_DEVICES) {
+	if (pdev->dev.of_node)
+		type = ARM_PMU_DEVICE_CPU;
+
+	if (type < 0 || type >= ARM_NUM_PMU_DEVICES) {
 		pr_warning("received registration request for unknown "
 				"device %d\n", pdev->id);
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
 
+static struct of_device_id pmu_device_ids[] = {
+	{ .compatible = "arm,cortex-a9-pmu" },
+	{ .compatible = "arm,cortex-a8-pmu" },
+	{ .compatible = "arm,arm1136-pmu" },
+	{ .compatible = "arm,arm1176-pmu" },
+	{},
+};
+
 static struct platform_driver pmu_driver = {
 	.driver		= {
 		.name	= "arm-pmu",
+		.of_match_table = pmu_device_ids,
 	},
 	.probe		= pmu_device_probe,
 };
-- 
1.7.4.1
