From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 25 Oct 2016 18:16:35 +0200
Subject: [PATCH] ARM: DT: stm32: move dma translation to board files
Message-ID: <1477412195-8124-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32f469-disco and stm32f429-eval boards use SDRAM start address remapping
(to @0) to boost performances. A DMA translation through "dma-ranges"
property was needed for other masters than the M4 CPU.
stm32f429-disco doesn't use remapping so doesn't need this DMA translation.
This patches moves this DMA translation definition from stm32f429 soc file
to board files.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 13c7cd2..a763c15 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -82,6 +82,10 @@
 		};
 	};
 
+	soc {
+		dma-ranges = <0xc0000000 0x0 0x10000000>;
+	};
+
 	usbotg_hs_phy: usbphy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 0596d60..3a1cfdd 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -59,8 +59,6 @@
 	};
 
 	soc {
-		dma-ranges = <0xc0000000 0x0 0x10000000>;
-
 		timer2: timer at 40000000 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000000 0x400>;
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 9e73656..c2213c0 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -64,6 +64,10 @@
 	aliases {
 		serial0 = &usart3;
 	};
+
+	soc {
+		dma-ranges = <0xc0000000 0x0 0x10000000>;
+	};
 };
 
 &clk_hse {
-- 
1.9.1
