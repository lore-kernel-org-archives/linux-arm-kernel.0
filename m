From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Mon, 31 Oct 2011 17:14:28 +0100
Subject: [PATCH] i2c-gpio.c: correct logic of pdata->scl_is_open_drain
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B34BE51@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If pdata->scl_is_open_drain was set, the driver used push-pull output
for SCL, not open-drain output.

Signed-off-by: Nikolaus Voss <n.voss@weinmann.de>
---
 drivers/i2c/busses/i2c-gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index a651779..b161335 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -104,7 +104,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_request_scl;
 
-	if (pdata->sda_is_open_drain) {
+	if (!pdata->sda_is_open_drain) {
 		gpio_direction_output(pdata->sda_pin, 1);
 		bit_data->setsda = i2c_gpio_setsda_val;
 	} else {
@@ -112,7 +112,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 		bit_data->setsda = i2c_gpio_setsda_dir;
 	}
 
-	if (pdata->scl_is_open_drain || pdata->scl_is_output_only) {
+	if (!pdata->scl_is_open_drain || pdata->scl_is_output_only) {
 		gpio_direction_output(pdata->scl_pin, 1);
 		bit_data->setscl = i2c_gpio_setscl_val;
 	} else {
-- 
1.7.4.1
