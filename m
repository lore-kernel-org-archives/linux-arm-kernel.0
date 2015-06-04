From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Thu,  4 Jun 2015 12:19:03 +0300
Subject: [PATCH 4/7] arm64: dts: qcom: Add msm8916 USB configuration nodes
In-Reply-To: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
References: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1433409546-23995-5-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Host, Device and OTG configuration nodes.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9ff0eb4..5911de0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -268,6 +268,45 @@
 			status = "disabled";
 		};

+		usb_dev: usb at 78d9000 {
+			compatible = "qcom,ci-hdrc";
+			reg = <0x78d9000 0x400>;
+			dr_mode = "peripheral";
+			interrupts = <GIC_SPI 134 IRQ_TYPE_NONE>;
+			usb-phy = <&usb_otg>;
+			status = "disabled";
+		};
+
+		usb_host: ehci at 78d9000 {
+			compatible = "qcom,ehci-host";
+			reg = <0x78d9000 0x400>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_NONE>;
+			usb-phy = <&usb_otg>;
+			status = "disabled";
+		};
+
+		usb_otg: phy at 78d9000 {
+			compatible = "qcom,usb-otg-snps";
+			reg = <0x78d9000 0x400>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_BOTH>,
+				     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,vdd-levels = <1 5 7>;
+			qcom,phy-init-sequence = <0x44 0x6B 0x24 0x13>;
+			dr_mode = "peripheral";
+			qcom,otg-control = <2>; // PMIC
+
+			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
+				 <&gcc GCC_USB_HS_SYSTEM_CLK>,
+				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+			clock-names = "iface", "core", "sleep";
+
+			resets = <&gcc GCC_USB2A_PHY_BCR>,
+				 <&gcc GCC_USB_HS_BCR>;
+			reset-names = "phy", "link";
+			status = "disabled";
+		};
+
 		intc: interrupt-controller at b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
--
1.9.1
