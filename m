From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 15 Oct 2018 18:37:18 +0530
Subject: [PATCH 16/19] PCI: keystone: Cleanup ks_pcie_link_up()
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
Message-ID: <20181015130721.5535-17-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ks_pcie_link_up() uses registers from the designware core to get the
status of the link. Move the register defines to pcie-designware.h
and cleanup ks_pcie_link_up().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c    | 11 +++--------
 drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 7015a353a614..67646a64c895 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -38,8 +38,6 @@
 
 /* Application register defines */
 #define LTSSM_EN_VAL		        BIT(0)
-#define LTSSM_STATE_MASK		0x1f
-#define LTSSM_STATE_L0			0x11
 #define DBI_CS2				BIT(5)
 #define OB_XLAT_EN_VAL		        BIT(1)
 
@@ -91,11 +89,7 @@
 
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
 
-/* Config space registers */
-#define DEBUG0				0x728
-
 #define MAX_MSI_HOST_IRQS		8
-
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK		0xb008
 #define PCIE_RC_K2E		0xb009
@@ -446,8 +440,9 @@ static int ks_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	val = dw_pcie_readl_dbi(pci, DEBUG0);
-	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
+	val &= PORT_LOGIC_LTSSM_STATE_MASK;
+	return (val == PORT_LOGIC_LTSSM_STATE_L0);
 }
 
 static void ks_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9f1a5e399b70..0989d880ac46 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -36,6 +36,10 @@
 #define PORT_LINK_MODE_4_LANES		(0x7 << 16)
 #define PORT_LINK_MODE_8_LANES		(0xf << 16)
 
+#define PCIE_PORT_DEBUG0		0x728
+#define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
+#define PORT_LOGIC_LTSSM_STATE_L0	0x11
+
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
 #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
-- 
2.17.1
