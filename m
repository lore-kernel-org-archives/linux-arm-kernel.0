From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Sat, 19 Aug 2017 20:18:12 +0300
Subject: [PATCH] staging: fsl-mc: move bus driver out of staging
Message-ID: <20170819171812.21902-1-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stuart Yoder <stuart.yoder@nxp.com>

Move the source files out of staging into their final locations:
  -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
  -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
  -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
  -README.txt, providing and overview of DPAA goes to
   Documentation/dpaa2/overview.txt

Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
Update dpaa2_eth and dpio staging drivers.

Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
[Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 .../README.txt => Documentation/dpaa2/overview.txt     |  0
 MAINTAINERS                                            |  2 +-
 drivers/bus/Kconfig                                    |  2 ++
 drivers/bus/Makefile                                   |  3 +++
 drivers/bus/fsl-mc/Kconfig                             | 17 +++++++++++++++++
 drivers/bus/fsl-mc/Makefile                            | 17 +++++++++++++++++
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp-cmd.h |  0
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c     |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.h     |  0
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmng-cmd.h |  0
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-cmd.h  |  0
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c   |  1 -
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c      |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.h      |  0
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c       |  1 -
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c    |  0
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c    |  0
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h         |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c     |  1 -
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c    |  2 +-
 drivers/irqchip/Makefile                               |  1 +
 .../fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/README              |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c         |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c              |  2 +-
 drivers/staging/fsl-mc/TODO                            | 18 ------------------
 drivers/staging/fsl-mc/bus/Kconfig                     | 10 ----------
 drivers/staging/fsl-mc/bus/Makefile                    | 15 ++-------------
 drivers/staging/fsl-mc/bus/dpbp.c                      |  2 +-
 drivers/staging/fsl-mc/bus/dpcon.c                     |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c          |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c         |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c                 |  2 +-
 .../staging/fsl-mc/include => include/linux/fsl}/mc.h  |  0
 34 files changed, 56 insertions(+), 58 deletions(-)
 rename drivers/staging/fsl-mc/README.txt => Documentation/dpaa2/overview.txt (100%)
 create mode 100644 drivers/bus/fsl-mc/Kconfig
 create mode 100644 drivers/bus/fsl-mc/Makefile
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmng-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c (99%)
 rename drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/TODO
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc.h (100%)

diff --git a/drivers/staging/fsl-mc/README.txt b/Documentation/dpaa2/overview.txt
similarity index 100%
rename from drivers/staging/fsl-mc/README.txt
rename to Documentation/dpaa2/overview.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index 6f7721d..2149eeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10900,7 +10900,7 @@ M:	Stuart Yoder <stuyoder@gmail.com>
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel at vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/
+F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 
 QT1010 MEDIA DRIVER
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 2408ea3..23e0279 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -183,4 +183,6 @@ config DA8XX_MSTPRI
 	  configuration. Allows to adjust the priorities of all master
 	  peripherals.
 
+source "drivers/bus/fsl-mc/Kconfig"
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index cc6364b..dee9a84 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -14,6 +14,9 @@ obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
 # Interconnect bus driver for OMAP SoCs.
 obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
 
+# DPAA2 fsl-mc bus
+obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
+
 obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 obj-$(CONFIG_QCOM_EBI2)		+= qcom-ebi2.o
 obj-$(CONFIG_SUNXI_RSB)		+= sunxi-rsb.o
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
new file mode 100644
index 0000000..30b55ac
--- /dev/null
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -0,0 +1,17 @@
+#
+# DPAA2 fsl-mc bus
+#
+# Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+#
+# This file is released under the GPLv2
+#
+
+config FSL_MC_BUS
+	bool "QorIQ DPAA2 fsl-mc bus driver"
+	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86 || PPC)))
+	select GENERIC_MSI_IRQ_DOMAIN
+	help
+	  Driver to enable the bus infrastructure for the QorIQ DPAA2
+	  architecture.  The fsl-mc bus driver handles discovery of
+	  DPAA2 objects (which are represented as Linux devices) and
+	  binding objects to drivers.
diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
new file mode 100644
index 0000000..1fe40282
--- /dev/null
+++ b/drivers/bus/fsl-mc/Makefile
@@ -0,0 +1,17 @@
+#
+# Freescale Management Complex (MC) bus drivers
+#
+# Copyright (C) 2014 Freescale Semiconductor, Inc.
+#
+# This file is released under the GPLv2
+#
+obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
+
+mc-bus-driver-objs := fsl-mc-bus.o \
+		      mc-sys.o \
+		      mc-io.o \
+		      dprc.o \
+		      dprc-driver.o \
+		      fsl-mc-allocator.o \
+		      fsl-mc-msi.o \
+		      dpmcp.o
diff --git a/drivers/staging/fsl-mc/bus/dpmcp-cmd.h b/drivers/bus/fsl-mc/dpmcp-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpmcp-cmd.h
rename to drivers/bus/fsl-mc/dpmcp-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dpmcp.c b/drivers/bus/fsl-mc/dpmcp.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpmcp.c
rename to drivers/bus/fsl-mc/dpmcp.c
index eea42f6..e56505f 100644
--- a/drivers/staging/fsl-mc/bus/dpmcp.c
+++ b/drivers/bus/fsl-mc/dpmcp.c
@@ -30,7 +30,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "dpmcp.h"
 #include "dpmcp-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dpmcp.h b/drivers/bus/fsl-mc/dpmcp.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpmcp.h
rename to drivers/bus/fsl-mc/dpmcp.h
diff --git a/drivers/staging/fsl-mc/bus/dpmng-cmd.h b/drivers/bus/fsl-mc/dpmng-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpmng-cmd.h
rename to drivers/bus/fsl-mc/dpmng-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dprc-cmd.h b/drivers/bus/fsl-mc/dprc-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dprc-cmd.h
rename to drivers/bus/fsl-mc/dprc-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dprc-driver.c
rename to drivers/bus/fsl-mc/dprc-driver.c
index 06df528..42a1f6a 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
-#include "../include/mc.h"
 
 #include "dprc-cmd.h"
 #include "fsl-mc-private.h"
diff --git a/drivers/staging/fsl-mc/bus/dprc.c b/drivers/bus/fsl-mc/dprc.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dprc.c
rename to drivers/bus/fsl-mc/dprc.c
index 6f6c65a..f8d579e 100644
--- a/drivers/staging/fsl-mc/bus/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -30,7 +30,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "dprc.h"
 
 #include "dprc-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dprc.h b/drivers/bus/fsl-mc/dprc.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dprc.h
rename to drivers/bus/fsl-mc/dprc.h
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
rename to drivers/bus/fsl-mc/fsl-mc-allocator.c
index b37a6f4..4ff5c7b 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -10,7 +10,6 @@
 
 #include <linux/module.h>
 #include <linux/msi.h>
-#include "../include/mc.h"
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
similarity index 100%
rename from drivers/staging/fsl-mc/bus/fsl-mc-bus.c
rename to drivers/bus/fsl-mc/fsl-mc-bus.c
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
similarity index 100%
rename from drivers/staging/fsl-mc/bus/fsl-mc-msi.c
rename to drivers/bus/fsl-mc/fsl-mc-msi.c
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-private.h
rename to drivers/bus/fsl-mc/fsl-mc-private.h
index 62d3989..d8b8281 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -10,7 +10,7 @@
 #ifndef _FSL_MC_PRIVATE_H_
 #define _FSL_MC_PRIVATE_H_
 
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "dprc.h"
 #include <linux/mutex.h>
 
diff --git a/drivers/staging/fsl-mc/bus/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/mc-io.c
rename to drivers/bus/fsl-mc/mc-io.c
index f65c23c..1e17ce6 100644
--- a/drivers/staging/fsl-mc/bus/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -31,7 +31,6 @@
  */
 
 #include <linux/io.h>
-#include "../include/mc.h"
 
 #include "fsl-mc-private.h"
 #include "dpmcp.h"
diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/mc-sys.c
rename to drivers/bus/fsl-mc/mc-sys.c
index 7ce105b..def3d3c 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -38,7 +38,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "dpmcp.h"
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e88d856..4839165 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
+obj-$(CONFIG_FSL_MC_BUS)		+= irq-gic-v3-its-fsl-mc-msi.o
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
rename to drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 123e4af..57c6b2a 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -15,7 +15,7 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include "fsl-mc-private.h"
+#include <linux/fsl/mc.h>
 
 static struct irq_chip its_msi_irq_chip = {
 	.name = "ITS-fMSI",
diff --git a/drivers/staging/fsl-dpaa2/ethernet/README b/drivers/staging/fsl-dpaa2/ethernet/README
index 410952e..1e825df 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/README
+++ b/drivers/staging/fsl-dpaa2/ethernet/README
@@ -36,7 +36,7 @@ are treated as internal resources of other objects.
 
 For a more detailed description of the DPAA2 architecture and its object
 abstractions see:
-	drivers/staging/fsl-mc/README.txt
+	Documentation/dpaa2/overview.txt
 
 Each Linux net device is built on top of a Datapath Network Interface (DPNI)
 object and uses Buffer Pools (DPBPs), I/O Portals (DPIOs) and Concentrators
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 26017fe..3f50e1a 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -39,7 +39,7 @@
 #include <linux/kthread.h>
 #include <linux/iommu.h>
 
-#include "../../fsl-mc/include/mc.h"
+#include <linux/fsl/mc.h>
 #include "dpaa2-eth.h"
 
 /* CREATE_TRACE_POINTS only needs to be defined once. Other dpa files
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni.c b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
index 5b9d442..2c5a601 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
@@ -32,7 +32,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include "../../fsl-mc/include/mc.h"
+#include <linux/fsl/mc.h>
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/TODO b/drivers/staging/fsl-mc/TODO
deleted file mode 100644
index 54a8bc6..0000000
--- a/drivers/staging/fsl-mc/TODO
+++ /dev/null
@@ -1,18 +0,0 @@
-* Add at least one device driver for a DPAA2 object (child device of the
-  fsl-mc bus).  Most likely candidate for this is adding DPAA2 Ethernet
-  driver support, which depends on drivers for several objects: DPNI,
-  DPIO, DPMAC.  Other pre-requisites include:
-
-     * MC firmware uprev.  The MC firmware upon which the fsl-mc
-       bus driver and DPAA2 object drivers are based is continuing
-       to evolve, so minor updates are needed to keep in sync with binary
-       interface changes to the MC.
-
-* Cleanup
-
-Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
-german.rivera at freescale.com, devel at driverdev.osuosl.org,
-linux-kernel at vger.kernel.org
-
-[1] https://lkml.org/lkml/2015/7/9/93
-[2] https://lkml.org/lkml/2015/7/7/712
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 504c987..9700f2c 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -6,16 +6,6 @@
 # This file is released under the GPLv2
 #
 
-config FSL_MC_BUS
-	bool "QorIQ DPAA2 fsl-mc bus driver"
-	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86 || PPC)))
-	select GENERIC_MSI_IRQ_DOMAIN
-	help
-	  Driver to enable the bus infrastructure for the QorIQ DPAA2
-	  architecture.  The fsl-mc bus driver handles discovery of
-	  DPAA2 objects (which are represented as Linux devices) and
-	  binding objects to drivers.
-
 config FSL_MC_DPIO
         tristate "QorIQ DPAA2 DPIO driver"
         depends on FSL_MC_BUS && ARCH_LAYERSCAPE
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 6df407e..b8f4c4d 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -5,19 +5,8 @@
 #
 # This file is released under the GPLv2
 #
-obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
-
-mc-bus-driver-objs := fsl-mc-bus.o \
-		      mc-sys.o \
-		      mc-io.o \
-		      dprc.o \
-		      dprc-driver.o \
-		      fsl-mc-allocator.o \
-		      fsl-mc-msi.o \
-		      irq-gic-v3-its-fsl-mc-msi.o \
-		      dpmcp.o \
-		      dpbp.o \
-		      dpcon.o
+obj-$(CONFIG_FSL_MC_BUS) += dpbp.o \
+			    dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/staging/fsl-mc/bus/dpbp.c
index 363730a..9f9ff82 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/staging/fsl-mc/bus/dpbp.c
@@ -30,7 +30,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../include/dpbp.h"
 
 #include "dpbp-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/staging/fsl-mc/bus/dpcon.c
index ca1da85..aa9ab7b 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/staging/fsl-mc/bus/dpcon.c
@@ -30,7 +30,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../include/dpcon.h"
 
 #include "dpcon-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index e36da20..6170547 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -38,8 +38,8 @@
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/fsl/mc.h>
 
-#include "../../include/mc.h"
 #include "../../include/dpaa2-io.h"
 
 #include "qbman-portal.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index f809682..706eeb5 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -30,7 +30,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/types.h>
-#include "../../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../../include/dpaa2-io.h"
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/staging/fsl-mc/bus/dpio/dpio.c
index 00eb221..7db0a04 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio.c
@@ -31,7 +31,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
-#include "../../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "dpio.h"
 #include "dpio-cmd.h"
diff --git a/drivers/staging/fsl-mc/include/mc.h b/include/linux/fsl/mc.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/mc.h
rename to include/linux/fsl/mc.h
-- 
2.9.4
