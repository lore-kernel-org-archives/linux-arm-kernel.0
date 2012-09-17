From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 17 Sep 2012 13:22:55 +0530
Subject: [PATCH 1/2] i2c: s3c2410: add optional pin configuration using
 pinctrl interface
In-Reply-To: <CACRpkdZ7kjfDQ-CNCcCv5fQwSqMez6sKSMUMLB=0Aviboiz=2g@mail.gmail.com>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
 <1346923381-14144-2-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdZ7kjfDQ-CNCcCv5fQwSqMez6sKSMUMLB=0Aviboiz=2g@mail.gmail.com>
Message-ID: <CAJuYYwQWXOnRoCmiKJUwnBiceUimrK7BHeKZUKZ+pB679fhQNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2012 01:32, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Sep 6, 2012 at 11:23 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>
>> Add optional support for i2c bus pin configuration using pinctrl interface
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> (...)
>> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> (...)
>> -       else
>> -               if (s3c24xx_i2c_parse_dt_gpio(i2c))
>> +       } else if (!IS_ERR_OR_NULL(i2c->pctrl) &&
>> +                       !IS_ERR_OR_NULL(i2c->pctrl_state)) {
>
> You don't need to check i2c->pctrl here, just check i2c->pctrl_state.
>
> If i2c->pctrl failed the other one will be null too, anyway.
> (Or the struct isn't kzalloc:ed properly... which I assume.)

Yes, that's right. I will modify this check.

>
>> +               if (pinctrl_select_state(i2c->pctrl, i2c->pctrl_state)) {
>> +                       dev_err(i2c->dev, "failed to configure io-pins\n");
>> +                       return -ENXIO;
>> +               }
>> +       } else if (s3c24xx_i2c_parse_dt_gpio(i2c)) {
>>                         return -EINVAL;
>> +       }
>>
>>         /* write slave address */
>>
>> @@ -1013,6 +1022,10 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>>         i2c->adap.algo_data = i2c;
>>         i2c->adap.dev.parent = &pdev->dev;
>>
>> +       i2c->pctrl = devm_pinctrl_get(i2c->dev);
>> +       if (!IS_ERR_OR_NULL(i2c->pctrl))
>> +               i2c->pctrl_state = pinctrl_lookup_state(i2c->pctrl, "default");
>> +
>
> If all you do is select the default state (later, in the init function)
> the use devm_pinctrl_get_select_default() and be done
> with it.

The driver has a separate init which is invoked during probe. This
init function sets up the i/o pads for the i2c controller. This
function has to support three different types of Samsung platforms -
(a) non-dt (b) dt without pinctrl and (c) dt with pinctrl. And the
decision to use one of the types of pin setup has to be taken at
runtime (to support multi-platform images)

So the order that is used is

1. Check if platform data has a callback for pin setup. If yes, invoke
that callback.

2. If not, check if a vaild pinctrl state available, (implies pinctrl
driver support is available), then use the pinctrl_select_state() call
to setup the pins.

3. If both the above options are not available, then try setting up
the pins with information available in device tree node.

When all the Samsung platforms switch to using device tree and pinctrl
driver, this code would be simplified to use the
devm_pinctrl_get_select_default() function.

>
> In any case do not open code the string "default", use
> PINCTRL_STATE_DEFAULT which defines to that string.

Okay, that was a mistake. I will fix this.

>
> Yours,
> Linus Walleij

Thanks,
Thomas.
