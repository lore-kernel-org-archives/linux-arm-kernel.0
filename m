From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 May 2018 14:26:55 +0200
Subject: [PATCH 1/4] ARM: dts: Restructure Vexpress motherboard includes
In-Reply-To: <20180528122658.3241-1-linus.walleij@linaro.org>
References: <20180528122658.3241-1-linus.walleij@linaro.org>
Message-ID: <20180528122658.3241-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is a bit unorthodox to just include a file in the middle
of a another DTS file, it breaks the pattern from other device
trees and also makes it really hard to reference things
across the files with phandles.

Restructure the include for the Versatile Express motherboards
to happen at the top of the file, reference the target nodes
directly, and indent the motherboard .dtsi files to reflect
their actual depth in the hiearchy.

This is a purely syntactic change that result in the same
DTB files from the DTS/DTSI files.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mali DP Maintainers <malidp@foss.arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi       | 706 +++++++++---------
 arch/arm/boot/dts/vexpress-v2m.dtsi           | 704 ++++++++---------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts   |   3 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts    |   5 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts       |   5 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts        |   5 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts |   5 +-
 7 files changed, 718 insertions(+), 715 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index 35714ff6f467..7b8ff5b3b912 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -17,426 +17,430 @@
  * CHANGES TO vexpress-v2m.dtsi!
  */
 
-	motherboard {
-		model = "V2M-P1";
-		arm,hbi = <0x190>;
-		arm,vexpress,site = <0>;
-		arm,v2m-memory-map = "rs1";
-		compatible = "arm,vexpress,v2m-p1", "simple-bus";
-		#address-cells = <2>; /* SMB chipselect number and offset */
-		#size-cells = <1>;
-		#interrupt-cells = <1>;
-		ranges;
-
-		flash at 0,00000000 {
-			compatible = "arm,vexpress-flash", "cfi-flash";
-			reg = <0 0x00000000 0x04000000>,
-			      <4 0x00000000 0x04000000>;
-			bank-width = <4>;
-		};
+/ {
+	smb at 8000000 {
+		motherboard {
+			model = "V2M-P1";
+			arm,hbi = <0x190>;
+			arm,vexpress,site = <0>;
+			arm,v2m-memory-map = "rs1";
+			compatible = "arm,vexpress,v2m-p1", "simple-bus";
+			#address-cells = <2>; /* SMB chipselect number and offset */
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			ranges;
 
-		psram at 1,00000000 {
-			compatible = "arm,vexpress-psram", "mtd-ram";
-			reg = <1 0x00000000 0x02000000>;
-			bank-width = <4>;
-		};
+			flash at 0,00000000 {
+				compatible = "arm,vexpress-flash", "cfi-flash";
+				reg = <0 0x00000000 0x04000000>,
+				      <4 0x00000000 0x04000000>;
+				bank-width = <4>;
+			};
 
-		v2m_video_ram: vram at 2,00000000 {
-			compatible = "arm,vexpress-vram";
-			reg = <2 0x00000000 0x00800000>;
-		};
+			psram at 1,00000000 {
+				compatible = "arm,vexpress-psram", "mtd-ram";
+				reg = <1 0x00000000 0x02000000>;
+				bank-width = <4>;
+			};
 
-		ethernet at 2,02000000 {
-			compatible = "smsc,lan9118", "smsc,lan9115";
-			reg = <2 0x02000000 0x10000>;
-			interrupts = <15>;
-			phy-mode = "mii";
-			reg-io-width = <4>;
-			smsc,irq-active-high;
-			smsc,irq-push-pull;
-			vdd33a-supply = <&v2m_fixed_3v3>;
-			vddvario-supply = <&v2m_fixed_3v3>;
-		};
+			v2m_video_ram: vram at 2,00000000 {
+				compatible = "arm,vexpress-vram";
+				reg = <2 0x00000000 0x00800000>;
+			};
 
-		usb at 2,03000000 {
-			compatible = "nxp,usb-isp1761";
-			reg = <2 0x03000000 0x20000>;
-			interrupts = <16>;
-			port1-otg;
-		};
+			ethernet at 2,02000000 {
+				compatible = "smsc,lan9118", "smsc,lan9115";
+				reg = <2 0x02000000 0x10000>;
+				interrupts = <15>;
+				phy-mode = "mii";
+				reg-io-width = <4>;
+				smsc,irq-active-high;
+				smsc,irq-push-pull;
+				vdd33a-supply = <&v2m_fixed_3v3>;
+				vddvario-supply = <&v2m_fixed_3v3>;
+			};
 
-		iofpga at 3,00000000 {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 3 0 0x200000>;
+			usb at 2,03000000 {
+				compatible = "nxp,usb-isp1761";
+				reg = <2 0x03000000 0x20000>;
+				interrupts = <16>;
+				port1-otg;
+			};
 
-			v2m_sysreg: sysreg at 10000 {
-				compatible = "arm,vexpress-sysreg";
-				reg = <0x010000 0x1000>;
+			iofpga at 3,00000000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 3 0 0x200000>;
 
-				v2m_led_gpios: sys_led {
-					compatible = "arm,vexpress-sysreg,sys_led";
-					gpio-controller;
-					#gpio-cells = <2>;
-				};
+				v2m_sysreg: sysreg at 10000 {
+					compatible = "arm,vexpress-sysreg";
+					reg = <0x010000 0x1000>;
 
-				v2m_mmc_gpios: sys_mci {
-					compatible = "arm,vexpress-sysreg,sys_mci";
-					gpio-controller;
-					#gpio-cells = <2>;
+					v2m_led_gpios: sys_led {
+						compatible = "arm,vexpress-sysreg,sys_led";
+						gpio-controller;
+						#gpio-cells = <2>;
+					};
+
+					v2m_mmc_gpios: sys_mci {
+						compatible = "arm,vexpress-sysreg,sys_mci";
+						gpio-controller;
+						#gpio-cells = <2>;
+					};
+
+					v2m_flash_gpios: sys_flash {
+						compatible = "arm,vexpress-sysreg,sys_flash";
+						gpio-controller;
+						#gpio-cells = <2>;
+					};
 				};
 
-				v2m_flash_gpios: sys_flash {
-					compatible = "arm,vexpress-sysreg,sys_flash";
-					gpio-controller;
-					#gpio-cells = <2>;
+				v2m_sysctl: sysctl at 20000 {
+					compatible = "arm,sp810", "arm,primecell";
+					reg = <0x020000 0x1000>;
+					clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&smbclk>;
+					clock-names = "refclk", "timclk", "apb_pclk";
+					#clock-cells = <1>;
+					clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+					assigned-clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_sysctl 3>, <&v2m_sysctl 3>;
+					assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
 				};
-			};
 
-			v2m_sysctl: sysctl at 20000 {
-				compatible = "arm,sp810", "arm,primecell";
-				reg = <0x020000 0x1000>;
-				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&smbclk>;
-				clock-names = "refclk", "timclk", "apb_pclk";
-				#clock-cells = <1>;
-				clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
-				assigned-clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_sysctl 3>, <&v2m_sysctl 3>;
-				assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
-			};
+				/* PCI-E I2C bus */
+				v2m_i2c_pcie: i2c at 30000 {
+					compatible = "arm,versatile-i2c";
+					reg = <0x030000 0x1000>;
 
-			/* PCI-E I2C bus */
-			v2m_i2c_pcie: i2c at 30000 {
-				compatible = "arm,versatile-i2c";
-				reg = <0x030000 0x1000>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
+					pcie-switch at 60 {
+						compatible = "idt,89hpes32h8";
+						reg = <0x60>;
+					};
+				};
 
-				pcie-switch at 60 {
-					compatible = "idt,89hpes32h8";
-					reg = <0x60>;
+				aaci at 40000 {
+					compatible = "arm,pl041", "arm,primecell";
+					reg = <0x040000 0x1000>;
+					interrupts = <11>;
+					clocks = <&smbclk>;
+					clock-names = "apb_pclk";
 				};
-			};
 
-			aaci at 40000 {
-				compatible = "arm,pl041", "arm,primecell";
-				reg = <0x040000 0x1000>;
-				interrupts = <11>;
-				clocks = <&smbclk>;
-				clock-names = "apb_pclk";
-			};
+				mmci at 50000 {
+					compatible = "arm,pl180", "arm,primecell";
+					reg = <0x050000 0x1000>;
+					interrupts = <9 10>;
+					cd-gpios = <&v2m_mmc_gpios 0 0>;
+					wp-gpios = <&v2m_mmc_gpios 1 0>;
+					max-frequency = <12000000>;
+					vmmc-supply = <&v2m_fixed_3v3>;
+					clocks = <&v2m_clk24mhz>, <&smbclk>;
+					clock-names = "mclk", "apb_pclk";
+				};
 
-			mmci at 50000 {
-				compatible = "arm,pl180", "arm,primecell";
-				reg = <0x050000 0x1000>;
-				interrupts = <9 10>;
-				cd-gpios = <&v2m_mmc_gpios 0 0>;
-				wp-gpios = <&v2m_mmc_gpios 1 0>;
-				max-frequency = <12000000>;
-				vmmc-supply = <&v2m_fixed_3v3>;
-				clocks = <&v2m_clk24mhz>, <&smbclk>;
-				clock-names = "mclk", "apb_pclk";
-			};
+				kmi at 60000 {
+					compatible = "arm,pl050", "arm,primecell";
+					reg = <0x060000 0x1000>;
+					interrupts = <12>;
+					clocks = <&v2m_clk24mhz>, <&smbclk>;
+					clock-names = "KMIREFCLK", "apb_pclk";
+				};
 
-			kmi at 60000 {
-				compatible = "arm,pl050", "arm,primecell";
-				reg = <0x060000 0x1000>;
-				interrupts = <12>;
-				clocks = <&v2m_clk24mhz>, <&smbclk>;
-				clock-names = "KMIREFCLK", "apb_pclk";
-			};
+				kmi at 70000 {
+					compatible = "arm,pl050", "arm,primecell";
+					reg = <0x070000 0x1000>;
+					interrupts = <13>;
+					clocks = <&v2m_clk24mhz>, <&smbclk>;
+					clock-names = "KMIREFCLK", "apb_pclk";
+				};
 
-			kmi at 70000 {
-				compatible = "arm,pl050", "arm,primecell";
-				reg = <0x070000 0x1000>;
-				interrupts = <13>;
-				clocks = <&v2m_clk24mhz>, <&smbclk>;
-				clock-names = "KMIREFCLK", "apb_pclk";
-			};
+				v2m_serial0: uart at 90000 {
+					compatible = "arm,pl011", "arm,primecell";
+					reg = <0x090000 0x1000>;
+					interrupts = <5>;
+					clocks = <&v2m_oscclk2>, <&smbclk>;
+					clock-names = "uartclk", "apb_pclk";
+				};
 
-			v2m_serial0: uart at 90000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x090000 0x1000>;
-				interrupts = <5>;
-				clocks = <&v2m_oscclk2>, <&smbclk>;
-				clock-names = "uartclk", "apb_pclk";
-			};
+				v2m_serial1: uart at a0000 {
+					compatible = "arm,pl011", "arm,primecell";
+					reg = <0x0a0000 0x1000>;
+					interrupts = <6>;
+					clocks = <&v2m_oscclk2>, <&smbclk>;
+					clock-names = "uartclk", "apb_pclk";
+				};
 
-			v2m_serial1: uart at a0000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x0a0000 0x1000>;
-				interrupts = <6>;
-				clocks = <&v2m_oscclk2>, <&smbclk>;
-				clock-names = "uartclk", "apb_pclk";
-			};
+				v2m_serial2: uart at b0000 {
+					compatible = "arm,pl011", "arm,primecell";
+					reg = <0x0b0000 0x1000>;
+					interrupts = <7>;
+					clocks = <&v2m_oscclk2>, <&smbclk>;
+					clock-names = "uartclk", "apb_pclk";
+				};
 
-			v2m_serial2: uart at b0000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x0b0000 0x1000>;
-				interrupts = <7>;
-				clocks = <&v2m_oscclk2>, <&smbclk>;
-				clock-names = "uartclk", "apb_pclk";
-			};
+				v2m_serial3: uart at c0000 {
+					compatible = "arm,pl011", "arm,primecell";
+					reg = <0x0c0000 0x1000>;
+					interrupts = <8>;
+					clocks = <&v2m_oscclk2>, <&smbclk>;
+					clock-names = "uartclk", "apb_pclk";
+				};
 
-			v2m_serial3: uart at c0000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x0c0000 0x1000>;
-				interrupts = <8>;
-				clocks = <&v2m_oscclk2>, <&smbclk>;
-				clock-names = "uartclk", "apb_pclk";
-			};
+				wdt at f0000 {
+					compatible = "arm,sp805", "arm,primecell";
+					reg = <0x0f0000 0x1000>;
+					interrupts = <0>;
+					clocks = <&v2m_refclk32khz>, <&smbclk>;
+					clock-names = "wdogclk", "apb_pclk";
+				};
 
-			wdt at f0000 {
-				compatible = "arm,sp805", "arm,primecell";
-				reg = <0x0f0000 0x1000>;
-				interrupts = <0>;
-				clocks = <&v2m_refclk32khz>, <&smbclk>;
-				clock-names = "wdogclk", "apb_pclk";
-			};
+				v2m_timer01: timer at 110000 {
+					compatible = "arm,sp804", "arm,primecell";
+					reg = <0x110000 0x1000>;
+					interrupts = <2>;
+					clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
+					clock-names = "timclken1", "timclken2", "apb_pclk";
+				};
 
-			v2m_timer01: timer at 110000 {
-				compatible = "arm,sp804", "arm,primecell";
-				reg = <0x110000 0x1000>;
-				interrupts = <2>;
-				clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
-				clock-names = "timclken1", "timclken2", "apb_pclk";
-			};
+				v2m_timer23: timer at 120000 {
+					compatible = "arm,sp804", "arm,primecell";
+					reg = <0x120000 0x1000>;
+					interrupts = <3>;
+					clocks = <&v2m_sysctl 2>, <&v2m_sysctl 3>, <&smbclk>;
+					clock-names = "timclken1", "timclken2", "apb_pclk";
+				};
 
-			v2m_timer23: timer at 120000 {
-				compatible = "arm,sp804", "arm,primecell";
-				reg = <0x120000 0x1000>;
-				interrupts = <3>;
-				clocks = <&v2m_sysctl 2>, <&v2m_sysctl 3>, <&smbclk>;
-				clock-names = "timclken1", "timclken2", "apb_pclk";
-			};
+				/* DVI I2C bus */
+				v2m_i2c_dvi: i2c at 160000 {
+					compatible = "arm,versatile-i2c";
+					reg = <0x160000 0x1000>;
 
-			/* DVI I2C bus */
-			v2m_i2c_dvi: i2c at 160000 {
-				compatible = "arm,versatile-i2c";
-				reg = <0x160000 0x1000>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
+					dvi-transmitter at 39 {
+						compatible = "sil,sii9022-tpi", "sil,sii9022";
+						reg = <0x39>;
+					};
 
-				dvi-transmitter at 39 {
-					compatible = "sil,sii9022-tpi", "sil,sii9022";
-					reg = <0x39>;
+					dvi-transmitter at 60 {
+						compatible = "sil,sii9022-cpi", "sil,sii9022";
+						reg = <0x60>;
+					};
 				};
 
-				dvi-transmitter at 60 {
-					compatible = "sil,sii9022-cpi", "sil,sii9022";
-					reg = <0x60>;
+				rtc at 170000 {
+					compatible = "arm,pl031", "arm,primecell";
+					reg = <0x170000 0x1000>;
+					interrupts = <4>;
+					clocks = <&smbclk>;
+					clock-names = "apb_pclk";
 				};
-			};
-
-			rtc at 170000 {
-				compatible = "arm,pl031", "arm,primecell";
-				reg = <0x170000 0x1000>;
-				interrupts = <4>;
-				clocks = <&smbclk>;
-				clock-names = "apb_pclk";
-			};
 
-			compact-flash at 1a0000 {
-				compatible = "arm,vexpress-cf", "ata-generic";
-				reg = <0x1a0000 0x100
-				       0x1a0100 0xf00>;
-				reg-shift = <2>;
-			};
-
-			clcd at 1f0000 {
-				compatible = "arm,pl111", "arm,primecell";
-				reg = <0x1f0000 0x1000>;
-				interrupt-names = "combined";
-				interrupts = <14>;
-				clocks = <&v2m_oscclk1>, <&smbclk>;
-				clock-names = "clcdclk", "apb_pclk";
-				memory-region = <&v2m_video_ram>;
-				max-memory-bandwidth = <50350000>; /* 16bpp @ 25.175MHz */
-
-				port {
-					v2m_clcd_pads: endpoint {
-						remote-endpoint = <&v2m_clcd_panel>;
-						arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
-					};
+				compact-flash at 1a0000 {
+					compatible = "arm,vexpress-cf", "ata-generic";
+					reg = <0x1a0000 0x100
+					       0x1a0100 0xf00>;
+					reg-shift = <2>;
 				};
 
-				panel {
-					compatible = "panel-dpi";
+				clcd at 1f0000 {
+					compatible = "arm,pl111", "arm,primecell";
+					reg = <0x1f0000 0x1000>;
+					interrupt-names = "combined";
+					interrupts = <14>;
+					clocks = <&v2m_oscclk1>, <&smbclk>;
+					clock-names = "clcdclk", "apb_pclk";
+					memory-region = <&v2m_video_ram>;
+					max-memory-bandwidth = <50350000>; /* 16bpp @ 25.175MHz */
 
 					port {
-						v2m_clcd_panel: endpoint {
-							remote-endpoint = <&v2m_clcd_pads>;
+						v2m_clcd_pads: endpoint {
+							remote-endpoint = <&v2m_clcd_panel>;
+							arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
 						};
 					};
 
-					panel-timing {
-						clock-frequency = <25175000>;
-						hactive = <640>;
-						hback-porch = <40>;
-						hfront-porch = <24>;
-						hsync-len = <96>;
-						vactive = <480>;
-						vback-porch = <32>;
-						vfront-porch = <11>;
-						vsync-len = <2>;
+					panel {
+						compatible = "panel-dpi";
+
+						port {
+							v2m_clcd_panel: endpoint {
+								remote-endpoint = <&v2m_clcd_pads>;
+							};
+						};
+
+						panel-timing {
+							clock-frequency = <25175000>;
+							hactive = <640>;
+							hback-porch = <40>;
+							hfront-porch = <24>;
+							hsync-len = <96>;
+							vactive = <480>;
+							vback-porch = <32>;
+							vfront-porch = <11>;
+							vsync-len = <2>;
+						};
 					};
 				};
 			};
-		};
 
-		v2m_fixed_3v3: fixed-regulator-0 {
-			compatible = "regulator-fixed";
-			regulator-name = "3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+			v2m_fixed_3v3: fixed-regulator-0 {
+				compatible = "regulator-fixed";
+				regulator-name = "3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
 
-		v2m_clk24mhz: clk24mhz {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <24000000>;
-			clock-output-names = "v2m:clk24mhz";
-		};
+			v2m_clk24mhz: clk24mhz {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <24000000>;
+				clock-output-names = "v2m:clk24mhz";
+			};
 
-		v2m_refclk1mhz: refclk1mhz {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <1000000>;
-			clock-output-names = "v2m:refclk1mhz";
-		};
+			v2m_refclk1mhz: refclk1mhz {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <1000000>;
+				clock-output-names = "v2m:refclk1mhz";
+			};
 
-		v2m_refclk32khz: refclk32khz {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "v2m:refclk32khz";
-		};
+			v2m_refclk32khz: refclk32khz {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <32768>;
+				clock-output-names = "v2m:refclk32khz";
+			};
 
-		leds {
-			compatible = "gpio-leds";
+			leds {
+				compatible = "gpio-leds";
 
-			user1 {
-				label = "v2m:green:user1";
-				gpios = <&v2m_led_gpios 0 0>;
-				linux,default-trigger = "heartbeat";
-			};
+				user1 {
+					label = "v2m:green:user1";
+					gpios = <&v2m_led_gpios 0 0>;
+					linux,default-trigger = "heartbeat";
+				};
 
-			user2 {
-				label = "v2m:green:user2";
-				gpios = <&v2m_led_gpios 1 0>;
-				linux,default-trigger = "mmc0";
-			};
+				user2 {
+					label = "v2m:green:user2";
+					gpios = <&v2m_led_gpios 1 0>;
+					linux,default-trigger = "mmc0";
+				};
 
-			user3 {
-				label = "v2m:green:user3";
-				gpios = <&v2m_led_gpios 2 0>;
-				linux,default-trigger = "cpu0";
-			};
+				user3 {
+					label = "v2m:green:user3";
+					gpios = <&v2m_led_gpios 2 0>;
+					linux,default-trigger = "cpu0";
+				};
 
-			user4 {
-				label = "v2m:green:user4";
-				gpios = <&v2m_led_gpios 3 0>;
-				linux,default-trigger = "cpu1";
-			};
+				user4 {
+					label = "v2m:green:user4";
+					gpios = <&v2m_led_gpios 3 0>;
+					linux,default-trigger = "cpu1";
+				};
 
-			user5 {
-				label = "v2m:green:user5";
-				gpios = <&v2m_led_gpios 4 0>;
-				linux,default-trigger = "cpu2";
-			};
+				user5 {
+					label = "v2m:green:user5";
+					gpios = <&v2m_led_gpios 4 0>;
+					linux,default-trigger = "cpu2";
+				};
 
-			user6 {
-				label = "v2m:green:user6";
-				gpios = <&v2m_led_gpios 5 0>;
-				linux,default-trigger = "cpu3";
-			};
+				user6 {
+					label = "v2m:green:user6";
+					gpios = <&v2m_led_gpios 5 0>;
+					linux,default-trigger = "cpu3";
+				};
 
-			user7 {
-				label = "v2m:green:user7";
-				gpios = <&v2m_led_gpios 6 0>;
-				linux,default-trigger = "cpu4";
-			};
+				user7 {
+					label = "v2m:green:user7";
+					gpios = <&v2m_led_gpios 6 0>;
+					linux,default-trigger = "cpu4";
+				};
 
-			user8 {
-				label = "v2m:green:user8";
-				gpios = <&v2m_led_gpios 7 0>;
-				linux,default-trigger = "cpu5";
+				user8 {
+					label = "v2m:green:user8";
+					gpios = <&v2m_led_gpios 7 0>;
+					linux,default-trigger = "cpu5";
+				};
 			};
-		};
 
-		mcc {
-			compatible = "arm,vexpress,config-bus";
-			arm,vexpress,config-bridge = <&v2m_sysreg>;
+			mcc {
+				compatible = "arm,vexpress,config-bus";
+				arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-			oscclk0 {
-				/* MCC static memory clock */
-				compatible = "arm,vexpress-osc";
-				arm,vexpress-sysreg,func = <1 0>;
-				freq-range = <25000000 60000000>;
-				#clock-cells = <0>;
-				clock-output-names = "v2m:oscclk0";
-			};
+				oscclk0 {
+					/* MCC static memory clock */
+					compatible = "arm,vexpress-osc";
+					arm,vexpress-sysreg,func = <1 0>;
+					freq-range = <25000000 60000000>;
+					#clock-cells = <0>;
+					clock-output-names = "v2m:oscclk0";
+				};
 
-			v2m_oscclk1: oscclk1 {
-				/* CLCD clock */
-				compatible = "arm,vexpress-osc";
-				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 65000000>;
-				#clock-cells = <0>;
-				clock-output-names = "v2m:oscclk1";
-			};
+				v2m_oscclk1: oscclk1 {
+					/* CLCD clock */
+					compatible = "arm,vexpress-osc";
+					arm,vexpress-sysreg,func = <1 1>;
+					freq-range = <23750000 65000000>;
+					#clock-cells = <0>;
+					clock-output-names = "v2m:oscclk1";
+				};
 
-			v2m_oscclk2: oscclk2 {
-				/* IO FPGA peripheral clock */
-				compatible = "arm,vexpress-osc";
-				arm,vexpress-sysreg,func = <1 2>;
-				freq-range = <24000000 24000000>;
-				#clock-cells = <0>;
-				clock-output-names = "v2m:oscclk2";
-			};
+				v2m_oscclk2: oscclk2 {
+					/* IO FPGA peripheral clock */
+					compatible = "arm,vexpress-osc";
+					arm,vexpress-sysreg,func = <1 2>;
+					freq-range = <24000000 24000000>;
+					#clock-cells = <0>;
+					clock-output-names = "v2m:oscclk2";
+				};
 
-			volt-vio {
-				/* Logic level voltage */
-				compatible = "arm,vexpress-volt";
-				arm,vexpress-sysreg,func = <2 0>;
-				regulator-name = "VIO";
-				regulator-always-on;
-				label = "VIO";
-			};
+				volt-vio {
+					/* Logic level voltage */
+					compatible = "arm,vexpress-volt";
+					arm,vexpress-sysreg,func = <2 0>;
+					regulator-name = "VIO";
+					regulator-always-on;
+					label = "VIO";
+				};
 
-			temp-mcc {
-				/* MCC internal operating temperature */
-				compatible = "arm,vexpress-temp";
-				arm,vexpress-sysreg,func = <4 0>;
-				label = "MCC";
-			};
+				temp-mcc {
+					/* MCC internal operating temperature */
+					compatible = "arm,vexpress-temp";
+					arm,vexpress-sysreg,func = <4 0>;
+					label = "MCC";
+				};
 
-			reset {
-				compatible = "arm,vexpress-reset";
-				arm,vexpress-sysreg,func = <5 0>;
-			};
+				reset {
+					compatible = "arm,vexpress-reset";
+					arm,vexpress-sysreg,func = <5 0>;
+				};
 
-			muxfpga {
-				compatible = "arm,vexpress-muxfpga";
-				arm,vexpress-sysreg,func = <7 0>;
-			};
+				muxfpga {
+					compatible = "arm,vexpress-muxfpga";
+					arm,vexpress-sysreg,func = <7 0>;
+				};
 
-			shutdown {
-				compatible = "arm,vexpress-shutdown";
-				arm,vexpress-sysreg,func = <8 0>;
-			};
+				shutdown {
+					compatible = "arm,vexpress-shutdown";
+					arm,vexpress-sysreg,func = <8 0>;
+				};
 
-			reboot {
-				compatible = "arm,vexpress-reboot";
-				arm,vexpress-sysreg,func = <9 0>;
-			};
+				reboot {
+					compatible = "arm,vexpress-reboot";
+					arm,vexpress-sysreg,func = <9 0>;
+				};
 
-			dvimode {
-				compatible = "arm,vexpress-dvimode";
-				arm,vexpress-sysreg,func = <11 0>;
+				dvimode {
+					compatible = "arm,vexpress-dvimode";
+					arm,vexpress-sysreg,func = <11 0>;
+				};
 			};
 		};
 	};
+};
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index b0021a816028..9cd5e146abd5 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -18,425 +18,429 @@
  * CHANGES TO vexpress-v2m-rs1.dtsi!
  */
 
-	motherboard {
-		model = "V2M-P1";
-		arm,hbi = <0x190>;
-		arm,vexpress,site = <0>;
-		compatible = "arm,vexpress,v2m-p1", "simple-bus";
-		#address-cells = <2>; /* SMB chipselect number and offset */
-		#size-cells = <1>;
-		#interrupt-cells = <1>;
-		ranges;
-
-		flash at 0,00000000 {
-			compatible = "arm,vexpress-flash", "cfi-flash";
-			reg = <0 0x00000000 0x04000000>,
-			      <1 0x00000000 0x04000000>;
-			bank-width = <4>;
-		};
+/ {
+	smb at 4000000 {
+		motherboard {
+			model = "V2M-P1";
+			arm,hbi = <0x190>;
+			arm,vexpress,site = <0>;
+			compatible = "arm,vexpress,v2m-p1", "simple-bus";
+			#address-cells = <2>; /* SMB chipselect number and offset */
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			ranges;
 
-		psram at 2,00000000 {
-			compatible = "arm,vexpress-psram", "mtd-ram";
-			reg = <2 0x00000000 0x02000000>;
-			bank-width = <4>;
-		};
+			flash at 0,00000000 {
+				compatible = "arm,vexpress-flash", "cfi-flash";
+				reg = <0 0x00000000 0x04000000>,
+				      <1 0x00000000 0x04000000>;
+				bank-width = <4>;
+			};
 
-		v2m_video_ram: vram at 3,00000000 {
-			compatible = "arm,vexpress-vram";
-			reg = <3 0x00000000 0x00800000>;
-		};
+			psram at 2,00000000 {
+				compatible = "arm,vexpress-psram", "mtd-ram";
+				reg = <2 0x00000000 0x02000000>;
+				bank-width = <4>;
+			};
 
-		ethernet at 3,02000000 {
-			compatible = "smsc,lan9118", "smsc,lan9115";
-			reg = <3 0x02000000 0x10000>;
-			interrupts = <15>;
-			phy-mode = "mii";
-			reg-io-width = <4>;
-			smsc,irq-active-high;
-			smsc,irq-push-pull;
-			vdd33a-supply = <&v2m_fixed_3v3>;
-			vddvario-supply = <&v2m_fixed_3v3>;
-		};
+			v2m_video_ram: vram at 3,00000000 {
+				compatible = "arm,vexpress-vram";
+				reg = <3 0x00000000 0x00800000>;
+			};
 
-		usb at 3,03000000 {
-			compatible = "nxp,usb-isp1761";
-			reg = <3 0x03000000 0x20000>;
-			interrupts = <16>;
-			port1-otg;
-		};
+			ethernet at 3,02000000 {
+				compatible = "smsc,lan9118", "smsc,lan9115";
+				reg = <3 0x02000000 0x10000>;
+				interrupts = <15>;
+				phy-mode = "mii";
+				reg-io-width = <4>;
+				smsc,irq-active-high;
+				smsc,irq-push-pull;
+				vdd33a-supply = <&v2m_fixed_3v3>;
+				vddvario-supply = <&v2m_fixed_3v3>;
+			};
 
-		iofpga at 7,00000000 {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 7 0 0x20000>;
+			usb at 3,03000000 {
+				compatible = "nxp,usb-isp1761";
+				reg = <3 0x03000000 0x20000>;
+				interrupts = <16>;
+				port1-otg;
+			};
 
-			v2m_sysreg: sysreg at 0 {
-				compatible = "arm,vexpress-sysreg";
-				reg = <0x00000 0x1000>;
+			iofpga at 7,00000000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 7 0 0x20000>;
 
-				v2m_led_gpios: sys_led {
-					compatible = "arm,vexpress-sysreg,sys_led";
-					gpio-controller;
-					#gpio-cells = <2>;
-				};
+				v2m_sysreg: sysreg at 0 {
+					compatible = "arm,vexpress-sysreg";
+					reg = <0x00000 0x1000>;
 
-				v2m_mmc_gpios: sys_mci {
-					compatible = "arm,vexpress-sysreg,sys_mci";
-					gpio-controller;
-					#gpio-cells = <2>;
+					v2m_led_gpios: sys_led {
+						compatible = "arm,vexpress-sysreg,sys_led";
+						gpio-controller;
+						#gpio-cells = <2>;
+					};
+
+					v2m_mmc_gpios: sys_mci {
+						compatible = "arm,vexpress-sysreg,sys_mci";
+						gpio-controller;
+						#gpio-cells = <2>;
+					};
+
+					v2m_flash_gpios: sys_flash {
+						compatible = "arm,vexpress-sysreg,sys_flash";
+						gpio-controller;
+						#gpio-cells = <2>;
+					};
 				};
 
-				v2m_flash_gpios: sys_flash {
-					compatible = "arm,vexpress-sysreg,sys_flash";
-					gpio-controller;
-					#gpio-cells = <2>;
+				v2m_sysctl: sysctl at 1000 {
+					compatible = "arm,sp810", "arm,primecell";
+					reg = <0x01000 0x1000>;
+					clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&smbclk>;
+					clock-names = "refclk", "timclk", "apb_pclk";
+					#clock-cells = <1>;
+					clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
+					assigned-clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_sysctl 3>, <&v2m_sysctl 3>;
+					assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
 				};
-			};
 
-			v2m_sysctl: sysctl at 1000 {
-				compatible = "arm,sp810", "arm,primecell";
-				reg = <0x01000 0x1000>;
-				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&smbclk>;
-				clock-names = "refclk", "timclk", "apb_pclk";
-				#clock-cells = <1>;
-				clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
-				assigned-clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&v2m_sysctl 3>, <&v2m_sysctl 3>;
-				assigned-clock-parents = <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>, <&v2m_refclk1mhz>;
-			};
+				/* PCI-E I2C bus */
+				v2m_i2c_pcie: i2c at 2000 {
+					compatible = "arm,versatile-i2c";
+					reg = <0x02000 0x1000>;
 
-			/* PCI-E I2C bus */
-			v2m_i2c_pcie: i2c at 2000 {
-				compatible = "arm,versatile-i2c";
-				reg = <0x02000 0x1000>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
+					pcie-switch at 60 {
+						compatible = "idt,89hpes32h8";
+						reg = <0x60>;
+					};
+				};
 
-				pcie-switch at 60 {
-					compatible = "idt,89hpes32h8";
-					reg = <0x60>;
+				aaci at 4000 {
+					compatible = "arm,pl041", "arm,primecell";
+					reg = <0x04000 0x1000>;
+					interrupts = <11>;
+					clocks = <&smbclk>;
+					clock-names = "apb_pclk";
 				};
-			};
 
-			aaci at 4000 {
-				compatible = "arm,pl041", "arm,primecell";
-				reg = <0x04000 0x1000>;
-				interrupts = <11>;
-				clocks = <&smbclk>;
-				clock-names = "apb_pclk";
-			};
+				mmci at 5000 {
+					compatible = "arm,pl180", "arm,primecell";
+					reg = <0x05000 0x1000>;
+					interrupts = <9 10>;
+					cd-gpios = <&v2m_mmc_gpios 0 0>;
+					wp-gpios = <&v2m_mmc_gpios 1 0>;
+					max-frequency = <12000000>;
+					vmmc-supply = <&v2m_fixed_3v3>;
+					clocks = <&v2m_clk24mhz>, <&smbclk>;
+					clock-names = "mclk", "apb_pclk";
+				};
 
-			mmci at 5000 {
-				compatible = "arm,pl180", "arm,primecell";
-				reg = <0x05000 0x1000>;
-				interrupts = <9 10>;
-				cd-gpios = <&v2m_mmc_gpios 0 0>;
-				wp-gpios = <&v2m_mmc_gpios 1 0>;
-				max-frequency = <12000000>;
-				vmmc-supply = <&v2m_fixed_3v3>;
-				clocks = <&v2m_clk24mhz>, <&smbclk>;
-				clock-names = "mclk", "apb_pclk";
-			};
+				kmi at 6000 {
+					compatible = "arm,pl050", "arm,primecell";
+					reg = <0x06000 0x1000>;
+					interrupts = <12>;
+					clocks = <&v2m_clk24mhz>, <&smbclk>;
+					clock-names = "KMIREFCLK", "apb_pclk";
+				};
 
-			kmi at 6000 {
-				compatible = "arm,pl050", "arm,primecell";
-				reg = <0x06000 0x1000>;
-				interrupts = <12>;
-				clocks = <&v2m_clk24mhz>, <&smbclk>;
-				clock-names = "KMIREFCLK", "apb_pclk";
-			};
+				kmi at 7000 {
+					compatible = "arm,pl050", "arm,primecell";
+					reg = <0x07000 0x1000>;
+					interrupts = <13>;
+					clocks = <&v2m_clk24mhz>, <&smbclk>;
+					clock-names = "KMIREFCLK", "apb_pclk";
+				};
 
-			kmi at 7000 {
-				compatible = "arm,pl050", "arm,primecell";
-				reg = <0x07000 0x1000>;
-				interrupts = <13>;
-				clocks = <&v2m_clk24mhz>, <&smbclk>;
-				clock-names = "KMIREFCLK", "apb_pclk";
-			};
+				v2m_serial0: uart at 9000 {
+					compatible = "arm,pl011", "arm,primecell";
+					reg = <0x09000 0x1000>;
+					interrupts = <5>;
+					clocks = <&v2m_oscclk2>, <&smbclk>;
+					clock-names = "uartclk", "apb_pclk";
+				};
 
-			v2m_serial0: uart at 9000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x09000 0x1000>;
-				interrupts = <5>;
-				clocks = <&v2m_oscclk2>, <&smbclk>;
-				clock-names = "uartclk", "apb_pclk";
-			};
+				v2m_serial1: uart at a000 {
+					compatible = "arm,pl011", "arm,primecell";
+					reg = <0x0a000 0x1000>;
+					interrupts = <6>;
+					clocks = <&v2m_oscclk2>, <&smbclk>;
+					clock-names = "uartclk", "apb_pclk";
+				};
 
-			v2m_serial1: uart at a000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x0a000 0x1000>;
-				interrupts = <6>;
-				clocks = <&v2m_oscclk2>, <&smbclk>;
-				clock-names = "uartclk", "apb_pclk";
-			};
+				v2m_serial2: uart at b000 {
+					compatible = "arm,pl011", "arm,primecell";
+					reg = <0x0b000 0x1000>;
+					interrupts = <7>;
+					clocks = <&v2m_oscclk2>, <&smbclk>;
+					clock-names = "uartclk", "apb_pclk";
+				};
 
-			v2m_serial2: uart at b000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x0b000 0x1000>;
-				interrupts = <7>;
-				clocks = <&v2m_oscclk2>, <&smbclk>;
-				clock-names = "uartclk", "apb_pclk";
-			};
+				v2m_serial3: uart at c000 {
+					compatible = "arm,pl011", "arm,primecell";
+					reg = <0x0c000 0x1000>;
+					interrupts = <8>;
+					clocks = <&v2m_oscclk2>, <&smbclk>;
+					clock-names = "uartclk", "apb_pclk";
+				};
 
-			v2m_serial3: uart at c000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x0c000 0x1000>;
-				interrupts = <8>;
-				clocks = <&v2m_oscclk2>, <&smbclk>;
-				clock-names = "uartclk", "apb_pclk";
-			};
+				wdt at f000 {
+					compatible = "arm,sp805", "arm,primecell";
+					reg = <0x0f000 0x1000>;
+					interrupts = <0>;
+					clocks = <&v2m_refclk32khz>, <&smbclk>;
+					clock-names = "wdogclk", "apb_pclk";
+				};
 
-			wdt at f000 {
-				compatible = "arm,sp805", "arm,primecell";
-				reg = <0x0f000 0x1000>;
-				interrupts = <0>;
-				clocks = <&v2m_refclk32khz>, <&smbclk>;
-				clock-names = "wdogclk", "apb_pclk";
-			};
+				v2m_timer01: timer at 11000 {
+					compatible = "arm,sp804", "arm,primecell";
+					reg = <0x11000 0x1000>;
+					interrupts = <2>;
+					clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
+					clock-names = "timclken1", "timclken2", "apb_pclk";
+				};
 
-			v2m_timer01: timer at 11000 {
-				compatible = "arm,sp804", "arm,primecell";
-				reg = <0x11000 0x1000>;
-				interrupts = <2>;
-				clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
-				clock-names = "timclken1", "timclken2", "apb_pclk";
-			};
+				v2m_timer23: timer at 12000 {
+					compatible = "arm,sp804", "arm,primecell";
+					reg = <0x12000 0x1000>;
+					interrupts = <3>;
+					clocks = <&v2m_sysctl 2>, <&v2m_sysctl 3>, <&smbclk>;
+					clock-names = "timclken1", "timclken2", "apb_pclk";
+				};
 
-			v2m_timer23: timer at 12000 {
-				compatible = "arm,sp804", "arm,primecell";
-				reg = <0x12000 0x1000>;
-				interrupts = <3>;
-				clocks = <&v2m_sysctl 2>, <&v2m_sysctl 3>, <&smbclk>;
-				clock-names = "timclken1", "timclken2", "apb_pclk";
-			};
+				/* DVI I2C bus */
+				v2m_i2c_dvi: i2c at 16000 {
+					compatible = "arm,versatile-i2c";
+					reg = <0x16000 0x1000>;
 
-			/* DVI I2C bus */
-			v2m_i2c_dvi: i2c at 16000 {
-				compatible = "arm,versatile-i2c";
-				reg = <0x16000 0x1000>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
+					dvi-transmitter at 39 {
+						compatible = "sil,sii9022-tpi", "sil,sii9022";
+						reg = <0x39>;
+					};
 
-				dvi-transmitter at 39 {
-					compatible = "sil,sii9022-tpi", "sil,sii9022";
-					reg = <0x39>;
+					dvi-transmitter at 60 {
+						compatible = "sil,sii9022-cpi", "sil,sii9022";
+						reg = <0x60>;
+					};
 				};
 
-				dvi-transmitter at 60 {
-					compatible = "sil,sii9022-cpi", "sil,sii9022";
-					reg = <0x60>;
+				rtc at 17000 {
+					compatible = "arm,pl031", "arm,primecell";
+					reg = <0x17000 0x1000>;
+					interrupts = <4>;
+					clocks = <&smbclk>;
+					clock-names = "apb_pclk";
 				};
-			};
-
-			rtc at 17000 {
-				compatible = "arm,pl031", "arm,primecell";
-				reg = <0x17000 0x1000>;
-				interrupts = <4>;
-				clocks = <&smbclk>;
-				clock-names = "apb_pclk";
-			};
 
-			compact-flash at 1a000 {
-				compatible = "arm,vexpress-cf", "ata-generic";
-				reg = <0x1a000 0x100
-				       0x1a100 0xf00>;
-				reg-shift = <2>;
-			};
-
-			clcd at 1f000 {
-				compatible = "arm,pl111", "arm,primecell";
-				reg = <0x1f000 0x1000>;
-				interrupt-names = "combined";
-				interrupts = <14>;
-				clocks = <&v2m_oscclk1>, <&smbclk>;
-				clock-names = "clcdclk", "apb_pclk";
-				memory-region = <&v2m_video_ram>;
-				max-memory-bandwidth = <50350000>; /* 16bpp @ 25.175MHz */
-
-				port {
-					v2m_clcd_pads: endpoint {
-						remote-endpoint = <&v2m_clcd_panel>;
-						arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
-					};
+				compact-flash at 1a000 {
+					compatible = "arm,vexpress-cf", "ata-generic";
+					reg = <0x1a000 0x100
+					       0x1a100 0xf00>;
+					reg-shift = <2>;
 				};
 
-				panel {
-					compatible = "panel-dpi";
+				clcd at 1f000 {
+					compatible = "arm,pl111", "arm,primecell";
+					reg = <0x1f000 0x1000>;
+					interrupt-names = "combined";
+					interrupts = <14>;
+					clocks = <&v2m_oscclk1>, <&smbclk>;
+					clock-names = "clcdclk", "apb_pclk";
+					memory-region = <&v2m_video_ram>;
+					max-memory-bandwidth = <50350000>; /* 16bpp @ 25.175MHz */
 
 					port {
-						v2m_clcd_panel: endpoint {
-							remote-endpoint = <&v2m_clcd_pads>;
+						v2m_clcd_pads: endpoint {
+							remote-endpoint = <&v2m_clcd_panel>;
+							arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
 						};
 					};
 
-					panel-timing {
-						clock-frequency = <25175000>;
-						hactive = <640>;
-						hback-porch = <40>;
-						hfront-porch = <24>;
-						hsync-len = <96>;
-						vactive = <480>;
-						vback-porch = <32>;
-						vfront-porch = <11>;
-						vsync-len = <2>;
+					panel {
+						compatible = "panel-dpi";
+
+						port {
+							v2m_clcd_panel: endpoint {
+								remote-endpoint = <&v2m_clcd_pads>;
+							};
+						};
+
+						panel-timing {
+							clock-frequency = <25175000>;
+							hactive = <640>;
+							hback-porch = <40>;
+							hfront-porch = <24>;
+							hsync-len = <96>;
+							vactive = <480>;
+							vback-porch = <32>;
+							vfront-porch = <11>;
+							vsync-len = <2>;
+						};
 					};
 				};
 			};
-		};
 
-		v2m_fixed_3v3: fixed-regulator-0 {
-			compatible = "regulator-fixed";
-			regulator-name = "3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+			v2m_fixed_3v3: fixed-regulator-0 {
+				compatible = "regulator-fixed";
+				regulator-name = "3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
 
-		v2m_clk24mhz: clk24mhz {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <24000000>;
-			clock-output-names = "v2m:clk24mhz";
-		};
+			v2m_clk24mhz: clk24mhz {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <24000000>;
+				clock-output-names = "v2m:clk24mhz";
+			};
 
-		v2m_refclk1mhz: refclk1mhz {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <1000000>;
-			clock-output-names = "v2m:refclk1mhz";
-		};
+			v2m_refclk1mhz: refclk1mhz {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <1000000>;
+				clock-output-names = "v2m:refclk1mhz";
+			};
 
-		v2m_refclk32khz: refclk32khz {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "v2m:refclk32khz";
-		};
+			v2m_refclk32khz: refclk32khz {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <32768>;
+				clock-output-names = "v2m:refclk32khz";
+			};
 
-		leds {
-			compatible = "gpio-leds";
+			leds {
+				compatible = "gpio-leds";
 
-			user1 {
-				label = "v2m:green:user1";
-				gpios = <&v2m_led_gpios 0 0>;
-				linux,default-trigger = "heartbeat";
-			};
+				user1 {
+					label = "v2m:green:user1";
+					gpios = <&v2m_led_gpios 0 0>;
+					linux,default-trigger = "heartbeat";
+				};
 
-			user2 {
-				label = "v2m:green:user2";
-				gpios = <&v2m_led_gpios 1 0>;
-				linux,default-trigger = "mmc0";
-			};
+				user2 {
+					label = "v2m:green:user2";
+					gpios = <&v2m_led_gpios 1 0>;
+					linux,default-trigger = "mmc0";
+				};
 
-			user3 {
-				label = "v2m:green:user3";
-				gpios = <&v2m_led_gpios 2 0>;
-				linux,default-trigger = "cpu0";
-			};
+				user3 {
+					label = "v2m:green:user3";
+					gpios = <&v2m_led_gpios 2 0>;
+					linux,default-trigger = "cpu0";
+				};
 
-			user4 {
-				label = "v2m:green:user4";
-				gpios = <&v2m_led_gpios 3 0>;
-				linux,default-trigger = "cpu1";
-			};
+				user4 {
+					label = "v2m:green:user4";
+					gpios = <&v2m_led_gpios 3 0>;
+					linux,default-trigger = "cpu1";
+				};
 
-			user5 {
-				label = "v2m:green:user5";
-				gpios = <&v2m_led_gpios 4 0>;
-				linux,default-trigger = "cpu2";
-			};
+				user5 {
+					label = "v2m:green:user5";
+					gpios = <&v2m_led_gpios 4 0>;
+					linux,default-trigger = "cpu2";
+				};
 
-			user6 {
-				label = "v2m:green:user6";
-				gpios = <&v2m_led_gpios 5 0>;
-				linux,default-trigger = "cpu3";
-			};
+				user6 {
+					label = "v2m:green:user6";
+					gpios = <&v2m_led_gpios 5 0>;
+					linux,default-trigger = "cpu3";
+				};
 
-			user7 {
-				label = "v2m:green:user7";
-				gpios = <&v2m_led_gpios 6 0>;
-				linux,default-trigger = "cpu4";
-			};
+				user7 {
+					label = "v2m:green:user7";
+					gpios = <&v2m_led_gpios 6 0>;
+					linux,default-trigger = "cpu4";
+				};
 
-			user8 {
-				label = "v2m:green:user8";
-				gpios = <&v2m_led_gpios 7 0>;
-				linux,default-trigger = "cpu5";
+				user8 {
+					label = "v2m:green:user8";
+					gpios = <&v2m_led_gpios 7 0>;
+					linux,default-trigger = "cpu5";
+				};
 			};
-		};
 
-		mcc {
-			compatible = "arm,vexpress,config-bus";
-			arm,vexpress,config-bridge = <&v2m_sysreg>;
+			mcc {
+				compatible = "arm,vexpress,config-bus";
+				arm,vexpress,config-bridge = <&v2m_sysreg>;
 
-			oscclk0 {
-				/* MCC static memory clock */
-				compatible = "arm,vexpress-osc";
-				arm,vexpress-sysreg,func = <1 0>;
-				freq-range = <25000000 60000000>;
-				#clock-cells = <0>;
-				clock-output-names = "v2m:oscclk0";
-			};
+				oscclk0 {
+					/* MCC static memory clock */
+					compatible = "arm,vexpress-osc";
+					arm,vexpress-sysreg,func = <1 0>;
+					freq-range = <25000000 60000000>;
+					#clock-cells = <0>;
+					clock-output-names = "v2m:oscclk0";
+				};
 
-			v2m_oscclk1: oscclk1 {
-				/* CLCD clock */
-				compatible = "arm,vexpress-osc";
-				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 65000000>;
-				#clock-cells = <0>;
-				clock-output-names = "v2m:oscclk1";
-			};
+				v2m_oscclk1: oscclk1 {
+					/* CLCD clock */
+					compatible = "arm,vexpress-osc";
+					arm,vexpress-sysreg,func = <1 1>;
+					freq-range = <23750000 65000000>;
+					#clock-cells = <0>;
+					clock-output-names = "v2m:oscclk1";
+				};
 
-			v2m_oscclk2: oscclk2 {
-				/* IO FPGA peripheral clock */
-				compatible = "arm,vexpress-osc";
-				arm,vexpress-sysreg,func = <1 2>;
-				freq-range = <24000000 24000000>;
-				#clock-cells = <0>;
-				clock-output-names = "v2m:oscclk2";
-			};
+				v2m_oscclk2: oscclk2 {
+					/* IO FPGA peripheral clock */
+					compatible = "arm,vexpress-osc";
+					arm,vexpress-sysreg,func = <1 2>;
+					freq-range = <24000000 24000000>;
+					#clock-cells = <0>;
+					clock-output-names = "v2m:oscclk2";
+				};
 
-			volt-vio {
-				/* Logic level voltage */
-				compatible = "arm,vexpress-volt";
-				arm,vexpress-sysreg,func = <2 0>;
-				regulator-name = "VIO";
-				regulator-always-on;
-				label = "VIO";
-			};
+				volt-vio {
+					/* Logic level voltage */
+					compatible = "arm,vexpress-volt";
+					arm,vexpress-sysreg,func = <2 0>;
+					regulator-name = "VIO";
+					regulator-always-on;
+					label = "VIO";
+				};
 
-			temp-mcc {
-				/* MCC internal operating temperature */
-				compatible = "arm,vexpress-temp";
-				arm,vexpress-sysreg,func = <4 0>;
-				label = "MCC";
-			};
+				temp-mcc {
+					/* MCC internal operating temperature */
+					compatible = "arm,vexpress-temp";
+					arm,vexpress-sysreg,func = <4 0>;
+					label = "MCC";
+				};
 
-			reset {
-				compatible = "arm,vexpress-reset";
-				arm,vexpress-sysreg,func = <5 0>;
-			};
+				reset {
+					compatible = "arm,vexpress-reset";
+					arm,vexpress-sysreg,func = <5 0>;
+				};
 
-			muxfpga {
-				compatible = "arm,vexpress-muxfpga";
-				arm,vexpress-sysreg,func = <7 0>;
-			};
+				muxfpga {
+					compatible = "arm,vexpress-muxfpga";
+					arm,vexpress-sysreg,func = <7 0>;
+				};
 
-			shutdown {
-				compatible = "arm,vexpress-shutdown";
-				arm,vexpress-sysreg,func = <8 0>;
-			};
+				shutdown {
+					compatible = "arm,vexpress-shutdown";
+					arm,vexpress-sysreg,func = <8 0>;
+				};
 
-			reboot {
-				compatible = "arm,vexpress-reboot";
-				arm,vexpress-sysreg,func = <9 0>;
-			};
+				reboot {
+					compatible = "arm,vexpress-reboot";
+					arm,vexpress-sysreg,func = <9 0>;
+				};
 
-			dvimode {
-				compatible = "arm,vexpress-dvimode";
-				arm,vexpress-sysreg,func = <11 0>;
+				dvimode {
+					compatible = "arm,vexpress-dvimode";
+					arm,vexpress-sysreg,func = <11 0>;
+				};
 			};
 		};
 	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index a8ac4e2ed290..3971427a105b 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include "vexpress-v2m-rs1.dtsi"
 
 / {
 	model = "V2P-CA15";
@@ -278,8 +279,6 @@
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
-
-		/include/ "vexpress-v2m-rs1.dtsi"
 	};
 
 	site2: hsb at 40000000 {
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index a4c7713edfcd..65a874ea66be 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include "vexpress-v2m-rs1.dtsi"
 
 / {
 	model = "V2P-CA15_CA7";
@@ -584,7 +585,7 @@
 		};
 	};
 
-	smb at 8000000 {
+	smb: smb at 8000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
@@ -641,8 +642,6 @@
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
-
-		/include/ "vexpress-v2m-rs1.dtsi"
 	};
 
 	site2: hsb at 40000000 {
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index 32f1906ffecf..e5b4a7570a01 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include "vexpress-v2m-rs1.dtsi"
 
 / {
 	model = "V2P-CA5s";
@@ -191,7 +192,7 @@
 		};
 	};
 
-	smb at 8000000 {
+	smb: smb at 8000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
@@ -248,8 +249,6 @@
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
-
-		/include/ "vexpress-v2m-rs1.dtsi"
 	};
 
 	site2: hsb at 40000000 {
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 56308c1c0208..7ec3dac1f61d 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include "vexpress-v2m.dtsi"
 
 / {
 	model = "V2P-CA9";
@@ -301,7 +302,7 @@
 		};
 	};
 
-	smb at 4000000 {
+	smb: smb at 4000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
@@ -357,8 +358,6 @@
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
-
-		/include/ "vexpress-v2m.dtsi"
 	};
 
 	site2: hsb at e0000000 {
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index 1c9eadc2d71e..38880380e0fa 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -13,6 +13,7 @@
 /dts-v1/;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "vexpress-v2m-rs1.dtsi"
 
 / {
 	model = "V2F-1XV7 Cortex-A53x2 SMM";
@@ -129,7 +130,7 @@
 		};
 	};
 
-	smb at 8000000 {
+	smb: smb at 8000000 {
 		compatible = "simple-bus";
 
 		#address-cells = <2>;
@@ -186,7 +187,5 @@
 				<0 0 40 &gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				<0 0 41 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
 				<0 0 42 &gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-
-		/include/ "vexpress-v2m-rs1.dtsi"
 	};
 };
-- 
2.17.0
