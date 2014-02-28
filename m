From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 27 Feb 2014 17:19:52 -0800
Subject: [PATCH 1/3] PCI: designware: add legacy PCI interrupt mapping
In-Reply-To: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1393550394-11071-2-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IMX6 maps INTA/B/C/D to ARM GIC IRQ 155/154/153/152 respectively.
This allows a PCIe-to-PCI bridge to function properly.

The irq field of the pcie_host struct is expanded to 4 interrupts to
allow for INTA/B/C/D and the IMX6 PCIe host driver will populate them
all from devicetree.  I'm not clear if the Exynos driver has this
capability so it places the same interrupt in all 4 slots.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi     |  2 +-
 drivers/pci/host/pci-exynos.c      |  7 +++++--
 drivers/pci/host/pci-imx6.c        | 11 +++++++----
 drivers/pci/host/pcie-designware.c |  8 +++++++-
 drivers/pci/host/pcie-designware.h |  2 +-
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index eed6897..fad8d90 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -126,7 +126,7 @@
 				  0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			interrupts = <0 123 0x04>;
+			interrupts = <0 123 0x04>, <0 122 0x04>, <0 121 0x04>, <0 120 0x04>;
 			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
 			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
 			status = "disabled";
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 3de6bfb..d85dcb0 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -515,11 +515,14 @@ static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
 {
 	int ret;
 
-	pp->irq = platform_get_irq(pdev, 1);
-	if (!pp->irq) {
+	pp->irq[0] = platform_get_irq(pdev, 1);
+	if (!pp->irq[0]) {
 		dev_err(&pdev->dev, "failed to get irq\n");
 		return -ENODEV;
 	}
+	pp->irq[1] = pp->irq[0];
+	pp->irq[2] = pp->irq[0];
+	pp->irq[3] = pp->irq[0];
 	ret = devm_request_irq(&pdev->dev, pp->irq, exynos_pcie_irq_handler,
 				IRQF_SHARED, "exynos-pcie", pp);
 	if (ret) {
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index e8663a8..aaa05c8 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -470,11 +470,14 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
 			struct platform_device *pdev)
 {
 	int ret;
+	int i;
 
-	pp->irq = platform_get_irq(pdev, 0);
-	if (!pp->irq) {
-		dev_err(&pdev->dev, "failed to get irq\n");
-		return -ENODEV;
+	for (i = 0; i < 4; i++) {
+		pp->irq[i] = platform_get_irq(pdev, i);
+		if (!pp->irq[i]) {
+			dev_err(&pdev->dev, "failed to get irq%d\n", i);
+			return -ENODEV;
+		}
 	}
 
 	pp->root_bus_nr = -1;
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 17ce88f..5808177 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -738,8 +738,14 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
+	int irq = -1;
 
-	return pp->irq;
+	if (pin > 0 && pin < 5)
+		irq = pp->irq[pin - 1];
+	dev_info(&dev->dev, "map_irq: %04x:%04x slot%d pin%d irq%d\n",
+		dev->vendor, dev->device, slot, pin, irq);
+
+	return irq;
 }
 
 static void dw_pcie_add_bus(struct pci_bus *bus)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 3063b35..5c596c0 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -46,7 +46,7 @@ struct pcie_port {
 	struct resource		io;
 	struct resource		mem;
 	struct pcie_port_info	config;
-	int			irq;
+	int			irq[4];
 	u32			lanes;
 	struct pcie_host_ops	*ops;
 	int			msi_irq;
-- 
1.8.3.2
