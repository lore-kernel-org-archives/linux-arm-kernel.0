From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2011 10:35:57 +0100
Subject: [PATCH 4/4] ARM: pmu: add platform_device_id table support
In-Reply-To: <4DEFA5E1.9010600@gmail.com>
References: <4DEFA5E1.9010600@gmail.com>
Message-ID: <1307957757-23001-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for platform_device_id tables, allowing new
PMU types to be registered with the correct type, without requiring
new platform_driver shims to provide the type.

Macros matching functionality of the of_device_id table macros are
provided for convenience.

Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/pmu.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index d34cf88..23c3af2 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -62,9 +62,22 @@ static struct of_device_id armpmu_of_device_ids[] = {
 	{},
 };
 
+#define PLAT_MATCH_PMU(name, type) {	\
+	.name = name,		\
+	.driver_data = (void *) type,	\
+}
+
+#define PLAT_MATCH_CPU(name)	PLAT_MATCH_PMU(name, ARM_PMU_DEVICE_CPU)
+
+static struct platform_device_id armpmu_plat_device_ids[] = {
+	/* None for now */
+	{},
+};
+
 enum arm_pmu_type armpmu_device_type(struct platform_device *pdev)
 {
 	const struct of_device_id	*of_id;
+	const struct platform_device_id *pdev_id;
 
 	/* provided by of_device_id table */
 	if (pdev->dev.of_node) {
@@ -73,6 +86,11 @@ enum arm_pmu_type armpmu_device_type(struct platform_device *pdev)
 		return (enum arm_pmu_type) of_id->data;
 	}
 
+	/* Provided by platform_device_id table */
+	if ((pdev_id = platform_get_device_id(pdev))) {
+		return (enum arm_pmu_type) pdev_id->driver_data;
+	}
+
 	/* Provided by a 'legacy' platform_device */
 	return ARM_PMU_DEVICE_CPU;
 }
@@ -88,6 +106,7 @@ static struct platform_driver armpmu_driver = {
 		.of_match_table = armpmu_of_device_ids,
 	},
 	.probe		= armpmu_device_probe,
+	.id_table	= armpmu_plat_device_ids,
 };
 
 static int __init register_pmu_driver(void)
-- 
1.7.0.4
