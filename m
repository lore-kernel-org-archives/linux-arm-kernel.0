From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Feb 2014 18:28:42 +0100
Subject: [PATCH 6/7] PCI: designware: use new OF interrupt mapping when
 possible
In-Reply-To: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1393608523-17509-7-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the recommended method of doing the IRQ
mapping. For old devicetrees we fall back to the
previous practice.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pcie-designware.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 17ce88f79d2b..3e0c2af11528 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/types.h>
@@ -738,8 +739,13 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
+	int irq;
 
-	return pp->irq;
+	irq = of_irq_parse_and_map_pci(dev, slot, pin);
+	if (!irq)
+		irq = pp->irq;
+
+	return irq;
 }
 
 static void dw_pcie_add_bus(struct pci_bus *bus)
-- 
1.8.5.3
