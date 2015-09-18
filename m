From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 18 Sep 2015 03:21:10 +0200
Subject: [PATCH v3 25/26] ARM: pxa: magician: Add missing regulator for PWM
 backlight
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Message-ID: <55FB6706.5030700@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a fake regulator, which is required for the correct initialization
of the PWM backlight driver.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 67969b1..c43e587 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -425,6 +425,15 @@ static struct pxafb_mach_info samsung_info = {
  * Backlight
  */
 
+ /*
+ * fixed regulator for pwm_backlight
+ */
+
+static struct regulator_consumer_supply pwm_backlight_supply[] = {
+	REGULATOR_SUPPLY("power", "pwm_backlight"),
+};
+
+
 static struct gpio magician_bl_gpios[] = {
 	{ EGPIO_MAGICIAN_BL_POWER,	GPIOF_DIR_OUT, "Backlight power" },
 	{ EGPIO_MAGICIAN_BL_POWER2,	GPIOF_DIR_OUT, "Backlight power 2" },
@@ -1125,6 +1134,9 @@ static void __init magician_init(void)
 	spi_register_board_info(ARRAY_AND_SIZE(ads7846_spi_board_info));
 
 	pxa_set_camera_info(&magician_pxacamera_pdata);
+
+	regulator_register_always_on(0, "power", pwm_backlight_supply,
+		ARRAY_SIZE(pwm_backlight_supply), 5000000);
 }
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-- 
1.7.12.1
