From: edu.molinas@gmail.com (Eduardo Molinas)
Date: Mon,  1 May 2017 18:45:58 -0400
Subject: [PATCH 1/2] [PATCH 1/2] iio: adc: sun4i-gpadc-iio: Fix module
 autoload when PLATFORM devices are registered
Message-ID: <20170501224559.21028-1-edu.molinas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the driver is built as a module, it won't be autloaded if the devices
are registered via PLATFORM code because the PLATFORM device table
entries are not exported as aliases

Before the patch:
$ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
$

After th patch:
$ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
alias:          platform:sun6i-a31-gpadc-iio
alias:          platform:sun5i-a13-gpadc-iio
alias:          platform:sun4i-a10-gpadc-iio

Signed-off-by: Eduardo Molinas <edu.molinas@gmail.com>
---
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index b23527309088..c3d7ba100a48 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -700,6 +700,7 @@ static const struct platform_device_id sun4i_gpadc_id[] = {
 	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_data },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(platform, sun4i_gpadc_id);
 
 static struct platform_driver sun4i_gpadc_driver = {
 	.driver = {
-- 
2.11.0
