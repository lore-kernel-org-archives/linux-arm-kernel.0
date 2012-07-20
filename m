From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 20 Jul 2012 16:17:45 +0900
Subject: [PATCH V2 3/7] ARM: EXYNOS5: add machine specific support for LCD
In-Reply-To: <CAL1wa8c1Ty2xz7qsTWixTqvmHc1LC+nEahd7wUgQEHWUPHY9UQ@mail.gmail.com>
References: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
 <1342591053-7092-4-git-send-email-l.krishna@samsung.com>
 <009b01cd64b1$0019eb20$004dc160$%szyprowski@samsung.com>
 <CAL1wa8c1Ty2xz7qsTWixTqvmHc1LC+nEahd7wUgQEHWUPHY9UQ@mail.gmail.com>
Message-ID: <50090619.4080301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2012 10:21 PM, Leela Krishna Amudala wrote:
> Hello Marek,
>
> On Wed, Jul 18, 2012 at 12:15 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hello,
>>
>> On Wednesday, July 18, 2012 7:57 AM Leela Krishna Amudala wrote:
>>
>>> This patch adds machine specific support for LCD controller like setting power to LCD
>>> and adding LCD platform device.
>>>
>>> Signed-off-by: Prathyush K <prathyush.k@samsung.com>
>>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>>> ---
>>>   arch/arm/mach-exynos/mach-exynos5-dt.c |   56 ++++++++++++++++++++++++++++++++
>>>   1 files changed, 56 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
>>> index e7113cc..02a0e68 100644
>>> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
>>> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
>>> @@ -13,6 +13,7 @@
>>>   #include <linux/serial_core.h>
>>>   #include <linux/pwm_backlight.h>
>>>   #include <linux/gpio.h>
>>> +#include <linux/delay.h>
>>>
>>>   #include <asm/mach/arch.h>
>>>   #include <asm/hardware/gic.h>
>>> @@ -24,6 +25,7 @@
>>>   #include <plat/gpio-cfg.h>
>>>
>>>   #include "common.h"
>>> +#include <video/platform_lcd.h>
>>>
>>>   static int smdk5250_bl_notify(struct device *unused, int brightness)
>>>   {
>>> @@ -47,6 +49,55 @@ static struct platform_pwm_backlight_data smdk5250_bl_data = {
>>>        .notify         = smdk5250_bl_notify,
>>>   };
>>>
>>> +static void lcd_set_power(struct plat_lcd_data *pd,
>>> +                     unsigned int power)
>>> +{
>>> +
>>> +     /* reset */
>>> +     gpio_request_one(EXYNOS5_GPX1(5), GPIOF_OUT_INIT_HIGH, "GPX1");
>>> +
>>> +     mdelay(20);
>>> +     if (power) {
>>> +             /* fire nRESET on power up */
>>> +             gpio_set_value(EXYNOS5_GPX1(5), 0);
>>> +             mdelay(20);
>>> +             gpio_set_value(EXYNOS5_GPX1(5), 1);
>>> +             mdelay(20);
>>> +             gpio_free(EXYNOS5_GPX1(5));
>>> +     } else {
>>> +             /* fire nRESET on power off */
>>> +             gpio_set_value(EXYNOS5_GPX1(5), 0);
>>> +             mdelay(20);
>>> +             gpio_set_value(EXYNOS5_GPX1(5), 1);
>>> +             mdelay(20);
>>> +             gpio_free(EXYNOS5_GPX1(5));
>>> +     }
>>> +     mdelay(20);
>>> +
>>> +     /*
>>> +      * Request lcd_bl_en GPIO for smdk5250_bl_notify().
>>> +      * TODO: Fix this so we are not at risk of requesting the GPIO
>>> +      * multiple times, this should be done with device tree, and
>>> +      * likely integrated into the plat-samsung/dev-backlight.c init.
>>> +      */
>>> +     gpio_request_one(EXYNOS5_GPX3(0), GPIOF_OUT_INIT_LOW, "GPX3");
>>> +}
>>> +
>>> +static int smdk5250_match_fb(struct plat_lcd_data *pd, struct fb_info *info)
>>> +{
>>> +     /* Don't call .set_power callback while unblanking */
>>> +     return 0;
>>> +}
>>> +
>>> +static struct plat_lcd_data smdk5250_lcd_data = {
>>> +     .set_power      = lcd_set_power,
>>> +     .match_fb       = smdk5250_match_fb,
>>> +};
>>> +
>>> +static struct platform_device smdk5250_lcd = {
>>> +     .name                   = "platform-lcd",
>>> +     .dev.platform_data      = &smdk5250_lcd_data,
>>> +};
>>>   /*
>>>    * The following lookup table is used to override device names when devices
>>>    * are registered from device tree. This is temporarily added to enable
>>> @@ -85,6 +136,10 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst
>>> = {
>>>        {},
>>>   };
>>>
>>> +static struct platform_device *smdk5250_devices[] __initdata = {
>>> +     &smdk5250_lcd, /* for platform_lcd device */
>>> +};
>>> +
>>>   static void __init exynos5250_dt_map_io(void)
>>>   {
>>>        exynos_init_io(NULL, 0);
>>> @@ -96,6 +151,7 @@ static void __init exynos5250_dt_machine_init(void)
>>>        samsung_bl_set(&smdk5250_bl_gpio_info, &smdk5250_bl_data);
>>>        of_platform_populate(NULL, of_default_bus_match_table,
>>>                                exynos5250_auxdata_lookup, NULL);
>>> +     platform_add_devices(smdk5250_devices, ARRAY_SIZE(smdk5250_devices));
>>>   }
>>>
>>>   static char const *exynos5250_dt_compat[] __initdata = {
>> Sorry, but this patch looks completely weird to me. exynos5-dt machine is aimed to
>> operate on ANY Exynos5 based board with proper device tree bindings, not only SMDK5250.
>> Please add DT support to platform lcd driver and create required bindings for it
>> instead of hardcoding the platform data and gpio numbers in mach-exynos5-dt.c
>>
> Yes true, that GPIO numbers will vary for boards.
> Can you please confirm that platform lcd driver means the core
> "drivers/video/backlight/platform_lcd.c" file.
> But platform lcd driver is used by other(non samsung) platforms also.
> So, If I add the DT suppot to that file, I have to test the changes on
> other platforms also.
> Can you please kindly suggest me some other way to overcome this situation.

These are smdk5250 specific codes to support NON DT device and driver.
Please see arch/arm/mach-kirkwood/board-dnskw.c, you can refer it to
support NON DT devices and drivers.

Thanks.
