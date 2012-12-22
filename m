From: mikedunn@newsguy.com (Mike Dunn)
Date: Sat, 22 Dec 2012 10:27:40 -0800
Subject: [PATCH 2/2] ARM: pxa: palm27x: fix lcd device initialization
In-Reply-To: <1356200860-3241-1-git-send-email-mikedunn@newsguy.com>
References: <1356200860-3241-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <1356200860-3241-3-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes incorrect tests of the return codes from gpiolib functions in
palm27x_lcd_init().  Currently a return code of 0 is incorrectly interpreted as
an error.  A call to gpio_free() is also added.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 arch/arm/mach-pxa/palm27x.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 298a8a9..473c9e3 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -145,12 +145,13 @@ void __init palm27x_lcd_init(int power, struct pxafb_mode_info *mode)
 	palm27x_lcd_screen.modes = mode;
 
 	if (gpio_is_valid(power)) {
-		if (!gpio_request(power, "LCD power")) {
+		if (gpio_request(power, "LCD power") < 0) {
 			pr_err("Palm27x: failed to claim lcd power gpio!\n");
 			return;
 		}
-		if (!gpio_direction_output(power, 1)) {
+		if (gpio_direction_output(power, 1) < 0) {
 			pr_err("Palm27x: lcd power configuration failed!\n");
+			gpio_free(power);
 			return;
 		}
 		palm27x_lcd_power = power;
-- 
1.7.8.6
