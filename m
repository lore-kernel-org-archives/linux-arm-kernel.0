From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed,  8 Jul 2015 16:21:21 -0400
Subject: [PATCH v1 7/7] ARM: dts: vf610-twr: Enable QSPI and map flash devices.
In-Reply-To: <1436386881-28088-1-git-send-email-cory.tusar@pid1solutions.com>
References: <1436386881-28088-1-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <1436386881-28088-8-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the qspi0 functional block, and maps the two
flash devices connected to QSPI0_A_CS0 and QSPI0_B_CS0 to individual MTD
devices.

Tested using mtd_readtest, mtd_speedtest, and mtd_stresstest on a Rev. H
TWR board.

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 375ab23..6ae2e7c 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -246,6 +246,23 @@
 			>;
 		};
 
+		pinctrl_qspi0: qspi0grp {
+			fsl,pins = <
+				VF610_PAD_PTD0__QSPI0_A_QSCK		0x31e2
+				VF610_PAD_PTD1__QSPI0_A_CS0		0x31e2
+				VF610_PAD_PTD2__QSPI0_A_DATA3		0x31e3
+				VF610_PAD_PTD3__QSPI0_A_DATA2		0x31e3
+				VF610_PAD_PTD4__QSPI0_A_DATA1		0x31e3
+				VF610_PAD_PTD5__QSPI0_A_DATA0		0x31e3
+				VF610_PAD_PTD7__QSPI0_B_QSCK		0x31e2
+				VF610_PAD_PTD8__QSPI0_B_CS0		0x31e2
+				VF610_PAD_PTD9__QSPI0_B_DATA3		0x31e3
+				VF610_PAD_PTD10__QSPI0_B_DATA2		0x31e3
+				VF610_PAD_PTD11__QSPI0_B_DATA1		0x31e3
+				VF610_PAD_PTD12__QSPI0_B_DATA0		0x31e3
+			>;
+		};
+
 		pinctrl_sai2: sai2grp {
 			fsl,pins = <
 				VF610_PAD_PTA16__SAI2_TX_BCLK		0x02ed
@@ -280,6 +297,28 @@
 	status = "okay";
 };
 
+&qspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi0>;
+	status = "okay";
+
+	flash0: s25fl128s at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <66000000>;
+		reg = <0>;
+	};
+
+	flash1: s25fl128s at 2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s";
+		spi-max-frequency = <66000000>;
+		reg = <2>;
+	};
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
-- 
2.3.6
