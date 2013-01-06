From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun,  6 Jan 2013 13:12:41 +0200
Subject: [PATCH] ARM: PXA27x: fix workaround for AC97 reset
Message-ID: <1357470761-14363-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the workaround to a hardware bug in the AC97 controller of PXA27x.
A bug in the controller's warm reset functionality requires that the MFP
used by the controller as the AC97_RESET_n line be temporarily
reconfigured as a GPIO (AF0) and manually held high for the duration of
the warm reset cycle.

The workaround was broken long ago by commit fb1bf8cd
([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset()).
The commit above changed the original workaround code in a way that
changed the MFP to AF0 (GPIO), but forgot to drive the GPIO high output.
This way, the GPIO state was left input (and undriven) and only worked
for boards with external pullup on the line.

Fix the above breakage by actually configurring the GPIO for output high
in case of reset assert and returning it to default state
(AF2 and GPDR - input) in case of reset deassert.

Reported-by: Mike Dunn <mikedunn@newsguy.com>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: stable at vger.kernel.org
---
Mike, this should work and without the GPIO not requested warning.
Can you test this, please?

 arch/arm/mach-pxa/devices.c |   13 ++++++++++++-
 arch/arm/mach-pxa/pxa27x.c  |    5 +++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index daa86d3..eaa7282 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -5,6 +5,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/gpio.h>
 
 #include <mach/udc.h>
 #include <linux/platform_data/usb-pxa3xx-ulpi.h>
@@ -488,7 +489,17 @@ struct platform_device pxa_device_ac97 = {
 
 void __init pxa_set_ac97_info(pxa2xx_audio_ops_t *ops)
 {
-	pxa_register_device(&pxa_device_ac97, ops);
+	int err = 0;
+
+	if (ops && gpio_is_valid(ops->reset_gpio)) {
+		err = gpio_request_one(ops->reset_gpio, GPIOF_IN, "ac97 rst");
+		if (err)
+			pr_err("%s: Failed requesting GPIO%d (ac97 rst): %d",
+			       __func__, ops->reset_gpio, err);
+	}
+
+	if (!err)
+		pxa_register_device(&pxa_device_ac97, ops);
 }
 
 #ifdef CONFIG_PXA25x
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 8047ee0..bb7e7c3 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -62,6 +62,11 @@ void pxa27x_assert_ac97reset(int reset_gpio, int on)
 	if (reset_gpio == 95)
 		pxa2xx_mfp_config(on ? &ac97_reset_config[2] :
 				       &ac97_reset_config[3], 1);
+
+	if (on)
+		gpio_direction_output(reset_gpio, 1);
+	else	/* to be on the safe side, return the GPDR to input */
+		gpio_direction_input(reset_gpio);
 }
 EXPORT_SYMBOL_GPL(pxa27x_assert_ac97reset);
 
-- 
1.7.3.4
