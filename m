From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 31 May 2014 10:01:31 +0400
Subject: [PATCH 1/3] ARM: i.MX: tzic: Use irqchip_init() for IRQ
 initialization in DT case
In-Reply-To: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
References: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
Message-ID: <1401516095-31020-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use generic irqchip_init() DT call to initialize IRQs, so after this patch,
the mxc-tzic driver is quite prepared to move to drivers/irqchip.
As a temporary solution to do it, we use OF_DECLARE_2()
instead of IRQCHIP_DECLARE().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/common.h     |  1 -
 arch/arm/mach-imx/mach-imx50.c |  1 -
 arch/arm/mach-imx/mach-imx51.c |  1 -
 arch/arm/mach-imx/mach-imx53.c |  1 -
 arch/arm/mach-imx/tzic.c       | 19 +++++++++++--------
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5aaea2b..9586187 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -33,7 +33,6 @@ void imx27_init_early(void);
 void imx31_init_early(void);
 void imx35_init_early(void);
 void mxc_init_irq(void __iomem *);
-void tzic_init_irq(void);
 void mx1_init_irq(void);
 void mx21_init_irq(void);
 void mx25_init_irq(void);
diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
index 62a4d45..f8d0030 100644
--- a/arch/arm/mach-imx/mach-imx50.c
+++ b/arch/arm/mach-imx/mach-imx50.c
@@ -29,7 +29,6 @@ static const char *imx50_dt_board_compat[] __initconst = {
 };
 
 DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
-	.init_irq	= tzic_init_irq,
 	.init_machine	= imx50_dt_init,
 	.dt_compat	= imx50_dt_board_compat,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index b6f42f8..bd4e9eb 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -74,7 +74,6 @@ static const char *imx51_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
 	.init_early	= imx51_init_early,
-	.init_irq	= tzic_init_irq,
 	.init_machine	= imx51_dt_init,
 	.init_late	= imx51_init_late,
 	.dt_compat	= imx51_dt_board_compat,
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index d8c3c08..37650b0 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -48,7 +48,6 @@ static const char *imx53_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
 	.init_early	= imx53_init_early,
-	.init_irq	= tzic_init_irq,
 	.init_machine	= imx53_dt_init,
 	.init_late	= imx53_init_late,
 	.dt_compat	= imx53_dt_board_compat,
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 1d4f384..b5fc0c7 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -109,7 +109,7 @@ static __init void tzic_init_gc(int idx, unsigned int irq_start)
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	gc = irq_alloc_generic_chip("tzic", 1, irq_start, tzic_base,
+	gc = irq_alloc_generic_chip("mxc-tzic", 1, irq_start, tzic_base,
 				    handle_level_irq);
 	gc->private = &tzic_extra_irq;
 	gc->wake_enabled = IRQ_MSK(32);
@@ -154,15 +154,15 @@ static void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
  * interrupts. It registers the interrupt enable and disable functions
  * to the kernel for each interrupt source.
  */
-void __init tzic_init_irq(void)
+static int __init tzic_init_irq(struct device_node *np,
+				struct device_node *parent)
 {
-	struct device_node *np;
 	int irq_base;
 	int i;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,tzic");
 	tzic_base = of_iomap(np, 0);
-	WARN_ON(!tzic_base);
+	if (!tzic_base)
+		return -ENOMEM;
 
 	/* put the TZIC into the reset value with
 	 * all interrupts disabled
@@ -183,11 +183,13 @@ void __init tzic_init_irq(void)
 	/* all IRQ no FIQ Warning :: No selection */
 
 	irq_base = irq_alloc_descs(-1, 0, TZIC_NUM_IRQS, numa_node_id());
-	WARN_ON(irq_base < 0);
+	if (irq_base < 0)
+		return -ENOMEM;
 
 	domain = irq_domain_add_legacy(np, TZIC_NUM_IRQS, irq_base, 0,
 				       &irq_domain_simple_ops, NULL);
-	WARN_ON(!domain);
+	if (!domain)
+		return -ENOMEM;
 
 	for (i = 0; i < 4; i++, irq_base += 32)
 		tzic_init_gc(i, irq_base);
@@ -199,8 +201,9 @@ void __init tzic_init_irq(void)
 	init_FIQ(FIQ_START);
 #endif
 
-	pr_info("TrustZone Interrupt Controller (TZIC) initialized\n");
+	return 0;
 }
+OF_DECLARE_2(irqchip, mxc_tzic, "fsl,tzic", tzic_init_irq);
 
 /**
  * tzic_enable_wake() - enable wakeup interrupt
-- 
1.8.5.5
