From: faiz_abbas@ti.com (Faiz Abbas)
Date: Wed, 30 May 2018 19:41:33 +0530
Subject: [PATCH v2 6/6] ARM: dts: dra76x: Add MCAN node
In-Reply-To: <20180530141133.3711-1-faiz_abbas@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
Message-ID: <20180530141133.3711-7-faiz_abbas@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Add support for the MCAN peripheral which supports both classic
CAN messages along with the new CAN-FD message.

Add MCAN node to evm and enable it with a maximum datarate of 5 mbps

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts |  7 +++++++
 arch/arm/boot/dts/dra76x.dtsi   | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 2deb96405d06..277765257410 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -404,3 +404,10 @@
 	phys = <&pcie1_phy>, <&pcie2_phy>;
 	phy-names = "pcie-phy0", "pcie-phy1";
 };
+
+&m_can0 {
+	status = "okay";
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index 57b8dc0fe719..d7a8cc569808 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -27,6 +27,21 @@
 			ti,syss-mask = <1>;
 			clocks = <&wkupaon_clkctrl DRA7_ADC_CLKCTRL 0>;
 			clock-names = "fck";
+
+			m_can0: mcan at 42c01a00 {
+				compatible = "bosch,m_can";
+				reg = <0x1a00 0x4000>, <0x0 0x18FC>;
+				reg-names = "m_can", "message_ram";
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "int0", "int1";
+				ti,hwmods = "mcan";
+				clocks = <&mcan_clk>, <&l3_iclk_div>;
+				clock-names = "cclk", "hclk";
+				bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.17.0
