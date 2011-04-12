From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Apr 2011 19:35:40 +0100
Subject: [PATCH 6/6] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
Message-ID: <1302633340-4795-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the gic uses handle_level_irq for handling SPIs (Shared
Peripheral Interrupts), requiring active interrupts to be masked at
the distributor level during IRQ handling.

On a virtualised system, only the CPU interfaces are virtualised in
hardware. Accesses to the distributor must be trapped by the
hypervisor, adding latency to the critical interrupt path in Linux.

This patch modifies the GIC code to use handle_fasteoi_irq for handling
interrupts, which only requires us to signal EOI to the CPU interface
when handling is complete. Cascaded IRQ handling is also updated to use
the chained IRQ enter/exit functions to honour the flow control of the
parent chip.

Note that commit 846afbd1 ("GIC: Dont disable INT in ack callback")
broke cascading interrupts by forgetting to add IRQ masking. This is
no longer an issue because the unmask call is now unnecessary.

Tested on Versatile Express and Realview EB (1176 w/ cascaded GICs).

Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/common/gic.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index f70ec7d..e9c2ff8 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -49,7 +49,7 @@ struct gic_chip_data {
  * Default make them NULL.
  */
 struct irq_chip gic_arch_extn = {
-	.irq_ack	= NULL,
+	.irq_eoi	= NULL,
 	.irq_mask	= NULL,
 	.irq_unmask	= NULL,
 	.irq_retrigger	= NULL,
@@ -84,15 +84,6 @@ static inline unsigned int gic_irq(struct irq_data *d)
 /*
  * Routines to acknowledge, disable and enable interrupts
  */
-static void gic_ack_irq(struct irq_data *d)
-{
-	spin_lock(&irq_controller_lock);
-	if (gic_arch_extn.irq_ack)
-		gic_arch_extn.irq_ack(d);
-	writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
-	spin_unlock(&irq_controller_lock);
-}
-
 static void gic_mask_irq(struct irq_data *d)
 {
 	u32 mask = 1 << (d->irq % 32);
@@ -115,6 +106,17 @@ static void gic_unmask_irq(struct irq_data *d)
 	spin_unlock(&irq_controller_lock);
 }
 
+static void gic_eoi_irq(struct irq_data *d)
+{
+	if (gic_arch_extn.irq_eoi) {
+		spin_lock(&irq_controller_lock);
+		gic_arch_extn.irq_eoi(d);
+		spin_unlock(&irq_controller_lock);
+	}
+
+	writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+}
+
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	void __iomem *base = gic_dist_base(d);
@@ -218,8 +220,7 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	unsigned int cascade_irq, gic_irq;
 	unsigned long status;
 
-	/* primary controller ack'ing */
-	chip->irq_ack(&desc->irq_data);
+	chained_irq_enter(chip, desc);
 
 	spin_lock(&irq_controller_lock);
 	status = readl(chip_data->cpu_base + GIC_CPU_INTACK);
@@ -236,15 +237,14 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 		generic_handle_irq(cascade_irq);
 
  out:
-	/* primary controller unmasking */
-	chip->irq_unmask(&desc->irq_data);
+	chained_irq_exit(chip, desc);
 }
 
 static struct irq_chip gic_chip = {
 	.name			= "GIC",
-	.irq_ack		= gic_ack_irq,
 	.irq_mask		= gic_mask_irq,
 	.irq_unmask		= gic_unmask_irq,
+	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_retrigger		= gic_retrigger,
 #ifdef CONFIG_SMP
@@ -319,7 +319,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 	 * Setup the Linux IRQ subsystem.
 	 */
 	for (i = irq_start; i < irq_limit; i++) {
-		irq_set_chip_and_handler(i, &gic_chip, handle_level_irq);
+		irq_set_chip_and_handler(i, &gic_chip, handle_fasteoi_irq);
 		irq_set_chip_data(i, gic);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 	}
-- 
1.7.0.4
