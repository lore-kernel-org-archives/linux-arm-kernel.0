From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Sun, 10 Jul 2011 01:06:36 +0200
Subject: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
In-Reply-To: <1310252796-10596-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-2-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-3-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The leds and buttons subdevices cannot be used without additional
platform data.

Use the presence of the platform data to enable the device instead
of an additional flag.

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/mach-mx31moboard.c |    2 +-
 drivers/mfd/mc13xxx-core.c           |    4 ++--
 include/linux/mfd/mc13783.h          |    1 -
 include/linux/mfd/mc13xxx.h          |    2 --
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 447143b..c4cd6b8 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -279,7 +279,7 @@ static struct mc13xxx_platform_data moboard_pmic = {
 	.leds = &moboard_leds,
 	.buttons = &moboard_buttons,
 	.flags = MC13XXX_USE_REGULATOR | MC13XXX_USE_RTC |
-		MC13XXX_USE_ADC | MC13XXX_USE_LED | MC13XXX_USE_BUTTON,
+		MC13XXX_USE_ADC,
 };
 
 static struct spi_board_info moboard_spi_board_info[] __initdata = {
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 44edf78..130781f 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -774,11 +774,11 @@ err_revision:
 	if (pdata->flags & MC13XXX_USE_TOUCHSCREEN)
 		mc13xxx_add_subdevice(mc13xxx, "%s-ts");
 
-	if (pdata->flags & MC13XXX_USE_LED)
+	if (pdata->leds)
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
 				pdata->leds, sizeof(*pdata->leds));
 
-	if (pdata->flags & MC13XXX_USE_BUTTON)
+	if (pdata->buttons)
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
 				pdata->buttons, sizeof(*pdata->buttons));
 
diff --git a/include/linux/mfd/mc13783.h b/include/linux/mfd/mc13783.h
index bd4fbac..61dca4c 100644
--- a/include/linux/mfd/mc13783.h
+++ b/include/linux/mfd/mc13783.h
@@ -114,7 +114,6 @@ static inline int mc13783_irq_ack(struct mc13783 *mc13783, int irq)
 #define MC13783_USE_ADC		MC13XXX_USE_ADC
 #define MC13783_USE_RTC		MC13XXX_USE_RTC
 #define MC13783_USE_REGULATOR	MC13XXX_USE_REGULATOR
-#define MC13783_USE_LED		MC13XXX_USE_LED
 
 #define MC13783_ADC_MODE_TS		1
 #define MC13783_ADC_MODE_SINGLE_CHAN	2
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 22d8930..6c4b854 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -159,8 +159,6 @@ struct mc13xxx_platform_data {
 #define MC13XXX_USE_ADC		(1 << 2)
 #define MC13XXX_USE_RTC		(1 << 3)
 #define MC13XXX_USE_REGULATOR	(1 << 4)
-#define MC13XXX_USE_LED		(1 << 5)
-#define MC13XXX_USE_BUTTON	(1 << 6)
 	unsigned int flags;
 
 	struct mc13xxx_regulator_platform_data regulators;
-- 
1.6.3.3
