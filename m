From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 27 Apr 2011 22:48:05 +0800
Subject: [PATCH 2/2] ARM: pxa: introduce {icip,
	ichp}_handle_irq() to prepare MULTI_IRQ_HANDLER
In-Reply-To: <1303915685-14823-1-git-send-email-eric.y.miao@gmail.com>
References: <1303915685-14823-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1303915685-14823-2-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/irqs.h |    3 +++
 arch/arm/mach-pxa/irq.c               |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index a94c694..564337d 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -106,9 +106,12 @@
 
 #ifndef __ASSEMBLY__
 struct irq_data;
+struct pt_regs;
 
 void pxa_mask_irq(struct irq_data *);
 void pxa_unmask_irq(struct irq_data *);
+void icip_handle_irq(struct pt_regs *);
+void ichp_handle_irq(struct pt_regs *);
 #endif
 
 #endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 0aeeff4..38be164 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -37,6 +37,8 @@
 #define IPR(i)			(((i) < 32) ? (0x01c + ((i) << 2)) :		\
 				((i) < 64) ? (0x0b0 + (((i) - 32) << 2)) :	\
 				      (0x144 + (((i) - 64) << 2)))
+#define ICHP_VAL_IRQ		(1 << 31)
+#define ICHP_IRQ(i)		(((i) >> 16) & 0x7fff)
 #define IPR_VALID		(1 << 31)
 #define IRQ_BIT(n)		(((n) - PXA_IRQ(0)) & 0x1f)
 
@@ -127,6 +129,36 @@ static struct irq_chip pxa_low_gpio_chip = {
 	.irq_set_type	= pxa_set_low_gpio_type,
 };
 
+asmlinkage void __exception_irq_entry icip_handle_irq(struct pt_regs *regs)
+{
+	uint32_t icip, icmr, mask;
+
+	do {
+		icip = __raw_readl(IRQ_BASE + ICIP);
+		icmr = __raw_readl(IRQ_BASE + ICMR);
+		mask = icip & icmr;
+
+		if (mask == 0)
+			break;
+
+		asm_do_IRQ(fls(mask) - 1, regs);
+	} while (1);
+}
+
+asmlinkage void __exception_irq_entry ichp_handle_irq(struct pt_regs *regs)
+{
+	uint32_t ichp;
+
+	do {
+		__asm__ __volatile__("mrc p6, 0, %0, c5, c0, 0\n": "=r"(ichp));
+
+		if ((ichp & ICHP_VAL_IRQ) == 0)
+			break;
+
+		asm_do_IRQ(PXA_IRQ(ICHP_IRQ(ichp)), regs);
+	} while (1);
+}
+
 static void __init pxa_init_low_gpio_irq(set_wake_t fn)
 {
 	int irq;
-- 
1.7.1
