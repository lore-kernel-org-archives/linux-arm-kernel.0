From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 17:18:32 +0100
Subject: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations for
 Armada 370
In-Reply-To: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1364314719-1049-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 SoC has two 1x PCIe 2.0 interfaces, so we add the
necessary Device Tree informations to make these interfaces availabel.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi |   45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 8188d13..b0468fd 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -153,5 +153,50 @@
 			clocks = <&coreclk 0>;
 		};
 
+		pcie-controller {
+			compatible = "marvell,armada-370-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			reg = <0xd0040000 0x2000>, <0xd0080000 0x2000>;
+
+			reg-names = "pcie0.0", "pcie1.0";
+
+			ranges = <0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+			          0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie at 1,0 {
+				device_type = "pci";
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie at 2,0 {
+				device_type = "pci";
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 62>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 9>;
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
1.7.9.5
