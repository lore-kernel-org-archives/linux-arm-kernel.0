From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  1 Jun 2016 22:07:32 +0300
Subject: [PATCH 2/2] ARM: imx: Use IRQCHIP_DECLARE for TZIC
In-Reply-To: <1464808052-3855-1-git-send-email-shc_work@mail.ru>
References: <1464808052-3855-1-git-send-email-shc_work@mail.ru>
Message-ID: <1464808052-3855-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove boilerplate code by using IRQCHIP_DECLARE macro.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/common.h     |  1 -
 arch/arm/mach-imx/mach-imx50.c |  1 -
 arch/arm/mach-imx/mach-imx51.c |  1 -
 arch/arm/mach-imx/mach-imx53.c |  1 -
 arch/arm/mach-imx/tzic.c       | 10 +++++-----
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 58a3846..60d9ae6 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -32,7 +32,6 @@ void imx27_init_early(void);
 void imx31_init_early(void);
 void imx35_init_early(void);
 void mxc_init_irq(void __iomem *);
-void tzic_init_irq(void);
 void mx1_init_irq(void);
 void mx21_init_irq(void);
 void mx27_init_irq(void);
diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
index ecf58b9..4cab5f6 100644
--- a/arch/arm/mach-imx/mach-imx50.c
+++ b/arch/arm/mach-imx/mach-imx50.c
@@ -22,6 +22,5 @@ static const char * const imx50_dt_board_compat[] __initconst = {
 };
 
 DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
-	.init_irq	= tzic_init_irq,
 	.dt_compat	= imx50_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 10a82a4..7296c31 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -69,7 +69,6 @@ static const char * const imx51_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
 	.init_early	= imx51_init_early,
-	.init_irq	= tzic_init_irq,
 	.init_machine	= imx51_dt_init,
 	.init_late	= imx51_init_late,
 	.dt_compat	= imx51_dt_board_compat,
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 18b5c5c13..d251cec 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -49,7 +49,6 @@ static const char * const imx53_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
 	.init_early	= imx53_init_early,
-	.init_irq	= tzic_init_irq,
 	.init_machine	= imx53_dt_init,
 	.init_late	= imx53_init_late,
 	.dt_compat	= imx53_dt_board_compat,
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index ae23d50..a53fdc2 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -9,12 +9,11 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -153,13 +152,11 @@ static void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
  * interrupts. It registers the interrupt enable and disable functions
  * to the kernel for each interrupt source.
  */
-void __init tzic_init_irq(void)
+static int __init tzic_init_dt(struct device_node *np, struct device_node *p)
 {
-	struct device_node *np;
 	int irq_base;
 	int i;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,tzic");
 	tzic_base = of_iomap(np, 0);
 	WARN_ON(!tzic_base);
 
@@ -199,7 +196,10 @@ void __init tzic_init_irq(void)
 #endif
 
 	pr_info("TrustZone Interrupt Controller (TZIC) initialized\n");
+
+	return 0;
 }
+IRQCHIP_DECLARE(tzic, "fsl,tzic", tzic_init_dt);
 
 /**
  * tzic_enable_wake() - enable wakeup interrupt
-- 
2.4.9
