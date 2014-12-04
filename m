From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu,  4 Dec 2014 14:10:01 +0300
Subject: [PATCH 2/3] ARM: pxa: add regulator_has_full_constraints to poodle
 board file
In-Reply-To: <1417691402-28166-1-git-send-email-dbaryshkov@gmail.com>
References: <1417691402-28166-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1417691402-28166-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add regulator_has_full_constraints() call to poodle board file to let
regulator core know that we do not have any additional regulators left.
This lets it substitute unprovided regulators with dummy ones.

This fixes the following warnings that can be seen on poodle if
regulators are enabled:

ads7846 spi1.0: unable to get regulator: -517
spi spi1.0: Driver ads7846 requests probe deferral
wm8731 0-001b: Failed to get supply 'AVDD': -517
wm8731 0-001b: Failed to request supplies: -517
wm8731 0-001b: ASoC: failed to probe component -517

Cc: stable at vger.kernel.org
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/poodle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 1319916..e81d216 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/regulator/machine.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/pxa2xx_spi.h>
@@ -455,6 +456,7 @@ static void __init poodle_init(void)
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(poodle_i2c_devices));
 	poodle_init_spi();
+	regulator_has_full_constraints();
 }
 
 static void __init fixup_poodle(struct tag *tags, char **cmdline)
-- 
2.1.3
