From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Sep 2011 14:49:14 +0200
Subject: [PATCH 2/4] ARM i.MX tzic: add handle_irq function
In-Reply-To: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
References: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1316522956-28530-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/common.h |    4 ++++
 arch/arm/plat-mxc/tzic.c                |   24 +++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 8de0d0c..2e8802b 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -74,6 +74,7 @@ extern int mx53_revision(void);
 extern int mx53_display_revision(void);
 
 void avic_handle_irq(struct pt_regs *);
+void tzic_handle_irq(struct pt_regs *);
 
 #define mx1_handle_irq avic_handle_irq
 #define mx21_handle_irq avic_handle_irq
@@ -81,5 +82,8 @@ void avic_handle_irq(struct pt_regs *);
 #define mx27_handle_irq avic_handle_irq
 #define mx31_handle_irq avic_handle_irq
 #define mx35_handle_irq avic_handle_irq
+#define mx50_handle_irq tzic_handle_irq
+#define mx51_handle_irq tzic_handle_irq
+#define mx53_handle_irq tzic_handle_irq
 
 #endif
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index f257fcc..b7a272d 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -42,7 +42,7 @@
 #define TZIC_SRCCLAR0	0x0280	/* Source Clear Register 0 */
 #define TZIC_PRIORITY0	0x0400	/* Priority Register 0 */
 #define TZIC_PND0	0x0D00	/* Pending Register 0 */
-#define TZIC_HIPND0	0x0D80	/* High Priority Pending Register */
+#define TZIC_HIPND(i)	(0x0D80+ ((i) << 2))	/* High Priority Pending Register */
 #define TZIC_WAKEUP0(i)	(0x0E00 + ((i) << 2))	/* Wakeup Config Register */
 #define TZIC_SWINT	0x0F00	/* Software Interrupt Rigger Register */
 #define TZIC_ID0	0x0FD0	/* Indentification Register 0 */
@@ -96,6 +96,28 @@ static __init void tzic_init_gc(unsigned int irq_start)
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, IRQ_NOREQUEST, 0);
 }
 
+asmlinkage void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
+{
+	u32 stat;
+	int i, irqofs, handled;
+
+	do {
+		handled = 0;
+
+		for (i = 0; i < 4; i++) {
+			stat = __raw_readl(tzic_base + TZIC_HIPND(i)) &
+				__raw_readl(tzic_base + TZIC_INTSEC0(i));
+
+			while (stat) {
+				handled = 1;
+				irqofs = fls(stat) - 1;
+				handle_IRQ(irqofs + i * 32, regs);
+				stat &= ~(1 << irqofs);
+			}
+		}
+	} while (handled);
+}
+
 /*
  * This function initializes the TZIC hardware and disables all the
  * interrupts. It registers the interrupt enable and disable functions
-- 
1.7.6.3
