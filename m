From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 27 Jan 2010 08:49:12 -0500
Subject: [PATCH] mmp2: add handling on PMIC IRQ
Message-ID: <mailman.175.1264572534.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since PMIC INT pin is a special pin of CPU, the status of PMIC INT pin needs
to be cleared after PMIC IRQ occured. Now append the clear operation in
irq chip handler.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/irq-mmp2.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index 41b29f6..761abe3 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -62,7 +62,9 @@ static void _name_##_unmask_irq(unsigned int irq)			\
 static void _name_##_irq_demux(unsigned int irq, struct irq_desc *desc)	\
 {									\
 	unsigned long status, mask, n;					\
+	unsigned long mfpr_pmic, data;					\
 	mask = __raw_readl(prefix##_MASK);				\
+	mfpr_pmic = APB_VIRT_BASE + 0x1e000 + 0x2c4;			\
 	while (1) {							\
 		status = __raw_readl(prefix##_STATUS) & ~mask;		\
 		if (status == 0)					\
@@ -70,6 +72,11 @@ static void _name_##_irq_demux(unsigned int irq,
struct irq_desc *desc)	\
 		n = find_first_bit(&status, BITS_PER_LONG);		\
 		while (n < BITS_PER_LONG) {				\
 			generic_handle_irq(irq_base + n);		\
+			if ((irq_base + n) == IRQ_MMP2_PMIC) {		\
+				data = __raw_readl(mfpr_pmic);		\
+				__raw_writel(data | (1 << 6), mfpr_pmic); \
+				__raw_writel(data, mfpr_pmic);		\
+			}						\
 			n = find_next_bit(&status, BITS_PER_LONG, n+1);	\
 		}							\
 	}								\
-- 
1.5.6.5
