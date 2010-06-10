From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 10 Jun 2010 13:36:35 +0900
Subject: [PATCH] [ARM] VIC: Remove resume_sources
Message-ID: <1276144595-17411-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The resume_sources is the bitmask of interrupts allowed for resume
sources, but it's value is zero in the all machine using VIC then
vic_set_wake returns always error.

The interrupt sources to allow can use to resume sources too and
vic_set_wake called by set_irq_wake desides whether enable or disable
interrupt sources to resume sources, so we don't have any reason to
control resume sources by resume_sources.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 arch/arm/common/vic.c               |   16 ++++------------
 arch/arm/include/asm/hardware/vic.h |    2 +-
 arch/arm/mach-ep93xx/core.c         |    4 ++--
 arch/arm/mach-netx/generic.c        |    2 +-
 arch/arm/mach-nomadik/cpu-8815.c    |    4 ++--
 arch/arm/mach-s3c64xx/irq.c         |    4 ++--
 arch/arm/mach-spear3xx/spear3xx.c   |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c   |    4 ++--
 arch/arm/mach-u300/core.c           |    4 ++--
 arch/arm/mach-versatile/core.c      |    2 +-
 arch/arm/plat-s5p/irq.c             |    2 +-
 11 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index ba65f6e..2a3c8fd 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -35,7 +35,6 @@
  * @sysdev: The system device which is registered.
  * @irq: The IRQ number for the base of the VIC.
  * @base: The register base for the VIC.
- * @resume_sources: A bitmask of interrupts for resume.
  * @resume_irqs: The IRQs enabled for resume.
  * @int_select: Save for VIC_INT_SELECT.
  * @int_enable: Save for VIC_INT_ENABLE.
@@ -47,7 +46,6 @@ struct vic_device {
 
 	void __iomem	*base;
 	int		irq;
-	u32		resume_sources;
 	u32		resume_irqs;
 	u32		int_select;
 	u32		int_enable;
@@ -180,13 +178,12 @@ late_initcall(vic_pm_init);
  * vic_pm_register - Register a VIC for later power management control
  * @base: The base address of the VIC.
  * @irq: The base IRQ for the VIC.
- * @resume_sources: bitmask of interrupts allowed for resume sources.
  *
  * Register the VIC with the system device tree so that it can be notified
  * of suspend and resume requests and ensure that the correct actions are
  * taken to re-instate the settings on resume.
  */
-static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 resume_sources)
+static void __init vic_pm_register(void __iomem *base, unsigned int irq)
 {
 	struct vic_device *v;
 
@@ -195,13 +192,12 @@ static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 res
 	else {
 		v = &vic_devices[vic_id];
 		v->base = base;
-		v->resume_sources = resume_sources;
 		v->irq = irq;
 		vic_id++;
 	}
 }
 #else
-static inline void vic_pm_register(void __iomem *base, unsigned int irq, u32 arg1) { }
+static inline void vic_pm_register(void __iomem *base, unsigned int irq) { }
 #endif /* CONFIG_PM */
 
 static void vic_ack_irq(unsigned int irq)
@@ -251,9 +247,6 @@ static int vic_set_wake(unsigned int irq, unsigned int on)
 	if (!v)
 		return -EINVAL;
 
-	if (!(bit & v->resume_sources))
-		return -EINVAL;
-
 	if (on)
 		v->resume_irqs |= bit;
 	else
@@ -355,10 +348,9 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
  * @base: iomem base address
  * @irq_start: starting interrupt number, must be muliple of 32
  * @vic_sources: bitmask of interrupt sources to allow
- * @resume_sources: bitmask of interrupt sources to allow for resume
  */
 void __init vic_init(void __iomem *base, unsigned int irq_start,
-		     u32 vic_sources, u32 resume_sources)
+		     u32 vic_sources)
 {
 	unsigned int i;
 	u32 cellid = 0;
@@ -394,5 +386,5 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 
 	vic_set_irq_sources(base, irq_start, vic_sources);
 
-	vic_pm_register(base, irq_start, resume_sources);
+	vic_pm_register(base, irq_start);
 }
diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
index 5d72550..f87328d 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -41,7 +41,7 @@
 #define VIC_PL192_VECT_ADDR		0xF00
 
 #ifndef __ASSEMBLY__
-void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
+void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources);
 #endif
 
 #endif
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 9092677..2cfa5c8 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -177,8 +177,8 @@ extern void ep93xx_gpio_init_irq(void);
 
 void __init ep93xx_init_irq(void)
 {
-	vic_init(EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
-	vic_init(EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK, 0);
+	vic_init(EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK);
+	vic_init(EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK);
 
 	ep93xx_gpio_init_irq();
 }
diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
index 43da8bb..79df60c 100644
--- a/arch/arm/mach-netx/generic.c
+++ b/arch/arm/mach-netx/generic.c
@@ -168,7 +168,7 @@ void __init netx_init_irq(void)
 {
 	int irq;
 
-	vic_init(__io(io_p2v(NETX_PA_VIC)), 0, ~0, 0);
+	vic_init(__io(io_p2v(NETX_PA_VIC)), 0, ~0);
 
 	for (irq = NETX_IRQ_HIF_CHAINED(0); irq <= NETX_IRQ_HIF_LAST; irq++) {
 		set_irq_chip(irq, &netx_hif_chip);
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 91c3c90..aea6dae 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -141,8 +141,8 @@ void __init cpu8815_map_io(void)
 void __init cpu8815_init_irq(void)
 {
 	/* This modified VIC cell has two register blocks,@0 and 0x20 */
-	vic_init(io_p2v(NOMADIK_IC_BASE + 0x00), IRQ_VIC_START +  0, ~0, 0);
-	vic_init(io_p2v(NOMADIK_IC_BASE + 0x20), IRQ_VIC_START + 32, ~0, 0);
+	vic_init(io_p2v(NOMADIK_IC_BASE + 0x00), IRQ_VIC_START +  0, ~0);
+	vic_init(io_p2v(NOMADIK_IC_BASE + 0x20), IRQ_VIC_START + 32, ~0);
 }
 
 /*
diff --git a/arch/arm/mach-s3c64xx/irq.c b/arch/arm/mach-s3c64xx/irq.c
index 67a145d..ae34225 100644
--- a/arch/arm/mach-s3c64xx/irq.c
+++ b/arch/arm/mach-s3c64xx/irq.c
@@ -54,8 +54,8 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
 
 	/* initialise the pair of VICs */
-	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, 0);
-	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, 0);
+	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid);
+	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid);
 
 	/* add the timer sub-irqs */
 
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index e87313a..0e579c8 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -63,7 +63,7 @@ void __init spear3xx_init(void)
 /* This will initialize vic */
 void __init spear3xx_init_irq(void)
 {
-	vic_init((void __iomem *)VA_SPEAR3XX_ML1_VIC_BASE, 0, ~0, 0);
+	vic_init((void __iomem *)VA_SPEAR3XX_ML1_VIC_BASE, 0, ~0);
 }
 
 /* Following will create static virtual/physical mappings */
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index baf6bcc..c5dd57e 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -113,8 +113,8 @@ void __init spear6xx_init(void)
 /* This will initialize vic */
 void __init spear6xx_init_irq(void)
 {
-	vic_init((void __iomem *)VA_SPEAR6XX_CPU_VIC_PRI_BASE, 0, ~0, 0);
-	vic_init((void __iomem *)VA_SPEAR6XX_CPU_VIC_SEC_BASE, 32, ~0, 0);
+	vic_init((void __iomem *)VA_SPEAR6XX_CPU_VIC_PRI_BASE, 0, ~0);
+	vic_init((void __iomem *)VA_SPEAR6XX_CPU_VIC_SEC_BASE, 32, ~0);
 }
 
 /* Following will create static virtual/physical mappings */
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 5f34eb6..d887414 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1482,8 +1482,8 @@ void __init u300_init_irq(void)
 	for (i = 0; i < NR_IRQS; i++)
 		set_bit(i, (unsigned long *) &mask[0]);
 	u300_enable_intcon_clock();
-	vic_init((void __iomem *) U300_INTCON0_VBASE, 0, mask[0], mask[0]);
-	vic_init((void __iomem *) U300_INTCON1_VBASE, 32, mask[1], mask[1]);
+	vic_init((void __iomem *) U300_INTCON0_VBASE, 0, mask[0]);
+	vic_init((void __iomem *) U300_INTCON1_VBASE, 32, mask[1]);
 }
 
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 3dff864..224bfc0 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -116,7 +116,7 @@ void __init versatile_init_irq(void)
 {
 	unsigned int i;
 
-	vic_init(VA_VIC_BASE, IRQ_VIC_START, ~0, 0);
+	vic_init(VA_VIC_BASE, IRQ_VIC_START, ~0);
 
 	set_irq_chained_handler(IRQ_VICSOURCE31, sic_handle_irq);
 
diff --git a/arch/arm/plat-s5p/irq.c b/arch/arm/plat-s5p/irq.c
index 25e1eb6..2ba3ff9 100644
--- a/arch/arm/plat-s5p/irq.c
+++ b/arch/arm/plat-s5p/irq.c
@@ -60,7 +60,7 @@ void __init s5p_init_irq(u32 *vic, u32 num_vic)
 
 	/* initialize the VICs */
 	for (irq = 0; irq < num_vic; irq++)
-		vic_init(VA_VIC(irq), VIC_BASE(irq), vic[irq], 0);
+		vic_init(VA_VIC(irq), VIC_BASE(irq), vic[irq]);
 
 	s3c_init_vic_timer_irq(IRQ_TIMER0_VIC, IRQ_TIMER0);
 	s3c_init_vic_timer_irq(IRQ_TIMER1_VIC, IRQ_TIMER1);
-- 
1.7.0.4
