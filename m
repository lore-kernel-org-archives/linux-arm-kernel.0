From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Wed, 19 Aug 2015 10:53:22 -0700
Subject: [PATCH 2/2] ARM: qcom: add GMAC nodes to IPQ806x platforms
In-Reply-To: <1440006802-2415-1-git-send-email-mathieu@codeaurora.org>
References: <1440006802-2415-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <1440006802-2415-2-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds GMAC nodes to IPQ806x platforms, both to the dtsi and
to the AP148 dts. This will provide ethernet connectivity to the device.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts | 33 ++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi      | 86 ++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
index d73df24..0958fa3 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
@@ -94,6 +94,18 @@
 					bias-disable;
 				};
 			};
+
+			rgmii2_pins: rgmii2_pins {
+				mux {
+					pins = "gpio27", "gpio28", "gpio29",
+					       "gpio30", "gpio31", "gpio32",
+					       "gpio51", "gpio52", "gpio59",
+					       "gpio60", "gpio61", "gpio62";
+					function = "rgmii2";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
 		};
 
 		sata-phy at 1b400000 {
@@ -122,5 +134,26 @@
 				reg = <4>;
 			};
 		};
+
+		gmac1: ethernet at 37200000 {
+			status = "ok";
+			phy-mode = "rgmii";
+			phy-handle = <&phy4>;
+			qcom,id = <1>;
+
+			pinctrl-0 = <&rgmii2_pins>;
+			pinctrl-names = "default";
+		};
+
+		gmac2: ethernet at 37400000 {
+			status = "ok";
+			phy-mode = "sgmii";
+			qcom,id = <2>;
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 2f270d7..6706a56 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -336,6 +336,92 @@
 			compatible = "syscon";
 			reg = <0x01200600 0x100>;
 		};
+
+		nss_common: syscon at 03000000 {
+			compatible = "syscon";
+			reg = <0x03000000 0x0000FFFF>;
+		};
+
+		qsgmii_csr: syscon at 1bb00000 {
+			compatible = "syscon";
+			reg = <0x1bb00000 0x000001FF>;
+		};
+
+		gmac0: ethernet at 37000000 {
+			device_type = "network";
+			compatible = "qcom,ipq806x-gmac";
+			reg = <0x37000000 0x200000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			qcom,nss-common = <&nss_common>;
+			qcom,qsgmii-csr = <&qsgmii_csr>;
+
+			clocks = <&gcc GMAC_CORE1_CLK>;
+			clock-names = "stmmaceth";
+
+			resets = <&gcc GMAC_CORE1_RESET>;
+			reset-names = "stmmaceth";
+
+			status = "disabled";
+		};
+
+		gmac1: ethernet at 37200000 {
+			device_type = "network";
+			compatible = "qcom,ipq806x-gmac";
+			reg = <0x37200000 0x200000>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			qcom,nss-common = <&nss_common>;
+			qcom,qsgmii-csr = <&qsgmii_csr>;
+
+			clocks = <&gcc GMAC_CORE2_CLK>;
+			clock-names = "stmmaceth";
+
+			resets = <&gcc GMAC_CORE2_RESET>;
+			reset-names = "stmmaceth";
+
+			status = "disabled";
+		};
+
+		gmac2: ethernet at 37400000 {
+			device_type = "network";
+			compatible = "qcom,ipq806x-gmac";
+			reg = <0x37400000 0x200000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			qcom,nss-common = <&nss_common>;
+			qcom,qsgmii-csr = <&qsgmii_csr>;
+
+			clocks = <&gcc GMAC_CORE3_CLK>;
+			clock-names = "stmmaceth";
+
+			resets = <&gcc GMAC_CORE3_RESET>;
+			reset-names = "stmmaceth";
+
+			status = "disabled";
+		};
+
+		gmac3: ethernet at 37600000 {
+			device_type = "network";
+			compatible = "qcom,ipq806x-gmac";
+			reg = <0x37600000 0x200000>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			qcom,nss-common = <&nss_common>;
+			qcom,qsgmii-csr = <&qsgmii_csr>;
+
+			clocks = <&gcc GMAC_CORE4_CLK>;
+			clock-names = "stmmaceth";
+
+			resets = <&gcc GMAC_CORE4_RESET>;
+			reset-names = "stmmaceth";
+
+			status = "disabled";
+		};
 	};
 
 	sfpb_mutex: sfpb-mutex {
-- 
2.1.4
