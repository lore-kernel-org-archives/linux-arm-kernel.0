From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:34 +0530
Subject: [RFC PATCH 19/40] PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-20-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Use BIT() macro for DBI_CS2 and cleanup
set_dbimode and get_dbi_mode

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d5304c4a1eb5..728b1e0db314 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -40,7 +40,7 @@
 #define LTSSM_EN_VAL		        BIT(0)
 #define LTSSM_STATE_MASK		0x1f
 #define LTSSM_STATE_L0			0x11
-#define DBI_CS2_EN_VAL			0x20
+#define DBI_CS2				BIT(5)
 #define OB_XLAT_EN_VAL		        BIT(1)
 
 /* Application registers */
@@ -214,11 +214,12 @@ static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
 	u32 val;
 
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
+	val |= DBI_CS2;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
 
 	do {
 		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	} while (!(val & DBI_CS2_EN_VAL));
+	} while (!(val & DBI_CS2));
 }
 
 /**
@@ -232,11 +233,12 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 	u32 val;
 
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
+	val &= ~DBI_CS2;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
 
 	do {
 		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	} while (val & DBI_CS2_EN_VAL);
+	} while (val & DBI_CS2);
 }
 
 static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-- 
2.17.1
