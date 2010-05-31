From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Mon, 31 May 2010 21:29:00 +0200
Subject: [PATCH 2/2] mx31moboard: Add MC13783 power button support
In-Reply-To: <1275334140-29339-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1275334140-29339-1-git-send-email-philippe.retornaz@epfl.ch>
	<1275334140-29339-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1275334140-29339-3-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the power-on button on mx31moboard using MC13783 PMIC.

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-mx3/mach-mx31moboard.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 62b5e40..7a8f078 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -31,6 +31,7 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/input.h>
 
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -262,12 +263,19 @@ static struct mc13783_leds_platform_data moboard_leds = {
 	.tc2_period = MC13783_LED_PERIOD_10MS,
 };
 
+static struct mc13783_buttons_platform_data moboard_buttons = {
+	.b1on_flags = MC13783_BUTTON_DBNC_750MS | MC13783_BUTTON_ENABLE |
+			MC13783_BUTTON_POL_INVERT | MC13783_BUTTON_EMUL_CAD,
+	.b1on_key = KEY_POWER,
+};
+
 static struct mc13783_platform_data moboard_pmic = {
 	.regulators = moboard_regulators,
 	.num_regulators = ARRAY_SIZE(moboard_regulators),
 	.leds = &moboard_leds,
+	.buttons = &moboard_buttons,
 	.flags = MC13783_USE_REGULATOR | MC13783_USE_RTC |
-		MC13783_USE_ADC | MC13783_USE_LED,
+		MC13783_USE_ADC | MC13783_USE_LED | MC13783_USE_BUTTON,
 };
 
 static struct spi_board_info moboard_spi_board_info[] __initdata = {
-- 
1.6.3.3
