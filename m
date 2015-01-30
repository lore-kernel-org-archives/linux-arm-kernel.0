From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 30 Jan 2015 15:54:26 -0700
Subject: [PATCH 2/2] coresight: Adding coresight support to arm64
In-Reply-To: <1422658466-23984-1-git-send-email-mathieu.poirier@linaro.org>
References: <1422658466-23984-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1422658466-23984-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Aside from tracers, all currently supported coresight IP blocks
are 64 bit ready.  As such add the required symbol definition to
compile the framework and drivers.

Also fixing a couple of warnings picked up by the 64bit compiler.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm64/Kconfig.debug            | 48 +++++++++++++++++++++++++++++++++++++
 drivers/coresight/coresight-etb10.c |  2 +-
 drivers/coresight/coresight-tmc.c   |  2 +-
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 5fdd6dce8061..77dfebbcbffe 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -66,4 +66,52 @@ config DEBUG_SET_MODULE_RONX
           against certain classes of kernel exploits.
           If in doubt, say "N".
 
+menuconfig CORESIGHT
+	bool "CoreSight Tracing Support"
+	select ARM_AMBA
+	help
+	  This framework provides a kernel interface for the CoreSight debug
+	  and trace drivers to register themselves with. It's intended to build
+	  a topological view of the CoreSight components based on a DT
+	  specification and configure the right serie of components when a
+	  trace source gets enabled.
+
+if CORESIGHT
+config CORESIGHT_LINKS_AND_SINKS
+	bool "CoreSight Link and Sink drivers"
+	help
+	  This enables support for CoreSight link and sink drivers that are
+	  responsible for transporting and collecting the trace data
+	  respectively.  Link and sinks are dynamically aggregated with a trace
+	  entity at run time to form a complete trace path.
+
+config CORESIGHT_LINK_AND_SINK_TMC
+	bool "Coresight generic TMC driver"
+	depends on CORESIGHT_LINKS_AND_SINKS
+	help
+	  This enables support for the Trace Memory Controller driver.
+	  Depending on its configuration the device can act as a link (embedded
+	  trace router - ETR) or sink (embedded trace FIFO).  The driver
+	  complies with the generic implementation of the component without
+	  special enhancement or added features.
+
+config CORESIGHT_SINK_TPIU
+	bool "Coresight generic TPIU driver"
+	depends on CORESIGHT_LINKS_AND_SINKS
+	help
+	  This enables support for the Trace Port Interface Unit driver,
+	  responsible for bridging the gap between the on-chip coresight
+	  components and a trace for bridging the gap between the on-chip
+	  coresight components and a trace port collection engine, typically
+	  connected to an external host for use case capturing more traces than
+	  the on-board coresight memory can handle.
+
+config CORESIGHT_SINK_ETBV10
+	bool "Coresight ETBv1.0 driver"
+	depends on CORESIGHT_LINKS_AND_SINKS
+	help
+	  This enables support for the Embedded Trace Buffer version 1.0 driver
+	  that complies with the generic implementation of the component without
+	  special enhancement or added features.
+endif
 endmenu
diff --git a/drivers/coresight/coresight-etb10.c b/drivers/coresight/coresight-etb10.c
index c9acd406f0d0..aa47d31fe2a2 100644
--- a/drivers/coresight/coresight-etb10.c
+++ b/drivers/coresight/coresight-etb10.c
@@ -314,7 +314,7 @@ static ssize_t etb_read(struct file *file, char __user *data,
 	*ppos += len;
 
 	dev_dbg(drvdata->dev, "%s: %d bytes copied, %d bytes left\n",
-		__func__, len, (int) (depth * 4 - *ppos));
+		__func__, (int)len, (int)(depth * 4 - *ppos));
 	return len;
 }
 
diff --git a/drivers/coresight/coresight-tmc.c b/drivers/coresight/coresight-tmc.c
index 3ff232f9ddf7..d08460327bd2 100644
--- a/drivers/coresight/coresight-tmc.c
+++ b/drivers/coresight/coresight-tmc.c
@@ -534,7 +534,7 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 	*ppos += len;
 
 	dev_dbg(drvdata->dev, "%s: %d bytes copied, %d bytes left\n",
-		__func__, len, (int) (drvdata->size - *ppos));
+		__func__, (int)len, (int)(drvdata->size - *ppos));
 	return len;
 }
 
-- 
1.9.1
