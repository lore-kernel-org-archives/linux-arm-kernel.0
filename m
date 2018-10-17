From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Oct 2018 13:11:09 +0530
Subject: [PATCH v2 16/21] PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
Message-ID: <20181017074114.28239-17-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Use BIT() macro for DBI_CS2 and cleanup
set_dbimode and get_dbi_mode

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 3576a184b9eb..2decbaec81a3 100644
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
@@ -315,11 +315,12 @@ static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
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
@@ -333,11 +334,12 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
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
 
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
-- 
2.17.1
