From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 22 Feb 2017 15:13:25 +0100
Subject: [PATCH v3 6/6] ARM: davinci: add enable GPIOs for vpif capture to
 pdata-quirks
In-Reply-To: <1487772805-19021-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487772805-19021-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487772805-19021-7-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the da850-evm board we need to select the UI expander video capture
function to make vpif capture work. Add the relevant GPIOs to the
pdata-quirks.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/pdata-quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index e2160ce..b60f422 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -9,6 +9,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/gpio/machine.h>
 
 #include <media/i2c/tvp514x.h>
 #include <media/i2c/adv7343.h>
@@ -120,6 +121,20 @@ static void __init da850_vpif_capture_legacy_init(void)
 			__func__, ret);
 }
 
+static struct gpiod_lookup_table vpif_capture_enable_gpios = {
+	.dev_id = "vpif_capture",
+	.table = {
+		GPIO_LOOKUP_IDX("tca6416", 7, "enable", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("tca6416", 6, "enable", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("tca6416", 5, "enable", 2, GPIO_ACTIVE_LOW),
+	},
+};
+
+static void __init da850_vpif_capture_gpio_sel_init(void)
+{
+	gpiod_add_lookup_table(&vpif_capture_enable_gpios);
+}
+
 static struct adv7343_platform_data adv7343_pdata = {
 	.mode_config = {
 		.dac = { 1, 1, 1 },
@@ -199,6 +214,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,da850-lcdk", da850_vpif_capture_legacy_init, },
 	{ "ti,da850-evm", da850_vpif_display_legacy_init, },
 	{ "ti,da850-evm", da850_vpif_capture_legacy_init, },
+	{ "ti,da850-evm", da850_vpif_capture_gpio_sel_init, },
 	{ /* sentinel */ },
 };
 
-- 
2.9.3
