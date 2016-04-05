From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue,  5 Apr 2016 21:27:33 +0800
Subject: [PATCH v3 09/16] arm64: dts: add hi6220 usb node
In-Reply-To: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
References: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1459862860-9775-10-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 53b5b25..3faa004 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -635,5 +635,37 @@
 			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
 			status = "disabled";
 		};
+
+		fixed_5v_hub: regulator at 0 {
+			compatible = "regulator-fixed";
+			regulator-name = "fixed_5v_hub";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-boot-on;
+			gpio = <&gpio0 7 0>;
+			regulator-always-on;
+		};
+
+		usb_phy: usbphy {
+			compatible = "hisilicon,hi6220-usb-phy";
+			#phy-cells = <0>;
+			phy-supply = <&fixed_5v_hub>;
+			hisilicon,peripheral-syscon = <&sys_ctrl>;
+		};
+
+		usb: usb at f72c0000 {
+			compatible = "hisilicon,hi6220-usb";
+			reg = <0x0 0xf72c0000 0x0 0x40000>;
+			phys = <&usb_phy>;
+			phy-names = "usb2-phy";
+			clocks = <&sys_ctrl HI6220_USBOTG_HCLK>;
+			clock-names = "otg";
+			dr_mode = "otg";
+			g-use-dma;
+			g-rx-fifo-size = <512>;
+			g-np-tx-fifo-size = <128>;
+			g-tx-fifo-size = <128 128 128 128 128 128>;
+			interrupts = <0 77 0x4>;
+		};
 	};
 };
-- 
1.9.1
