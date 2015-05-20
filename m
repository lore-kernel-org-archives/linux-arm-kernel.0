From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 20 May 2015 18:00:13 +0800
Subject: [RFC v1 25/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1432116013-25902-26-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/dma/ipu/ipu_irq.c       |    6 ++++--
 drivers/gpu/ipu-v3/ipu-common.c |    4 ++--
 drivers/pci/host/pci-keystone.c |    7 ++++---
 drivers/spmi/spmi-pmic-arb.c    |    2 +-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
index 0e12af37fe2f..edd12278dc3e 100644
--- a/drivers/dma/ipu/ipu_irq.c
+++ b/drivers/dma/ipu/ipu_irq.c
@@ -266,8 +266,9 @@ int ipu_irq_unmap(unsigned int source)
 }
 
 /* Chained IRQ handler for IPU error interrupt */
-static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
+static void ipu_irq_err(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_to_irq(desc);
 	struct ipu *ipu = irq_desc_get_handler_data(desc);
 	u32 status;
 	int i, line;
@@ -307,8 +308,9 @@ static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
 }
 
 /* Chained IRQ handler for IPU function interrupt */
-static void ipu_irq_fn(unsigned int irq, struct irq_desc *desc)
+static void ipu_irq_fn(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_to_irq(desc);
 	struct ipu *ipu = irq_desc_get_handler_data(desc);
 	u32 status;
 	int i, line;
diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 7022825b7a2c..1125b03c36af 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -912,7 +912,7 @@ static void ipu_irq_handle(struct ipu_soc *ipu, const int *regs, int num_regs)
 	}
 }
 
-static void ipu_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ipu_irq_handler(struct irq_desc *desc)
 {
 	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -925,7 +925,7 @@ static void ipu_irq_handler(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void ipu_err_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ipu_err_irq_handler(struct irq_desc *desc)
 {
 	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 75333b0c4f0a..659a73da372c 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -112,8 +112,9 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 	return 0;
 }
 
-static void ks_pcie_msi_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_to_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	u32 offset = irq - ks_pcie->msi_host_irqs[0];
 	struct pcie_port *pp = &ks_pcie->pp;
@@ -133,14 +134,14 @@ static void ks_pcie_msi_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 /**
  * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
- * @irq: IRQ line for legacy interrupts
  * @desc: Pointer to irq descriptor
  *
  * Traverse through pending legacy interrupts and invoke handler for each. Also
  * takes care of interrupt controller level mask/ack operation.
  */
-static void ks_pcie_legacy_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_to_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	struct pcie_port *pp = &ks_pcie->pp;
 	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index b32cb0a813cb..d7e7846917ae 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -451,7 +451,7 @@ static void periph_interrupt(struct spmi_pmic_arb_dev *pa, u8 apid)
 	}
 }
 
-static void pmic_arb_chained_irq(unsigned int irq, struct irq_desc *desc)
+static void pmic_arb_chained_irq(struct irq_desc *desc)
 {
 	struct spmi_pmic_arb_dev *pa = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-- 
1.7.10.4
