From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 11 Nov 2014 15:48:00 +0000
Subject: [PATCH 02/15] PCI/MSI: genirq: allow architecture-specific override
 of flow handler
In-Reply-To: <1415720893-13371-1-git-send-email-marc.zyngier@arm.com>
References: <1415720893-13371-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1415720893-13371-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM interrupt controllers tend to use a "fasteoi" handler rather than
the expected "edge". Allow the architecture to override the function
call setting up the flow handler by defining arch_msi_irq_set_handler.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/msi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 8de7c87..6fea997 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1113,6 +1113,11 @@ msi_get_hwirq(struct pci_dev *dev, struct msi_desc *desc)
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
 
+void __weak arch_msi_irq_set_handler(unsigned int virq)
+{
+	__irq_set_handler(virq, handle_edge_irq, 0, "edge");
+}
+
 static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 			    unsigned int nr_irqs, void *arg)
 {
@@ -1130,7 +1135,7 @@ static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
 					      domain->host_data,
 					      (void *)(long)i);
-		__irq_set_handler(virq + i, handle_edge_irq, 0, "edge");
+		arch_msi_irq_set_handler(virq + i);
 	}
 
 	return ret;
-- 
2.0.4
