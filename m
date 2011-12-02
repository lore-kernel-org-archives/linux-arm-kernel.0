From: dh09.lee@samsung.com (leedonghwa)
Date: Fri, 02 Dec 2011 16:45:50 +0900
Subject: backlight/ld9040.c: regulator control in the lcd driver
Message-ID: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports regulator power control in the driver.

Current ld9040 driver was controlled power on/off sequence by callback
function

in the board file. But, by doing this, there's no need to register lcd power

on/off callback function in the board file.

 

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Signed-off-by: Inki Dae <inki.dae@samsung.com>

---

 drivers/video/backlight/ld9040.c |   88
++++++++++++++++++++++++++++++++-----

 1 files changed, 76 insertions(+), 12 deletions(-)

 

diff --git a/drivers/video/backlight/ld9040.c
b/drivers/video/backlight/ld9040.c

index da9a5ce..9698f48 100644

--- a/drivers/video/backlight/ld9040.c

+++ b/drivers/video/backlight/ld9040.c

@@ -31,6 +31,7 @@

 #include <linux/lcd.h>

 #include <linux/backlight.h>

 #include <linux/module.h>

+#include <linux/regulator/consumer.h>

 

 #include "ld9040_gamma.h"

 

@@ -53,8 +54,60 @@ struct ld9040 {

          struct lcd_device            *ld;

          struct backlight_device               *bd;

          struct lcd_platform_data  *lcd_pd;

+

+         struct mutex                           lock;

+         struct regulator             *reg_vdd3;

+         struct regulator             *reg_vci;

+         bool  enabled;

 };

 

+static void ld9040_regulator_enable(struct ld9040 *lcd)

+{

+         int ret = 0;

+         struct lcd_platform_data *pd = NULL;

+

+         pd = lcd->lcd_pd;

+         mutex_lock(&lcd->lock);

+         if (!lcd->enabled) {

+                   if (lcd->reg_vdd3)

+                              ret = regulator_enable(lcd->reg_vdd3);

+                   if (ret)

+                              goto out;

+

+                   if (lcd->reg_vci)

+                              ret = regulator_enable(lcd->reg_vci);

+                   if (ret)

+                              goto out;

+

+                   lcd->enabled = true;

+         }

+         mdelay(pd->power_on_delay);

+out:

+         mutex_unlock(&lcd->lock);

+}

+

+static void ld9040_regulator_disable(struct ld9040 *lcd)

+{

+         int ret = 0;

+

+         mutex_lock(&lcd->lock);

+         if (lcd->enabled) {

+                   if (lcd->reg_vci)

+                              regulator_disable(lcd->reg_vci);

+                   if (ret)

+                              goto out;

+

+                   if (lcd->reg_vdd3)

+                              regulator_disable(lcd->reg_vdd3);

+                   if (ret)

+                              goto out;

+

+                   lcd->enabled = false;

+         }

+out:

+         mutex_unlock(&lcd->lock);

+}

+

 static const unsigned short seq_swreset[] = {

          0x01, COMMAND_ONLY,

          ENDDEF, 0x00

@@ -532,13 +585,8 @@ static int ld9040_power_on(struct ld9040 *lcd)

                     return -EFAULT;

          }

 

-          if (!pd->power_on) {

-                    dev_err(lcd->dev, "power_on is NULL.\n");

-                    return -EFAULT;

-          } else {

-                    pd->power_on(lcd->ld, 1);

-                    mdelay(pd->power_on_delay);

-          }

+         /* lcd power on */

+         ld9040_regulator_enable(lcd);

 

          if (!pd->reset) {

                     dev_err(lcd->dev, "reset is NULL.\n");

@@ -582,11 +630,8 @@ static int ld9040_power_off(struct ld9040 *lcd)

 

          mdelay(pd->power_off_delay);

 

-          if (!pd->power_on) {

-                    dev_err(lcd->dev, "power_on is NULL.\n");

-                    return -EFAULT;

-          } else

-                    pd->power_on(lcd->ld, 0);

+         /* lcd power off */

+         ld9040_regulator_disable(lcd);

 

          return 0;

 }

@@ -693,6 +738,20 @@ static int ld9040_probe(struct spi_device *spi)

                     goto out_free_lcd;

          }

 

+         mutex_init(&lcd->lock);

+

+         lcd->reg_vdd3 = regulator_get(lcd->dev, "vdd");

+         if (IS_ERR(lcd->reg_vdd3)) {

+                   dev_info(lcd->dev, "no %s regulator found\n", "vdd");

+                   lcd->reg_vdd3 = NULL;

+         }

+

+         lcd->reg_vci = regulator_get(lcd->dev, "vci");

+         if (IS_ERR(lcd->reg_vci)) {

+                   dev_info(lcd->dev, "no %s regulator found\n", "vci");

+                   lcd->reg_vci = NULL;

+         }

+

          ld = lcd_device_register("ld9040", &spi->dev, lcd,
&ld9040_lcd_ops);

          if (IS_ERR(ld)) {

                     ret = PTR_ERR(ld);

@@ -739,6 +798,9 @@ static int ld9040_probe(struct spi_device *spi)

 out_unregister_lcd:

          lcd_device_unregister(lcd->ld);

 out_free_lcd:

+         regulator_put(lcd->reg_vci);

+         regulator_put(lcd->reg_vdd3);

+

          kfree(lcd);

          return ret;

 }

@@ -750,6 +812,8 @@ static int __devexit ld9040_remove(struct spi_device
*spi)

          ld9040_power(lcd, FB_BLANK_POWERDOWN);

          backlight_device_unregister(lcd->bd);

          lcd_device_unregister(lcd->ld);

+         regulator_put(lcd->reg_vci);

+         regulator_put(lcd->reg_vdd3);

          kfree(lcd);

 

          return 0;

-- 

1.7.4.1

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111202/5e869ca5/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-backlight-ld9040.c-regulator-control-in-the-driver.patch
Type: application/octet-stream
Size: 4063 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111202/5e869ca5/attachment-0001.obj>
