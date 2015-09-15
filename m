From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Tue, 15 Sep 2015 17:37:14 +0800
Subject: [PATCH RFC 8/8] dts: hisilicon: Add drm driver device dts config for
 HiKey board
In-Reply-To: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <1442309834-21420-9-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds drm dts node for HiKey board using hi6220 SOC.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
Signed-off-by: Yu Gong <gongyu@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..9ce8c62 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -4,6 +4,7 @@
  * Copyright (C) 2015, Hisilicon Ltd.
  */
 
+#include <dt-bindings/clock/hi6220-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -167,5 +168,38 @@
 			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		display-subsystem {
+			compatible = "hisilicon,display-subsystem";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			dma-coherent;
+
+			ade: ade at f4100000 {
+				compatible = "hisilicon,hi6220-ade";
+				reg = <0x0 0xf4100000 0x0 0x7800>,
+				      <0x0 0xf4410000 0x0 0x1000>;
+				reg-names = "ade_base",
+					    "media_base";
+				interrupts = <0 115 4>; /* ldi interrupt */
+
+				clocks = <&media_ctrl HI6220_ADE_CORE>,
+					 <&media_ctrl HI6220_CODEC_JPEG>,
+					 <&media_ctrl HI6220_ADE_PIX_SRC>;
+				/*clock name*/
+				clock-names  = "clk_ade_core",
+					       "aclk_codec_jpeg_src",
+					       "clk_ade_pix";
+			};
+
+			dsi {
+				compatible = "hisilicon,hi6220-dsi";
+				reg = <0x0 0xf4107800 0x0 0x100>;
+				clocks = <&media_ctrl  HI6220_DSI_PCLK>;
+				clock-names = "pclk_dsi";
+				encoder-slave = <&adv7533>;
+			};
+		};
 	};
 };
-- 
1.9.1
