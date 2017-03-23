From: sr@denx.de (Stefan Roese)
Date: Thu, 23 Mar 2017 13:34:29 +0100
Subject: [PATCH] irqchip/armada-370-xp: Correctly align bits in 'msi_used'
 bitmap (multi-MSI)
Message-ID: <20170323123429.11145-1-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Testing on an Armada XP platform has shown, that requesting 4 MSI vectors
may lead to a MSI message data value of 0x0f15 on a PCIe device
supporting 4 MSI vectors. This MSI message data register needs to be
aligned to power-of-2 of the supported vector count [1]. The result from
this setup was, that 0x0f14 has been written into this data register
and therefore not all interrupt vectors were available, or even worse,
an incorrect (off by one) IRQ was trigger by the PCIe device.

This patch now fixes this issue by making sure, that the bits are
correctly aligned in the 'msi_used' bitmap. Resulting in the example
from above in a MSI message data value of 0x0f18.

[1] PCI Local Bus Spec: 6.8.1.6

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-armada-370-xp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index eb0d4d41b156..793862978f19 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -151,11 +151,24 @@ static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
 	int hwirq, i;
+	int nr_irqs_pow2;
+
+	/*
+	 * Round number of requested irqs up to next power of 2. This is
+	 * needed since the MSI message data register in the configuration
+	 * space is only allowed to have the low order bits changed for
+	 * multi MSI vectors. This result will be used to allocated the
+	 * bits in the "msi_used" bitmap for the hwirq vectors, this time
+	 * aligned to "nr_irqs_pow2".
+	 *
+	 * Please look at PCI Local Bus Spec: 6.8.1.6 for further details.
+	 */
+	nr_irqs_pow2 = 1 << fls(nr_irqs - 1);
 
 	mutex_lock(&msi_used_lock);
 
 	hwirq = bitmap_find_next_zero_area(msi_used, PCI_MSI_DOORBELL_NR,
-					   0, nr_irqs, 0);
+					   0, nr_irqs, nr_irqs_pow2 - 1);
 	if (hwirq >= PCI_MSI_DOORBELL_NR) {
 		mutex_unlock(&msi_used_lock);
 		return -ENOSPC;
-- 
2.12.1
