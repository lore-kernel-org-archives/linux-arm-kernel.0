From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:43 +0530
Subject: [RFC PATCH 28/40] PCI: dwc: Fix ATU identification for designware
 version >= 4.80
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-29-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Synopsys designware version >= 4.80 uses a separate register space
for programming ATU. The current code identifies if there exists a
separate register space by accessing the register address of ATUs
in designware version < 4.80. Accessing this address results in
abort in the case of K2G.

Fix it here by adding "version" member to struct dw_pcie. This should
be set by platform specific drivers and designware core will use it
to identify if the platform has a separate ATU space. For platforms
which hasn't populated the version member, the old method of
identification will still be used.

Since identifying if iATU is enabled or not is specific to both
host mode and device mode, setting of iatu_unroll_enabled is moved
from pcie-designware-host.c to pcie-designware.c

Use the register space having reg-names as "atu" for the ATU
address space. For platforms which hasn't populated atu register space,
use the existing hard coded address.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 16 ------
 drivers/pci/controller/dwc/pcie-designware.c  | 50 +++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h  |  9 ++--
 3 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 29a05759a294..37ea4f7e77b0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -637,17 +637,6 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
-static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
-	if (val == 0xffffffff)
-		return 1;
-
-	return 0;
-}
-
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val, ctrl, num_ctrls;
@@ -694,11 +683,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf) {
-		/* Get iATU unroll support */
-		pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
-		dev_dbg(pci->dev, "iATU unroll: %s\n",
-			pci->iatu_unroll_enabled ? "enabled" : "disabled");
-
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 778c4f76a884..881f9c3786ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -92,16 +92,27 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
+	void __iomem *base = pci->atu_base;
+	u32 val;
+	int ret;
+
+	ret = dw_pcie_read(base + offset + reg, 0x4, &val);
+	if (ret)
+		dev_err(pci->dev, "read DBI address failed\n");
 
-	return dw_pcie_readl_dbi(pci, offset + reg);
+	return val;
 }
 
 static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 				     u32 val)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
+	void __iomem *base = pci->atu_base;
+	int ret;
 
-	dw_pcie_writel_dbi(pci, offset + reg, val);
+	ret = dw_pcie_write(base + offset + reg, 0x4, val);
+	if (ret)
+		dev_err(pci->dev, "write DBI address failed\n");
 }
 
 static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
@@ -186,16 +197,27 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 static u32 dw_pcie_readl_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
+	void __iomem *base = pci->atu_base;
+	u32 val;
+	int ret;
+
+	ret = dw_pcie_read(base + offset + reg, 0x4, &val);
+	if (ret)
+		dev_err(pci->dev, "read DBI address failed\n");
 
-	return dw_pcie_readl_dbi(pci, offset + reg);
+	return val;
 }
 
 static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 				     u32 val)
 {
 	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
+	void __iomem *base = pci->atu_base;
+	int ret;
 
-	dw_pcie_writel_dbi(pci, offset + reg, val);
+	ret = dw_pcie_write(base + offset + reg, 0x4, val);
+	if (ret)
+		dev_err(pci->dev, "write DBI address failed\n");
 }
 
 static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
@@ -339,6 +361,17 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
 }
 
+static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
+	if (val == 0xffffffff)
+		return 1;
+
+	return 0;
+}
+
 void dw_pcie_setup(struct dw_pcie *pci)
 {
 	int ret;
@@ -347,6 +380,15 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 
+	if (pci->version >= 0x480A || (!pci->version &&
+				       dw_pcie_iatu_unroll_enabled(pci))) {
+		pci->iatu_unroll_enabled = true;
+		if (!pci->atu_base)
+			pci->atu_base = pci->dbi_base + PCIE_ATU_BASE_OFFSET;
+	}
+	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
+		"enabled" : "disabled");
+
 	ret = of_property_read_u32(np, "num-lanes", &lanes);
 	if (ret)
 		lanes = 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a4d939536faf..b8ff37d1563b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -85,6 +85,7 @@
  * iATU Unroll-specific register definitions
  * From 4.80 core version the address translation will be made by unroll
  */
+#define PCIE_ATU_BASE_OFFSET		(0x3 << 20)
 #define PCIE_ATU_UNR_REGION_CTRL1	0x00
 #define PCIE_ATU_UNR_REGION_CTRL2	0x04
 #define PCIE_ATU_UNR_LOWER_BASE		0x08
@@ -95,10 +96,10 @@
 
 /* Register address builder */
 #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	\
-			((0x3 << 20) | ((region) << 9))
+			((region) << 9)
 
-#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region)				\
-			((0x3 << 20) | ((region) << 9) | (0x1 << 8))
+#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region)		\
+			(((region) << 9) | (0x1 << 8))
 
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
@@ -220,11 +221,13 @@ struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
 	void __iomem		*dbi_base2;
+	void __iomem		*atu_base;
 	u32			num_viewport;
 	u8			iatu_unroll_enabled;
 	struct pcie_port	pp;
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
+	unsigned int		version;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.17.1
