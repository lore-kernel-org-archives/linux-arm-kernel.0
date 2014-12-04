From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu,  4 Dec 2014 14:10:00 +0300
Subject: [PATCH 1/3] ARM: pxa: add regulator_has_full_constraints to corgi
 board file
Message-ID: <1417691402-28166-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add regulator_has_full_constraints() call to corgi board file to let
regulator core know that we do not have any additional regulators left.
This lets it substitute unprovided regulators with dummy ones.

This fixes the following warnings that can be seen on corgi if
regulators are enabled:

ads7846 spi1.0: unable to get regulator: -517
spi spi1.0: Driver ads7846 requests probe deferral
wm8731 0-001b: Failed to get supply 'AVDD': -517
wm8731 0-001b: Failed to request supplies: -517
wm8731 0-001b: ASoC: failed to probe component -517
corgi-audio corgi-audio: ASoC: failed to instantiate card -517

Cc: stable at vger.kernel.org
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/corgi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 06022b2..89f790d 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -26,6 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/io.h>
+#include <linux/regulator/machine.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/corgi_lcd.h>
@@ -752,6 +753,8 @@ static void __init corgi_init(void)
 		sharpsl_nand_partitions[1].size = 53 * 1024 * 1024;
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	regulator_has_full_constraints();
 }
 
 static void __init fixup_corgi(struct tag *tags, char **cmdline)
-- 
2.1.3
