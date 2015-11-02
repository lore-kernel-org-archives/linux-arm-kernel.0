From: jonmason@broadcom.com (Jon Mason)
Date: Mon, 2 Nov 2015 13:40:56 -0500
Subject: [PATCH RESEND 1/3] ARM: dts: NSP: Add PCI support
In-Reply-To: <1446489658-29705-1-git-send-email-jonmason@broadcom.com>
References: <1446489658-29705-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1446489658-29705-2-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCI support to the Northstar Plus SoC.  This uses the existing
pcie-iproc driver.  So, all that is needed is device tree entries in the
DTS.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi   | 74 +++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/bcm958625k.dts | 12 +++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 58aca27..85fb1c8 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -96,7 +96,7 @@
 
 	axi {
 		compatible = "simple-bus";
-		ranges = <0x00000000 0x18000000 0x00001000>;
+		ranges = <0x00000000 0x18000000 0x00015000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -115,5 +115,77 @@
 			clock-frequency = <62499840>;
 			status = "disabled";
 		};
+
+		pcie0: pcie at 18012000 {
+			compatible = "brcm,iproc-pcie";
+			reg = <0x12000 0x1000>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_NONE>;
+
+			linux,pci-domain = <0>;
+
+			bus-range = <0x00 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+
+			/* Note: The HW does not support I/O resources.  So,
+			 * only the memory resource range is being specified.
+			 */
+			ranges = <0x82000000 0 0x08000000 0x08000000 0 0x8000000>;
+
+			status = "disabled";
+		};
+
+		pcie1: pcie at 18013000 {
+			compatible = "brcm,iproc-pcie";
+			reg = <0x13000 0x1000>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 137 IRQ_TYPE_NONE>;
+
+			linux,pci-domain = <1>;
+
+			bus-range = <0x00 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+
+			/* Note: The HW does not support I/O resources.  So,
+			 * only the memory resource range is being specified.
+			 */
+			ranges = <0x82000000 0 0x40000000 0x40000000 0 0x8000000>;
+
+			status = "disabled";
+		};
+
+		pcie2: pcie at 18014000 {
+			compatible = "brcm,iproc-pcie";
+			reg = <0x14000 0x1000>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 143 IRQ_TYPE_NONE>;
+
+			linux,pci-domain = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+
+			/* Note: The HW does not support I/O resources.  So,
+			 * only the memory resource range is being specified.
+			 */
+			ranges = <0x82000000 0 0x48000000 0x48000000 0 0x8000000>;
+
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 16303db..4859268 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -55,3 +55,15 @@
 &uart1 {
 	status = "okay";
 };
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
-- 
1.9.1
