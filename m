From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 6 Sep 2012 16:36:08 +0530
Subject: [PATCH 1/2] i2c: s3c2410: add optional pin configuration using
 pinctrl interface
In-Reply-To: <2444562.GB3nOHUb9M@amdc1227>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
 <1346923381-14144-2-git-send-email-thomas.abraham@linaro.org>
 <2444562.GB3nOHUb9M@amdc1227>
Message-ID: <CAJuYYwQCQDTnpPR5WABtbozZOgc6_SZRBv3b6D8KY78tzMt-Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 September 2012 15:04, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi,
>
> This patch shows the problem of the need to explicitly migrate all drivers
> to pinctrl.
>
> Maybe we should consider extending the pinctrl subsystem to set the default
> state automatically before binding a driver to a device, at least in case
> of DT-based platforms?

The pinctrl driver allows for activating default pin configuration
when the pinctrl driver loads. This is referred to as "hogging". But
should hog be used or not is something that needs to be decided. Some
of the factors which favor the driver explicitly setting up the pin
configuration are

1. After a suspend and resume cycle, the pin configuration registers
may be reset to default values. Hence, during resume, the pin
configuration has be redone.

2. Runtime muxing/config is possible.

3. Setting some of the config options such as pull-up by default might
start consuming power from boot time itself, which could be avoided if
such setup is done only when needed.

Adding pinctrl driver support in device drivers seems to be simple
task. And it is just one time effort which can be reused on multiple
SoC's.

>
> This would be similar to what is done currently with samsung-gpio bindings
> - the pin is being configured by custom xlate callback based on additional
> cells in GPIO specifier, when the driver retrieves the pin using
> of_get{_named,}_gpio without the need of setting it up in the driver.

The Samsung gpio dt bindings was just a bootstrap method to get device
tree support going for Samsung platforms. The gpio xlate callback was
used as a back door to setup the pinmux/pinconfig due to lack of
generic driver interface to setup the pinmux/pinconfig for Samsung
platforms. From a linux perspective, gpio and pinmux/pinconfig are
separate entities. So using gpio xlate to setup pinmux/pinconfig was
not correct but helped getting device tree enabled for Samsung
platforms. With the pinctrl framework available now, there are generic
interfaces to setup gpio and pinmux /pinconfig.

Thanks,
Thomas.

>
> Best regards,
> --
> Tomasz Figa
> Samsung Poland R&D Center
>
> On Thursday 06 of September 2012 14:53:00 Thomas Abraham wrote:
>> Add optional support for i2c bus pin configuration using pinctrl
>> interface
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>  drivers/i2c/busses/i2c-s3c2410.c |   19 ++++++++++++++++---
>>  1 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-s3c2410.c
>> b/drivers/i2c/busses/i2c-s3c2410.c index 5ae3b02..f4b2d6f 100644
>> --- a/drivers/i2c/busses/i2c-s3c2410.c
>> +++ b/drivers/i2c/busses/i2c-s3c2410.c
>> @@ -38,6 +38,7 @@
>>  #include <linux/io.h>
>>  #include <linux/of_i2c.h>
>>  #include <linux/of_gpio.h>
>> +#include <linux/pinctrl/consumer.h>
>>
>>  #include <asm/irq.h>
>>
>> @@ -83,6 +84,8 @@ struct s3c24xx_i2c {
>>
>>       struct s3c2410_platform_i2c     *pdata;
>>       int                     gpios[2];
>> +     struct pinctrl          *pctrl;
>> +     struct pinctrl_state    *pctrl_state;
>>  #ifdef CONFIG_CPU_FREQ
>>       struct notifier_block   freq_transition;
>>  #endif
>> @@ -859,11 +862,17 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c
>> *i2c)
>>
>>       /* inititalise the gpio */
>>
>> -     if (pdata->cfg_gpio)
>> +     if (pdata->cfg_gpio) {
>>               pdata->cfg_gpio(to_platform_device(i2c->dev));
>> -     else
>> -             if (s3c24xx_i2c_parse_dt_gpio(i2c))
>> +     } else if (!IS_ERR_OR_NULL(i2c->pctrl) &&
>> +                     !IS_ERR_OR_NULL(i2c->pctrl_state)) {
>> +             if (pinctrl_select_state(i2c->pctrl, i2c->pctrl_state)) {
>> +                     dev_err(i2c->dev, "failed to configure io-pins\n");
>> +                     return -ENXIO;
>> +             }
>> +     } else if (s3c24xx_i2c_parse_dt_gpio(i2c)) {
>>                       return -EINVAL;
>> +     }
>>
>>       /* write slave address */
>>
>> @@ -1013,6 +1022,10 @@ static int s3c24xx_i2c_probe(struct
>> platform_device *pdev) i2c->adap.algo_data = i2c;
>>       i2c->adap.dev.parent = &pdev->dev;
>>
>> +     i2c->pctrl = devm_pinctrl_get(i2c->dev);
>> +     if (!IS_ERR_OR_NULL(i2c->pctrl))
>> +             i2c->pctrl_state = pinctrl_lookup_state(i2c->pctrl, "default");
>> +
>>       /* initialise the i2c controller */
>>
>>       ret = s3c24xx_i2c_init(i2c);
>
