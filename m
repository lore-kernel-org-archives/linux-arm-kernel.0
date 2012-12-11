From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Dec 2012 18:18:01 -0700
Subject: [PATCHv2 1/3] ARM: Orion: Hoist bridge interrupt handling out of the
 timer
Message-ID: <1355188683-18208-1-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The intent of this patch is to expose the other bridge cause
interrupts to users in the kernel.

- Add orion_bridge_irq_init to create a new edge triggered interrupt
  chip based on the bridge cause register
- Remove all interrupt register code from time.c and use normal
  interrupt functions instead
- Update the machines that use orion_time_init to call
  orion_bridge_irq_init and use the new signature

Tested on a Kirkwood platform.

I'm skeptical that MV78xx0 has a bridge interrupt cause/mask register,
it was setup so the timer code would touch those registers, so I've
preserved that, but prior to this patch the 'bridge cause register'
was only written to, never read. If it is wired-to-zero because it
doesn't exist then the timer will fail to function.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/mach-dove/common.c                       |    7 ++-
 arch/arm/mach-dove/include/mach/bridge-regs.h     |    2 +-
 arch/arm/mach-dove/include/mach/irqs.h            |    9 +++-
 arch/arm/mach-kirkwood/common.c                   |    8 ++-
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    2 -
 arch/arm/mach-kirkwood/include/mach/irqs.h        |   14 ++++-
 arch/arm/mach-mv78xx0/common.c                    |   12 +++-
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h  |    2 +-
 arch/arm/mach-mv78xx0/include/mach/irqs.h         |    9 +++-
 arch/arm/mach-orion5x/common.c                    |    8 ++-
 arch/arm/mach-orion5x/include/mach/bridge-regs.h  |    2 -
 arch/arm/mach-orion5x/include/mach/irqs.h         |    9 +++-
 arch/arm/plat-orion/include/plat/irq.h            |    3 +
 arch/arm/plat-orion/include/plat/time.h           |    4 +-
 arch/arm/plat-orion/irq.c                         |   70 +++++++++++++++++++++
 arch/arm/plat-orion/time.c                        |   46 +++-----------
 16 files changed, 149 insertions(+), 58 deletions(-)

v2 changes
- Defines for BRIDGE registers
- Re-order the bridge IRQs to follow the GPIO irqs, otherwise there
  will be problems when switching to DT
- Make orion_bridge_irq_init suitable for being DT bound, call
  irq_alloc_descs to get a dynamic range allocation.
- Use "orion_bridge" as the chip name
- I left orion_bridge_irq_init in the timer_init functions.
  For the DT boards there is no better place for it at this
  point, putting it in eg, kirkwood_init_irq, will not call
  it on the DT case and the board won't boot. The next patch
  provides a solution for the DT case so then we can safely
  move it.

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index f723fe1..6bad21b 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -243,8 +243,11 @@ static int __init dove_find_tclk(void)
 static void __init dove_timer_init(void)
 {
 	dove_tclk = dove_find_tclk();
-	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
-			IRQ_DOVE_BRIDGE, dove_tclk);
+	if (orion_bridge_irq_init(IRQ_DOVE_BRIDGE,
+				  IRQ_DOVE_BRIDGE_START,
+				  BRIDGE_CAUSE, NULL))
+		panic("Unable to setup bridge irqs");
+	orion_time_init(IRQ_DOVE_BRIDGE_TIMER1, dove_tclk);
 }
 
 struct sys_timer dove_timer = {
diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/include/mach/bridge-regs.h
index 99f259e..3bd4656 100644
--- a/arch/arm/mach-dove/include/mach/bridge-regs.h
+++ b/arch/arm/mach-dove/include/mach/bridge-regs.h
@@ -26,7 +26,7 @@
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
 #define  SOFT_RESET		0x00000001
 
-#define  BRIDGE_INT_TIMER1_CLR	(~0x0004)
+#define BRIDGE_CAUSE            (BRIDGE_VIRT_BASE + 0x0110)
 
 #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0200)
 #define IRQ_CAUSE_LOW_OFF	0x0000
diff --git a/arch/arm/mach-dove/include/mach/irqs.h b/arch/arm/mach-dove/include/mach/irqs.h
index 03d401d..f153de0 100644
--- a/arch/arm/mach-dove/include/mach/irqs.h
+++ b/arch/arm/mach-dove/include/mach/irqs.h
@@ -90,7 +90,14 @@
 #define NR_PMU_IRQS		7
 #define IRQ_DOVE_RTC		(IRQ_DOVE_PMU_START + 5)
 
-#define NR_IRQS			(IRQ_DOVE_PMU_START + NR_PMU_IRQS)
+/*
+ * Bridge Interrupt Controller
+ */
+#define IRQ_DOVE_BRIDGE_START   (IRQ_DOVE_PMU_START + NR_PMU_IRQS)
+#define IRQ_DOVE_BRIDGE_TIMER1  (IRQ_DOVE_BRIDGE_START + 2)
+#define NR_BRIDGE_IRQS          6
+
+#define NR_IRQS			(IRQ_DOVE_BRIDGE_START + NR_BRIDGE_IRQS)
 
 
 #endif
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 906c22e..ccd3ed5 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -35,6 +35,7 @@
 #include <plat/time.h>
 #include <plat/addr-map.h>
 #include <linux/platform_data/dma-mv_xor.h>
+#include <plat/irq.h>
 #include "common.h"
 
 /*****************************************************************************
@@ -534,8 +535,11 @@ static void __init kirkwood_timer_init(void)
 {
 	kirkwood_tclk = kirkwood_find_tclk();
 
-	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
-			IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
+	if (orion_bridge_irq_init(IRQ_KIRKWOOD_BRIDGE,
+				  IRQ_KIRKWOOD_BRIDGE_START,
+				  BRIDGE_CAUSE, NULL))
+		panic("Unable to setup bridge irqs");
+	orion_time_init(IRQ_KIRKWOOD_BRIDGE_TIMER1, kirkwood_tclk);
 }
 
 struct sys_timer kirkwood_timer = {
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 5c82b7d..fd66a56 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -29,8 +29,6 @@
 #define BRIDGE_CAUSE		(BRIDGE_VIRT_BASE + 0x0110)
 #define WDT_INT_REQ		0x0008
 
-#define BRIDGE_INT_TIMER1_CLR	(~0x0004)
-
 #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0200)
 #define IRQ_CAUSE_LOW_OFF	0x0000
 #define IRQ_MASK_LOW_OFF	0x0004
diff --git a/arch/arm/mach-kirkwood/include/mach/irqs.h b/arch/arm/mach-kirkwood/include/mach/irqs.h
index 2bf8161..82c5984 100644
--- a/arch/arm/mach-kirkwood/include/mach/irqs.h
+++ b/arch/arm/mach-kirkwood/include/mach/irqs.h
@@ -59,7 +59,19 @@
 #define IRQ_KIRKWOOD_GPIO_START	64
 #define NR_GPIO_IRQS		50
 
-#define NR_IRQS			(IRQ_KIRKWOOD_GPIO_START + NR_GPIO_IRQS)
+/*
+ * Bridge Interrupt Controller
+ */
+#define IRQ_KIRKWOOD_BRIDGE_START (IRQ_KIRKWOOD_GPIO_START + NR_GPIO_IRQS)
+#define IRQ_KIRKWOOD_BRIDGE_SELFINT   (IRQ_KIRKWOOD_BRIDGE_START + 0)
+#define IRQ_KIRKWOOD_BRIDGE_TIMER0    (IRQ_KIRKWOOD_BRIDGE_START + 1)
+#define IRQ_KIRKWOOD_BRIDGE_TIMER1    (IRQ_KIRKWOOD_BRIDGE_START + 2)
+#define IRQ_KIRKWOOD_BRIDGE_TIMERWD   (IRQ_KIRKWOOD_BRIDGE_START + 3)
+#define IRQ_KIRKWOOD_BRIDGE_ACCESSERR (IRQ_KIRKWOOD_BRIDGE_START + 4)
+#define IRQ_KIRKWOOD_BRIDGE_BIT64ERR  (IRQ_KIRKWOOD_BRIDGE_START + 5)
+#define NR_BRIDGE_IRQS          6
+
+#define NR_IRQS			(IRQ_KIRKWOOD_BRIDGE_START + NR_BRIDGE_IRQS)
 
 
 #endif
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index d0cb485..e9c9ef7 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -25,6 +25,7 @@
 #include <plat/time.h>
 #include <plat/common.h>
 #include <plat/addr-map.h>
+#include <plat/irq.h>
 #include "common.h"
 
 static int get_tclk(void);
@@ -338,8 +339,15 @@ void __init mv78xx0_init_early(void)
 
 static void __init_refok mv78xx0_timer_init(void)
 {
-	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
-			IRQ_MV78XX0_TIMER_1, get_tclk());
+	/*
+	 * FIXME: MV78XX0 may not have a bridge cause register, in which case
+	 * the timer should run directly from IRQ_MV78XX0_TIMER_1
+	 */
+	if (orion_bridge_irq_init(IRQ_MV78XX0_TIMER_1,
+				  IRQ_MV78XX0_BRIDGE_START,
+				  BRIDGE_CAUSE, NULL))
+		panic("Unable to setup bridge irqs");
+	orion_time_init(IRQ_MV78XX0_BRIDGE_TIMER1, get_tclk());
 }
 
 struct sys_timer mv78xx0_timer = {
diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
index 5f03484..787bd2a 100644
--- a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
@@ -20,7 +20,7 @@
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
 #define SOFT_RESET		0x00000001
 
-#define BRIDGE_INT_TIMER1_CLR	(~0x0004)
+#define BRIDGE_CAUSE            (BRIDGE_VIRT_BASE + 0x0110)
 
 #define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0200)
 #define IRQ_CAUSE_ERR_OFF	0x0000
diff --git a/arch/arm/mach-mv78xx0/include/mach/irqs.h b/arch/arm/mach-mv78xx0/include/mach/irqs.h
index fa1d422..1d70936 100644
--- a/arch/arm/mach-mv78xx0/include/mach/irqs.h
+++ b/arch/arm/mach-mv78xx0/include/mach/irqs.h
@@ -88,7 +88,14 @@
 #define IRQ_MV78XX0_GPIO_START	96
 #define NR_GPIO_IRQS		32
 
-#define NR_IRQS			(IRQ_MV78XX0_GPIO_START + NR_GPIO_IRQS)
+/*
+ * Bridge Interrupt Controller
+ */
+#define IRQ_MV78XX0_BRIDGE_START   (IRQ_MV78XX0_GPIO_START + NR_GPIO_IRQS)
+#define IRQ_MV78XX0_BRIDGE_TIMER1  (IRQ_MV78XX0_BRIDGE_START + 2)
+#define NR_BRIDGE_IRQS             6
+
+#define NR_IRQS			(IRQ_MV78XX0_BRIDGE_START + NR_BRIDGE_IRQS)
 
 
 #endif
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index b3eb3da..c95c6c1 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -35,6 +35,7 @@
 #include <plat/time.h>
 #include <plat/common.h>
 #include <plat/addr-map.h>
+#include <plat/irq.h>
 #include "common.h"
 
 /*****************************************************************************
@@ -221,8 +222,11 @@ static void __init orion5x_timer_init(void)
 {
 	orion5x_tclk = orion5x_find_tclk();
 
-	orion_time_init(ORION5X_BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
-			IRQ_ORION5X_BRIDGE, orion5x_tclk);
+	if (orion_bridge_irq_init(IRQ_ORION5X_BRIDGE,
+				  IRQ_ORION5X_BRIDGE_START,
+				  BRIDGE_CAUSE, NULL))
+		panic("Unable to setup bridge irqs");
+	orion_time_init(IRQ_ORION5X_BRIDGE_TIMER1, orion5x_tclk);
 }
 
 struct sys_timer orion5x_timer = {
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
index 461fd69..0847182 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
@@ -28,8 +28,6 @@
 
 #define WDT_INT_REQ		0x0008
 
-#define BRIDGE_INT_TIMER1_CLR	(~0x0004)
-
 #define MAIN_IRQ_CAUSE		(ORION5X_BRIDGE_VIRT_BASE + 0x200)
 
 #define MAIN_IRQ_MASK		(ORION5X_BRIDGE_VIRT_BASE + 0x204)
diff --git a/arch/arm/mach-orion5x/include/mach/irqs.h b/arch/arm/mach-orion5x/include/mach/irqs.h
index a6fa9d8..b8d53e6 100644
--- a/arch/arm/mach-orion5x/include/mach/irqs.h
+++ b/arch/arm/mach-orion5x/include/mach/irqs.h
@@ -54,7 +54,14 @@
 #define IRQ_ORION5X_GPIO_START	32
 #define NR_GPIO_IRQS		32
 
-#define NR_IRQS			(IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS)
+/*
+ * Bridge Interrupt Controller
+ */
+#define IRQ_ORION5X_BRIDGE_START   (IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS)
+#define IRQ_ORION5X_BRIDGE_TIMER1  (IRQ_ORION5X_BRIDGE_START + 2)
+#define NR_BRIDGE_IRQS          6
+
+#define NR_IRQS			(IRQ_ORION5X_BRIDGE_START + NR_BRIDGE_IRQS)
 
 
 #endif
diff --git a/arch/arm/plat-orion/include/plat/irq.h b/arch/arm/plat-orion/include/plat/irq.h
index 50547e4..d86ae85 100644
--- a/arch/arm/plat-orion/include/plat/irq.h
+++ b/arch/arm/plat-orion/include/plat/irq.h
@@ -12,5 +12,8 @@
 #define __PLAT_IRQ_H
 
 void orion_irq_init(unsigned int irq_start, void __iomem *maskaddr);
+int __init orion_bridge_irq_init(unsigned int bridge_irq, int irq_start,
+				 void __iomem *causeaddr,
+				 struct device_node *np);
 void __init orion_dt_init_irq(void);
 #endif
diff --git a/arch/arm/plat-orion/include/plat/time.h b/arch/arm/plat-orion/include/plat/time.h
index 07527e4..c5ccc0a 100644
--- a/arch/arm/plat-orion/include/plat/time.h
+++ b/arch/arm/plat-orion/include/plat/time.h
@@ -13,8 +13,6 @@
 
 void orion_time_set_base(void __iomem *timer_base);
 
-void orion_time_init(void __iomem *bridge_base, u32 bridge_timer1_clr_mask,
-		     unsigned int irq, unsigned int tclk);
-
+void orion_time_init(unsigned int irq, unsigned int tclk);
 
 #endif
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 1867944..a903012 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/plat-orion/irq.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -18,6 +19,75 @@
 #include <plat/irq.h>
 #include <plat/orion-gpio.h>
 
+#define BRIDGE_CAUSE_OFF 0
+#define BRIDGE_MASK_OFF  4
+#define BRIDGE_NUM_IRQS 6
+
+static void bridge_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	struct irq_chip_generic *gc = irq_get_handler_data(irq);
+	u32 cause;
+	int i;
+
+	cause = readl(gc->reg_base) & readl(gc->reg_base + BRIDGE_MASK_OFF);
+	for (i = 0; i < BRIDGE_NUM_IRQS; i++)
+		if ((cause & (1 << i)))
+			generic_handle_irq(i + gc->irq_base);
+}
+
+static void irq_gc_eoi_inv(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 mask = 1 << (d->irq - gc->irq_base);
+	struct irq_chip_regs *regs;
+
+	regs = &container_of(d->chip, struct irq_chip_type, chip)->regs;
+	irq_gc_lock(gc);
+	irq_reg_writel(~mask, gc->reg_base + regs->eoi);
+	irq_gc_unlock(gc);
+}
+
+int __init orion_bridge_irq_init(unsigned int bridge_irq, int irq_start,
+				 void __iomem *causeaddr,
+				 struct device_node *np)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	int rc;
+
+	irq_start = irq_alloc_descs(irq_start, 0, BRIDGE_NUM_IRQS,
+				    NUMA_NO_NODE);
+	if (irq_start < 0)
+		return irq_start;
+	gc = irq_alloc_generic_chip("orion_bridge", 1, irq_start,
+				    causeaddr, handle_fasteoi_irq);
+	if (!gc)
+		return -ENOMEM;
+
+	ct = gc->chip_types;
+	ct->regs.mask = BRIDGE_MASK_OFF;
+	ct->regs.eoi = BRIDGE_CAUSE_OFF;
+	/* ACK and mask all interrupts */
+	writel(0, causeaddr);
+	writel(0, causeaddr + ct->regs.mask);
+	ct->chip.irq_eoi = irq_gc_eoi_inv;
+	ct->chip.irq_mask = irq_gc_mask_clr_bit;
+	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	irq_setup_generic_chip(gc, IRQ_MSK(BRIDGE_NUM_IRQS),
+			       IRQ_GC_INIT_MASK_CACHE,
+			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
+	rc = irq_set_handler_data(bridge_irq, gc);
+	if (rc)
+		return rc;
+	irq_set_chained_handler(bridge_irq, bridge_irq_handler);
+
+	if (np)
+		irq_domain_add_legacy(np, gc->irq_cnt, gc->irq_base,
+				      0, &irq_domain_simple_ops, NULL);
+
+	return 0;
+}
+
 void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
 {
 	struct irq_chip_generic *gc;
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 0f4fa86..da22aa4 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -17,15 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <asm/sched_clock.h>
-
-/*
- * MBus bridge block registers.
- */
-#define BRIDGE_CAUSE_OFF	0x0110
-#define BRIDGE_MASK_OFF		0x0114
-#define  BRIDGE_INT_TIMER0	 0x0002
-#define  BRIDGE_INT_TIMER1	 0x0004
-
+#include <linux/sched.h>
+#include <plat/time.h>
 
 /*
  * Timer block registers.
@@ -44,9 +37,8 @@
 /*
  * SoC-specific data.
  */
-static void __iomem *bridge_base;
-static u32 bridge_timer1_clr_mask;
 static void __iomem *timer_base;
+static unsigned int timer_irq;
 
 
 /*
@@ -82,11 +74,7 @@ orion_clkevt_next_event(unsigned long delta, struct clock_event_device *dev)
 	/*
 	 * Clear and enable clockevent timer interrupt.
 	 */
-	writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
-
-	u = readl(bridge_base + BRIDGE_MASK_OFF);
-	u |= BRIDGE_INT_TIMER1;
-	writel(u, bridge_base + BRIDGE_MASK_OFF);
+	enable_irq(timer_irq);
 
 	/*
 	 * Setup new clockevent timer value.
@@ -122,8 +110,7 @@ orion_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 		/*
 		 * Enable timer interrupt.
 		 */
-		u = readl(bridge_base + BRIDGE_MASK_OFF);
-		writel(u | BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
+		enable_irq(timer_irq);
 
 		/*
 		 * Enable timer.
@@ -141,14 +128,7 @@ orion_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 		/*
 		 * Disable timer interrupt.
 		 */
-		u = readl(bridge_base + BRIDGE_MASK_OFF);
-		writel(u & ~BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
-
-		/*
-		 * ACK pending timer interrupt.
-		 */
-		writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
-
+		disable_irq(timer_irq);
 	}
 	local_irq_restore(flags);
 }
@@ -164,10 +144,6 @@ static struct clock_event_device orion_clkevt = {
 
 static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
 {
-	/*
-	 * ACK timer interrupt and call event handler.
-	 */
-	writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
 	orion_clkevt.event_handler(&orion_clkevt);
 
 	return IRQ_HANDLED;
@@ -186,16 +162,14 @@ orion_time_set_base(void __iomem *_timer_base)
 }
 
 void __init
-orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
-		unsigned int irq, unsigned int tclk)
+orion_time_init(unsigned int irq, unsigned int tclk)
 {
 	u32 u;
 
 	/*
 	 * Set SoC-specific data.
 	 */
-	bridge_base = _bridge_base;
-	bridge_timer1_clr_mask = _bridge_timer1_clr_mask;
+	timer_irq = irq;
 
 	ticks_per_jiffy = (tclk + HZ/2) / HZ;
 
@@ -210,8 +184,6 @@ orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
 	 */
 	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
 	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
-	u = readl(bridge_base + BRIDGE_MASK_OFF);
-	writel(u & ~BRIDGE_INT_TIMER0, bridge_base + BRIDGE_MASK_OFF);
 	u = readl(timer_base + TIMER_CTRL_OFF);
 	writel(u | TIMER0_EN | TIMER0_RELOAD_EN, timer_base + TIMER_CTRL_OFF);
 	clocksource_mmio_init(timer_base + TIMER0_VAL_OFF, "orion_clocksource",
@@ -220,7 +192,7 @@ orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
 	/*
 	 * Setup clockevent timer (interrupt-driven).
 	 */
-	setup_irq(irq, &orion_timer_irq);
+	setup_irq(timer_irq, &orion_timer_irq);
 	orion_clkevt.mult = div_sc(tclk, NSEC_PER_SEC, orion_clkevt.shift);
 	orion_clkevt.max_delta_ns = clockevent_delta2ns(0xfffffffe, &orion_clkevt);
 	orion_clkevt.min_delta_ns = clockevent_delta2ns(1, &orion_clkevt);
-- 
1.7.5.4
