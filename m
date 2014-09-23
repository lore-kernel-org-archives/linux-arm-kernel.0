From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Tue, 23 Sep 2014 22:28:59 +0800
Subject: [PATCH v3 2/3] PCI: designware: Add get_msi_data() to pcie_host_ops
In-Reply-To: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <1411482540-31297-4-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds get_msi_data() for some platforms to return their
special MSI message data.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Change log:
v3: no change
v2: no change just derived from v1

 drivers/pci/host/pcie-designware.c | 7 ++++++-
 drivers/pci/host/pcie-designware.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1c09f814..c28ca05 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -366,7 +366,12 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 	else
 		msg.address_lo = virt_to_phys((void *)pp->msi_data);
 	msg.address_hi = 0x0;
-	msg.data = pos;
+
+	if (pp->ops->get_msi_data)
+		msg.data = pp->ops->get_msi_data(pp, pos);
+	else
+		msg.data = pos;
+
 	write_msi_msg(irq, &msg);
 
 	return 0;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 904e40a..c625675 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -71,6 +71,7 @@ struct pcie_host_ops {
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
 	u32 (*get_msi_addr)(struct pcie_port *pp);
+	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp, struct msi_chip *chip);
 };
-- 
1.9.1
