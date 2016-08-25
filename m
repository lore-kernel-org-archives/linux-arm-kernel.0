From: stefan.schoefegger@ginzinger.com (Stefan Schoefegger)
Date: Thu, 25 Aug 2016 12:38:38 +0200
Subject: [PATCH 1/1] PCI: imx6: Add pcie compliance test option
Message-ID: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Link speed must not be limited to gen1 during link test for compliance
tests, see
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/pci/host/pci-imx6.c?id=rel_imx_4.1.15_1.1.1_patch#n551

Signed-off-by: Stefan Schoefegger <stefan.schoefegger@ginzinger.com>
---
 drivers/pci/host/Kconfig    | 10 ++++++++++
 drivers/pci/host/pci-imx6.c | 21 ++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 9b485d8..ab9396e 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -67,6 +67,16 @@ config PCI_IMX6
 	select PCIEPORTBUS
 	select PCIE_DW
 
+config PCI_IMX6_COMPLIANCE_TEST
+	bool "Enable pcie compliance tests on imx6"
+	depends on PCI_IMX6
+	default n
+	help
+	  Enables support for pcie compliance test on FSL iMX SoCs.
+	  The link speed wouldn't be limited to gen1 when enabled.
+	  Enable only during compliance tests, otherwise
+	  link detection will fail on some peripherals.
+
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA && !ARM64
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index b741a36..cd08206 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -481,15 +481,18 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	u32 tmp;
 	int ret;
 
-	/*
-	 * Force Gen1 operation when starting the link.  In case the link is
-	 * started in Gen2 mode, there is a possibility the devices on the
-	 * bus will not be detected at all.  This happens with PCIe switches.
-	 */
-	tmp = readl(pp->dbi_base + PCIE_RC_LCR);
-	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
-	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
-	writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+	if (!IS_ENABLED(CONFIG_PCI_IMX6_COMPLIANCE_TEST)) {
+		/*
+		 * Force Gen1 operation when starting the link.  In
+		 * case the link is  started in Gen2 mode, there is
+		 * a possibility the devices on the bus will not be
+		 * detected at all.  This happens with PCIe switches.
+		*/
+		tmp = readl(pp->dbi_base + PCIE_RC_LCR);
+		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
+		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
+		writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+	}
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-- 
2.1.4
