From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 21 Jun 2011 11:07:13 +0900
Subject: [PATCH v2 4/4] Exynos4 NURI: support for NTC thermistor
In-Reply-To: <1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
References: <20110620103124.GD31864@opensource.wolfsonmicro.com>
	<1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1308622033-2521-5-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 arch/arm/mach-exynos4/mach-nuri.c |   46 +++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 51f55b4..dc6fc36 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -16,6 +16,7 @@
 #include <linux/i2c-gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/ntc_thermistor.h>
 #include <linux/power/max17042_battery.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
@@ -1006,6 +1007,50 @@ static void __init nuri_ehci_init(void)
 	s5p_ehci_set_platdata(pdata);
 }
 
+/* NTC Thermistor */
+static struct platform_device nuri_ncp15wb473_thermistor;
+static int read_thermistor_uV(void)
+{
+	static struct s3c_adc_client *adc;
+	int val;
+	s64 converted;
+
+	if (!adc) {
+		adc = s3c_adc_register(&nuri_ncp15wb473_thermistor,
+				NULL, NULL, 0);
+		if (IS_ERR_OR_NULL(adc)) {
+			pr_err("%s: Cannot get adc.\n", __func__);
+			return adc ? PTR_ERR(adc) : -ENODEV;
+		}
+	}
+
+	if (IS_ERR_OR_NULL(adc))
+		return adc ? PTR_ERR(adc) : -ENODEV;
+
+	val = s3c_adc_read(adc, 6);
+
+	converted = 3300000LL * (s64) val;
+	converted >>= 12;
+
+	pr_emerg("%s: %d -> %llduV\n", __func__, val, converted);
+	return converted;
+}
+
+static struct ntc_thermistor_platform_data ncp15wb473_pdata = {
+	.read_uV	= read_thermistor_uV,
+	.pullup_uV	= 3300000, /* VADC_3.3V_C210 */
+	.pullup_ohm	= 100000, /* R613 in SLP 7 0105 */
+	.pulldown_ohm	= 100000, /* R615 in SLP 7 0105 */
+	.connect	= NTC_CONNECTED_GROUND,
+};
+
+static struct platform_device nuri_ncp15wb473_thermistor = {
+	.name			= "ncp15wb473",
+	.dev			= {
+		.platform_data = &ncp15wb473_pdata,
+	},
+};
+
 static struct platform_device *nuri_devices[] __initdata = {
 	/* Samsung Platform Devices */
 	&emmc_fixed_voltage,
@@ -1024,6 +1069,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&nuri_gpio_keys,
 	&nuri_lcd_device,
 	&nuri_backlight_device,
+	&nuri_ncp15wb473_thermistor,
 };
 
 static void __init nuri_map_io(void)
-- 
1.7.4.1
