From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 30 Mar 2015 13:39:30 +0300
Subject: [PATCH 2/3] ARM: pxa: poodle: add gpio-keys configuration
In-Reply-To: <1427711971-8164-1-git-send-email-dbaryshkov@gmail.com>
References: <1427711971-8164-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1427711971-8164-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support setting wakeup sources through the two gpio keys - On button and
'Sync' key present on cradle.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/poodle.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 4dd29a7..596e756 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -35,6 +35,8 @@
 #include <linux/memblock.h>
 #include <linux/iio/machine.h>
 #include <linux/mfd/locomo.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -161,6 +163,38 @@ static struct scoop_pcmcia_config poodle_pcmcia_config = {
 
 EXPORT_SYMBOL(poodle_scoop_device);
 
+static struct gpio_keys_button poodle_gpio_keys[] = {
+	{
+		.type	= EV_PWR,
+		.code	= KEY_RESERVED,
+		.gpio	= POODLE_GPIO_ON_KEY,
+		.desc	= "On key",
+		.wakeup	= 1,
+		.active_low = 1,
+	},
+	{
+		.type	= EV_PWR,
+		.code	= KEY_WAKEUP,
+		.gpio	= POODLE_GPIO_WAKEUP,
+		.desc	= "Sync",
+		.wakeup = 1,
+		.active_low = 1,
+	},
+};
+
+static struct gpio_keys_platform_data poodle_gpio_keys_data = {
+	.buttons	= poodle_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(poodle_gpio_keys),
+};
+
+static struct platform_device poodle_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &poodle_gpio_keys_data,
+	},
+};
+
 
 static struct platform_device poodle_audio_device = {
 	.name	= "poodle-audio",
@@ -436,6 +470,7 @@ static struct platform_device *devices[] __initdata = {
 	&poodle_locomo_device,
 	&poodle_scoop_device,
 	&poodle_audio_device,
+	&poodle_gpio_keys_device,
 	&sharpsl_nand_device,
 	&sharpsl_rom_device,
 	&poodle_power_device,
-- 
2.1.4
