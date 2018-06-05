From: kim.phillips@arm.com (Kim Phillips)
Date: Tue,  5 Jun 2018 16:07:03 -0500
Subject: [PATCH v4 07/14] coresight: allow dynamic-replicator to be built as a
 module
In-Reply-To: <20180605210710.22227-1-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
Message-ID: <20180605210710.22227-8-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow to build coresight-dynamic-replicator as a module,
for ease of development.

- Kconfig becomes a tristate, to allow =m
- add a replicator_remove function, for module unload
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
 drivers/hwtracing/coresight/Kconfig           |  5 ++++-
 .../coresight/coresight-dynamic-replicator.c  | 19 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 8c5e5407b7dd..945b17ca2eed 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -71,13 +71,16 @@ config CORESIGHT_SOURCE_ETM4X
 	  data tracing may also be available.
 
 config CORESIGHT_DYNAMIC_REPLICATOR
-	bool "CoreSight Programmable Replicator driver"
+	tristate "CoreSight Programmable Replicator driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for dynamic CoreSight replicator link driver.
 	  The programmable ATB replicator allows independent filtering of the
 	  trace data based on the traceid.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-dynamic-replicator.
+
 config CORESIGHT_STM
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
 	tristate "CoreSight System Trace Macrocell driver"
diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index f6d0571ab9dd..b59055097436 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -159,6 +159,15 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	return PTR_ERR_OR_ZERO(drvdata->csdev);
 }
 
+static int __exit replicator_remove(struct amba_device *adev)
+{
+	struct replicator_state *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int replicator_runtime_suspend(struct device *dev)
 {
@@ -200,13 +209,21 @@ static const struct amba_id replicator_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, replicator_ids);
+
 static struct amba_driver replicator_driver = {
 	.drv = {
 		.name	= "coresight-dynamic-replicator",
+		.owner	= THIS_MODULE,
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 	.probe		= replicator_probe,
+	.remove         = replicator_remove,
 	.id_table	= replicator_ids,
 };
-builtin_amba_driver(replicator_driver);
+module_amba_driver(replicator_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight Dynamic Replicator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
