From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 14:35:00 +0200
Subject: [PATCH] arm: mvebu: move irq controller driver in drivers/irqchip/
Message-ID: <1351168500-11129-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new support for the ARM BCM2835 SoC has introduced the
drivers/irqchip/ directory for IRQ controller drivers. So let's
conform to this good new approach, and move the IRQ controller driver
for Marvell Armada 370/XP in this directory.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Makefile                       |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    1 +
 arch/arm/mach-mvebu/common.h                       |    3 ---
 drivers/irqchip/Makefile                           |    1 +
 .../irqchip}/irq-armada-370-xp.c                   |    0
 include/linux/irqchip/armada-370-xp.h              |   19 +++++++++++++++++++
 6 files changed, 22 insertions(+), 4 deletions(-)
 rename {arch/arm/mach-mvebu => drivers/irqchip}/irq-armada-370-xp.c (100%)
 create mode 100644 include/linux/irqchip/armada-370-xp.h

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 57f996b..7f4e9f4 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -2,4 +2,4 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-orion/include
 
 obj-y += system-controller.o
-obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o
+obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o addr-map.o
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 49d7915..1c0021d 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/time-armada-370-xp.h>
+#include <linux/irqchip/armada-370-xp.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 02f89ea..f0eaa21 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -17,7 +17,4 @@
 
 void mvebu_restart(char mode, const char *cmd);
 
-void armada_370_xp_init_irq(void);
-void armada_370_xp_handle_irq(struct pt_regs *regs);
-
 #endif
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 054321d..af0412c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
+obj-$(CONFIG_MACH_ARMADA_370_XP) += irq-armada-370-xp.o
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
similarity index 100%
rename from arch/arm/mach-mvebu/irq-armada-370-xp.c
rename to drivers/irqchip/irq-armada-370-xp.c
diff --git a/include/linux/irqchip/armada-370-xp.h b/include/linux/irqchip/armada-370-xp.h
new file mode 100644
index 0000000..78876c2
--- /dev/null
+++ b/include/linux/irqchip/armada-370-xp.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2012 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __LINUX_IRQCHIP_ARMADA_370_XP_H_
+#define __LINUX_IRQCHIP_ARMADA_370_XP_H_
+
+#include <asm/exception.h>
+
+void armada_370_xp_init_irq(void);
+void armada_370_xp_handle_irq(struct pt_regs *regs);
+
+#endif
-- 
1.7.9.5
