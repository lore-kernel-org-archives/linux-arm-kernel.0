From: kim.phillips@arm.com (Kim Phillips)
Date: Tue,  5 Jun 2018 16:07:07 -0500
Subject: [PATCH v4 11/14] coresight: allow tpiu to be built as a module
In-Reply-To: <20180605210710.22227-1-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
Message-ID: <20180605210710.22227-12-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow to build coresight-tpiu as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- add a tpiu_remove function, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/Kconfig          |  5 ++++-
 drivers/hwtracing/coresight/coresight-tpiu.c | 19 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 3c3256425a7f..2f44adb82361 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -32,7 +32,7 @@ config CORESIGHT_LINK_AND_SINK_TMC
 	  special enhancement or added features.
 
 config CORESIGHT_SINK_TPIU
-	bool "Coresight generic TPIU driver"
+	tristate "Coresight generic TPIU driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Trace Port Interface Unit driver,
@@ -42,6 +42,9 @@ config CORESIGHT_SINK_TPIU
 	  connected to an external host for use case capturing more traces than
 	  the on-board coresight memory can handle.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-tpiu.
+
 config CORESIGHT_SINK_ETBV10
 	tristate "Coresight ETBv1.0 driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 01b7457fe8fc..ab53ce1a9ce3 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -164,6 +164,15 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	return PTR_ERR_OR_ZERO(drvdata->csdev);
 }
 
+static int __exit tpiu_remove(struct amba_device *adev)
+{
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int tpiu_runtime_suspend(struct device *dev)
 {
@@ -207,6 +216,8 @@ static const struct amba_id tpiu_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, tpiu_ids);
+
 static struct amba_driver tpiu_driver = {
 	.drv = {
 		.name	= "coresight-tpiu",
@@ -215,6 +226,12 @@ static struct amba_driver tpiu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= tpiu_probe,
+	.remove         = tpiu_remove,
 	.id_table	= tpiu_ids,
 };
-builtin_amba_driver(tpiu_driver);
+module_amba_driver(tpiu_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight TPIU (Trace Port Interface Unit) driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
