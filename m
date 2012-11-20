From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:00:55 +0100
Subject: [PATCH 04/16] arm: mvebu: move irq controller driver to
 drivers/irqchip
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the drivers/irqchip/ directory has a minimal infrastructure
to support the addition of irq controller driver, we move the irq
controller driver for Armada 370 and Armada XP ARM SoCs from the
arch/arm/mach-mvebu/ directory to the drivers/irqchip/ directory and
update the irqchip infrastructure to take into account this new
driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Makefile                       |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    4 +--
 arch/arm/mach-mvebu/common.h                       |    3 ---
 drivers/irqchip/Makefile                           |    1 +
 .../irqchip}/irq-armada-370-xp.c                   |   28 +++++++++++---------
 5 files changed, 19 insertions(+), 19 deletions(-)
 rename {arch/arm/mach-mvebu => drivers/irqchip}/irq-armada-370-xp.c (87%)

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
index a2f5bbc..5e90401 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/time-armada-370-xp.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -54,8 +55,7 @@ static const char * const armada_370_xp_dt_compat[] = {
 DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.init_machine	= armada_370_xp_dt_init,
 	.map_io		= armada_370_xp_map_io,
-	.init_irq	= armada_370_xp_init_irq,
-	.handle_irq     = armada_370_xp_handle_irq,
+	.init_irq	= irqchip_init,
 	.timer		= &armada_370_xp_timer,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_compat,
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
index 6b5a6e0..5148ffd 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_IRQCHIP) += irqchip.o
 obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
+obj-$(CONFIG_ARCH_MVEBU)   += irq-armada-370-xp.o
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
similarity index 87%
rename from arch/arm/mach-mvebu/irq-armada-370-xp.c
rename to drivers/irqchip/irq-armada-370-xp.c
index 5f5f939..09fad6c 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -23,8 +23,11 @@
 #include <linux/of_irq.h>
 #include <linux/irqdomain.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
+#include "irqchip.h"
+
 /* Interrupt Controller Registers Map */
 #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
 #define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
@@ -77,8 +80,12 @@ static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
-static int __init armada_370_xp_mpic_of_init(struct device_node *node,
-					     struct device_node *parent)
+static asmlinkage void
+armada_370_xp_handle_irq(struct pt_regs *regs);
+
+static int __init
+armada_370_xp_mpic_of_init(struct device_node *node,
+			   struct device_node *parent)
 {
 	u32 control;
 
@@ -98,11 +105,14 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
 
 	irq_set_default_host(armada_370_xp_mpic_domain);
+
+	set_handle_irq(armada_370_xp_handle_irq);
+
 	return 0;
 }
 
-asmlinkage void __exception_irq_entry armada_370_xp_handle_irq(struct pt_regs
-							       *regs)
+static asmlinkage void __exception_irq_entry
+armada_370_xp_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
 
@@ -122,12 +132,4 @@ asmlinkage void __exception_irq_entry armada_370_xp_handle_irq(struct pt_regs
 	} while (1);
 }
 
-static const struct of_device_id mpic_of_match[] __initconst = {
-	{.compatible = "marvell,mpic", .data = armada_370_xp_mpic_of_init},
-	{},
-};
-
-void __init armada_370_xp_init_irq(void)
-{
-	of_irq_init(mpic_of_match);
-}
+IRQCHIP_DECLARE(mpic, "marvell,mpic", armada_370_xp_mpic_of_init);
-- 
1.7.9.5
