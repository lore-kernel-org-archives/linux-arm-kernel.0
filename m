From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Jun 2015 19:51:33 +0100
Subject: [PATCH v5 02/17] leds: port locomo leds driver to new locomo core
In-Reply-To: <5576CF9A.4010701@samsung.com>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-3-git-send-email-dbaryshkov@gmail.com>
 <20150609065730.GC2982@x1>
 <CALT56yMkpXqurNw9xQeEBTdH5UTsrmSHTx1jbWXTb8zSWwDD6Q@mail.gmail.com>
 <20150609111130.GT2982@x1> <5576CF9A.4010701@samsung.com>
Message-ID: <20150609185133.GU2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Jun 2015, Jacek Anaszewski wrote:

> On 06/09/2015 01:11 PM, Lee Jones wrote:
> >On Tue, 09 Jun 2015, Dmitry Eremin-Solenikov wrote:
> >
> >>2015-06-09 9:57 GMT+03:00 Lee Jones <lee.jones@linaro.org>:
> >>>On Mon, 08 Jun 2015, Dmitry Eremin-Solenikov wrote:
> >>>
> >>>>Adapt locomo leds driver to new locomo core setup.
> >>>>
> >>>>Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >>>>Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> >>>
> >>>This is missing Bryan's Ack.
> >>
> >>Jacek is listed as a co-maintainer of the LEDS subsystem, so I assumed
> >>that his acked-by is enough.
> >
> >Ah, this is new.
> >
> >Congratulations Jacek.
> 
> Thanks.
> 
> >Ignore me then.
> 
> I think that it should go via mfd tree, as this patch adds
> dependency on header linux/mfd/locomo.h, which is added
> in one of the preceding patches [1] in this series.

Yep, that's the plan.

> [1] [PATCH v3 01/17] mfd: add new driver for Sharp LoCoMo
> 
> >>>>---
> >>>>  drivers/leds/Kconfig       |   2 +-
> >>>>  drivers/leds/leds-locomo.c | 117 +++++++++++++++++++++++----------------------
> >>>>  2 files changed, 61 insertions(+), 58 deletions(-)
> >>>>
> >>>>diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> >>>>index 966b960..d086aac 100644
> >>>>--- a/drivers/leds/Kconfig
> >>>>+++ b/drivers/leds/Kconfig
> >>>>@@ -79,7 +79,7 @@ config LEDS_LM3642
> >>>>  config LEDS_LOCOMO
> >>>>       tristate "LED Support for Locomo device"
> >>>>       depends on LEDS_CLASS
> >>>>-     depends on SHARP_LOCOMO
> >>>>+     depends on MFD_LOCOMO
> >>>>       help
> >>>>         This option enables support for the LEDs on Sharp Locomo.
> >>>>         Zaurus models SL-5500 and SL-5600.
> >>>>diff --git a/drivers/leds/leds-locomo.c b/drivers/leds/leds-locomo.c
> >>>>index 80ba048..a4286e9 100644
> >>>>--- a/drivers/leds/leds-locomo.c
> >>>>+++ b/drivers/leds/leds-locomo.c
> >>>>@@ -9,89 +9,92 @@
> >>>>   */
> >>>>
> >>>>  #include <linux/kernel.h>
> >>>>-#include <linux/init.h>
> >>>>-#include <linux/module.h>
> >>>>-#include <linux/device.h>
> >>>>  #include <linux/leds.h>
> >>>>+#include <linux/mfd/locomo.h>
> >>>>+#include <linux/module.h>
> >>>>+#include <linux/platform_device.h>
> >>>>+#include <linux/regmap.h>
> >>>>
> >>>>-#include <mach/hardware.h>
> >>>>-#include <asm/hardware/locomo.h>
> >>>>+struct locomo_led {
> >>>>+     struct led_classdev led;
> >>>>+     struct regmap *regmap;
> >>>>+     unsigned int reg;
> >>>>+};
> >>>>
> >>>>  static void locomoled_brightness_set(struct led_classdev *led_cdev,
> >>>>-                             enum led_brightness value, int offset)
> >>>>-{
> >>>>-     struct locomo_dev *locomo_dev = LOCOMO_DEV(led_cdev->dev->parent);
> >>>>-     unsigned long flags;
> >>>>-
> >>>>-     local_irq_save(flags);
> >>>>-     if (value)
> >>>>-             locomo_writel(LOCOMO_LPT_TOFH, locomo_dev->mapbase + offset);
> >>>>-     else
> >>>>-             locomo_writel(LOCOMO_LPT_TOFL, locomo_dev->mapbase + offset);
> >>>>-     local_irq_restore(flags);
> >>>>-}
> >>>>-
> >>>>-static void locomoled_brightness_set0(struct led_classdev *led_cdev,
> >>>>                               enum led_brightness value)
> >>>>  {
> >>>>-     locomoled_brightness_set(led_cdev, value, LOCOMO_LPT0);
> >>>>+     struct locomo_led *led = container_of(led_cdev, struct locomo_led, led);
> >>>>+
> >>>>+     regmap_write(led->regmap, led->reg,
> >>>>+                     value ? LOCOMO_LPT_TOFH : LOCOMO_LPT_TOFL);
> >>>>  }
> >>>>
> >>>>-static void locomoled_brightness_set1(struct led_classdev *led_cdev,
> >>>>-                             enum led_brightness value)
> >>>>+static int locomo_led_register(
> >>>>+             struct device *dev,
> >>>>+             struct locomo_led *led,
> >>>>+             const char *name,
> >>>>+             const char *trigger,
> >>>>+             struct regmap *regmap,
> >>>>+             unsigned int reg)
> >>>>  {
> >>>>-     locomoled_brightness_set(led_cdev, value, LOCOMO_LPT1);
> >>>>+     led->led.name = name;
> >>>>+     led->led.flags = LED_CORE_SUSPENDRESUME;
> >>>>+     led->led.default_trigger = trigger;
> >>>>+     led->led.brightness_set = locomoled_brightness_set;
> >>>>+     led->regmap = regmap;
> >>>>+     led->reg = reg;
> >>>>+
> >>>>+     return devm_led_classdev_register(dev, &led->led);
> >>>>  }
> >>>>
> >>>>-static struct led_classdev locomo_led0 = {
> >>>>-     .name                   = "locomo:amber:charge",
> >>>>-     .default_trigger        = "main-battery-charging",
> >>>>-     .brightness_set         = locomoled_brightness_set0,
> >>>>-};
> >>>>-
> >>>>-static struct led_classdev locomo_led1 = {
> >>>>-     .name                   = "locomo:green:mail",
> >>>>-     .default_trigger        = "nand-disk",
> >>>>-     .brightness_set         = locomoled_brightness_set1,
> >>>>-};
> >>>>-
> >>>>-static int locomoled_probe(struct locomo_dev *ldev)
> >>>>+static int locomoled_probe(struct platform_device *pdev)
> >>>>  {
> >>>>       int ret;
> >>>>-
> >>>>-     ret = led_classdev_register(&ldev->dev, &locomo_led0);
> >>>>+     struct locomo_led *leds;
> >>>>+     struct regmap *regmap;
> >>>>+
> >>>>+     leds = devm_kzalloc(&pdev->dev, 2 * sizeof(*leds), GFP_KERNEL);
> >>>>+     if (!leds)
> >>>>+             return -ENOMEM;
> >>>>+
> >>>>+     regmap = dev_get_regmap(pdev->dev.parent, NULL);
> >>>>+     if (!regmap)
> >>>>+             return -ENODEV;
> >>>>+
> >>>>+     ret = locomo_led_register(
> >>>>+                     &pdev->dev,
> >>>>+                     leds,
> >>>>+                     "locomo:amber:charge",
> >>>>+                     "main-battery-charging",
> >>>>+                     regmap,
> >>>>+                     LOCOMO_LPT0);
> >>>>       if (ret < 0)
> >>>>               return ret;
> >>>>
> >>>>-     ret = led_classdev_register(&ldev->dev, &locomo_led1);
> >>>>+     ret = locomo_led_register(
> >>>>+                     &pdev->dev,
> >>>>+                     leds + 1,
> >>>>+                     "locomo:green:mail",
> >>>>+                     "mmc0",
> >>>>+                     regmap,
> >>>>+                     LOCOMO_LPT1);
> >>>>       if (ret < 0)
> >>>>-             led_classdev_unregister(&locomo_led0);
> >>>>-
> >>>>-     return ret;
> >>>>-}
> >>>>+             return ret;
> >>>>
> >>>>-static int locomoled_remove(struct locomo_dev *dev)
> >>>>-{
> >>>>-     led_classdev_unregister(&locomo_led0);
> >>>>-     led_classdev_unregister(&locomo_led1);
> >>>>       return 0;
> >>>>  }
> >>>>
> >>>>-static struct locomo_driver locomoled_driver = {
> >>>>-     .drv = {
> >>>>-             .name = "locomoled"
> >>>>+static struct platform_driver locomoled_driver = {
> >>>>+     .driver = {
> >>>>+             .name = "locomo-led"
> >>>>       },
> >>>>-     .devid  = LOCOMO_DEVID_LED,
> >>>>       .probe  = locomoled_probe,
> >>>>-     .remove = locomoled_remove,
> >>>>  };
> >>>>
> >>>>-static int __init locomoled_init(void)
> >>>>-{
> >>>>-     return locomo_driver_register(&locomoled_driver);
> >>>>-}
> >>>>-module_init(locomoled_init);
> >>>>+module_platform_driver(locomoled_driver);
> >>>>
> >>>>  MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
> >>>>  MODULE_DESCRIPTION("Locomo LED driver");
> >>>>  MODULE_LICENSE("GPL");
> >>>>+MODULE_ALIAS("platform:locomo-led");
> >>>
> >>
> >>
> >>
> >
> 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
