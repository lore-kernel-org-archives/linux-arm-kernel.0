From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Mon, 17 May 2010 18:40:23 +0200
Subject: [PATCH 2/2] mx31moboard: Add MC13783 led support
In-Reply-To: <1274114423-30020-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1274114423-30020-1-git-send-email-philippe.retornaz@epfl.ch>
	<1274114423-30020-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1274114423-30020-3-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two RGB led on mx31moboard using MC13783 led subsystem

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-mx3/mach-mx31moboard.c |   45 +++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 33a8d35..62b5e40 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -220,11 +220,54 @@ static struct mc13783_regulator_init_data moboard_regulators[] = {
 	},
 };
 
+static struct mc13783_led_platform_data moboard_led[] = {
+	{
+		.id = MC13783_LED_R1,
+		.name = "coreboard-led-4:red",
+		.max_current = 2,
+	},
+	{
+		.id = MC13783_LED_G1,
+		.name = "coreboard-led-4:green",
+		.max_current = 2,
+	},
+	{
+		.id = MC13783_LED_B1,
+		.name = "coreboard-led-4:blue",
+		.max_current = 2,
+	},
+	{
+		.id = MC13783_LED_R2,
+		.name = "coreboard-led-5:red",
+		.max_current = 3,
+	},
+	{
+		.id = MC13783_LED_G2,
+		.name = "coreboard-led-5:green",
+		.max_current = 3,
+	},
+	{
+		.id = MC13783_LED_B2,
+		.name = "coreboard-led-5:blue",
+		.max_current = 3,
+	},
+};
+
+static struct mc13783_leds_platform_data moboard_leds = {
+	.num_leds = ARRAY_SIZE(moboard_led),
+	.led = moboard_led,
+	.flags = MC13783_LED_SLEWLIMTC,
+	.abmode = MC13783_LED_AB_DISABLED,
+	.tc1_period = MC13783_LED_PERIOD_10MS,
+	.tc2_period = MC13783_LED_PERIOD_10MS,
+};
+
 static struct mc13783_platform_data moboard_pmic = {
 	.regulators = moboard_regulators,
 	.num_regulators = ARRAY_SIZE(moboard_regulators),
+	.leds = &moboard_leds,
 	.flags = MC13783_USE_REGULATOR | MC13783_USE_RTC |
-		MC13783_USE_ADC,
+		MC13783_USE_ADC | MC13783_USE_LED,
 };
 
 static struct spi_board_info moboard_spi_board_info[] __initdata = {
-- 
1.6.3.3
