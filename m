From: jonmason@broadcom.com (Jon Mason)
Date: Wed, 21 Oct 2015 19:08:52 -0400
Subject: [PATCH 2/3] ARM: dts: NSP: Add NAND Support to DT
In-Reply-To: <1445468933-25933-1-git-send-email-jonmason@broadcom.com>
References: <1445468933-25933-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1445468933-25933-3-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND support to the device tree for the Broadcom Northstar Plus SoC.
Since no driver changes are needed to enable this hardware, only the
device tree changes are required to make this functional.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi   | 16 +++++++++++++++-
 arch/arm/boot/dts/bcm958625k.dts | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 85fb1c8..62bc86f 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -96,7 +96,7 @@
 
 	axi {
 		compatible = "simple-bus";
-		ranges = <0x00000000 0x18000000 0x00015000>;
+		ranges = <0x00000000 0x18000000 0x0011ba08>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -187,5 +187,19 @@
 
 			status = "disabled";
 		};
+
+		nand: nand at 18026000 {
+			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
+			reg = <0x026000 0x600>,
+			      <0x11b408 0x600>,
+			      <0x026f00 0x20>;
+			reg-names = "nand", "iproc-idm", "iproc-ext";
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			brcm,nand-has-wp;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 4859268..b966955 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -67,3 +67,41 @@
 &pcie2 {
 	status = "okay";
 };
+
+&nand {
+	nandcs at 0 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-on-flash-bbt;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		nand-ecc-strength = <24>;
+		nand-ecc-step-size = <1024>;
+
+		brcm,nand-oob-sector-size = <27>;
+
+		partition at 0 {
+			label = "nboot";
+			reg = <0x00000000 0x00200000>;
+			read-only;
+		};
+		partition at 1 {
+			label = "nenv";
+			reg = <0x00200000 0x00400000>;
+		};
+		partition at 2 {
+			label = "nsystem";
+			reg = <0x00600000 0x00a00000>;
+		};
+		partition at 3 {
+			label = "nrootfs";
+			reg = <0x01000000 0x03000000>;
+		};
+		partition at 4 {
+			label = "ncustfs";
+			reg = <0x04000000 0x3c000000>;
+		};
+	};
+};
-- 
1.9.1
