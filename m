From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat,  6 Feb 2016 11:24:58 +0800
Subject: [PATCH v4 11/11] arm64: dts: hisilicon: Add display subsystem DT
 nodes for hi6220
In-Reply-To: <1454729098-79807-1-git-send-email-xinliang.liu@linaro.org>
References: <1454729098-79807-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1454729098-79807-12-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ade, dsi and adv7533 DT nodes for hikey board.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 44 +++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 53 ++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 818525197508..5c3557c8e59b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -39,3 +39,47 @@
 &uart3 {
 	label = "LS-UART1";
 };
+
+&ade {
+	status = "okay";
+};
+
+&dsi {
+	status = "ok";
+
+	ports {
+		 /* 1 for output port */
+		port at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			/* 0 for bridge, other value for panel */
+			dsi_out0: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&adv7533_in>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "ok";
+
+	adv7533: adv7533 at 39 {
+		compatible = "adi,adv7533";
+		reg = <0x39>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 2>;
+		pd-gpio = <&gpio0 4 0>;
+		adi,dsi-lanes = <4>;
+
+		port {
+			adv7533_in: endpoint {
+				remote-endpoint = <&dsi_out0>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index ad1f1ebcb05c..e50e81cdd242 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -209,5 +209,58 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		ade: ade at f4100000 {
+			compatible = "hisilicon,hi6220-ade";
+			reg = <0x0 0xf4100000 0x0 0x7800>,
+			      <0x0 0xf4410000 0x0 0x1000>,
+			      <0x0 0xf4520000 0x0 0x1000>;
+			reg-names = "ade_base",
+				    "media_base",
+				    "media_noc_base";
+
+			interrupts = <0 115 4>; /* ldi interrupt */
+
+			clocks = <&media_ctrl HI6220_ADE_CORE>,
+				 <&media_ctrl HI6220_CODEC_JPEG>,
+				 <&media_ctrl HI6220_ADE_PIX_SRC>;
+			/*clock name*/
+			clock-names  = "clk_ade_core",
+				       "clk_codec_jpeg",
+				       "clk_ade_pix";
+
+			assigned-clocks = <&media_ctrl HI6220_ADE_CORE>,
+				<&media_ctrl HI6220_CODEC_JPEG>;
+			assigned-clock-rates = <360000000>, <288000000>;
+			dma-coherent;
+			status = "disabled";
+
+			port {
+				ade_out: endpoint {
+					remote-endpoint = <&dsi_in>;
+				};
+			};
+		};
+
+		dsi: dsi at f4107800 {
+			compatible = "hisilicon,hi6220-dsi";
+			reg = <0x0 0xf4107800 0x0 0x100>;
+			clocks = <&media_ctrl  HI6220_DSI_PCLK>;
+			clock-names = "pclk_dsi";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* 0 for input port */
+				port at 0 {
+					reg = <0>;
+					dsi_in: endpoint {
+						remote-endpoint = <&ade_out>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
1.9.1
