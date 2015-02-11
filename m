From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Tue, 10 Feb 2015 21:31:24 -0700
Subject: [PATCH v3 1/2] coresight: Adding coresight support for arm64
 architecture
Message-ID: <1423629085-1044-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Most CoreSight blocks are 64-bit ready.  As such move configuration
entries from "arch/arm/Kconfig.config" to the driver's subdirectory
and source the newly created Kconfig from architecture specific
Kconfig.debug files.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
Change for v3:
  - Separating Kconfig work from compilation warnings fixes.
---
 arch/arm/Kconfig.debug    | 55 +-----------------------------------------
 arch/arm64/Kconfig.debug  |  2 ++
 drivers/coresight/Kconfig | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 54 deletions(-)
 create mode 100644 drivers/coresight/Kconfig

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5ddd4906f7a7..4fdbb0c012e6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1478,59 +1478,6 @@ config DEBUG_SET_MODULE_RONX
 	  against certain classes of kernel exploits.
 	  If in doubt, say "N".
 
-menuconfig CORESIGHT
-	bool "CoreSight Tracing Support"
-	select ARM_AMBA
-	help
-	  This framework provides a kernel interface for the CoreSight debug
-	  and trace drivers to register themselves with. It's intended to build
-	  a topological view of the CoreSight components based on a DT
-	  specification and configure the right serie of components when a
-	  trace source gets enabled.
-
-if CORESIGHT
-config CORESIGHT_LINKS_AND_SINKS
-	bool "CoreSight Link and Sink drivers"
-	help
-	  This enables support for CoreSight link and sink drivers that are
-	  responsible for transporting and collecting the trace data
-	  respectively.  Link and sinks are dynamically aggregated with a trace
-	  entity at run time to form a complete trace path.
-
-config CORESIGHT_LINK_AND_SINK_TMC
-	bool "Coresight generic TMC driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
-	help
-	  This enables support for the Trace Memory Controller driver.  Depending
-	  on its configuration the device can act as a link (embedded trace router
-	  - ETR) or sink (embedded trace FIFO).  The driver complies with the
-	  generic implementation of the component without special enhancement or
-	  added features.
-
-config CORESIGHT_SINK_TPIU
-	bool "Coresight generic TPIU driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
-	help
-	  This enables support for the Trace Port Interface Unit driver, responsible
-	  for bridging the gap between the on-chip coresight components and a trace
-	  port collection engine, typically connected to an external host for use
-	  case capturing more traces than the on-board coresight memory can handle.
-
-config CORESIGHT_SINK_ETBV10
-	bool "Coresight ETBv1.0 driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
-	help
-	  This enables support for the Embedded Trace Buffer version 1.0 driver
-	  that complies with the generic implementation of the component without
-	  special enhancement or added features.
+source "drivers/coresight/Kconfig"
 
-config CORESIGHT_SOURCE_ETM3X
-	bool "CoreSight Embedded Trace Macrocell 3.x driver"
-	select CORESIGHT_LINKS_AND_SINKS
-	help
-	  This driver provides support for processor ETM3.x and PTM1.x modules,
-	  which allows tracing the instructions that a processor is executing
-	  This is primarily useful for instruction level tracing.  Depending
-	  the ETM version data tracing may also be available.
-endif
 endmenu
diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 5fdd6dce8061..650e46056c55 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -66,4 +66,6 @@ config DEBUG_SET_MODULE_RONX
           against certain classes of kernel exploits.
           If in doubt, say "N".
 
+source "drivers/coresight/Kconfig"
+
 endmenu
diff --git a/drivers/coresight/Kconfig b/drivers/coresight/Kconfig
new file mode 100644
index 000000000000..fc1f1ae7a49d
--- /dev/null
+++ b/drivers/coresight/Kconfig
@@ -0,0 +1,61 @@
+#
+# Coresight configuration
+#
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
+
+config CORESIGHT_SOURCE_ETM3X
+	bool "CoreSight Embedded Trace Macrocell 3.x driver"
+	depends on !ARM64
+	select CORESIGHT_LINKS_AND_SINKS
+	help
+	  This driver provides support for processor ETM3.x and PTM1.x modules,
+	  which allows tracing the instructions that a processor is executing
+	  This is primarily useful for instruction level tracing.  Depending
+	  the ETM version data tracing may also be available.
+endif
-- 
1.9.1
