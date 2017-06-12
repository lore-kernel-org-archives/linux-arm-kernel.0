From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 12 Jun 2017 15:36:40 +0100
Subject: [PATCH 01/12] coresight replicator: Cleanup programmable replicator
 naming
In-Reply-To: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1497278211-5001-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linux coresight drivers define the programmable ATB replicator as
Qualcom replicator, while this is designed by ARM. This can cause confusion
to a user selecting the driver. Cleanup all references to make it
 explicitly clear. This patch :

 1) Adds a new compatible string for the same, retaining the old one for
    compatibility.
 2) Changes the Kconfig symbol (since this is not part of any defconfigs)
	 CORESIGHT_QCOM_REPLICATOR => CORESIGHT_DYNAMIC_REPLICATOR
 3) Improves the help message in the Kconfig.
 4) Changes the name of the driver :
	coresight-replicator-qcom => coresight-dynamic-replicator

Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/devicetree/bindings/arm/coresight.txt     |  4 +++-
 drivers/hwtracing/coresight/Kconfig                     | 10 +++++-----
 drivers/hwtracing/coresight/Makefile                    |  2 +-
 drivers/hwtracing/coresight/coresight-replicator-qcom.c |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index fcbae6a..f77329f 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -34,7 +34,9 @@ its hardware characteristcs.
 		- Embedded Trace Macrocell (version 4.x):
 			"arm,coresight-etm4x", "arm,primecell";
 
-		- Qualcomm Configurable Replicator (version 1.x):
+		- Coresight programmable Replicator (version 1.x):
+			"arm,coresight-dynamic-replicator", "arm,primecell";
+				OR
 			"qcom,coresight-replicator1x", "arm,primecell";
 
 		- System Trace Macrocell:
diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 8d55d6d..e50ea56 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -70,13 +70,13 @@ config CORESIGHT_SOURCE_ETM4X
 	  for instruction level tracing. Depending on the implemented version
 	  data tracing may also be available.
 
-config CORESIGHT_QCOM_REPLICATOR
-	bool "Qualcomm CoreSight Replicator driver"
+config CORESIGHT_DYNAMIC_REPLICATOR
+	bool "Programmable CoreSight Replicator driver"
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
index 433d590..c7638d4 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -14,6 +14,6 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
 					coresight-etm3x-sysfs.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
 					coresight-etm4x-sysfs.o
-obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
+obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-replicator-qcom.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
index 0a3d15f..b7e44d1 100644
--- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
+++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
@@ -186,7 +186,7 @@ static struct amba_id replicator_ids[] = {
 
 static struct amba_driver replicator_driver = {
 	.drv = {
-		.name	= "coresight-replicator-qcom",
+		.name	= "coresight-dynamic-replicator",
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
-- 
2.7.4
