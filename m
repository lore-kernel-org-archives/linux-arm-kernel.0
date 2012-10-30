From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Oct 2012 09:54:19 -0500
Subject: [PATCH 2/3] irqchip: Move ARM VIC to drivers/irqchip
In-Reply-To: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
References: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
Message-ID: <1351608860-24617-3-git-send-email-robherring2@gmail.com>
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
 arch/arm/common/vic.c => drivers/irqchip/irq-vic.c |    0
 drivers/irqchip/irqchip.c                          |   14 ++++++++++++++
 drivers/irqchip/irqchip.h                          |    1 +
 7 files changed, 31 insertions(+), 16 deletions(-)
 rename arch/arm/common/vic.c => drivers/irqchip/irq-vic.c (100%)

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
similarity index 100%
rename from arch/arm/common/vic.c
rename to drivers/irqchip/irq-vic.c
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 3f37397..0872cd7 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -24,6 +24,20 @@ static const struct of_device_id irqchip_of_match[] __initconst = {
 		.data = gic_of_init,
 	},
 #endif
+#ifdef CONFIG_ARM_VIC
+	{
+		.compatible = "arm,versatile-vic",
+		.data = vic_of_init,
+	},
+	{
+		.compatible = "arm,pl190-vic",
+		.data = vic_of_init,
+	},
+	{
+		.compatible = "arm,pl190-vic",
+		.data = vic_of_init,
+	},
+#endif
 #ifdef CONFIG_ARCH_BCM2835
 	{
 		.compatible = "brcm,bcm2835-armctrl-ic",
diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h
index 62773ab3..8b8c2b2 100644
--- a/drivers/irqchip/irqchip.h
+++ b/drivers/irqchip/irqchip.h
@@ -15,5 +15,6 @@ int bcm2835_irqchip_init(struct device_node *node, struct device_node *parent);
 int armada_370_xp_mpic_of_init(struct device_node *node,
 			       struct device_node *parent);
 int gic_of_init(struct device_node *node, struct device_node *parent);
+int vic_of_init(struct device_node *node, struct device_node *parent);
 
 #endif
-- 
1.7.10.4
