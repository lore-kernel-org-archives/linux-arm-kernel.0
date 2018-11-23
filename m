From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 15:18:20 +0100
Subject: [PATCH 01/12] PCI: aardvark: configure more registers in the
 configuration helper
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
Message-ID: <20181123141831.8214-2-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mimic U-Boot configuration to be sure all hardware registers are set
properly. This will be needed for future S2RAM operation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 750081c1cb48..b95eb2aa00bb 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -100,6 +100,8 @@
 #define     PCIE_CORE_CTRL2_STRICT_ORDER_ENABLE	BIT(5)
 #define     PCIE_CORE_CTRL2_OB_WIN_ENABLE	BIT(6)
 #define     PCIE_CORE_CTRL2_MSI_ENABLE		BIT(10)
+#define PCIE_PHY_REFCLK				(CONTROL_BASE_ADDR + 0x14)
+#define     PCIE_PHY_REFCLK_BUF_CTRL		0x1342
 #define PCIE_MSG_LOG_REG			(CONTROL_BASE_ADDR + 0x30)
 #define PCIE_ISR0_REG				(CONTROL_BASE_ADDR + 0x40)
 #define PCIE_MSG_PM_PME_MASK			BIT(7)
@@ -243,6 +245,9 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
 
+	/* Set HW Reference Clock Buffer Control */
+	advk_writel(pcie, PCIE_PHY_REFCLK_BUF_CTRL, PCIE_PHY_REFCLK);
+
 	/* Set to Direct mode */
 	reg = advk_readl(pcie, CTRL_CONFIG_REG);
 	reg &= ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
@@ -274,6 +279,15 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		PCIE_CORE_CTRL2_TD_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
+	/* Set PCIe Device Control and Status 1 PF0 register */
+	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
+		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE;
+	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
+
+	/* Program PCIe Control 2 to disable strict ordering */
+	reg = PCIE_CORE_CTRL2_RESERVED | PCIE_CORE_CTRL2_TD_ENABLE;
+	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
+
 	/* Set GEN2 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
 	reg &= ~PCIE_GEN_SEL_MSK;
-- 
2.19.1
