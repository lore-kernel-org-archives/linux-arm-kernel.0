From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:29:00 +0100
Subject: [PATCH 26/32] arm: mvebu: add PCIe Device Tree informations for
 Armada 370
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-27-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 SoC has two 1x PCIe 2.0 interfaces, so we add the
necessary Device Tree informations to make these interfaces availabel.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi |   43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 636cf7d..39055ba 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -132,5 +132,48 @@
 				dmacap,memset;
 			};
 		};
+
+		pcie-controller {
+			compatible = "marvell,armada-370-xp-pcie";
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
+				  0x00001000 0 0xd0080000 0xd0080000 0 0x00002000   /* port 1.0 registers */
+				  0x81000000 0 0	  0xc0000000 0 0x00010000   /* downstream I/O */
+				  0x82000000 0 0	  0xc1000000 0 0x08000000>; /* non-prefetchable memory */
+
+			pcie at 0,0 {
+				device_type = "pciex";
+				reg = <0x0800 0 0xd0040000 0 0x2000>;
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
+			pcie at 1,0 {
+				device_type = "pciex";
+				reg = <0x1000 0 0xd0080000 0 0x2000>;
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
