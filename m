From: esndbod@gmail.com (Bodo-Merle Sandor)
Date: Sat,  7 Oct 2017 14:08:44 +0200
Subject: [PATCH] PCI: iproc: Allow allocation of multiple MSIs
Message-ID: <20171007120851.20230-1-sbodomerle@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandor Bodo-Merle <sbodomerle@gmail.com>

Add support for allocating multiple MSIs at the same time, so that the
MSI_FLAG_MULTI_PCI_MSI flag can be added to the msi_domain_info
structure.

Avoid storing the hwirq in the low 5 bits of the message data, as it is
used by the device. Also fix an endianness problem by using readl().

Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
---
 drivers/pci/host/pcie-iproc-msi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/host/pcie-iproc-msi.c
index 2d0f535a2f69..990fc906d73d 100644
--- a/drivers/pci/host/pcie-iproc-msi.c
+++ b/drivers/pci/host/pcie-iproc-msi.c
@@ -179,7 +179,7 @@ static struct irq_chip iproc_msi_irq_chip = {
 
 static struct msi_domain_info iproc_msi_domain_info = {
 	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_PCI_MSIX,
+		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
 	.chip = &iproc_msi_irq_chip,
 };
 
@@ -237,7 +237,7 @@ static void iproc_msi_irq_compose_msi_msg(struct irq_data *data,
 	addr = msi->msi_addr + iproc_msi_addr_offset(msi, data->hwirq);
 	msg->address_lo = lower_32_bits(addr);
 	msg->address_hi = upper_32_bits(addr);
-	msg->data = data->hwirq;
+	msg->data = data->hwirq << 5;
 }
 
 static struct irq_chip iproc_msi_bottom_irq_chip = {
@@ -251,7 +251,7 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
 				      void *args)
 {
 	struct iproc_msi *msi = domain->host_data;
-	int hwirq;
+	int hwirq, i;
 
 	mutex_lock(&msi->bitmap_lock);
 
@@ -267,10 +267,14 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
 
 	mutex_unlock(&msi->bitmap_lock);
 
-	irq_domain_set_info(domain, virq, hwirq, &iproc_msi_bottom_irq_chip,
-			    domain->host_data, handle_simple_irq, NULL, NULL);
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &iproc_msi_bottom_irq_chip,
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
+	}
 
-	return 0;
+	return hwirq;
 }
 
 static void iproc_msi_irq_domain_free(struct irq_domain *domain,
@@ -302,7 +306,8 @@ static inline u32 decode_msi_hwirq(struct iproc_msi *msi, u32 eq, u32 head)
 
 	offs = iproc_msi_eq_offset(msi, eq) + head * sizeof(u32);
 	msg = (u32 *)(msi->eq_cpu + offs);
-	hwirq = *msg & IPROC_MSI_EQ_MASK;
+	hwirq = readl(msg);
+	hwirq = (hwirq >> 5) + (hwirq & 0x1f);
 
 	/*
 	 * Since we have multiple hwirq mapped to a single MSI vector,
-- 
2.15.0.rc0
