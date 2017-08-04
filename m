From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Fri, 4 Aug 2017 14:41:33 +0800
Subject: [PATCHv2 1/2] PCI: layerscape: Add support for ls2088a
In-Reply-To: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <1501828894-25598-2-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The ls2088a pcie controller's some registers address are different
from ls2080a, so add a match entry to identify ls2088a pcie.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Removed "fsl,ls1088a-pcie" from the layerscape-pci binding doc.

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 drivers/pci/dwc/pci-layerscape.c                         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index ee1c72d5..2057b00 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -15,6 +15,7 @@ Required properties:
 - compatible: should contain the platform identifier such as:
         "fsl,ls1021a-pcie", "snps,dw-pcie"
         "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
+        "fsl,ls2088a-pcie"
         "fsl,ls1046a-pcie"
 - reg: base addresses and lengths of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index bf52825..5989ae1 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -240,12 +240,21 @@ static struct ls_pcie_drvdata ls2080_drvdata = {
 	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
+static struct ls_pcie_drvdata ls2088_drvdata = {
+	.lut_offset = 0x80000,
+	.ltssm_shift = 0,
+	.lut_dbg = 0x407fc,
+	.ops = &ls_pcie_host_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ops,
+};
+
 static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
 	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
 	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
 	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
 	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie", .data = &ls2088_drvdata },
 	{ },
 };
 
-- 
2.1.0.27.g96db324
