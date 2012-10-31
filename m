From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Oct 2012 09:58:35 -0500
Subject: [PATCH v2 3/5] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
Message-ID: <1351695517-5636-4-git-send-email-robherring2@gmail.com>
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
 arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |    0
 drivers/irqchip/irqchip.c                          |   10 ++++++++++
 drivers/irqchip/irqchip.h                          |    1 +
 7 files changed, 20 insertions(+), 9 deletions(-)
 rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (100%)

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
similarity index 100%
rename from arch/arm/common/gic.c
rename to drivers/irqchip/irq-gic.c
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index f36d423..3f37397 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -14,6 +14,16 @@
 #include "irqchip.h"
 
 static const struct of_device_id irqchip_of_match[] __initconst = {
+#ifdef CONFIG_ARM_GIC
+	{
+		.compatible = "arm,cortex-a15-gic",
+		.data = gic_of_init,
+	},
+	{
+		.compatible = "arm,cortex-a9-gic",
+		.data = gic_of_init,
+	},
+#endif
 #ifdef CONFIG_ARCH_BCM2835
 	{
 		.compatible = "brcm,bcm2835-armctrl-ic",
diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h
index 0a0d7af..62773ab3 100644
--- a/drivers/irqchip/irqchip.h
+++ b/drivers/irqchip/irqchip.h
@@ -14,5 +14,6 @@
 int bcm2835_irqchip_init(struct device_node *node, struct device_node *parent);
 int armada_370_xp_mpic_of_init(struct device_node *node,
 			       struct device_node *parent);
+int gic_of_init(struct device_node *node, struct device_node *parent);
 
 #endif
-- 
1.7.10.4
