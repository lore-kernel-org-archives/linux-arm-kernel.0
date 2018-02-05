From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Mon,  5 Feb 2018 08:07:42 -0600
Subject: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
In-Reply-To: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
Message-ID: <20180205140743.29974-2-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the source files out of staging into their final locations:
  -mc.h include file in drivers/staging/fsl-mc/include go to include/linux/fsl
  -source files in drivers/staging/fsl-mc/bus go to drivers/bus/fsl-mc
  -overview.rst, providing an overview of DPAA2, goes to
   Documentation/networking/dpaa2/overview.rst

Update or delete other remaining staging files -- Makefile, Kconfig, TODO.
Update dpaa2_eth and dpio staging drivers.
Add integration bits for the documentation build system.

Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
[rebased, add dpaa2_eth and dpio #include updates]
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
[rebased, split irqchip to separate patch]
Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
Notes:
    -v6:
      - generate patch with rename detection enabled (GregKH)
    -v5:
      - split irqchip glue code to separate patch (GregKH)
      - integrate doc with the kernel build system
    -v4:
      - regenerated patch with renames detection disabled (Andrew Lunn)
    -v3:
      - rebased
    -v2:
      - group irqchip gic its glue code together with the rest (Marc Zyngier)

 Documentation/networking/dpaa2/index.rst               |  8 ++++++++
 .../networking/dpaa2}/overview.rst                     |  0
 Documentation/networking/index.rst                     |  1 +
 MAINTAINERS                                            |  3 ++-
 drivers/bus/Kconfig                                    |  2 ++
 drivers/bus/Makefile                                   |  4 ++++
 drivers/bus/fsl-mc/Kconfig                             | 16 ++++++++++++++++
 drivers/bus/fsl-mc/Makefile                            | 16 ++++++++++++++++
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c     |  2 +-
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c   |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c      |  3 ++-
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c       |  2 +-
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c    |  0
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c    |  1 +
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h         |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c     |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c    |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/README              |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c         |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c              |  2 +-
 drivers/staging/fsl-mc/TODO                            | 18 ------------------
 drivers/staging/fsl-mc/bus/Kconfig                     | 10 ----------
 drivers/staging/fsl-mc/bus/Makefile                    | 16 +++-------------
 drivers/staging/fsl-mc/bus/dpbp.c                      |  2 +-
 drivers/staging/fsl-mc/bus/dpcon.c                     |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c          |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c         |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c                 |  2 +-
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |  2 +-
 .../staging/fsl-mc/include => include/linux/fsl}/mc.h  |  0
 30 files changed, 70 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/networking/dpaa2/index.rst
 rename {drivers/staging/fsl-mc => Documentation/networking/dpaa2}/overview.rst (100%)
 create mode 100644 drivers/bus/fsl-mc/Kconfig
 create mode 100644 drivers/bus/fsl-mc/Makefile
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/TODO
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc.h (100%)

diff --git a/Documentation/networking/dpaa2/index.rst b/Documentation/networking/dpaa2/index.rst
new file mode 100644
index 0000000..4c6586c
--- /dev/null
+++ b/Documentation/networking/dpaa2/index.rst
@@ -0,0 +1,8 @@
+===================
+DPAA2 Documentation
+===================
+
+.. toctree::
+   :maxdepth: 1
+
+   overview
diff --git a/drivers/staging/fsl-mc/overview.rst b/Documentation/networking/dpaa2/overview.rst
similarity index 100%
rename from drivers/staging/fsl-mc/overview.rst
rename to Documentation/networking/dpaa2/overview.rst
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 90966c2..f204eaf 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -8,6 +8,7 @@ Contents:
 
    batman-adv
    can
+   dpaa2/index
    kapi
    z8530book
    msg_zerocopy
diff --git a/MAINTAINERS b/MAINTAINERS
index 4c104db..91e79bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11365,8 +11365,9 @@ M:	Stuart Yoder <stuyoder@gmail.com>
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel at vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/
+F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+F:	Documentation/networking/dpaa2/overview.rst
 
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 57e011d..769599b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -199,4 +199,6 @@ config DA8XX_MSTPRI
 	  configuration. Allows to adjust the priorities of all master
 	  peripherals.
 
+source "drivers/bus/fsl-mc/Kconfig"
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 9bcd0bf..b666c49 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -8,6 +8,10 @@ obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
 obj-$(CONFIG_ARM_CCN)		+= arm-ccn.o
 
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
+
+# DPAA2 fsl-mc bus
+obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
+
 obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
 obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
 obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
new file mode 100644
index 0000000..bcca644
--- /dev/null
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# DPAA2 fsl-mc bus
+#
+# Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
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
index 0000000..6a97f2c
--- /dev/null
+++ b/drivers/bus/fsl-mc/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Freescale Management Complex (MC) bus drivers
+#
+# Copyright (C) 2014 Freescale Semiconductor, Inc.
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
diff --git a/drivers/staging/fsl-mc/bus/dpmcp.c b/drivers/bus/fsl-mc/dpmcp.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/dpmcp.c
rename to drivers/bus/fsl-mc/dpmcp.c
index be07c77..8d997b0 100644
--- a/drivers/staging/fsl-mc/bus/dpmcp.c
+++ b/drivers/bus/fsl-mc/dpmcp.c
@@ -4,7 +4,7 @@
  *
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dprc-driver.c
rename to drivers/bus/fsl-mc/dprc-driver.c
index b090757..52c7e15 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dprc.c b/drivers/bus/fsl-mc/dprc.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dprc.c
rename to drivers/bus/fsl-mc/dprc.c
index 97f5172..5c23e8d 100644
--- a/drivers/staging/fsl-mc/bus/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -4,7 +4,8 @@
  *
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
+
 #include "fsl-mc-private.h"
 
 /**
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
rename to drivers/bus/fsl-mc/fsl-mc-allocator.c
index 8f313a4..452c5d7 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -8,7 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/msi.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
similarity index 100%
rename from drivers/staging/fsl-mc/bus/fsl-mc-bus.c
rename to drivers/bus/fsl-mc/fsl-mc-bus.c
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-msi.c
rename to drivers/bus/fsl-mc/fsl-mc-msi.c
index 971ad87..ec35e25 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+
 #include "fsl-mc-private.h"
 
 #ifdef GENERIC_MSI_DOMAIN_OPS
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-private.h
rename to drivers/bus/fsl-mc/fsl-mc-private.h
index 83b89d6..bed990c 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -8,7 +8,7 @@
 #ifndef _FSL_MC_PRIVATE_H_
 #define _FSL_MC_PRIVATE_H_
 
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include <linux/mutex.h>
 
 /*
diff --git a/drivers/staging/fsl-mc/bus/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/mc-io.c
rename to drivers/bus/fsl-mc/mc-io.c
index 7e6fb36..7226cfc 100644
--- a/drivers/staging/fsl-mc/bus/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -5,7 +5,7 @@
  */
 
 #include <linux/io.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/mc-sys.c
rename to drivers/bus/fsl-mc/mc-sys.c
index f09d75d..bd03f15 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -12,7 +12,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-dpaa2/ethernet/README b/drivers/staging/fsl-dpaa2/ethernet/README
index 410952e..e3b5c90 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/README
+++ b/drivers/staging/fsl-dpaa2/ethernet/README
@@ -36,7 +36,7 @@ are treated as internal resources of other objects.
 
 For a more detailed description of the DPAA2 architecture and its object
 abstractions see:
-	drivers/staging/fsl-mc/README.txt
+	Documentation/networking/dpaa2/overview.rst
 
 Each Linux net device is built on top of a Datapath Network Interface (DPNI)
 object and uses Buffer Pools (DPBPs), I/O Portals (DPIOs) and Concentrators
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 2817e67..b519fee 100644
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
index e8be761..b16ff5c 100644
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
index 1f91000..5f4115d 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -5,16 +5,6 @@
 # Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
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
index 29059db..18b1b5f 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,19 +4,9 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
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
+obj-$(CONFIG_FSL_MC_BUS) += irq-gic-v3-its-fsl-mc-msi.o \
+			    dpbp.o \
+			    dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/staging/fsl-mc/bus/dpbp.c
index a4df846..c0addaa 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/staging/fsl-mc/bus/dpbp.c
@@ -4,7 +4,7 @@
  *
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../include/dpbp.h"
 
 #include "dpbp-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/staging/fsl-mc/bus/dpcon.c
index 8f84d7b..021b425 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/staging/fsl-mc/bus/dpcon.c
@@ -4,7 +4,7 @@
  *
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../include/dpcon.h"
 
 #include "dpcon-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index b8479ef..182b384 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -14,7 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 
-#include "../../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../../include/dpaa2-io.h"
 
 #include "qbman-portal.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index d3c8462..1acff7e 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -5,7 +5,7 @@
  *
  */
 #include <linux/types.h>
-#include "../../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../../include/dpaa2-io.h"
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/staging/fsl-mc/bus/dpio/dpio.c
index 20cdeae..3175057 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio.c
@@ -5,7 +5,7 @@
  *
  */
 #include <linux/kernel.h>
-#include "../../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "dpio.h"
 #include "dpio-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 5064d5d..b365fbb 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -13,7 +13,7 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 static struct irq_chip its_msi_irq_chip = {
 	.name = "ITS-fMSI",
diff --git a/drivers/staging/fsl-mc/include/mc.h b/include/linux/fsl/mc.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/mc.h
rename to include/linux/fsl/mc.h
-- 
2.7.4
