From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:25 -0600
Subject: [PATCH v4 16/19] irqchip: Move ARM VIC to drivers/irqchip
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-17-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that we have drivers/irqchip, move VIC irqchip to drivers/irqchip.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/common/Kconfig                            |   15 ---------------
 arch/arm/common/Makefile                           |    1 -
 drivers/irqchip/Kconfig                            |   15 +++++++++++++++
 drivers/irqchip/Makefile                           |    1 +
 arch/arm/common/vic.c => drivers/irqchip/irq-vic.c |    5 +++++
 5 files changed, 21 insertions(+), 16 deletions(-)
 rename arch/arm/common/vic.c => drivers/irqchip/irq-vic.c (98%)

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 7bf52b2..9353184 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -1,18 +1,3 @@
-config ARM_VIC
-	bool
-	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-
-config ARM_VIC_NR
-	int
-	default 4 if ARCH_S5PV210
-	default 3 if ARCH_S5PC100
-	default 2
-	depends on ARM_VIC
-	help
-	  The maximum number of VICs available in the system, for
-	  power management.
-
 config ICST
 	bool
 
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 4104b82..dc8dd0d 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -2,7 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-obj-$(CONFIG_ARM_VIC)		+= vic.o
 obj-$(CONFIG_ICST)		+= icst.o
 obj-$(CONFIG_SA1111)		+= sa1111.o
 obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 98f30b0..a350969 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -10,6 +10,21 @@ config ARM_GIC
 config GIC_NON_BANKED
 	bool
 
+config ARM_VIC
+	bool
+	select IRQ_DOMAIN
+	select MULTI_IRQ_HANDLER
+
+config ARM_VIC_NR
+	int
+	default 4 if ARCH_S5PV210
+	default 3 if ARCH_S5PC100
+	default 2
+	depends on ARM_VIC
+	help
+	  The maximum number of VICs available in the system, for
+	  power management.
+
 config VERSATILE_FPGA_IRQ
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f2a9a07..0fb8655 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o
+obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
diff --git a/arch/arm/common/vic.c b/drivers/irqchip/irq-vic.c
similarity index 98%
rename from arch/arm/common/vic.c
rename to drivers/irqchip/irq-vic.c
index d5ee437..554deaf 100644
--- a/arch/arm/common/vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -35,6 +35,8 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/vic.h>
 
+#include "irqchip.h"
+
 #define VIC_IRQ_STATUS			0x00
 #define VIC_FIQ_STATUS			0x04
 #define VIC_INT_SELECT			0x0c	/* 1 = FIQ, 0 = IRQ */
@@ -442,6 +444,9 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 
 	return 0;
 }
+IRQCHIP_DECLARE(arm_pl190_vic, "arm,pl190-vic", vic_of_init);
+IRQCHIP_DECLARE(arm_pl192_vic, "arm,pl192-vic", vic_of_init);
+IRQCHIP_DECLARE(arm_versatile_vic, "arm,versatile-vic", vic_of_init);
 #endif /* CONFIG OF */
 
 /*
-- 
1.7.10.4
