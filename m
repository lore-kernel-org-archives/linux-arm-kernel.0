From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 13:18:30 +0100
Subject: [PATCH] irqchip/sirfsoc: fix sparse warnings on __iomem
Message-ID: <1465301910-2308-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warnings from sparse about casting to __iomem from non anotated
variable:

drivers/irqchip/irq-sirfsoc.c:56:47: warning: incorrect type in initializer (different address spaces)
drivers/irqchip/irq-sirfsoc.c:56:47:    expected void [noderef] <asn:2>*base
drivers/irqchip/irq-sirfsoc.c:56:47:    got void *host_data
drivers/irqchip/irq-sirfsoc.c:97:47: warning: incorrect type in initializer (different address spaces)
drivers/irqchip/irq-sirfsoc.c:97:47:    expected void [noderef] <asn:2>*base
drivers/irqchip/irq-sirfsoc.c:97:47:    got void *host_data
drivers/irqchip/irq-sirfsoc.c:109:47: warning: incorrect type in initializer (different address spaces)
drivers/irqchip/irq-sirfsoc.c:109:47:    expected void [noderef] <asn:2>*base
drivers/irqchip/irq-sirfsoc.c:109:47:    got void *host_data

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/irqchip/irq-sirfsoc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
index 10cb21b..e133684 100644
--- a/drivers/irqchip/irq-sirfsoc.c
+++ b/drivers/irqchip/irq-sirfsoc.c
@@ -29,6 +29,11 @@
 
 static struct irq_domain *sirfsoc_irqdomain;
 
+static void __iomem *sirfsoc_irq_get_regbase(void)
+{
+	return (void __iomem __force *)sirfsoc_irqdomain->host_data;
+}
+
 static __init void sirfsoc_alloc_gc(void __iomem *base)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
@@ -53,7 +58,7 @@ static __init void sirfsoc_alloc_gc(void __iomem *base)
 
 static void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
 {
-	void __iomem *base = sirfsoc_irqdomain->host_data;
+	void __iomem *base = sirfsoc_irq_get_regbase();
 	u32 irqstat;
 
 	irqstat = readl_relaxed(base + SIRFSOC_INIT_IRQ_ID);
@@ -94,7 +99,7 @@ static struct sirfsoc_irq_status sirfsoc_irq_st;
 
 static int sirfsoc_irq_suspend(void)
 {
-	void __iomem *base = sirfsoc_irqdomain->host_data;
+	void __iomem *base = sirfsoc_irq_get_regbase();
 
 	sirfsoc_irq_st.mask0 = readl_relaxed(base + SIRFSOC_INT_RISC_MASK0);
 	sirfsoc_irq_st.mask1 = readl_relaxed(base + SIRFSOC_INT_RISC_MASK1);
@@ -106,7 +111,7 @@ static int sirfsoc_irq_suspend(void)
 
 static void sirfsoc_irq_resume(void)
 {
-	void __iomem *base = sirfsoc_irqdomain->host_data;
+	void __iomem *base = sirfsoc_irq_get_regbase();
 
 	writel_relaxed(sirfsoc_irq_st.mask0, base + SIRFSOC_INT_RISC_MASK0);
 	writel_relaxed(sirfsoc_irq_st.mask1, base + SIRFSOC_INT_RISC_MASK1);
-- 
2.8.1
