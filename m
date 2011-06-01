From: robherring2@gmail.com (Rob Herring)
Date: Wed,  1 Jun 2011 11:37:48 -0500
Subject: [PATCH 1/3] ARM: pmu: add OF probing support
In-Reply-To: <1306946270-18379-1-git-send-email-robherring2@gmail.com>
References: <1306946270-18379-1-git-send-email-robherring2@gmail.com>
Message-ID: <1306946270-18379-2-git-send-email-robherring2@gmail.com>
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
 arch/arm/kernel/pmu.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

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
