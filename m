From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 05 Dec 2011 14:22:28 +0530
Subject: [PATCH 2/2] arm: exynos: allow platform-lcd driver to control lcd
 regulator source on origen
Message-ID: <1323075148-29356-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The buck7 regulator of max8997 pmic which provides the power source to lcd panel
and the lvds transmitter is allowed to be controlled by the platform-lcd driver.
It is not required to apply the voltage source by default. Also, the voltage
range for buck7 regulator is modified as the per the values in the datasheet.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mach-origen.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index f56d027..5456254 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -126,7 +126,7 @@ static struct regulator_consumer_supply __initdata buck3_consumer[] = {
 	REGULATOR_SUPPLY("vdd_g3d", "mali_drm"), /* G3D */
 };
 static struct regulator_consumer_supply __initdata buck7_consumer[] = {
-	REGULATOR_SUPPLY("vcc", "platform-lcd"), /* LCD */
+	REGULATOR_SUPPLY("vcc_lcd", "platform-lcd.0"), /* LCD */
 };
 
 static struct regulator_init_data __initdata max8997_ldo1_data = {
@@ -379,11 +379,11 @@ static struct regulator_init_data __initdata max8997_buck5_data = {
 static struct regulator_init_data __initdata max8997_buck7_data = {
 	.constraints	= {
 		.name		= "VDD_LCD_3.3V",
-		.min_uV		= 3300000,
-		.max_uV		= 3300000,
+		.min_uV		= 750000,
+		.max_uV		= 3900000,
 		.boot_on	= 1,
-		.apply_uV	= 1,
-		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS |
+					REGULATOR_CHANGE_VOLTAGE,
 		.state_mem	= {
 			.disabled	= 1
 		},
@@ -562,6 +562,8 @@ static void lcd_hv070wsa_set_power(struct plat_lcd_data *pd, unsigned int power)
 
 static struct plat_lcd_data origen_lcd_hv070wsa_data = {
 	.set_power = lcd_hv070wsa_set_power,
+	.min_uV		= 3300000,
+	.max_uV		= 3300000,
 };
 
 static struct platform_device origen_lcd_hv070wsa = {
-- 
1.6.6.rc2
