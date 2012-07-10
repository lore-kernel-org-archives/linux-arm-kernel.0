From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 10 Jul 2012 10:08:08 +0300
Subject: [PATCH 2/6] ARM: apx4devkit: add display support
In-Reply-To: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <1341904092-13777-3-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HannStar display and device tree configuration.

Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
---
 arch/arm/boot/dts/apx4devkit.dts |   21 +++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c     |   24 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/apx4devkit.dts b/arch/arm/boot/dts/apx4devkit.dts
index ecad288..6217297 100644
--- a/arch/arm/boot/dts/apx4devkit.dts
+++ b/arch/arm/boot/dts/apx4devkit.dts
@@ -35,11 +35,32 @@
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 */
+						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				lcdif_pins_apx4: lcdif-apx4 at 0 {
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
+				pinctrl-0 = <&lcdif_24bit_pins_a
+					     &lcdif_pins_apx4>;
+				status = "okay";
 			};
 		};
 
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index b3239e2..4ea78e6 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -80,6 +80,25 @@ static struct fb_videomode m28evk_video_modes[] = {
 	},
 };
 
+static struct fb_videomode apx4devkit_video_modes[] = {
+	{
+		.name		= "HannStar PJ70112A",
+		.refresh	= 60,
+		.xres		= 800,
+		.yres		= 480,
+		.pixclock	= 33333, /* picosecond (30.00 MHz) */
+		.left_margin	= 88,
+		.right_margin	= 40,
+		.upper_margin	= 32,
+		.lower_margin	= 13,
+		.hsync_len	= 48,
+		.vsync_len	= 3,
+		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT |
+				  FB_SYNC_DATA_ENABLE_HIGH_ACT |
+				  FB_SYNC_DOTCLK_FAILING_ACT,
+	},
+};
+
 static struct mxsfb_platform_data mxsfb_pdata __initdata;
 
 static struct of_dev_auxdata mxs_auxdata_lookup[] __initdata = {
@@ -250,6 +269,11 @@ static void __init apx4devkit_init(void)
 	if (IS_BUILTIN(CONFIG_PHYLIB))
 		phy_register_fixup_for_uid(PHY_ID_KS8051, MICREL_PHY_ID_MASK,
 					   apx4devkit_phy_fixup);
+
+	mxsfb_pdata.mode_list = apx4devkit_video_modes;
+	mxsfb_pdata.mode_count = ARRAY_SIZE(apx4devkit_video_modes);
+	mxsfb_pdata.default_bpp = 32;
+	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
 }
 
 static void __init mxs_machine_init(void)
-- 
1.7.9.5
