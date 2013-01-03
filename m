From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:17 -0600
Subject: [PATCH v4 08/19] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-9-git-send-email-robherring2@gmail.com>
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
 drivers/irqchip/Makefile                           |    3 ++-
 arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |    7 +++++++
 5 files changed, 17 insertions(+), 10 deletions(-)
 rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (98%)

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
index 93dfd8f..98f30b0 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -2,6 +2,14 @@ config IRQCHIP
 	def_bool y
 	depends on OF_IRQ
 
+config ARM_GIC
+	bool
+	select IRQ_DOMAIN
+	select MULTI_IRQ_HANDLER
+
+config GIC_NON_BANKED
+	bool
+
 config VERSATILE_FPGA_IRQ
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 29b78c9..f2a9a07 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -2,5 +2,6 @@ obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi.o
-obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
+obj-$(CONFIG_ARM_GIC)			+= irq-gic.o
+obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
diff --git a/arch/arm/common/gic.c b/drivers/irqchip/irq-gic.c
similarity index 98%
rename from arch/arm/common/gic.c
rename to drivers/irqchip/irq-gic.c
index 90eebfea..dc511a4 100644
--- a/arch/arm/common/gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -45,6 +45,8 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
 
+#include "irqchip.h"
+
 union gic_base {
 	void __iomem *common_base;
 	void __percpu __iomem **percpu_base;
@@ -814,4 +816,9 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 	gic_cnt++;
 	return 0;
 }
+IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
+IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
+IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
+IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
+
 #endif
-- 
1.7.10.4
