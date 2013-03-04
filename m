From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 4 Mar 2013 19:42:11 +0530
Subject: [PATCH] i2c: s3c24xx: allow device core to setup default pin
 configuration
In-Reply-To: <201303041503.44459.heiko@sntech.de>
References: <1362404573-30406-1-git-send-email-thomas.abraham@linaro.org>
 <201303041503.44459.heiko@sntech.de>
Message-ID: <CAJuYYwQ88Nw02kKf6oxdaDpCtFM0_9JOEECZHNJH9fB2oqwO+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2013 19:33, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Thomas,
>
> Am Montag, 4. M?rz 2013, 14:42:53 schrieb Thomas Abraham:
>> With device core now able to setup the default pin configuration,
>> the call to devm_pinctrl_get_select_default can be removed. And
>> the pin configuration code based on the deprecated Samsung specific
>> gpio bindings is also removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>
>> Hi Heiko, Tomasz,
>>
>> We have to make a choice on the path forward for pinctrl support
>> on Samsung platforms. We have three cases to deal with.
>>
>> A. Samsung platforms without DT support.
>> B. Samsung platforms with DT support using old Samsung specific
>>    gpio bindings for pin-configuration (s3c24xx and s3x64xx).
>> C. Samsung platforms with DT support using using pinctrl based
>>    pin-configurations (Exynos4 and Exynos5).
>>
>> For [A], we just let the platform specific callbacks handle the
>> pin setup. For [B] and [C], based on Linus Walleij's pin grab
>> by device core patch and subsequent discussions with him on the
>> mailing list, would it be acceptable that we discontinue support
>> for [B] in Samsung SoC device drivers. This will impact your
>> current DT work on s3c24xx and s3c64xx platforms. Pinctrl is
>> inevitable and we have to migrate to it. Instead of workarounds
>> to maintain support for [B], it might be better that we migrate
>> s3c24xx and s3c64xx platforms to pinctrl.
>>
>> Please do let us know your opinion on this.
>
> As discusses in the other thread, I'm in favor of going forward this way and
> not to invest unnecessary energy in keeping the non-pinctrl stuff alive.
>
> Pinctrl for at least the s3c2416 [0] is already on my playground-wishlist, but
> I'm still in the process of getting to know it.
>
> So for this patch:
> Acked-by: Heiko Stuebner <heiko@sntech.de>
>
>
> Heiko
>
>
> [0] in contrast to what the gpio-samsung driver implies, the s3c24xx pin banks
> are not uniform between SoCs, making this more difficult still :-)

Hi Heiko,

Thanks for the Ack. If the common samsung pinctrl support
(pinctrl-samsung.c) is not well suited for s3c24xx platforms, we could
write a separate pinctrl driver for s3c24xx platforms. But I guess we
might be able to support s3c24xx which some changes to existing code.
If there is anything that I can help with here, please do let me know.

Thanks,
Thomas.

>
>
>>  drivers/i2c/busses/i2c-s3c2410.c |   67
>> +------------------------------------- 1 files changed, 1 insertions(+),
>> 66 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-s3c2410.c
>> b/drivers/i2c/busses/i2c-s3c2410.c index f6b880b..703272c 100644
>> --- a/drivers/i2c/busses/i2c-s3c2410.c
>> +++ b/drivers/i2c/busses/i2c-s3c2410.c
>> @@ -37,8 +37,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/io.h>
>>  #include <linux/of_i2c.h>
>> -#include <linux/of_gpio.h>
>> -#include <linux/pinctrl/consumer.h>
>>
>>  #include <asm/irq.h>
>>
>> @@ -84,8 +82,6 @@ struct s3c24xx_i2c {
>>       struct i2c_adapter      adap;
>>
>>       struct s3c2410_platform_i2c     *pdata;
>> -     int                     gpios[2];
>> -     struct pinctrl          *pctrl;
>>  #ifdef CONFIG_CPU_FREQ
>>       struct notifier_block   freq_transition;
>>  #endif
>> @@ -856,57 +852,6 @@ static inline void
>> s3c24xx_i2c_deregister_cpufreq(struct s3c24xx_i2c *i2c) }
>>  #endif
>>
>> -#ifdef CONFIG_OF
>> -static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
>> -{
>> -     int idx, gpio, ret;
>> -
>> -     if (i2c->quirks & QUIRK_NO_GPIO)
>> -             return 0;
>> -
>> -     for (idx = 0; idx < 2; idx++) {
>> -             gpio = of_get_gpio(i2c->dev->of_node, idx);
>> -             if (!gpio_is_valid(gpio)) {
>> -                     dev_err(i2c->dev, "invalid gpio[%d]: %d\n", idx, gpio);
>> -                     goto free_gpio;
>> -             }
>> -             i2c->gpios[idx] = gpio;
>> -
>> -             ret = gpio_request(gpio, "i2c-bus");
>> -             if (ret) {
>> -                     dev_err(i2c->dev, "gpio [%d] request failed\n", gpio);
>> -                     goto free_gpio;
>> -             }
>> -     }
>> -     return 0;
>> -
>> -free_gpio:
>> -     while (--idx >= 0)
>> -             gpio_free(i2c->gpios[idx]);
>> -     return -EINVAL;
>> -}
>> -
>> -static void s3c24xx_i2c_dt_gpio_free(struct s3c24xx_i2c *i2c)
>> -{
>> -     unsigned int idx;
>> -
>> -     if (i2c->quirks & QUIRK_NO_GPIO)
>> -             return;
>> -
>> -     for (idx = 0; idx < 2; idx++)
>> -             gpio_free(i2c->gpios[idx]);
>> -}
>> -#else
>> -static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
>> -{
>> -     return 0;
>> -}
>> -
>> -static void s3c24xx_i2c_dt_gpio_free(struct s3c24xx_i2c *i2c)
>> -{
>> -}
>> -#endif
>> -
>>  /* s3c24xx_i2c_init
>>   *
>>   * initialise the controller, set the IO lines and frequency
>> @@ -1054,15 +999,9 @@ static int s3c24xx_i2c_probe(struct platform_device
>> *pdev) i2c->adap.algo_data = i2c;
>>       i2c->adap.dev.parent = &pdev->dev;
>>
>> -     i2c->pctrl = devm_pinctrl_get_select_default(i2c->dev);
>> -
>>       /* inititalise the i2c gpio lines */
>> -
>> -     if (i2c->pdata->cfg_gpio) {
>> +     if (i2c->pdata->cfg_gpio)
>>               i2c->pdata->cfg_gpio(to_platform_device(i2c->dev));
>> -     } else if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c)) {
>> -             return -EINVAL;
>> -     }
>>
>>       /* initialise the i2c controller */
>>
>> @@ -1140,10 +1079,6 @@ static int s3c24xx_i2c_remove(struct platform_device
>> *pdev) i2c_del_adapter(&i2c->adap);
>>
>>       clk_disable_unprepare(i2c->clk);
>> -
>> -     if (pdev->dev.of_node && IS_ERR(i2c->pctrl))
>> -             s3c24xx_i2c_dt_gpio_free(i2c);
>> -
>>       return 0;
>>  }
>
