From: eric.auger@linaro.org (Eric Auger)
Date: Tue,  1 Mar 2016 18:27:51 +0000
Subject: [RFC v5 11/17] msi: msi_compose wrapper
In-Reply-To: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
References: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1456856877-4817-12-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the MSI message is composed by directly calling
irq_chip_compose_msi_msg and erased by setting the memory to zero.

On some platforms, we will need to complexify this composition to
properly handle MSI emission through IOMMU. Also we will need to track
when the MSI message is erased.

We propose to introduce a common wrapper for actual composition and
erasure, msi_compose.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v4 -> v5:
- just introduce the msi-compose wrapper without adding new
  functionalities

v3 -> v4:
- that code was formely in irq-gic-common.c
  "irqchip/gicv2m/v3-its-pci-msi: IOMMU map the MSI frame when needed"
  also the [un]mapping was done in irq_write_msi_msg; now done on compose

v2 -> v3:
- protect iova/addr manipulation with CONFIG_ARCH_DMA_ADDR_T_64BIT and
  CONFIG_PHYS_ADDR_T_64BIT
- only expose gic_pci_msi_domain_write_msg in case CONFIG_IOMMU_API &
  CONFIG_PCI_MSI_IRQ_DOMAIN are set.
- gic_set/unset_msi_addr duly become static
---
 kernel/irq/msi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 9b0ba4a..72bf4d6 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -55,6 +55,19 @@ static inline void irq_chip_write_msi_msg(struct irq_data *data,
 	data->chip->irq_write_msi_msg(data, msg);
 }
 
+static int msi_compose(struct irq_data *irq_data,
+		       struct msi_msg *msg, bool erase)
+{
+	int ret = 0;
+
+	if (erase)
+		memset(msg, 0, sizeof(*msg));
+	else
+		ret = irq_chip_compose_msi_msg(irq_data, msg);
+
+	return ret;
+}
+
 /**
  * msi_domain_set_affinity - Generic affinity setter function for MSI domains
  * @irq_data:	The irq data associated to the interrupt
@@ -73,7 +86,7 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
-		BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
+		BUG_ON(msi_compose(irq_data, &msg, false));
 		irq_chip_write_msi_msg(irq_data, &msg);
 	}
 
@@ -85,7 +98,7 @@ static void msi_domain_activate(struct irq_domain *domain,
 {
 	struct msi_msg msg;
 
-	BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
+	BUG_ON(msi_compose(irq_data, &msg, false));
 	irq_chip_write_msi_msg(irq_data, &msg);
 }
 
@@ -94,7 +107,7 @@ static void msi_domain_deactivate(struct irq_domain *domain,
 {
 	struct msi_msg msg;
 
-	memset(&msg, 0, sizeof(msg));
+	msi_compose(irq_data, &msg, true);
 	irq_chip_write_msi_msg(irq_data, &msg);
 }
 
-- 
1.9.1
