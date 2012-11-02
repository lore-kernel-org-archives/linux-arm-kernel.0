From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri,  2 Nov 2012 19:01:48 +0100
Subject: [PATCH 2/2] ARM: mxs: apf28dev: Add LCD and backlight support
In-Reply-To: <1351879308-72491-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1351879308-72491-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1351879308-72491-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c         |   24 ++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 8e765ae..1643d25 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -46,6 +46,26 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				lcdif_pins_apf28dev: lcdif-apf28dev at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x1181 /* MX28_PAD_LCD_RD_E__LCD_VSYNC */
+						0x1191 /* MX28_PAD_LCD_WR_RWN__LCD_HSYNC */
+						0x11a1 /* MX28_PAD_LCD_RS__LCD_DOTCLK */
+						0x11b1 /* MX28_PAD_LCD_CS__LCD_ENABLE */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
+
+			lcdif at 80030000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&lcdif_16bit_pins_a
+						&lcdif_pins_apf28dev>;
+				status = "okay";
 			};
 		};
 
@@ -110,4 +130,12 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+
+		pwms = <&pwm 3 191000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
 };
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 48c2eba..67ef355 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -100,6 +100,25 @@ static struct fb_videomode apx4devkit_video_modes[] = {
 	},
 };
 
+static struct fb_videomode apf28dev_video_modes[] = {
+	{
+		.name = "LW700",
+		.refresh = 60,
+		.xres = 800,
+		.yres = 480,
+		.pixclock = 30303, /* picosecond */
+		.left_margin = 96,
+		.right_margin = 96, /* at least 3 & 1 */
+		.upper_margin = 0x14,
+		.lower_margin = 0x15,
+		.hsync_len = 64,
+		.vsync_len = 4,
+		.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT |
+				FB_SYNC_DATA_ENABLE_HIGH_ACT |
+				FB_SYNC_DOTCLK_FAILING_ACT,
+	},
+};
+
 static struct mxsfb_platform_data mxsfb_pdata __initdata;
 
 /*
@@ -374,6 +393,11 @@ static void __init cfa10049_init(void)
 static void __init apf28_init(void)
 {
 	enable_clk_enet_out();
+
+	mxsfb_pdata.mode_list = apf28dev_video_modes;
+	mxsfb_pdata.mode_count = ARRAY_SIZE(apf28dev_video_modes);
+	mxsfb_pdata.default_bpp = 16;
+	mxsfb_pdata.ld_intf_width = STMLCDIF_16BIT;
 }
 
 static void __init mxs_machine_init(void)
-- 
1.7.8.6
