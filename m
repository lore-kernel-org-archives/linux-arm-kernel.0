From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  4 Sep 2016 20:59:45 +0200
Subject: [PATCH 1/3] ARM: pxa: pxa_cplds: fix interrupt handling
Message-ID: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since its initial commit, the driver is buggy for multiple interrupts
handling. The translation from the former lubbock.c file was not
complete, and might stall all interrupt handling when multiple
interrupts occur.

This is especially true when inside the interrupt handler and if a new
interrupt comes and is not handled, leaving the output line still held,
and not creating a transition as the GPIO block behind would expect to
trigger another cplds_irq_handler() call.

For the record, the hardware is working as follows.

The interrupt mechanism relies on :
 - one status register
 - one mask register

Let's suppose the input irq lines are called :
 - i_sa1111
 - i_lan91x
 - i_mmc_cd
Let's suppose the status register for each irq line is called :
 - status_sa1111
 - status_lan91x
 - status_mmc_cd
Let's suppose the interrupt mask for each irq line is called :
 - irqen_sa1111
 - irqen_lan91x
 - irqen_mmc_cd
Let's suppose the output irq line, connected to GPIO0 is called :
 - o_gpio0

The behavior is as follows :
 - o_gpio0 = not((status_sa1111 & irqen_sa1111) |
		 (status_lan91x & irqen_lan91x) |
		 (status_mmc_cd & irqen_mmc_cd))
   => this is a N-to-1 NOR gate and multiple AND gates
 - irqen_* is exactly as programmed by a write to the FPGA
 - status_* behavior is governed by a bi-stable D flip-flop
   => on next FPGA clock :
     - if i_xxx is high, status_xxx becomes 1
     - if i_xxx is low, status_xxx remains as it is
     - if software sets status_xxx to 0, the D flip-flop is reset
       => status_xxx becomes 0
       => on next FPGA clock cycle, if i_xxx is high, status_xxx becomes
	  1 again

Fixes: fc9e38c0f4d3 ("ARM: pxa: lubbock: use new pxa_cplds driver")
Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/pxa_cplds_irqs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index 2385052b0ce1..e362f865fcd2 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -41,30 +41,35 @@ static irqreturn_t cplds_irq_handler(int in_irq, void *d)
 	unsigned long pending;
 	unsigned int bit;
 
-	pending = readl(fpga->base + FPGA_IRQ_SET_CLR) & fpga->irq_mask;
-	for_each_set_bit(bit, &pending, CPLDS_NB_IRQ)
-		generic_handle_irq(irq_find_mapping(fpga->irqdomain, bit));
+	do {
+		pending = readl(fpga->base + FPGA_IRQ_SET_CLR) & fpga->irq_mask;
+		for_each_set_bit(bit, &pending, CPLDS_NB_IRQ) {
+			generic_handle_irq(irq_find_mapping(fpga->irqdomain,
+							    bit));
+		}
+	} while (pending);
 
 	return IRQ_HANDLED;
 }
 
-static void cplds_irq_mask_ack(struct irq_data *d)
+static void cplds_irq_mask(struct irq_data *d)
 {
 	struct cplds *fpga = irq_data_get_irq_chip_data(d);
 	unsigned int cplds_irq = irqd_to_hwirq(d);
-	unsigned int set, bit = BIT(cplds_irq);
+	unsigned int bit = BIT(cplds_irq);
 
 	fpga->irq_mask &= ~bit;
 	writel(fpga->irq_mask, fpga->base + FPGA_IRQ_MASK_EN);
-	set = readl(fpga->base + FPGA_IRQ_SET_CLR);
-	writel(set & ~bit, fpga->base + FPGA_IRQ_SET_CLR);
 }
 
 static void cplds_irq_unmask(struct irq_data *d)
 {
 	struct cplds *fpga = irq_data_get_irq_chip_data(d);
 	unsigned int cplds_irq = irqd_to_hwirq(d);
-	unsigned int bit = BIT(cplds_irq);
+	unsigned int set, bit = BIT(cplds_irq);
+
+	set = readl(fpga->base + FPGA_IRQ_SET_CLR);
+	writel(set & ~bit, fpga->base + FPGA_IRQ_SET_CLR);
 
 	fpga->irq_mask |= bit;
 	writel(fpga->irq_mask, fpga->base + FPGA_IRQ_MASK_EN);
@@ -72,7 +77,8 @@ static void cplds_irq_unmask(struct irq_data *d)
 
 static struct irq_chip cplds_irq_chip = {
 	.name		= "pxa_cplds",
-	.irq_mask_ack	= cplds_irq_mask_ack,
+	.irq_ack	= cplds_irq_mask,
+	.irq_mask	= cplds_irq_mask,
 	.irq_unmask	= cplds_irq_unmask,
 	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
 };
-- 
2.1.4
