From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Wed, 27 Jun 2018 17:21:35 +0800
Subject: [PATCH 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
In-Reply-To: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1530091298-28120-2-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Mediatek's host controller have two slots, each have it's own control
registers. The host driver need to identify which slot was connected
in order to access the device's configuration space. There's problem
for current host driver to find out which slot was connected to for
a given EP device.

Assuming each slot have connect with one EP device as below:

                host bridge
  bus 0 --> __________|_______
           |                  |
           |                  |
         slot 0             slot 1
  bus 1 -->|        bus 2 --> |
           |                  |
         EP 0               EP 1

While PCI emulation, system software will scan all the PCI device
starting from devfn 0. So it will get the proper port for slot0 and
slot1 device when using PCI_SLOT(devfn) for match. But it will get
the wrong slot for EP1: The devfn will be start from 0 when scanning
EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
for port0's slot value. So the host driver should not using EP's devfn
but the slot's devfn(the slot which EP was connected to) for match.

This patch fix the mtk_pcie_find_port's logical by using the slot's
devfn for match.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 0baabe3..9cf7ecf 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -337,10 +337,23 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
 {
 	struct mtk_pcie *pcie = bus->sysdata;
 	struct mtk_pcie_port *port;
+	struct pci_dev *dev;
+	struct pci_bus *pbus;
 
-	list_for_each_entry(port, &pcie->ports, list)
-		if (port->slot == PCI_SLOT(devfn))
+	list_for_each_entry(port, &pcie->ports, list) {
+		if (bus->number == 0 && port->slot == PCI_SLOT(devfn)) {
 			return port;
+		} else if (bus->number != 0) {
+			pbus = bus;
+			do {
+				dev = pbus->self;
+				if (port->slot == PCI_SLOT(dev->devfn))
+					return port;
+
+				pbus = dev->bus;
+			} while (dev->bus->number != 0);
+		}
+	}
 
 	return NULL;
 }
-- 
2.6.4
