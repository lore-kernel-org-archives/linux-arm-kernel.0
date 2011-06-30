From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 17:26:25 +0900
Subject: [PATCH 1/3] Samsung SoC: NTC Thermistor attached to S3C-ADC.
In-Reply-To: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309422387-11546-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309422387-11546-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows platform configurations to share information about
the NTC thermistor device attached to ADC port of S3C.

A platform configuration is required to initialize the ADC port for NTC
thermistor by calling "s3c_adc_ntc_init(portnum);" before registering
the NTC thermistor device. Then, registering a platform device,
s3c_device_adc_ntc_thermistor, enables NTC thermistor for the
platform.

The platform data is configured for Exynos4-Nuri, S5PC110-Aquila, and
S5PC110-Goni. However, if a board happens to have different platform
data setting, we will need to provide different platform data either
by providing a function to update the platform data or by providing
another platform data entry.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/dev-adc.c           |   57 +++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h |    1 +
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-adc.c b/arch/arm/plat-samsung/dev-adc.c
index 9d903d4..622972c 100644
--- a/arch/arm/plat-samsung/dev-adc.c
+++ b/arch/arm/plat-samsung/dev-adc.c
@@ -9,9 +9,11 @@
  * published by the Free Software Foundation.
 */
 
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/ntc_thermistor.h>
 
 #include <mach/irqs.h>
 #include <mach/map.h>
@@ -44,3 +46,58 @@ struct platform_device s3c_device_adc = {
 	.num_resources	= ARRAY_SIZE(s3c_adc_resource),
 	.resource	= s3c_adc_resource,
 };
+
+/* NTC Thermistor. Attached to S3C-ADC in some Samsung SoC Devices */
+struct platform_device s3c_device_adc_ntc_thermistor;
+static int ntc_adc_num = -EINVAL; /* Uninitialized */
+static struct s3c_adc_client *ntc_adc;
+
+int __init s3c_adc_ntc_init(int port)
+{
+	int err = 0;
+
+	if (port < 0 || port > 9)
+		return -EINVAL;
+	ntc_adc_num = port;
+
+	ntc_adc = s3c_adc_register(&s3c_device_adc_ntc_thermistor, NULL, NULL,
+				   0);
+	if (IS_ERR(ntc_adc)) {
+		err = PTR_ERR(ntc_adc);
+		ntc_adc = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+static int read_thermistor_uV(void)
+{
+	int val;
+	s64 converted;
+
+	WARN(ntc_adc == NULL || ntc_adc_num < 0,
+	     "S3C NTC-ADC is not initialized for %s.\n", __func__);
+
+	val = s3c_adc_read(ntc_adc, ntc_adc_num);
+
+	converted = 3300000LL * (s64) val;
+	converted >>= 12;
+
+	return converted;
+}
+
+static struct ntc_thermistor_platform_data ntc_adc_pdata = {
+	.read_uV	= read_thermistor_uV,
+	.pullup_uV	= 3300000, /* voltage of vdd for ADC */
+	.pullup_ohm	= 100000,
+	.pulldown_ohm	= 100000,
+	.connect	= NTC_CONNECTED_GROUND,
+};
+
+struct platform_device s3c_device_adc_ntc_thermistor = {
+	.name			= "ncp15wb473",
+	.dev			= {
+		.platform_data = &ntc_adc_pdata,
+	},
+};
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 3c87779..f83b1da 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -61,6 +61,7 @@ extern struct platform_device s3c_device_i2c6;
 extern struct platform_device s3c_device_i2c7;
 extern struct platform_device s3c_device_rtc;
 extern struct platform_device s3c_device_adc;
+extern struct platform_device s3c_device_adc_ntc_thermistor;
 extern struct platform_device s3c_device_sdi;
 extern struct platform_device s3c_device_iis;
 extern struct platform_device s3c_device_hwmon;
-- 
1.7.4.1
