From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 27 Feb 2014 17:19:53 -0800
Subject: [PATCH 2/3] PCI: designware: add ability for custom swizzle
In-Reply-To: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1393550394-11071-3-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ability for a platform driver to provide a host-specific
swizzle function.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pcie-designware.c | 3 +++
 drivers/pci/host/pcie-designware.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 5808177..a143f2a 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -480,6 +480,9 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
+	if (pp->swizzle)
+		dw_pci.swizzle = pp->swizzle;
+
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
 	/* program correct class for RC */
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 5c596c0..8631d56 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -53,6 +53,7 @@ struct pcie_port {
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+	u8			(*swizzle)(struct pci_dev *, u8 *);
 };
 
 struct pcie_host_ops {
-- 
1.8.3.2
