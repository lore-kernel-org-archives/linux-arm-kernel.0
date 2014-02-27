From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 27 Feb 2014 17:41:44 +0100
Subject: [PATCH v3 2/3] ARM: dts: imx6: extend PCIe interrupt list for MSI
In-Reply-To: <1393519305-15128-1-git-send-email-l.stach@pengutronix.de>
References: <1393519305-15128-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1393519305-15128-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add optional irqs, necessary for MSI handling.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 10 +++++++++-
 arch/arm/boot/dts/imx6qdl.dtsi                           |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index aade8d29314c..3b27ec310ec4 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -16,6 +16,13 @@ Required properties:
 	- "pcie_axi"
 
 Optional properties:
+- interrupts: Must contain an entry for each entry in the
+  interrupt-names property.
+- interrupt-names: May include the following entries:
+	- "inta"
+	- "intb"
+	- "intc"
+	- "intd/msi" if not present the driver won't be able to handle MSI
 - power-on-gpio: gpio pin number of power-enable signal
 - wake-up-gpio:  gpio pin number of incoming wakeup signal
 - disable-gpio:  gpio pin number of outgoing rfkill/endpoint disable signal
@@ -32,7 +39,8 @@ Example:
 			  0x81000000 0 0          0x01f80000 0 0x00010000
 			  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
 		num-lanes = <1>;
-		interrupts = <0 123 0x04>;
+		interrupt-names = "inta", "intb", "intc", "intd/msi";
+		interrupts = <0 123 0x04>, <0 122 0x04>, <0 121 0x04>, <0 120 0x04>;
 		clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
 		clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
 	};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2ecb1db..e0261dd3fdd3 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -126,7 +126,8 @@
 				  0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			interrupts = <0 123 0x04>;
+			interrupt-names = "inta", "intb", "intc", "intd/msi";
+			interrupts = <0 123 0x04>, <0 122 0x04>, <0 121 0x04>, <0 120 0x04>;
 			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
 			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
 			status = "disabled";
-- 
1.8.5.3
