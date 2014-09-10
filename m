From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 10 Sep 2014 15:33:37 +0100
Subject: [PATCH 1/2] ARM: vexpress: Add CLCD Device Tree properties
Message-ID: <1410359618-3441-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... for V2M-P1 motherboard CLCD (limited to 640x480 16bpp and using
dedicated video RAM bank) and for V2P-CA9 (up to 1024x768 16bpp).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi | 36 +++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/vexpress-v2m.dtsi     | 36 +++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/vexpress-v2p-ca9.dts  | 31 ++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index 756c986..2efb205 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -41,7 +41,7 @@
 			bank-width = <4>;
 		};
 
-		vram at 2,00000000 {
+		v2m_video_ram: vram at 2,00000000 {
 			compatible = "arm,vexpress-vram";
 			reg = <2 0x00000000 0x00800000>;
 		};
@@ -246,9 +246,41 @@
 			clcd at 1f0000 {
 				compatible = "arm,pl111", "arm,primecell";
 				reg = <0x1f0000 0x1000>;
+				interrupt-names = "combined";
 				interrupts = <14>;
 				clocks = <&v2m_oscclk1>, <&smbclk>;
 				clock-names = "clcdclk", "apb_pclk";
+				memory-region = <&v2m_video_ram>;
+				max-memory-bandwidth = <50350000>; /* 16bpp @ 25.175MHz */
+
+				port {
+					v2m_clcd_pads: endpoint {
+						remote-endpoint = <&v2m_clcd_panel>;
+						arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+					};
+				};
+
+				panel {
+					compatible = "panel-dpi";
+
+					port {
+						v2m_clcd_panel: endpoint {
+							remote-endpoint = <&v2m_clcd_pads>;
+						};
+					};
+
+					panel-timing {
+						clock-frequency = <25175000>;
+						hactive = <640>;
+						hback-porch = <40>;
+						hfront-porch = <24>;
+						hsync-len = <96>;
+						vactive = <480>;
+						vback-porch = <32>;
+						vfront-porch = <11>;
+						vsync-len = <2>;
+					};
+				};
 			};
 		};
 
@@ -350,7 +382,7 @@
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 63500000>;
+				freq-range = <23750000 65000000>;
 				#clock-cells = <0>;
 				clock-output-names = "v2m:oscclk1";
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index ba856d6..cb3090f 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -40,7 +40,7 @@
 			bank-width = <4>;
 		};
 
-		vram at 3,00000000 {
+		v2m_video_ram: vram at 3,00000000 {
 			compatible = "arm,vexpress-vram";
 			reg = <3 0x00000000 0x00800000>;
 		};
@@ -245,9 +245,41 @@
 			clcd at 1f000 {
 				compatible = "arm,pl111", "arm,primecell";
 				reg = <0x1f000 0x1000>;
+				interrupt-names = "combined";
 				interrupts = <14>;
 				clocks = <&v2m_oscclk1>, <&smbclk>;
 				clock-names = "clcdclk", "apb_pclk";
+				memory-region = <&v2m_video_ram>;
+				max-memory-bandwidth = <50350000>; /* 16bpp @ 25.175MHz */
+
+				port {
+					v2m_clcd_pads: endpoint {
+						remote-endpoint = <&v2m_clcd_panel>;
+						arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+					};
+				};
+
+				panel {
+					compatible = "panel-dpi";
+
+					port {
+						v2m_clcd_panel: endpoint {
+							remote-endpoint = <&v2m_clcd_pads>;
+						};
+					};
+
+					panel-timing {
+						clock-frequency = <25175000>;
+						hactive = <640>;
+						hback-porch = <40>;
+						hfront-porch = <24>;
+						hsync-len = <96>;
+						vactive = <480>;
+						vback-porch = <32>;
+						vfront-porch = <11>;
+						vsync-len = <2>;
+					};
+				};
 			};
 		};
 
@@ -349,7 +381,7 @@
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 63500000>;
+				freq-range = <23750000 65000000>;
 				#clock-cells = <0>;
 				clock-output-names = "v2m:oscclk1";
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 62d9b22..23662b5 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -70,9 +70,40 @@
 	clcd at 10020000 {
 		compatible = "arm,pl111", "arm,primecell";
 		reg = <0x10020000 0x1000>;
+		interrupt-names = "combined";
 		interrupts = <0 44 4>;
 		clocks = <&oscclk1>, <&oscclk2>;
 		clock-names = "clcdclk", "apb_pclk";
+		max-memory-bandwidth = <130000000>; /* 16bpp @ 63.5MHz */
+
+		port {
+			clcd_pads: endpoint {
+				remote-endpoint = <&clcd_panel>;
+				arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+			};
+		};
+
+		panel {
+			compatible = "panel-dpi";
+
+			port {
+				clcd_panel: endpoint {
+					remote-endpoint = <&clcd_pads>;
+				};
+			};
+
+			panel-timing {
+				clock-frequency = <63500127>;
+				hactive = <1024>;
+				hback-porch = <152>;
+				hfront-porch = <48>;
+				hsync-len = <104>;
+				vactive = <768>;
+				vback-porch = <23>;
+				vfront-porch = <3>;
+				vsync-len = <4>;
+			};
+		};
 	};
 
 	memory-controller at 100e0000 {
-- 
1.9.1
