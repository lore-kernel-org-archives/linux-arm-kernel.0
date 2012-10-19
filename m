From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 19 Oct 2012 14:42:09 +0800
Subject: [PATCH v2] ARM: pxa: hx4700: Fix backlight PWM device number
In-Reply-To: <20120927182951.GA4639@avionic-0098.mockup.avionic-design.de>
References: <50631868.3000205@yahoo.com>
 <20120927182951.GA4639@avionic-0098.mockup.avionic-design.de>
Message-ID: <CAN1soZyqSYPX-L22UknrfXQ20LCeBgBfaiqcTGFp1xTj+SHvvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 2:29 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Wed, Sep 26, 2012 at 03:59:52PM +0100, Paul Parsons wrote:
>> Recent changes to PXA PWM support changed the PXA27X PWM device
>> numbering scheme.
>>
>> The linux-3.5 PXA PWM driver followed the hardware numbering scheme for
>> the 4 PWMs, while the linux-3.6-rc1 PXA PWM driver has adopted a linear
>> numbering scheme:
>>
>> Address               Hardware        3.5 pwm_id      3.6-rc1 pwm_id
>> 0x40b00000    PWM0            0               0
>> 0x40b00010    PWM2            2               1
>> 0x40c00000    PWM1            1               2
>> 0x40c00010    PWM3            3               3
>>
>> The hx4700 backlight uses PWM1 at 0x40c00000. Consequently the pwm_id
>> must be changed from 1 to 2.
>>
>> This patch fixes the backlight PWM device number and at the same time
>> moves from the legacy PWM API (pwm_id) to the new PWM API (pwm_lookup).
>>
>> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
>> Cc: Thierry Reding <thierry.reding@avionic-design.de>
>> ---
>>
>> V2: Switch from legacy PWM API to new PWM API.
>>
>>  arch/arm/mach-pxa/hx4700.c |    8 +++++++-
>>  1 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
>> index e631198..d66f9f9 100644
>> --- a/arch/arm/mach-pxa/hx4700.c
>> +++ b/arch/arm/mach-pxa/hx4700.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/mfd/asic3.h>
>>  #include <linux/mtd/physmap.h>
>>  #include <linux/pda_power.h>
>> +#include <linux/pwm.h>
>>  #include <linux/pwm_backlight.h>
>>  #include <linux/regulator/driver.h>
>>  #include <linux/regulator/gpio-regulator.h>
>> @@ -556,7 +557,7 @@ static struct platform_device hx4700_lcd = {
>>   */
>>
>>  static struct platform_pwm_backlight_data backlight_data = {
>> -     .pwm_id         = 1,
>> +     .pwm_id         = -1,   /* Superseded by pwm_lookup */
>
> It doesn't actually matter what this is set to, but -1 is probably a
> good marker that the field is invalid.
>
>>       .max_brightness = 200,
>>       .dft_brightness = 100,
>>       .pwm_period_ns  = 30923,
>> @@ -571,6 +572,10 @@ static struct platform_device backlight = {
>>       },
>>  };
>>
>> +static struct pwm_lookup hx4700_pwm_lookup[] = {
>> +     PWM_LOOKUP("pxa27x-pwm.1", 0, "pwm-backlight", NULL),
>> +};
>> +
>>  /*
>>   * USB "Transceiver"
>>   */
>> @@ -872,6 +877,7 @@ static void __init hx4700_init(void)
>>       pxa_set_stuart_info(NULL);
>>
>>       platform_add_devices(devices, ARRAY_SIZE(devices));
>> +     pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
>>
>>       pxa_set_ficp_info(&ficp_info);
>>       pxa27x_set_i2c_power_info(NULL);
>
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

Paul,

I failed to apply this patch on v3.7-rc1. Could you help to format the
patch again?

Regards
Haojian
