From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 15 Aug 2016 00:24:55 +0200
Subject: [PATCH] ARM: pxa: remove irq init from dt machines
Message-ID: <1471213495-2315-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init_irq and handle_irq can be declared through standard irqchip
declaration and are not necessary in machine descriptions.

This is another step towards the generic kernel for the pxa
architecture.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/generic.h |  3 ---
 arch/arm/mach-pxa/pxa-dt.c  |  6 ------
 arch/arm/mach-pxa/pxa25x.c  | 11 ++++++++---
 arch/arm/mach-pxa/pxa27x.c  | 11 ++++++++---
 arch/arm/mach-pxa/pxa3xx.c  |  8 +++++++-
 5 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 3f914d97cac2..75e3f611e5d8 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -27,21 +27,18 @@ extern void pxa_timer_init(void);
 
 #define pxa25x_handle_irq icip_handle_irq
 extern int __init pxa25x_clocks_init(void);
-extern void __init pxa25x_dt_init_irq(void);
 extern void __init pxa25x_init_irq(void);
 extern void __init pxa25x_map_io(void);
 extern void __init pxa26x_init_irq(void);
 
 #define pxa27x_handle_irq ichp_handle_irq
 extern int __init pxa27x_clocks_init(void);
-extern void __init pxa27x_dt_init_irq(void);
 extern unsigned	pxa27x_get_clk_frequency_khz(int);
 extern void __init pxa27x_init_irq(void);
 extern void __init pxa27x_map_io(void);
 
 #define pxa3xx_handle_irq ichp_handle_irq
 extern int __init pxa3xx_clocks_init(void);
-extern void __init pxa3xx_dt_init_irq(void);
 extern void __init pxa3xx_init_irq(void);
 extern void __init pxa3xx_map_io(void);
 
diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index 3e331e61f995..aa9b255f5570 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -26,8 +26,6 @@ static const char * const pxa25x_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(PXA25X_DT, "Marvell PXA25x (Device Tree Support)")
 	.map_io		= pxa25x_map_io,
-	.init_irq	= pxa25x_dt_init_irq,
-	.handle_irq	= pxa25x_handle_irq,
 	.restart	= pxa_restart,
 	.dt_compat	= pxa25x_dt_board_compat,
 MACHINE_END
@@ -41,8 +39,6 @@ static const char * const pxa27x_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(PXA27X_DT, "Marvell PXA27x (Device Tree Support)")
 	.map_io		= pxa27x_map_io,
-	.init_irq	= pxa27x_dt_init_irq,
-	.handle_irq	= pxa27x_handle_irq,
 	.restart	= pxa_restart,
 	.dt_compat	= pxa27x_dt_board_compat,
 MACHINE_END
@@ -58,8 +54,6 @@ static const char *const pxa3xx_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
 	.map_io		= pxa3xx_map_io,
-	.init_irq	= pxa3xx_dt_init_irq,
-	.handle_irq	= pxa3xx_handle_irq,
 	.restart	= pxa_restart,
 	.dt_compat	= pxa3xx_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 30b4270adc02..12b94357fbc1 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -25,6 +25,7 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
@@ -151,11 +152,15 @@ void __init pxa26x_init_irq(void)
 }
 #endif
 
-void __init pxa25x_dt_init_irq(void)
+static int __init __init
+pxa25x_dt_init_irq(struct device_node *node, struct device_node *parent)
 {
-	if (IS_ENABLED(CONFIG_OF))
-		pxa_dt_irq_init(pxa25x_set_wake);
+	pxa_dt_irq_init(pxa25x_set_wake);
+	set_handle_irq(ichp_handle_irq);
+
+	return 0;
 }
+IRQCHIP_DECLARE(pxa25x_intc, "marvell,pxa-intc", pxa25x_dt_init_irq);
 
 static struct map_desc pxa25x_io_desc[] __initdata = {
 	{	/* Mem Ctl */
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index f0262ff0e5ef..918fd6312502 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqchip.h>
 #include <linux/suspend.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
@@ -233,11 +234,15 @@ void __init pxa27x_init_irq(void)
 	pxa_init_irq(34, pxa27x_set_wake);
 }
 
-void __init pxa27x_dt_init_irq(void)
+static int __init
+pxa27x_dt_init_irq(struct device_node *node, struct device_node *parent)
 {
-	if (IS_ENABLED(CONFIG_OF))
-		pxa_dt_irq_init(pxa27x_set_wake);
+	pxa_dt_irq_init(pxa27x_set_wake);
+	set_handle_irq(ichp_handle_irq);
+
+	return 0;
 }
+IRQCHIP_DECLARE(pxa27x_intc, "marvell,pxa-intc", pxa27x_dt_init_irq);
 
 static struct map_desc pxa27x_io_desc[] __initdata = {
 	{	/* Mem Ctl */
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 6a014c8d8a47..87acc96388c7 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/syscore_ops.h>
@@ -356,11 +357,16 @@ void __init pxa3xx_init_irq(void)
 }
 
 #ifdef CONFIG_OF
-void __init pxa3xx_dt_init_irq(void)
+static int __init __init
+pxa3xx_dt_init_irq(struct device_node *node, struct device_node *parent)
 {
 	__pxa3xx_init_irq();
 	pxa_dt_irq_init(pxa3xx_set_wake);
+	set_handle_irq(ichp_handle_irq);
+
+	return 0;
 }
+IRQCHIP_DECLARE(pxa3xx_intc, "marvell,pxa-intc", pxa3xx_dt_init_irq);
 #endif	/* CONFIG_OF */
 
 static struct map_desc pxa3xx_io_desc[] __initdata = {
-- 
2.1.4
