From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 May 2018 14:26:56 +0200
Subject: [PATCH 2/4] ARM: dts: Modernize the Vexpress PL111 integration
In-Reply-To: <20180528122658.3241-1-linus.walleij@linaro.org>
References: <20180528122658.3241-1-linus.walleij@linaro.org>
Message-ID: <20180528122658.3241-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Express was submitted with the actual display
bridges unconnected (but defined in the device tree) and
mock "panels" encoded in the device tree node of the PL111
controller.

This doesn't even remotely describe the actual Versatile
Express hardware. Exploit the SiI9022 bridge by connecting
the PL111 pads to it, making it use EDID or fallback values
to drive the monitor.

The  also has to use the reserved memory through the
CMA pool rather than by open coding a memory region and
remapping it explicitly in the driver. To achieve this,
a reserved-memory node must exist in the root of the
device tree, so we need to pull that out of the
motherboard .dtsi include files, and push it into each
top-level device tree instead.

We do the same manouver for all the Versatile Express
boards, taking into account the different location of the
video RAM depending on which chip select is used on
each platform.

This plays nicely with the new PL111 DRM driver and
follows the standard ways of assigning bridges and
memory pools for graphics.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mali DP Maintainers <malidp@foss.arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix up the memory address for the -rs1 tiles to 0x18000000
- Drop a bunch of extraneous reg props from the DVI adapter
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi       | 44 ++++++------------
 arch/arm/boot/dts/vexpress-v2m.dtsi           | 45 ++++++-------------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts   | 14 ++++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts    | 14 ++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts       | 14 ++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts        | 41 +++++++----------
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts    | 14 ++++++
 .../boot/dts/arm/rtsm_ve-motherboard.dtsi     | 37 +++------------
 8 files changed, 105 insertions(+), 118 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index 7b8ff5b3b912..69f6a9436325 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -43,11 +43,6 @@
 				bank-width = <4>;
 			};
 
-			v2m_video_ram: vram at 2,00000000 {
-				compatible = "arm,vexpress-vram";
-				reg = <2 0x00000000 0x00800000>;
-			};
-
 			ethernet at 2,02000000 {
 				compatible = "smsc,lan9118", "smsc,lan9115";
 				reg = <2 0x02000000 0x10000>;
@@ -224,6 +219,14 @@
 					dvi-transmitter at 39 {
 						compatible = "sil,sii9022-tpi", "sil,sii9022";
 						reg = <0x39>;
+
+						ports {
+							port at 0 {
+								dvi_bridge_in: endpoint {
+									remote-endpoint = <&clcd_pads>;
+								};
+							};
+						};
 					};
 
 					dvi-transmitter at 60 {
@@ -254,37 +257,16 @@
 					interrupts = <14>;
 					clocks = <&v2m_oscclk1>, <&smbclk>;
 					clock-names = "clcdclk", "apb_pclk";
-					memory-region = <&v2m_video_ram>;
-					max-memory-bandwidth = <50350000>; /* 16bpp @ 25.175MHz */
+					/* 800x600 16bpp @36MHz works fine */
+					max-memory-bandwidth = <54000000>;
+					memory-region = <&vram>;
 
 					port {
-						v2m_clcd_pads: endpoint {
-							remote-endpoint = <&v2m_clcd_panel>;
+						clcd_pads: endpoint {
+							remote-endpoint = <&dvi_bridge_in>;
 							arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
 						};
 					};
-
-					panel {
-						compatible = "panel-dpi";
-
-						port {
-							v2m_clcd_panel: endpoint {
-								remote-endpoint = <&v2m_clcd_pads>;
-							};
-						};
-
-						panel-timing {
-							clock-frequency = <25175000>;
-							hactive = <640>;
-							hback-porch = <40>;
-							hfront-porch = <24>;
-							hsync-len = <96>;
-							vactive = <480>;
-							vback-porch = <32>;
-							vfront-porch = <11>;
-							vsync-len = <2>;
-						};
-					};
 				};
 			};
 
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index 9cd5e146abd5..067d84bc61c0 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -43,11 +43,6 @@
 				bank-width = <4>;
 			};
 
-			v2m_video_ram: vram at 3,00000000 {
-				compatible = "arm,vexpress-vram";
-				reg = <3 0x00000000 0x00800000>;
-			};
-
 			ethernet at 3,02000000 {
 				compatible = "smsc,lan9118", "smsc,lan9115";
 				reg = <3 0x02000000 0x10000>;
@@ -224,6 +219,14 @@
 					dvi-transmitter at 39 {
 						compatible = "sil,sii9022-tpi", "sil,sii9022";
 						reg = <0x39>;
+
+						ports {
+							port at 0 {
+								dvi_bridge_in: endpoint {
+									remote-endpoint = <&clcd_pads>;
+								};
+							};
+						};
 					};
 
 					dvi-transmitter at 60 {
@@ -247,6 +250,7 @@
 					reg-shift = <2>;
 				};
 
+
 				clcd at 1f000 {
 					compatible = "arm,pl111", "arm,primecell";
 					reg = <0x1f000 0x1000>;
@@ -254,37 +258,16 @@
 					interrupts = <14>;
 					clocks = <&v2m_oscclk1>, <&smbclk>;
 					clock-names = "clcdclk", "apb_pclk";
-					memory-region = <&v2m_video_ram>;
-					max-memory-bandwidth = <50350000>; /* 16bpp @ 25.175MHz */
+					/* 800x600 16bpp @36MHz works fine */
+					max-memory-bandwidth = <54000000>;
+					memory-region = <&vram>;
 
 					port {
-						v2m_clcd_pads: endpoint {
-							remote-endpoint = <&v2m_clcd_panel>;
+						clcd_pads_mb: endpoint {
+							remote-endpoint = <&dvi_bridge_in>;
 							arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
 						};
 					};
-
-					panel {
-						compatible = "panel-dpi";
-
-						port {
-							v2m_clcd_panel: endpoint {
-								remote-endpoint = <&v2m_clcd_pads>;
-							};
-						};
-
-						panel-timing {
-							clock-frequency = <25175000>;
-							hactive = <640>;
-							hback-porch = <40>;
-							hfront-porch = <24>;
-							hsync-len = <96>;
-							vactive = <480>;
-							vback-porch = <32>;
-							vfront-porch = <11>;
-							vsync-len = <2>;
-						};
-					};
 				};
 			};
 
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 3971427a105b..0dc4277d5f8b 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -53,6 +53,20 @@
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* Chipselect 2 is physically at 0x18000000 */
+		vram: vram at 18000000 {
+			/* 8 MB of designated video RAM */
+			compatible = "shared-dma-pool";
+			reg = <0 0x18000000 0 0x00800000>;
+			no-map;
+		};
+	};
+
 	hdlcd at 2b000000 {
 		compatible = "arm,hdlcd";
 		reg = <0 0x2b000000 0 0x1000>;
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 65a874ea66be..d03617d60866 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -104,6 +104,20 @@
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* Chipselect 2 is physically at 0x18000000 */
+		vram: vram at 18000000 {
+			/* 8 MB of designated video RAM */
+			compatible = "shared-dma-pool";
+			reg = <0 0x18000000 0 0x00800000>;
+			no-map;
+		};
+	};
+
 	wdt at 2a490000 {
 		compatible = "arm,sp805", "arm,primecell";
 		reg = <0 0x2a490000 0 0x1000>;
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index e5b4a7570a01..d5b47d526f9e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -55,6 +55,20 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* Chipselect 2 is physically at 0x18000000 */
+		vram: vram at 18000000 {
+			/* 8 MB of designated video RAM */
+			compatible = "shared-dma-pool";
+			reg = <0x18000000 0x00800000>;
+			no-map;
+		};
+	};
+
 	hdlcd at 2a110000 {
 		compatible = "arm,hdlcd";
 		reg = <0x2a110000 0x1000>;
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 7ec3dac1f61d..7252bcce2086 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -69,6 +69,20 @@
 		reg = <0x60000000 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* Chipselect 3 is physically at 0x4c000000 */
+		vram: vram at 4c000000 {
+			/* 8 MB of designated video RAM */
+			compatible = "shared-dma-pool";
+			reg = <0x4c000000 0x00800000>;
+			no-map;
+		};
+	};
+
 	clcd at 10020000 {
 		compatible = "arm,pl111", "arm,primecell";
 		reg = <0x10020000 0x1000>;
@@ -76,36 +90,15 @@
 		interrupts = <0 44 4>;
 		clocks = <&oscclk1>, <&oscclk2>;
 		clock-names = "clcdclk", "apb_pclk";
-		max-memory-bandwidth = <130000000>; /* 16bpp @ 63.5MHz */
+		/* 1024x768 16bpp @65MHz */
+		max-memory-bandwidth = <95000000>;
 
 		port {
 			clcd_pads: endpoint {
-				remote-endpoint = <&clcd_panel>;
+				remote-endpoint = <&dvi_bridge_in>;
 				arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
 			};
 		};
-
-		panel {
-			compatible = "panel-dpi";
-
-			port {
-				clcd_panel: endpoint {
-					remote-endpoint = <&clcd_pads>;
-				};
-			};
-
-			panel-timing {
-				clock-frequency = <63500127>;
-				hactive = <1024>;
-				hback-porch = <152>;
-				hfront-porch = <48>;
-				hsync-len = <104>;
-				vactive = <768>;
-				vback-porch = <23>;
-				vfront-porch = <3>;
-				vsync-len = <4>;
-			};
-		};
 	};
 
 	memory-controller at 100e0000 {
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index 06c8117e812a..e9423a099573 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -76,6 +76,20 @@
 		      <0x00000008 0x80000000 0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* Chipselect 2 is physically at 0x48000000 */
+		vram: vram at 48000000 {
+			/* 8 MB of designated video RAM */
+			compatible = "shared-dma-pool";
+			reg = <0x48000000 0x00800000>;
+			no-map;
+		};
+	};
+
 	gic: interrupt-controller at 2c001000 {
 		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index 1134e5d8df18..737d0a0c0854 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -23,11 +23,6 @@
 			bank-width = <4>;
 		};
 
-		v2m_video_ram: vram at 2,00000000 {
-			compatible = "arm,vexpress-vram";
-			reg = <2 0x00000000 0x00800000>;
-		};
-
 		ethernet at 2,02000000 {
 			compatible = "smsc,lan91c111";
 			reg = <2 0x02000000 0x10000>;
@@ -186,38 +181,16 @@
 				interrupts = <14>;
 				clocks = <&v2m_oscclk1>, <&v2m_clk24mhz>;
 				clock-names = "clcdclk", "apb_pclk";
-				arm,pl11x,framebuffer = <0x18000000 0x00180000>;
-				memory-region = <&v2m_video_ram>;
-				max-memory-bandwidth = <130000000>; /* 16bpp @ 63.5MHz */
+				/* 800x600 16bpp @36MHz works fine */
+				max-memory-bandwidth = <54000000>;
+				memory-region = <&vram>;
 
 				port {
-					v2m_clcd_pads: endpoint {
-						remote-endpoint = <&v2m_clcd_panel>;
+					clcd_pads: endpoint {
+						remote-endpoint = <&dvi_bridge_in>;
 						arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
 					};
 				};
-
-				panel {
-					compatible = "panel-dpi";
-
-					port {
-						v2m_clcd_panel: endpoint {
-							remote-endpoint = <&v2m_clcd_pads>;
-						};
-					};
-
-					panel-timing {
-						clock-frequency = <63500127>;
-						hactive = <1024>;
-						hback-porch = <152>;
-						hfront-porch = <48>;
-						hsync-len = <104>;
-						vactive = <768>;
-						vback-porch = <23>;
-						vfront-porch = <3>;
-						vsync-len = <4>;
-					};
-				};
 			};
 
 			virtio-block at 130000 {
-- 
2.17.0
