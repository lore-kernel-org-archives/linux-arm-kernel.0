From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Thu, 16 Jun 2016 09:53:35 -0400
Subject: [PATCH 7/7] ARM: dts: nsp: Add sata device tree entry
In-Reply-To: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1466085215-10246-8-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sata support to the Northstar Plus SoC device tree.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi   | 42 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958625k.dts | 12 ++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index def9e78..71ececf 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -266,6 +266,48 @@
 			      <0x30028 0x04>,
 			      <0x3f408 0x04>;
 		};
+
+		sata_phy: sata_phy at 40100 {
+			compatible = "brcm,iproc-nsp-sata-phy";
+			reg = <0x40100 0x340>;
+			reg-names = "phy";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
+			sata_phy1: sata-phy at 1 {
+				reg = <1>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		sata: ahci at 41000 {
+			compatible = "brcm,bcm-nsp-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x41000 0x1000>, <0x40020 0x1c>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+				phy-names = "sata-phy";
+			};
+
+			sata1: sata-port at 1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+				phy-names = "sata-phy";
+			};
+		};
 	};
 
 	pcie0: pcie at 18012000 {
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index e298450..2d84226 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -68,6 +68,18 @@
 	status = "okay";
 };
 
+&sata_phy0 {
+	status = "okay";
+};
+
+&sata_phy1 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
-- 
2.1.0
