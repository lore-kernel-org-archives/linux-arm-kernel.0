From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 11 Jul 2018 13:40:19 -0600
Subject: [PATCH 09/25] dts: bindings: Restrict coresight tmc-etr
 scatter-gather mode
In-Reply-To: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1531338035-11729-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We are about to add the support for ETR builtin scatter-gather mode
for dealing with large amount of trace buffers. However, on some of
the platforms, using the ETR SG mode can lock up the system due to
the way the ETR is connected to the memory subsystem.

In SG mode, the ETR performs READ from the scatter-gather table to
fetch the next page and regular WRITE of trace data. If the READ
operation doesn't complete(due to the memory subsystem issues,
which we have seen on a couple of platforms) the trace WRITE
cannot proceed leading to issues. So, we by default do not
use the SG mode, unless it is known to be safe on the platform.
We define a DT property for the TMC node to specify whether we
have a proper SG mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: John Horley <john.horley@arm.com>
Cc: Robert Walker <robert.walker@arm.com>
Cc: devicetree at vger.kernel.org
Cc: frowand.list at gmail.com
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
 drivers/hwtracing/coresight/coresight-tmc.c         | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 15ac8e8dcfdf..603d3c62e8c7 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -86,6 +86,8 @@ its hardware characteristcs.
 	* arm,buffer-size: size of contiguous buffer space for TMC ETR
 	 (embedded trace router)
 
+	* arm,scatter-gather: boolean. Indicates that the TMC-ETR can safely
+	  use the SG mode on this system.
 
 Example:
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index bb57e7f57eb5..bc8fc860c473 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/property.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
@@ -296,6 +297,12 @@ const struct attribute_group *coresight_tmc_groups[] = {
 	NULL,
 };
 
+static inline bool tmc_etr_can_use_sg(struct tmc_drvdata *drvdata)
+{
+	return fwnode_property_present(drvdata->dev->fwnode,
+				       "arm,scatter-gather");
+}
+
 /* Detect and initialise the capabilities of a TMC ETR */
 static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 			     u32 devid, void *dev_caps)
@@ -305,7 +312,7 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 	/* Set the unadvertised capabilities */
 	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
 
-	if (!(devid & TMC_DEVID_NOSCAT))
+	if (!(devid & TMC_DEVID_NOSCAT) && tmc_etr_can_use_sg(drvdata))
 		tmc_etr_set_cap(drvdata, TMC_ETR_SG);
 
 	/* Check if the AXI address width is available */
-- 
2.7.4
