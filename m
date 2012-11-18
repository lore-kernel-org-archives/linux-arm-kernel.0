From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Nov 2012 16:29:44 +0000
Subject: [PATCH] Dove: Attempt to fix PMU/RTC interrupts
Message-ID: <20121118162944.GV3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the acknowledgement of PMU interrupts on Dove: some Dove hardware
has not been sensibly designed so that interrupts can be handled in a
race free manner.  The PMU is one such instance.

The pending (aka 'cause') register is a bunch of RW bits, meaning that
these bits can be both cleared and set by software (confirmed on the
Armada-510 on the cubox.)

Hardware sets the appropriate bit when an interrupt is asserted, and
software is required to clear the bits which are to be processed.  If
we write ~(1 << bit), then we end up asserting every other interrupt
except the one we're processing.  So, we need to do a read-modify-write
cycle to clear the asserted bit.

However, any interrupts which occur in the middle of this cycle will
also be written back as zero, which will also clear the new interrupts.

The upshot of this is: there is _no_ way to safely clear down interrupts
in this register (and other similarly behaving interrupt pending
registers on this device.)  The patch below at least stops us creating
new interrupts.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
-- 
 arch/arm/mach-dove/irq.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

This should be -rc material - it's a bug; the existing code will cause
an interrupt storm should more than one interrupt in this register be
enabled at the same time.

diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 9bc97a5..8c861ae 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -45,8 +45,20 @@ static void pmu_irq_ack(struct irq_data *d)
 	int pin = irq_to_pmu(d->irq);
 	u32 u;
 
+	/*
+	 * The PMU mask register is not RW0C: it is RW.  This means that
+	 * the bits take whatever value is written to them; if you write
+	 * a '1', you will set the interrupt.
+	 *
+	 * Unfortunately this means there is NO race free way to clear
+	 * these interrupts.
+	 *
+	 * So, let's structure the code so that the window is as small as
+	 * possible.
+	 */
 	u = ~(1 << (pin & 31));
-	writel(u, PMU_INTERRUPT_CAUSE);
+	u &= readl_relaxed(PMU_INTERRUPT_CAUSE);
+	writel_relaxed(u, PMU_INTERRUPT_CAUSE);
 }
 
 static struct irq_chip pmu_irq_chip = {
