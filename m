From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri, 30 Dec 2016 10:03:53 -0800
Subject: [PATCH 10/20] gpio: pca953x: Add optional reset gpio control
In-Reply-To: <CACRpkdZG2j4_LwP8KUVBTOtXma75YvYtC6CW1QqYwOm-MOZgHg@mail.gmail.com>
References: <1483050455-10683-1-git-send-email-steve_longerbeam@mentor.com>
 <1483050455-10683-11-git-send-email-steve_longerbeam@mentor.com>
 <CACRpkdZG2j4_LwP8KUVBTOtXma75YvYtC6CW1QqYwOm-MOZgHg@mail.gmail.com>
Message-ID: <9fa1db80-b0ea-68af-c122-49ea0b4315ec@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, Lothar,


On 12/30/2016 05:17 AM, Linus Walleij wrote:
> On Thu, Dec 29, 2016 at 11:27 PM, Steve Longerbeam
> <slongerbeam@gmail.com> wrote:
>
>> Add optional reset-gpios pin control. If present, de-assert the
>> specified reset gpio pin to bring the chip out of reset.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: linux-gpio at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
> This seems like a separate patch from the other 19 patches so please send it
> separately so I can handle logistics easier in the future.

Ok, I'll send the next version separately.

>
>
>> @@ -133,6 +134,7 @@ struct pca953x_chip {
>>          const char *const *names;
>>          unsigned long driver_data;
>>          struct regulator *regulator;
>> +       struct gpio_desc *reset_gpio;
> Why do you even keep this around in the device state container?
>
> As you only use it in the probe() function, use a local variable.
>
> The descriptor will be free():ed by the devm infrastructure anyways.

I think my reasoning for putting the gpio handle into the device
struct was for possibly using it for run-time reset control at some
point. But that could be done later if needed, so I'll go ahead and
make it local.

>> +               /* see if we need to de-assert a reset pin */
>> +               chip->reset_gpio = devm_gpiod_get_optional(&client->dev,
>> +                                                          "reset",
>> +                                                          GPIOD_OUT_LOW);
>> +               if (IS_ERR(chip->reset_gpio)) {
>> +                       dev_err(&client->dev, "request for reset pin failed\n");
>> +                       return PTR_ERR(chip->reset_gpio);
>> +               }
> Nice.
>
>> +               if (chip->reset_gpio) {
>> +                       /* bring chip out of reset */
>> +                       dev_info(&client->dev, "releasing reset\n");
>> +                       gpiod_set_value(chip->reset_gpio, 0);
>> +               }
> Is this really needed given that you set it low in the
> devm_gpiod_get_optional()?

Yep, this is left over from a previous iteration, but it isn't needed now.
I'll remove it.

Steve
