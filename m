From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Thu, 21 Dec 2017 10:11:17 +0800
Subject: [PATCH v2 2/2] PCI: mediatek: Fixup class type for MT7622
In-Reply-To: <1513822277-18329-1-git-send-email-honghui.zhang@mediatek.com>
References: <1513822277-18329-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1513822277-18329-3-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The host bridge of MT7622 has hardware code the class code to an
arbitrary, meaningless value, fix that.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 3248771..ae8d367 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -1174,3 +1174,15 @@ static struct platform_driver mtk_pcie_driver = {
 	},
 };
 builtin_platform_driver(mtk_pcie_driver);
+
+/* The host bridge of MT7622 advertises the wrong device class. */
+static void mtk_fixup_class(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+
+/*
+ * The HW default value of vendor id and device id for mt7622 are 0x0e8d,
+ * 0x3258, which are arbitrary, meaningless values.
+ */
+DECLARE_PCI_FIXUP_EARLY(0x0e8d, 0x3258, mtk_fixup_class);
-- 
2.6.4
