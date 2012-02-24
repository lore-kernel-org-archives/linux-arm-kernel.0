From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 16:54:11 -0800
Subject: [PATCH 4/7] ARM: OMAP2+: Fix zoom LCD backlight if TWL_CORE is not
 selected
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Message-ID: <20120224005411.16794.720.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we get:

arch/arm/mach-omap2/board-zoom-display.c:64: undefined reference to `twl_i2c_read_u8'
arch/arm/mach-omap2/board-zoom-display.c:65: undefined reference to `twl_i2c_read_u8'
arch/arm/mach-omap2/board-zoom-display.c:84: undefined reference to `twl_i2c_write_u8'
arch/arm/mach-omap2/board-zoom-display.c:86: undefined reference to `twl_i2c_write_u8'
arch/arm/mach-omap2/board-zoom-display.c:91: undefined reference to `twl_i2c_write_u8'
arch/arm/mach-omap2/board-zoom-display.c:92: undefined reference to `twl_i2c_write_u8'
arch/arm/mach-omap2/board-zoom-display.c:72: undefined reference to `twl_i2c_write_u8'

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-display.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index d4683ba..7f75fcd 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -53,8 +53,11 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
 #define TWL_LED_PWMON	0x0
 #define TWL_LED_PWMOFF	0x1
 
+
 static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
 {
+
+#ifdef CONFIG_TWL4030_CORE
 	unsigned char c;
 	u8 mux_pwm, enb_pwm;
 
@@ -90,6 +93,9 @@ static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
 	c = ((50 * (100 - level)) / 100) + 1;
 	twl_i2c_write_u8(TWL4030_MODULE_PWM1, 0x7F, TWL_LED_PWMOFF);
 	twl_i2c_write_u8(TWL4030_MODULE_PWM1, c, TWL_LED_PWMON);
+#else
+	pr_warn("Backlight not enabled\n");
+#endif
 
 	return 0;
 }
