From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:00:59 +0100
Subject: [PATCH 08/16] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that we have drivers/irqchip, move GIC irqchip to drivers/irqchip. This
is necessary to share the GIC with arm and arm64.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/common/Kconfig                            |    8 --------
 arch/arm/common/Makefile                           |    1 -
 drivers/irqchip/Kconfig                            |    8 ++++++++
 drivers/irqchip/Makefile                           |    1 +
 arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |    8 ++++++++
 5 files changed, 17 insertions(+), 9 deletions(-)
 rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (99%)

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 45ceeb0..7bf52b2 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -1,11 +1,3 @@
-config ARM_GIC
-	bool
-	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-
-config GIC_NON_BANKED
-	bool
-
 config ARM_VIC
 	bool
 	select IRQ_DOMAIN
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e8a4e58..4104b82 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -2,7 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-obj-$(CONFIG_ARM_GIC)		+= gic.o
 obj-$(CONFIG_ARM_VIC)		+= vic.o
 obj-$(CONFIG_ICST)		+= icst.o
 obj-$(CONFIG_SA1111)		+= sa1111.o
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 88b0929..2d7f350 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -1,3 +1,11 @@
 config IRQCHIP
 	def_bool y
 	depends on OF_IRQ
+
+config ARM_GIC
+	bool
+	select IRQ_DOMAIN
+	select MULTI_IRQ_HANDLER
+
+config GIC_NON_BANKED
+	bool
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5148ffd..94118db 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_IRQCHIP) += irqchip.o
 obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
 obj-$(CONFIG_ARCH_MVEBU)   += irq-armada-370-xp.o
+obj-$(CONFIG_ARM_GIC)   += irq-gic.o
diff --git a/arch/arm/common/gic.c b/drivers/irqchip/irq-gic.c
similarity index 99%
rename from arch/arm/common/gic.c
rename to drivers/irqchip/irq-gic.c
index 1bee954..1038e99 100644
--- a/arch/arm/common/gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -44,6 +44,8 @@
 #include <asm/smp_plat.h>
 #include <asm/mach/irq.h>
 
+#include "irqchip.h"
+
 #define GIC_CPU_CTRL			0x00
 #define GIC_CPU_PRIMASK			0x04
 #define GIC_CPU_BINPOINT		0x08
@@ -799,8 +801,14 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 	if (parent) {
 		irq = irq_of_parse_and_map(node, 0);
 		gic_cascade_irq(gic_cnt, irq);
+	} else {
+		set_handle_irq(gic_handle_irq);
 	}
+
 	gic_cnt++;
 	return 0;
 }
 #endif
+
+IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
+IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
-- 
1.7.9.5
