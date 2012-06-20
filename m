From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:42 +0100
Subject: [PATCH 06/15] mfd: Register the ab8500 from db8500-prcmu using the
 MFD API
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hierarchically, the AB8500 is a child of the DB8500 PRCMU. So now that
Device Tree is being used and MFD core code is Device Tree aware, we
can simply register DB8500 PRCMU from Device Tree in the normal way
then allow the DB8500 PRCMU driver to register the AB8500 as a simple
MFD device at probe time.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    2 --
 drivers/mfd/ab8500-core.c          |   12 ------------
 drivers/mfd/db8500-prcmu.c         |   15 +++++++++++++++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 7e5b161..0bae853 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -820,8 +820,6 @@ static const struct of_device_id u8500_local_bus_nodes[] = {
 	/* only create devices below soc node */
 	{ .compatible = "stericsson,db8500", },
 	{ .compatible = "stericsson,db8500-prcmu", },
-	{ .compatible = "stericsson,db8500-prcmu-regulator", },
-	{ .compatible = "stericsson,ab8500", },
 	{ .compatible = "simple-bus"},
 	{ },
 };
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 79d7672..738b9c5 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1247,14 +1247,6 @@ static struct attribute_group ab9540_attr_group = {
 	.attrs	= ab9540_sysfs_entries,
 };
 
-static const struct of_device_id ab8500_match[] = {
-	{
-		.compatible = "stericsson,ab8500",
-		.data = (void *)AB8500_VERSION_AB8500,
-	},
-	{},
-};
-
 static int __devinit ab8500_probe(struct platform_device *pdev)
 {
 	struct ab8500_platform_data *plat = dev_get_platdata(&pdev->dev);
@@ -1296,9 +1288,6 @@ static int __devinit ab8500_probe(struct platform_device *pdev)
 
 	if (platid)
 		version = platid->driver_data;
-	else if (np)
-		version = (unsigned int)
-			of_match_device(ab8500_match, &pdev->dev)->data;
 
 	if (version != AB8500_VERSION_UNDEFINED)
 		ab8500->version = version;
@@ -1492,7 +1481,6 @@ static struct platform_driver ab8500_core_driver = {
 	.driver = {
 		.name = "ab8500-core",
 		.owner = THIS_MODULE,
-		.of_match_table = ab8500_match,
 	},
 	.probe	= ab8500_probe,
 	.remove	= __devexit_p(ab8500_remove),
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index e9e576c..80def6c 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2945,6 +2945,14 @@ static struct regulator_init_data db8500_regulators[DB8500_NUM_REGULATORS] = {
 	},
 };
 
+static struct resource ab8500_resources[] = {
+	[0] = {
+		.start	= IRQ_DB8500_AB8500,
+		.end	= IRQ_DB8500_AB8500,
+		.flags	= IORESOURCE_IRQ
+	}
+};
+
 static struct mfd_cell db8500_prcmu_devs[] = {
 	{
 		.name = "db8500-prcmu-regulators",
@@ -2956,6 +2964,13 @@ static struct mfd_cell db8500_prcmu_devs[] = {
 		.name = "cpufreq-u8500",
 		.of_compatible = "stericsson,cpufreq-u8500",
 	},
+	{
+		.name = "ab8500-core",
+		.of_compatible = "stericsson,ab8500",
+		.num_resources = ARRAY_SIZE(ab8500_resources),
+		.resources = ab8500_resources,
+		.id = AB8500_VERSION_AB8500,
+	},
 };
 
 /**
-- 
1.7.9.5
