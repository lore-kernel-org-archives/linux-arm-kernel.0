From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 11 Feb 2016 14:34:18 +0000
Subject: [RFC v2 11/15] msi: Add a new MSI_FLAG_IRQ_REMAPPING flag
In-Reply-To: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
References: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1455201262-5259-12-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's introduce a new msi_domain_info flag value, MSI_FLAG_IRQ_REMAPPING
meant to tell the domain supports IRQ REMAPPING, also known as Interrupt
Translation Service. On Intel HW this capability is abstracted on IOMMU
side while on ARM it is abstracted on MSI controller side.

GICv3 ITS HW is the first HW advertising that feature.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 1 +
 include/linux/msi.h              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3447549..a5e0d8b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1544,6 +1544,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 		inner_domain->parent = parent;
 		inner_domain->bus_token = DOMAIN_BUS_NEXUS;
 		info->ops = &its_msi_domain_ops;
+		info->flags |= MSI_FLAG_IRQ_REMAPPING;
 		info->data = its;
 		inner_domain->host_data = info;
 	}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a2a0068..03eda72 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -261,6 +261,8 @@ enum {
 	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
 	/* Support PCI MSIX interrupts */
 	MSI_FLAG_PCI_MSIX		= (1 << 4),
+	/* Support MSI IRQ remapping service */
+	MSI_FLAG_IRQ_REMAPPING		= (1 << 5),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
-- 
1.9.1
