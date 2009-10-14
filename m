From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 14 Oct 2009 09:20:22 +0200
Subject: [PATCH 05/10] [ARM] pxa/cm-x300: add support for PXA310 cpu
In-Reply-To: <cover.1255504387.git.mike@compulab.co.il>
References: <cover.1255504387.git.mike@compulab.co.il>
Message-ID: <e35b39c32b99771de29056bae6b7ac73a6e17e9f.1255504387.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Grinberg <grinberg@compulab.co.il>

CM-X300 can be assembled with PXA300 and PXA310 CPU. Provide support for
both CPU variants.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/Kconfig   |    1 +
 arch/arm/mach-pxa/cm-x300.c |   42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index a6f8eab..75e321b 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -329,6 +329,7 @@ config MACH_CM_X300
 	bool "CompuLab CM-X300 modules"
 	select PXA3xx
 	select CPU_PXA300
+	select CPU_PXA310
 
 config MACH_H4700
 	bool "HP iPAQ hx4700"
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index f721931..890c9d4 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -59,7 +59,7 @@
 #define GPIO97_RTC_RD		(97)
 #define GPIO98_RTC_IO		(98)
 
-static mfp_cfg_t cm_x300_mfp_cfg[] __initdata = {
+static mfp_cfg_t cm_x3xx_mfp_cfg[] __initdata = {
 	/* LCD */
 	GPIO54_LCD_LDD_0,
 	GPIO55_LCD_LDD_1,
@@ -158,20 +158,47 @@ static mfp_cfg_t cm_x300_mfp_cfg[] __initdata = {
 	GPIO22_I2C_SDA,
 };
 
-static mfp_cfg_t cm_x300_rev_lt130_mfp_cfg[] __initdata = {
+static mfp_cfg_t cm_x3xx_rev_lt130_mfp_cfg[] __initdata = {
 	/* GPIOs */
 	GPIO79_GPIO,			/* LED */
 	GPIO77_GPIO,			/* WiFi reset */
 	GPIO78_GPIO,			/* BT reset */
 };
 
-static mfp_cfg_t cm_x300_rev_ge130_mfp_cfg[] __initdata = {
+static mfp_cfg_t cm_x3xx_rev_ge130_mfp_cfg[] __initdata = {
 	/* GPIOs */
 	GPIO76_GPIO,			/* LED */
 	GPIO71_GPIO,			/* WiFi reset */
 	GPIO70_GPIO,			/* BT reset */
 };
 
+static mfp_cfg_t cm_x310_mfp_cfg[] __initdata = {
+	/* USB PORT 2 */
+	ULPI_STP,
+	ULPI_NXT,
+	ULPI_DIR,
+	GPIO30_ULPI_DATA_OUT_0,
+	GPIO31_ULPI_DATA_OUT_1,
+	GPIO32_ULPI_DATA_OUT_2,
+	GPIO33_ULPI_DATA_OUT_3,
+	GPIO34_ULPI_DATA_OUT_4,
+	GPIO35_ULPI_DATA_OUT_5,
+	GPIO36_ULPI_DATA_OUT_6,
+	GPIO37_ULPI_DATA_OUT_7,
+	GPIO38_ULPI_CLK,
+	/* external PHY reset pin */
+	GPIO127_GPIO,
+
+	/* USB PORT 3 */
+	GPIO77_USB_P3_1,
+	GPIO78_USB_P3_2,
+	GPIO79_USB_P3_3,
+	GPIO80_USB_P3_4,
+	GPIO81_USB_P3_5,
+	GPIO82_USB_P3_6,
+	GPIO0_2_USBH_PEN,
+};
+
 #if defined(CONFIG_DM9000) || defined(CONFIG_DM9000_MODULE)
 static struct resource dm9000_resources[] = {
 	[0] = {
@@ -553,12 +580,15 @@ static void __init cm_x300_init_wi2wi(void)
 static void __init cm_x300_init_mfp(void)
 {
 	/* board-processor specific GPIO initialization */
-	pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x300_mfp_cfg));
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x3xx_mfp_cfg));
 
 	if (system_rev < 130)
-		pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x300_rev_lt130_mfp_cfg));
+		pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x3xx_rev_lt130_mfp_cfg));
 	else
-		pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x300_rev_ge130_mfp_cfg));
+		pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x3xx_rev_ge130_mfp_cfg));
+
+	if (cpu_is_pxa310())
+		pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x310_mfp_cfg));
 }
 
 static void __init cm_x300_init(void)
-- 
1.6.0.6
