From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 31 Oct 2014 13:39:59 +0400
Subject: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
In-Reply-To: <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
Message-ID: <CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-31 10:48 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Oct 28, 2014 at 1:01 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> Add gpiolib driver for gpio pins placed on the LoCoMo GA.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>

[skipped]

> (etc, everywhere this pattern occurs).
>> +static void locomo_gpio_set(struct gpio_chip *chip,
>> +               unsigned offset, int value)
>> +{
>> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&lg->lock, flags);
>> +
>> +       __locomo_gpio_set(chip, offset, value);
>> +
>> +       spin_unlock_irqrestore(&lg->lock, flags);
>
> If you actually always have to be getting and releasing a spin lock around
> the register writes, contemplate using regmap-mmio because that
> is part of what it does.
>
> But is this locking really necessary?

I have a custom of doing such locking and never having to think about
somebody breaking into RMW cycles.

Also isn't regmap an overkill here? Wouldn't regmap also do a lock/unlock
around each register read/write/RMW?

>> +static int locomo_gpio_remove(struct platform_device *pdev)
>> +{
>> +       struct locomo_gpio *lg = platform_get_drvdata(pdev);
>> +       int ret;
>> +
>> +       ret = gpiochip_remove(&lg->gpio);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Can't remove gpio chip: %d\n", ret);
>> +               return ret;
>> +       }
>
> The return value from gpiochip_remove() has been removed in v3.18-rc1
> so this will not compile.

Yes, the fix will be in the next iteration. This patchset was based on 3.17

-- 
With best wishes
Dmitry
