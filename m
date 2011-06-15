From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jun 2011 15:40:04 +0100
Subject: [PATCHv2 4/4] ARM: pmu: add platform_device_id table support
In-Reply-To: <1308148804-5518-1-git-send-email-mark.rutland@arm.com>
References: <1308148804-5518-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1308148804-5518-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for platform_device_id tables, allowing new
PMU types to be registered with the correct type, without requiring
new platform_driver shims to provide the type. An single entry for
existing devices is provided.

Macros matching functionality of the of_device_id table macros are
provided for convenience.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Jamie Iles <jamie@jamieiles.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/pmu.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index 2ce00be..2b70709 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -61,9 +61,22 @@ static struct of_device_id armpmu_of_device_ids[] = {
 	{},
 };
 
+#define PLAT_MATCH_PMU(_name, _type) {	\
+	.name		= _name,	\
+	.driver_data	= _type,	\
+}
+
+#define PLAT_MATCH_CPU(_name)	PLAT_MATCH_PMU(_name, ARM_PMU_DEVICE_CPU)
+
+static struct platform_device_id armpmu_plat_device_ids[] = {
+	PLAT_MATCH_CPU("arm-pmu"),
+	{},
+};
+
 enum arm_pmu_type armpmu_device_type(struct platform_device *pdev)
 {
 	const struct of_device_id	*of_id;
+	const struct platform_device_id *pdev_id;
 
 	/* provided by of_device_id table */
 	if (pdev->dev.of_node) {
@@ -72,8 +85,10 @@ enum arm_pmu_type armpmu_device_type(struct platform_device *pdev)
 		return (enum arm_pmu_type)of_id->data;
 	}
 
-	/* Provided by a 'legacy' platform_device */
-	return ARM_PMU_DEVICE_CPU;
+	/* Provided by platform_device_id table */
+	pdev_id = platform_get_device_id(pdev);
+	BUG_ON(!pdev_id);
+	return pdev_id->driver_data;
 }
 
 static int __devinit armpmu_device_probe(struct platform_device *pdev)
@@ -87,6 +102,7 @@ static struct platform_driver armpmu_driver = {
 		.of_match_table = armpmu_of_device_ids,
 	},
 	.probe		= armpmu_device_probe,
+	.id_table	= armpmu_plat_device_ids,
 };
 
 static int __init register_pmu_driver(void)
-- 
1.7.0.4
