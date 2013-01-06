From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun,  6 Jan 2013 18:48:01 +0200
Subject: [PATCH v2] ARM: PXA27x: fix workaround for AC97 reset
In-Reply-To: <87fw2ebe1i.fsf@free.fr>
References: <87fw2ebe1i.fsf@free.fr>
Message-ID: <1357490881-19015-1-git-send-email-grinberg@compulab.co.il>
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
(AF1 - for GPIO95 and AF2 - for GPIO113) in case of reset deassert.

Reported-by: Mike Dunn <mikedunn@newsguy.com>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Cc: Mike Dunn <mikedunn@newsguy.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: stable at vger.kernel.org
---
v2:	Do not change the GPDR to input on reset deassert, as AC97
	controller will not drive it (thanks Robert).
	Also, this time really send to Mike.

Mike, Robert, can you test this one on boards with GPIO113 and GPIO95?
Thanks!

 arch/arm/mach-pxa/devices.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index daa86d3..03db2ce 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -5,6 +5,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/gpio.h>
 
 #include <mach/udc.h>
 #include <linux/platform_data/usb-pxa3xx-ulpi.h>
@@ -488,7 +489,18 @@ struct platform_device pxa_device_ac97 = {
 
 void __init pxa_set_ac97_info(pxa2xx_audio_ops_t *ops)
 {
-	pxa_register_device(&pxa_device_ac97, ops);
+	int err = 0;
+
+	if (ops && gpio_is_valid(ops->reset_gpio)) {
+		err = gpio_request_one(ops->reset_gpio, GPIOF_INIT_HIGH,
+				       "ac97 rst");
+		if (err)
+			pr_err("%s: Failed requesting GPIO%d (ac97 rst): %d",
+			       __func__, ops->reset_gpio, err);
+	}
+
+	if (!err)
+		pxa_register_device(&pxa_device_ac97, ops);
 }
 
 #ifdef CONFIG_PXA25x
-- 
1.7.3.4
