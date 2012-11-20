From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:01:00 +0100
Subject: [PATCH 09/16] irqchip: Move ARM VIC to drivers/irqchip
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that we have drivers/irqchip, move VIC irqchip to drivers/irqchip.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/common/Kconfig                            |   15 ----
 arch/arm/common/Makefile                           |    1 -
 drivers/irqchip/Kconfig                            |   15 ++++
 drivers/irqchip/Makefile                           |    1 +
 arch/arm/common/vic.c => drivers/irqchip/irq-vic.c |   75 +++++++++++---------
 5 files changed, 58 insertions(+), 49 deletions(-)
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
index 2d7f350..d80e5c7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -9,3 +9,18 @@ config ARM_GIC
 
 config GIC_NON_BANKED
 	bool
+
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
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 94118db..9c7f91e 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_IRQCHIP) += irqchip.o
 obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
 obj-$(CONFIG_ARCH_MVEBU)   += irq-armada-370-xp.o
 obj-$(CONFIG_ARM_GIC)   += irq-gic.o
+obj-$(CONFIG_ARM_VIC)   += irq-vic.o
diff --git a/arch/arm/common/vic.c b/drivers/irqchip/irq-vic.c
similarity index 98%
rename from arch/arm/common/vic.c
rename to drivers/irqchip/irq-vic.c
index e0d5388..98a0708 100644
--- a/arch/arm/common/vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -35,6 +35,8 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/vic.h>
 
+#include "irqchip.h"
+
 /**
  * struct vic_device - VIC PM device
  * @irq: The IRQ number for the base of the VIC.
@@ -390,6 +392,40 @@ void __init __vic_init(void __iomem *base, unsigned int irq_start,
 	vic_register(base, irq_start, vic_sources, resume_sources, node);
 }
 
+/*
+ * Handle each interrupt in a single VIC.  Returns non-zero if we've
+ * handled at least one interrupt.  This reads the status register
+ * before handling each interrupt, which is necessary given that
+ * handle_IRQ may briefly re-enable interrupts for soft IRQ handling.
+ */
+static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
+{
+	u32 stat, irq;
+	int handled = 0;
+
+	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
+		irq = ffs(stat) - 1;
+		handle_IRQ(irq_find_mapping(vic->domain, irq), regs);
+		handled = 1;
+	}
+
+	return handled;
+}
+
+/*
+ * Keep iterating over all registered VIC's until there are no pending
+ * interrupts.
+ */
+asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
+{
+	int i, handled;
+
+	do {
+		for (i = 0, handled = 0; i < vic_id; ++i)
+			handled |= handle_one_vic(&vic_devices[i], regs);
+	} while (handled);
+}
+
 /**
  * vic_init() - initialise a vectored interrupt controller
  * @base: iomem base address
@@ -422,6 +458,8 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 
 	__vic_init(regs, irq_base, ~0, ~0, node);
 
+	set_handle_irq(vic_handle_irq);
+
 	return 0;
 
  out_unmap:
@@ -429,38 +467,9 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 
 	return -EIO;
 }
-#endif /* CONFIG OF */
-
-/*
- * Handle each interrupt in a single VIC.  Returns non-zero if we've
- * handled@least one interrupt.  This reads the status register
- * before handling each interrupt, which is necessary given that
- * handle_IRQ may briefly re-enable interrupts for soft IRQ handling.
- */
-static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
-{
-	u32 stat, irq;
-	int handled = 0;
 
-	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
-		irq = ffs(stat) - 1;
-		handle_IRQ(irq_find_mapping(vic->domain, irq), regs);
-		handled = 1;
-	}
+IRQCHIP_DECLARE(versatile_vic, "arm,versatile-vic", vic_of_init);
+IRQCHIP_DECLARE(pl190_vic, "arm,pl190-vic", vic_of_init);
+IRQCHIP_DECLARE(pl192_vic, "arm,pl192-vic", vic_of_init);
 
-	return handled;
-}
-
-/*
- * Keep iterating over all registered VIC's until there are no pending
- * interrupts.
- */
-asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
-{
-	int i, handled;
-
-	do {
-		for (i = 0, handled = 0; i < vic_id; ++i)
-			handled |= handle_one_vic(&vic_devices[i], regs);
-	} while (handled);
-}
+#endif /* CONFIG OF */
-- 
1.7.9.5
