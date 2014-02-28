From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Feb 2014 18:30:31 +0100
Subject: [PATCH 1/3] ARM: dts: imx6: extend PCIe interrupt list for MSI
In-Reply-To: <1393608633-18321-1-git-send-email-l.stach@pengutronix.de>
References: <1393608633-18321-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1393608633-18321-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optional IRQ necessary for handling MSI.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 9 ++++++++-
 arch/arm/boot/dts/imx6qdl.dtsi                           | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 93fbfd62f13c..0515183a6d96 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -17,6 +17,11 @@ Required properties:
 	- "pcie_axi"
 
 Optional properties:
+- interrupts: Must contain an entry for each entry in the
+  interrupt-names property.
+- interrupt-names: May include the following entries:
+	- "inta"
+	- "msi" if not present the driver won't be able to handle MSI
 - power-on-gpio: gpio pin number of power-enable signal
 - wake-up-gpio:  gpio pin number of incoming wakeup signal
 - disable-gpio:  gpio pin number of outgoing rfkill/endpoint disable signal
@@ -34,7 +39,9 @@ Example:
 			  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
 		num-lanes = <1>;
 
-		interrupts = <0 123 0x04>;
+		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "inta", "msi";
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0x7>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index db3339e7d3a2..a3a3acd90964 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -129,7 +129,9 @@
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 
-			interrupts = <0 123 0x04>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "inta", "msi";
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-- 
1.8.5.3
