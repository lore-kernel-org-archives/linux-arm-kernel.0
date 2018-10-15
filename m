From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Mon, 15 Oct 2018 16:08:53 +0800
Subject: [PATCH v8 2/9] PCI: mediatek: Fix class type for MT7622 as
 PCI_CLASS_BRIDGE_PCI
In-Reply-To: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1539590940-13355-3-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class
type for MT7622") have set the class type for MT7622 as un-properly
value of PCI_CLASS_BRIDGE_HOST.

The PCIe controller of MT7622 is complexed with Root Port and PCI-to-PCI
bridge, the bridge has type 1 configuration space header and related bridge
windows. The HW default value of this bridge's class type is invalid. Fix
its class type as PCI_CLASS_BRIDGE_PCI since it is HW defines.

Making the bridge visiable to PCI framework by setting its class type
properly will get its bridge windows configurated during PCI device
enumerate.

Fixes: 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class type for MT7622")
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
