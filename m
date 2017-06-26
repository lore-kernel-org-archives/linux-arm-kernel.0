From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 26 Jun 2017 16:22:45 +0100
Subject: [PATCH v2 01/12] coresight replicator: Cleanup programmable
 replicator naming
In-Reply-To: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
References: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1498490576-1350-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linux coresight drivers define the programmable ATB replicator as
Qualcom replicator, while this is designed by ARM. This can cause confusion
to a user selecting the driver. Cleanup all references to make it
 explicitly clear. This patch :

 1) Replace the compatible string for the replicator :
	qcom,coresight-replicator1x => arm,coresight-dynamic-replicator
 2) Changes the Kconfig symbol (since this is not part of any defconfigs)
	 CORESIGHT_QCOM_REPLICATOR => CORESIGHT_DYNAMIC_REPLICATOR
 3) Improves the help message in the Kconfig.
 4) Changes the name of the driver and the file :
	coresight-replicator-qcom => coresight-dynamic-replicator

Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V1:
 - Since the driver doesn't use the compatible string, change the
   recommended compatible string.
 - Rename the driver file to coresight-dynamic-replicator.c
---
 Documentation/devicetree/bindings/arm/coresight.txt            |  4 ++--
 drivers/hwtracing/coresight/Kconfig                            | 10 +++++-----
 drivers/hwtracing/coresight/Makefile                           |  2 +-
 ...esight-replicator-qcom.c => coresight-dynamic-replicator.c} |  5 ++---
 4 files changed, 10 insertions(+), 11 deletions(-)
 rename drivers/hwtracing/coresight/{coresight-replicator-qcom.c => coresight-dynamic-replicator.c} (97%)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index fcbae6a..15ac8e8 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -34,8 +34,8 @@ its hardware characteristcs.
 		- Embedded Trace Macrocell (version 4.x):
 			"arm,coresight-etm4x", "arm,primecell";
 
-		- Qualcomm Configurable Replicator (version 1.x):
-			"qcom,coresight-replicator1x", "arm,primecell";
+		- Coresight programmable Replicator :
+			"arm,coresight-dynamic-replicator", "arm,primecell";
 
 		- System Trace Macrocell:
 			"arm,coresight-stm", "arm,primecell"; [1]
diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 8d55d6d..ef9cb3c 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -70,13 +70,13 @@ config CORESIGHT_SOURCE_ETM4X
 	  for instruction level tracing. Depending on the implemented version
 	  data tracing may also be available.
 
-config CORESIGHT_QCOM_REPLICATOR
-	bool "Qualcomm CoreSight Replicator driver"
+config CORESIGHT_DYNAMIC_REPLICATOR
+	bool "CoreSight Programmable Replicator driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
-	  This enables support for Qualcomm CoreSight link driver. The
-	  programmable ATB replicator sends the ATB trace stream from the
-	  ETB/ETF to the TPIUi and ETR.
+	  This enables support for dynamic CoreSight replicator link driver.
+	  The programmable ATB replicator allows independent filtering of the
+	  trace data based on the traceid.
 
 config CORESIGHT_STM
 	bool "CoreSight System Trace Macrocell driver"
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 433d590..5bae90ce 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -14,6 +14,6 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
 					coresight-etm3x-sysfs.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
 					coresight-etm4x-sysfs.o
-obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
+obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
similarity index 97%
rename from drivers/hwtracing/coresight/coresight-replicator-qcom.c
rename to drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 0a3d15f..1675031 100644
--- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -143,7 +143,7 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "initialized\n");
 	return 0;
 }
 
@@ -179,14 +179,13 @@ static struct amba_id replicator_ids[] = {
 	{
 		.id     = 0x0003b909,
 		.mask   = 0x0003ffff,
-		.data	= "REPLICATOR 1.0",
 	},
 	{ 0, 0 },
 };
 
 static struct amba_driver replicator_driver = {
 	.drv = {
-		.name	= "coresight-replicator-qcom",
+		.name	= "coresight-dynamic-replicator",
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
-- 
2.7.5
