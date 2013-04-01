From: achew@nvidia.com (Andrew Chew)
Date: Mon, 1 Apr 2013 14:53:20 -0700
Subject: [PATCH V6 1/9] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
In-Reply-To: <1364853208-32503-1-git-send-email-achew@nvidia.com>
References: <1364853208-32503-1-git-send-email-achew@nvidia.com>
Message-ID: <1364853208-32503-2-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/mach-omap2/board-4430sdp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 35f3ad0..9b03bbd 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -291,6 +291,10 @@ static struct platform_device sdp4430_leds_pwm = {
 	},
 };
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight");
+
 static struct platform_pwm_backlight_data sdp4430_backlight_data = {
 	.max_brightness = 127,
 	.dft_brightness = 127,
@@ -718,6 +722,8 @@ static void __init omap_4430sdp_init(void)
 
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-- 
1.8.1.5
