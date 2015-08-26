From: jonmason@broadcom.com (Jon Mason)
Date: Wed, 26 Aug 2015 18:35:28 -0400
Subject: [PATCH v2 3/5] ARM: NSP: Add basic support for Broadcom Northstar
 Plus SoC
In-Reply-To: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
References: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1440628530-6137-4-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom Northstar Plus family of SoCs are used for switching
control and management applications as well as residential
router/gateway applications. The SoC features dual core Cortex
A9 ARM CPUs, integrating several peripheral interfaces including
multiple Gigabit Ethernet PHYs, DDR3 memory, PCIE Gen-2, USB 2.0
and USB 3.0, serial and NAND flash, SATA and several other IO
controllers.

Signed-off-by: Kapil Hali <kapilh@broadcom.com>
Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig   | 14 ++++++++++++++
 arch/arm/mach-bcm/Makefile  |  5 ++++-
 arch/arm/mach-bcm/bcm_nsp.c | 25 +++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-bcm/bcm_nsp.c

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 0ac9e4b3..22c85b1 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -35,6 +35,20 @@ config ARCH_BCM_CYGNUS
 	  BCM11300, BCM11320, BCM11350, BCM11360,
 	  BCM58300, BCM58302, BCM58303, BCM58305.
 
+config ARCH_BCM_NSP
+	bool "Broadcom Northstar Plus SoC Support" if ARCH_MULTI_V7
+	select ARCH_BCM_IPROC
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
+	help
+	  Support for Broadcom Northstar Plus SoC.
+	  Broadcom Northstar Plus family of SoCs are used for switching control
+	  and management applications as well as residential router/gateway
+	  applications. The SoC features dual core Cortex A9 ARM CPUs,
+	  integrating several peripheral interfaces including multiple Gigabit
+	  Ethernet PHYs, DDR3 memory, PCIE Gen-2, USB 2.0 and USB 3.0, serial and
+	  NAND flash, SATA and several other IO controllers.
+
 config ARCH_BCM_5301X
 	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
 	select ARCH_BCM_IPROC
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 4fb0da4..786d720 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2012-2014 Broadcom Corporation
+# Copyright (C) 2012-2015 Broadcom Corporation
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -13,6 +13,9 @@
 # Cygnus
 obj-$(CONFIG_ARCH_BCM_CYGNUS) +=  bcm_cygnus.o
 
+# Northstar Plus
+obj-$(CONFIG_ARCH_BCM_NSP) += bcm_nsp.o
+
 # BCM281XX
 obj-$(CONFIG_ARCH_BCM_281XX)	+= board_bcm281xx.o
 
diff --git a/arch/arm/mach-bcm/bcm_nsp.c b/arch/arm/mach-bcm/bcm_nsp.c
new file mode 100644
index 0000000..a1101a3
--- /dev/null
+++ b/arch/arm/mach-bcm/bcm_nsp.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/mach/arch.h>
+
+static const char *const bcm_nsp_dt_compat[] __initconst = {
+	"brcm,nsp",
+	NULL,
+};
+
+DT_MACHINE_START(NSP_DT, "Broadcom Northstar Plus SoC")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
+	.dt_compat = bcm_nsp_dt_compat,
+MACHINE_END
-- 
1.9.1
