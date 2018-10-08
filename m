From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Mon, 8 Oct 2018 11:24:41 +0800
Subject: [PATCH v6 2/9] PCI: mediatek: Fixup class ID for MT7622 as
 PCI_CLASS_BRIDGE_PCI
In-Reply-To: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The PCIe controller of MT7622 has TYPE 1 configuration space type, but
the HW default class type values is invalid.

The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class
type for MT7622") have set the class ID for MT7622 as
PCI_CLASS_BRIDGE_HOST, but it's not workable for MT7622:

In __pci_bus_assign_resources, the framework only setup bridge's
resource window only if class type is PCI_CLASS_BRIDGE_PCI. Or it
will leave the subordinary PCIe device's MMIO window un-touched.

Fixup the class type to PCI_CLASS_BRIDGE_PCI as most of the controller
driver do.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 288b8e2..bcdac9b 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -432,7 +432,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		val = PCI_VENDOR_ID_MEDIATEK;
 		writew(val, port->base + PCIE_CONF_VEND_ID);
 
-		val = PCI_CLASS_BRIDGE_HOST;
+		val = PCI_CLASS_BRIDGE_PCI;
 		writew(val, port->base + PCIE_CONF_CLASS_ID);
 	}
 
-- 
2.6.4
