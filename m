From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Aug 2014 12:24:55 -0700
Subject: [PATCH v3 1/5] ARM: BCM63XX: add basic support for the Broadcom
 BCM63138 DSL SoC
In-Reply-To: <1408389899-1022-1-git-send-email-f.fainelli@gmail.com>
References: <1408389899-1022-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1408389899-1022-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support for the Broadcom BCM63138 DSL SoC which is
using a dual-core Cortex A9 system. Add the very minimum required code
boot Linux on this SoC.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
- removed custom init function and use machine descriptor members for
  L2C initialization

Changes in v2:
- removed custom map_io() function since it is not necessary
- removed custom PL310 cache controller initialization, this has
  been submitted as part of more general patch

 .../devicetree/bindings/arm/bcm/bcm63138.txt       |  9 ++++++++
 arch/arm/mach-bcm/Kconfig                          | 17 ++++++++++++++
 arch/arm/mach-bcm/Makefile                         |  3 +++
 arch/arm/mach-bcm/bcm63xx.c                        | 27 ++++++++++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
 create mode 100644 arch/arm/mach-bcm/bcm63xx.c

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
new file mode 100644
index 000000000000..bd49987a8812
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
@@ -0,0 +1,9 @@
+Broadcom BCM63138 DSL System-on-a-Chip device tree bindings
+-----------------------------------------------------------
+
+Boards compatible with the BCM63138 DSL System-on-a-Chip should have the
+following properties:
+
+Required root node property:
+
+compatible: should be "brcm,bcm63138"
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index fc938005ad39..2abad742516d 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -99,6 +99,23 @@ config ARCH_BCM_5301X
 	  different SoC or with the older BCM47XX and BCM53XX based
 	  network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
 
+config ARCH_BCM_63XX
+	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
+	depends on MMU
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select CACHE_L2X0
+	select HAVE_ARM_ARCH_TIMER
+	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_SCU if SMP
+	select HAVE_SMP
+	help
+	  This enables support for systems based on Broadcom DSL SoCs.
+	  It currently supports the 'BCM63XX' ARM-based family, which includes
+	  the BCM63138 variant.
+
 config ARCH_BRCMSTB
 	bool "Broadcom BCM7XXX based boards" if ARCH_MULTI_V7
 	depends on MMU
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 67c492aabf4d..cbbb0be54554 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -34,6 +34,9 @@ obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
 # BCM5301X
 obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
 
+# BCM63XXx
+obj-$(CONFIG_ARCH_BCM_63XX)	:= bcm63xx.o
+
 ifeq ($(CONFIG_ARCH_BRCMSTB),y)
 obj-y				+= brcmstb.o
 obj-$(CONFIG_SMP)		+= headsmp-brcmstb.o platsmp-brcmstb.o
diff --git a/arch/arm/mach-bcm/bcm63xx.c b/arch/arm/mach-bcm/bcm63xx.c
new file mode 100644
index 000000000000..c4c66ae51308
--- /dev/null
+++ b/arch/arm/mach-bcm/bcm63xx.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2014 Broadcom Corporation
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
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+
+static const char * const bcm63xx_dt_compat[] = {
+	"brcm,bcm63138",
+	NULL
+};
+
+DT_MACHINE_START(BCM63XXX_DT, "BCM63xx DSL SoC")
+	.dt_compat	= bcm63xx_dt_compat,
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
+MACHINE_END
-- 
1.9.1
