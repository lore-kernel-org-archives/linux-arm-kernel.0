From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 28 Mar 2016 10:18:27 +0530
Subject: [PATCH v2 2/5] phy: Add support for NS2 SATA3 PHY in Broadcom SATA3
 PHY driver
In-Reply-To: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1459140510-5317-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Broadcom NS2 SATA3 PHY in existing
Broadcom SATA3 PHY driver.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/phy/phy-brcm-sata.c | 238 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 200 insertions(+), 38 deletions(-)

diff --git a/drivers/phy/phy-brcm-sata.c b/drivers/phy/phy-brcm-sata.c
index c97b9d6..6c4c5cb 100644
--- a/drivers/phy/phy-brcm-sata.c
+++ b/drivers/phy/phy-brcm-sata.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -24,22 +25,26 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
-#define SATA_MDIO_BANK_OFFSET				0x23c
-#define SATA_MDIO_REG_OFFSET(ofs)			((ofs) * 4)
+#define SATA_PCB_BANK_OFFSET				0x23c
+#define SATA_PCB_REG_OFFSET(ofs)			((ofs) * 4)
 
 #define MAX_PORTS					2
 
 /* Register offset between PHYs in PCB space */
-#define SATA_MDIO_REG_28NM_SPACE_SIZE			0x1000
+#define SATA_PCB_REG_28NM_SPACE_SIZE			0x1000
 
 /* The older SATA PHY registers duplicated per port registers within the map,
  * rather than having a separate map per port.
  */
-#define SATA_MDIO_REG_40NM_SPACE_SIZE			0x10
+#define SATA_PCB_REG_40NM_SPACE_SIZE			0x10
+
+/* Register offset between PHYs in PHY control space */
+#define SATA_PHY_CTRL_REG_28NM_SPACE_SIZE		0x8
 
 enum brcm_sata_phy_version {
-	BRCM_SATA_PHY_28NM,
-	BRCM_SATA_PHY_40NM,
+	BRCM_SATA_PHY_STB_28NM,
+	BRCM_SATA_PHY_STB_40NM,
+	BRCM_SATA_PHY_IPROC_NS2,
 };
 
 struct brcm_sata_port {
@@ -52,15 +57,48 @@ struct brcm_sata_port {
 struct brcm_sata_phy {
 	struct device *dev;
 	void __iomem *phy_base;
+	void __iomem *ctrl_base;
 	enum brcm_sata_phy_version version;
 
 	struct brcm_sata_port phys[MAX_PORTS];
 };
 
-enum sata_mdio_phy_regs {
-	PLL_REG_BANK_0				= 0x50,
+enum sata_phy_regs {
+	BLOCK0_REG_BANK				= 0x000,
+	BLOCK0_XGXSSTATUS			= 0x81,
+	BLOCK0_XGXSSTATUS_PLL_LOCK		= BIT(12),
+	BLOCK0_SPARE				= 0x8d,
+	BLOCK0_SPARE_OOB_CLK_SEL_MASK		= 0x3,
+	BLOCK0_SPARE_OOB_CLK_SEL_REFBY2		= 0x1,
+
+	PLL_REG_BANK_0				= 0x050,
 	PLL_REG_BANK_0_PLLCONTROL_0		= 0x81,
 
+	PLL1_REG_BANK				= 0x060,
+	PLL1_ACTRL2				= 0x82,
+	PLL1_ACTRL3				= 0x83,
+	PLL1_ACTRL4				= 0x84,
+
+	OOB_REG_BANK				= 0x150,
+	OOB_CTRL1				= 0x80,
+	OOB_CTRL1_BURST_MAX_MASK		= 0xf,
+	OOB_CTRL1_BURST_MAX_SHIFT		= 12,
+	OOB_CTRL1_BURST_MIN_MASK		= 0xf,
+	OOB_CTRL1_BURST_MIN_SHIFT		= 8,
+	OOB_CTRL1_WAKE_IDLE_MAX_MASK		= 0xf,
+	OOB_CTRL1_WAKE_IDLE_MAX_SHIFT		= 4,
+	OOB_CTRL1_WAKE_IDLE_MIN_MASK		= 0xf,
+	OOB_CTRL1_WAKE_IDLE_MIN_SHIFT		= 0,
+	OOB_CTRL2				= 0x81,
+	OOB_CTRL2_SEL_ENA_SHIFT			= 15,
+	OOB_CTRL2_SEL_ENA_RC_SHIFT		= 14,
+	OOB_CTRL2_RESET_IDLE_MAX_MASK		= 0x3f,
+	OOB_CTRL2_RESET_IDLE_MAX_SHIFT		= 8,
+	OOB_CTRL2_BURST_CNT_MASK		= 0x3,
+	OOB_CTRL2_BURST_CNT_SHIFT		= 6,
+	OOB_CTRL2_RESET_IDLE_MIN_MASK		= 0x3f,
+	OOB_CTRL2_RESET_IDLE_MIN_SHIFT		= 0,
+
 	TXPMD_REG_BANK				= 0x1a0,
 	TXPMD_CONTROL1				= 0x81,
 	TXPMD_CONTROL1_TX_SSC_EN_FRC		= BIT(0),
@@ -72,69 +110,183 @@ enum sata_mdio_phy_regs {
 	TXPMD_TX_FREQ_CTRL_CONTROL3_FMAX_MASK	= 0x3ff,
 };
 
-static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *port)
+enum sata_phy_ctrl_regs {
+	PHY_CTRL_1				= 0x0,
+	PHY_CTRL_1_RESET			= BIT(0),
+};
+
+static inline void __iomem *brcm_sata_pcb_base(struct brcm_sata_port *port)
 {
 	struct brcm_sata_phy *priv = port->phy_priv;
-	u32 offset = 0;
+	u32 size = 0;
+
+	switch (priv->version) {
+	case BRCM_SATA_PHY_STB_28NM:
+	case BRCM_SATA_PHY_IPROC_NS2:
+		size = SATA_PCB_REG_28NM_SPACE_SIZE;
+		break;
+	case BRCM_SATA_PHY_STB_40NM:
+		size = SATA_PCB_REG_40NM_SPACE_SIZE;
+		break;
+	default:
+		dev_err(priv->dev, "invalid phy version\n");
+		break;
+	};
 
-	if (priv->version == BRCM_SATA_PHY_28NM)
-		offset = SATA_MDIO_REG_28NM_SPACE_SIZE;
-	else if (priv->version == BRCM_SATA_PHY_40NM)
-		offset = SATA_MDIO_REG_40NM_SPACE_SIZE;
-	else
+	return priv->phy_base + (port->portnum * size);
+}
+
+static inline void __iomem *brcm_sata_ctrl_base(struct brcm_sata_port *port)
+{
+	struct brcm_sata_phy *priv = port->phy_priv;
+	u32 size = 0;
+
+	switch (priv->version) {
+	case BRCM_SATA_PHY_IPROC_NS2:
+		size = SATA_PHY_CTRL_REG_28NM_SPACE_SIZE;
+		break;
+	default:
 		dev_err(priv->dev, "invalid phy version\n");
+		break;
+	};
 
-	return priv->phy_base + (port->portnum * offset);
+	return priv->ctrl_base + (port->portnum * size);
 }
 
-static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
-			      u32 msk, u32 value)
+static void brcm_sata_phy_wr(void __iomem *pcb_base, u32 bank,
+			     u32 ofs, u32 msk, u32 value)
 {
 	u32 tmp;
 
-	writel(bank, addr + SATA_MDIO_BANK_OFFSET);
-	tmp = readl(addr + SATA_MDIO_REG_OFFSET(ofs));
+	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);
+	tmp = readl(pcb_base + SATA_PCB_REG_OFFSET(ofs));
 	tmp = (tmp & msk) | value;
-	writel(tmp, addr + SATA_MDIO_REG_OFFSET(ofs));
+	writel(tmp, pcb_base + SATA_PCB_REG_OFFSET(ofs));
+}
+
+static u32 brcm_sata_phy_rd(void __iomem *pcb_base, u32 bank, u32 ofs)
+{
+	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);
+	return readl(pcb_base + SATA_PCB_REG_OFFSET(ofs));
 }
 
 /* These defaults were characterized by H/W group */
-#define FMIN_VAL_DEFAULT	0x3df
-#define FMAX_VAL_DEFAULT	0x3df
-#define FMAX_VAL_SSC		0x83
+#define STB_FMIN_VAL_DEFAULT	0x3df
+#define STB_FMAX_VAL_DEFAULT	0x3df
+#define STB_FMAX_VAL_SSC	0x83
 
-static void brcm_sata_cfg_ssc(struct brcm_sata_port *port)
+static int brcm_stb_sata_init(struct brcm_sata_port *port)
 {
-	void __iomem *base = brcm_sata_phy_base(port);
+	void __iomem *base = brcm_sata_pcb_base(port);
 	struct brcm_sata_phy *priv = port->phy_priv;
 	u32 tmp;
 
 	/* override the TX spread spectrum setting */
 	tmp = TXPMD_CONTROL1_TX_SSC_EN_FRC_VAL | TXPMD_CONTROL1_TX_SSC_EN_FRC;
-	brcm_sata_mdio_wr(base, TXPMD_REG_BANK, TXPMD_CONTROL1, ~tmp, tmp);
+	brcm_sata_phy_wr(base, TXPMD_REG_BANK, TXPMD_CONTROL1, ~tmp, tmp);
 
 	/* set fixed min freq */
-	brcm_sata_mdio_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL2,
-			  ~TXPMD_TX_FREQ_CTRL_CONTROL2_FMIN_MASK,
-			  FMIN_VAL_DEFAULT);
+	brcm_sata_phy_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL2,
+			 ~TXPMD_TX_FREQ_CTRL_CONTROL2_FMIN_MASK,
+			 STB_FMIN_VAL_DEFAULT);
 
 	/* set fixed max freq depending on SSC config */
 	if (port->ssc_en) {
-		dev_info(priv->dev, "enabling SSC on port %d\n", port->portnum);
-		tmp = FMAX_VAL_SSC;
+		dev_info(priv->dev, "enabling SSC on port%d\n", port->portnum);
+		tmp = STB_FMAX_VAL_SSC;
 	} else {
-		tmp = FMAX_VAL_DEFAULT;
+		tmp = STB_FMAX_VAL_DEFAULT;
 	}
 
-	brcm_sata_mdio_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL3,
+	brcm_sata_phy_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL3,
 			  ~TXPMD_TX_FREQ_CTRL_CONTROL3_FMAX_MASK, tmp);
+
+	return 0;
+}
+
+/* NS2 SATA PLL1 defaults were characterized by H/W group */
+#define NS2_PLL1_ACTRL2_MAGIC	0x1df8
+#define NS2_PLL1_ACTRL3_MAGIC	0x2b00
+#define NS2_PLL1_ACTRL4_MAGIC	0x8824
+
+static int brcm_ns2_sata_init(struct brcm_sata_port *port)
+{
+	int try;
+	unsigned int val;
+	void __iomem *base = brcm_sata_pcb_base(port);
+	void __iomem *ctrl_base = brcm_sata_ctrl_base(port);
+	struct device *dev = port->phy_priv->dev;
+
+	/* Configure OOB control */
+	val = 0x0;
+	val |= (0xc << OOB_CTRL1_BURST_MAX_SHIFT);
+	val |= (0x4 << OOB_CTRL1_BURST_MIN_SHIFT);
+	val |= (0x9 << OOB_CTRL1_WAKE_IDLE_MAX_SHIFT);
+	val |= (0x3 << OOB_CTRL1_WAKE_IDLE_MIN_SHIFT);
+	brcm_sata_phy_wr(base, OOB_REG_BANK, OOB_CTRL1, 0x0, val);
+	val = 0x0;
+	val |= (0x1b << OOB_CTRL2_RESET_IDLE_MAX_SHIFT);
+	val |= (0x2 << OOB_CTRL2_BURST_CNT_SHIFT);
+	val |= (0x9 << OOB_CTRL2_RESET_IDLE_MIN_SHIFT);
+	brcm_sata_phy_wr(base, OOB_REG_BANK, OOB_CTRL2, 0x0, val);
+
+	/* Configure PHY PLL register bank 1 */
+	val = NS2_PLL1_ACTRL2_MAGIC;
+	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL2, 0x0, val);
+	val = NS2_PLL1_ACTRL3_MAGIC;
+	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL3, 0x0, val);
+	val = NS2_PLL1_ACTRL4_MAGIC;
+	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL4, 0x0, val);
+
+	/* Configure PHY BLOCK0 register bank */
+	/* Set oob_clk_sel to refclk/2 */
+	brcm_sata_phy_wr(base, BLOCK0_REG_BANK, BLOCK0_SPARE,
+			 ~BLOCK0_SPARE_OOB_CLK_SEL_MASK,
+			 BLOCK0_SPARE_OOB_CLK_SEL_REFBY2);
+
+	/* Strobe PHY reset using PHY control register */
+	writel(PHY_CTRL_1_RESET, ctrl_base + PHY_CTRL_1);
+	mdelay(1);
+	writel(0x0, ctrl_base + PHY_CTRL_1);
+	mdelay(1);
+
+	/* Wait for PHY PLL lock by polling pll_lock bit */
+	try = 50;
+	while (try) {
+		val = brcm_sata_phy_rd(base, BLOCK0_REG_BANK,
+					BLOCK0_XGXSSTATUS);
+		if (val & BLOCK0_XGXSSTATUS_PLL_LOCK)
+			break;
+		msleep(20);
+		try--;
+	}
+	if (!try) {
+		/* PLL did not lock; give up */
+		dev_err(dev, "port%d PLL did not lock\n", port->portnum);
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(dev, "port%d initialized\n", port->portnum);
+
+	return 0;
 }
 
 static int brcm_sata_phy_init(struct phy *phy)
 {
+	int rc;
 	struct brcm_sata_port *port = phy_get_drvdata(phy);
 
-	brcm_sata_cfg_ssc(port);
+	switch (port->phy_priv->version) {
+	case BRCM_SATA_PHY_STB_28NM:
+	case BRCM_SATA_PHY_STB_40NM:
+		rc = brcm_stb_sata_init(port);
+		break;
+	case BRCM_SATA_PHY_IPROC_NS2:
+		rc = brcm_ns2_sata_init(port);
+		break;
+	default:
+		rc = -ENODEV;
+	};
 
 	return 0;
 }
@@ -146,9 +298,11 @@ static const struct phy_ops phy_ops = {
 
 static const struct of_device_id brcm_sata_phy_of_match[] = {
 	{ .compatible	= "brcm,bcm7445-sata-phy",
-	  .data = (void *)BRCM_SATA_PHY_28NM },
+	  .data = (void *)BRCM_SATA_PHY_STB_28NM },
 	{ .compatible	= "brcm,bcm7425-sata-phy",
-	  .data = (void *)BRCM_SATA_PHY_40NM },
+	  .data = (void *)BRCM_SATA_PHY_STB_40NM },
+	{ .compatible	= "brcm,iproc-ns2-sata-phy",
+	  .data = (void *)BRCM_SATA_PHY_IPROC_NS2 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
@@ -181,7 +335,15 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	if (of_id)
 		priv->version = (enum brcm_sata_phy_version)of_id->data;
 	else
-		priv->version = BRCM_SATA_PHY_28NM;
+		priv->version = BRCM_SATA_PHY_STB_28NM;
+
+	if (priv->version == BRCM_SATA_PHY_IPROC_NS2) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "phy-ctrl");
+		priv->ctrl_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(priv->ctrl_base))
+			return PTR_ERR(priv->ctrl_base);
+	}
 
 	for_each_available_child_of_node(dn, child) {
 		unsigned int id;
-- 
1.9.1
