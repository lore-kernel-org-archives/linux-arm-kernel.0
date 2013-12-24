From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:04:59 +0900
Subject: [PATCH 1/3] ARM: shmobile: armadillo: Add PWM backlight power supply
In-Reply-To: <cover.1387856124.git.horms+renesas@verge.net.au>
References: <cover.1387856124.git.horms+renesas@verge.net.au>
Message-ID: <9fb444f22f09cfad3798e3610f7dc62f8a385ee8.1387856124.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Commit 22ceeee16eb8f0d04de3ef43a5174fb30ec18af9 ("pwm-backlight: Add
power supply support") added a mandatory power supply for the PWM
backlight. Add a fixed 5V regulator to board code with a consumer supply
entry for the backlight device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit ad11cb9a5cf96346f1240995c672cdbb5501785c)
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 958e3cb..c186891 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -614,6 +614,11 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
 	REGULATOR_SUPPLY("vqmmc", "sh_mmcif"),
 };
 
+/* Fixed 3.3V regulator used by LCD backlight */
+static struct regulator_consumer_supply fixed5v0_power_consumers[] = {
+	REGULATOR_SUPPLY("power", "pwm-backlight.0"),
+};
+
 /* Fixed 3.3V regulator to be used by SDHI0 */
 static struct regulator_consumer_supply vcc_sdhi0_consumers[] = {
 	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
@@ -1196,6 +1201,8 @@ static void __init eva_init(void)
 
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+	regulator_register_always_on(3, "fixed-5.0V", fixed5v0_power_consumers,
+				     ARRAY_SIZE(fixed5v0_power_consumers), 5000000);
 
 	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
 	pwm_add_table(pwm_lookup, ARRAY_SIZE(pwm_lookup));
-- 
1.8.4
