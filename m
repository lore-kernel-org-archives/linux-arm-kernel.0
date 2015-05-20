From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 20 May 2015 17:59:59 +0800
Subject: [RFC v1 11/25] keystone,
 irq: Use irq_data_get_xxx() to avoid redundant lookup of irq_data
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1432116013-25902-12-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_data_get_xxx() to avoid redundant lookup of irq_data while we
already have a pointer to corresponding irq_data.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/host/pci-keystone-dw.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index f34892e0edb4..e42d077039d3 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -104,14 +104,13 @@ static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
 {
 	u32 offset, reg_offset, bit_pos;
 	struct keystone_pcie *ks_pcie;
-	unsigned int irq = d->irq;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
 
-	msi = irq_get_msi_desc(irq);
+	msi = irq_data_get_msi_desc(d);
 	pp = sys_to_pcie(msi->dev->bus->sysdata);
 	ks_pcie = to_keystone_pcie(pp);
-	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
+	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
 
 	writel(BIT(bit_pos),
@@ -142,15 +141,14 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 {
 	struct keystone_pcie *ks_pcie;
-	unsigned int irq = d->irq;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
 	u32 offset;
 
-	msi = irq_get_msi_desc(irq);
+	msi = irq_data_get_msi_desc(d);
 	pp = sys_to_pcie(msi->dev->bus->sysdata);
 	ks_pcie = to_keystone_pcie(pp);
-	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
+	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
 	/* Mask the end point if PVM implemented */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -164,15 +162,14 @@ static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
 {
 	struct keystone_pcie *ks_pcie;
-	unsigned int irq = d->irq;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
 	u32 offset;
 
-	msi = irq_get_msi_desc(irq);
+	msi = irq_data_get_msi_desc(d);
 	pp = sys_to_pcie(msi->dev->bus->sysdata);
 	ks_pcie = to_keystone_pcie(pp);
-	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
+	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
 	/* Mask the end point if PVM implemented */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-- 
1.7.10.4
