From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 28 Feb 2018 15:47:04 +0100
Subject: [PATCH 2/2] PCI: armada8k: Fix clock resource by adding a register
 clock
In-Reply-To: <20180228144704.12947-1-gregory.clement@bootlin.com>
References: <20180228144704.12947-1-gregory.clement@bootlin.com>
Message-ID: <20180228144704.12947-3-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 7K/8K we need to explicitly enable the register clock. This
clock is optional because not all the SoCs using this IP need it but at
least for Armada 7K/8K it is actually mandatory.

The binding documentation is updated accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/pci/pci-armada8k.txt |  6 +++++-
 drivers/pci/dwc/pcie-armada8k.c                        | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index c1e4c3d10a74..9948b1e9a8e5 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -12,7 +12,11 @@ Required properties:
    - "ctrl" for the control register region
    - "config" for the config space region
 - interrupts: Interrupt specifier for the PCIe controler
-- clocks: reference to the PCIe controller clock
+- clocks: reference to the PCIe controller clocks
+- clock-names: mandatory if there is a second clock, in this case the
+   name must be "core" for the first clock and "reg" for the second
+   one
+
 
 Example:
 
diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index f9b1aec25c5c..aa4e5cc4ab7b 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -28,6 +28,7 @@
 struct armada8k_pcie {
 	struct dw_pcie *pci;
 	struct clk *clk;
+	struct clk *clk_reg;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -229,6 +230,15 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (IS_ERR(pcie->clk_reg) && PTR_ERR(pcie->clk_reg) == -EPROBE_DEFER) {
+		clk_disable_unprepare(pcie->clk);
+		return -EPROBE_DEFER;
+	}
+	if (!IS_ERR(pcie->clk_reg)) {
+		ret = clk_prepare_enable(pcie->clk_reg);
+		if (ret)
+			goto fail;
+	}
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
@@ -247,6 +257,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 fail:
+	clk_disable_unprepare(pcie->clk_reg);
 	clk_disable_unprepare(pcie->clk);
 
 	return ret;
-- 
2.16.1
