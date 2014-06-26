From: dianders@chromium.org (Doug Anderson)
Date: Thu, 26 Jun 2014 09:12:58 -0700
Subject: [PATCH v4 07/14] mfd: Add driver for Maxim 77802 Power Management
 IC
In-Reply-To: <53AC003E.2010608@collabora.co.uk>
References: <1403723019-6212-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403723019-6212-8-git-send-email-javier.martinez@collabora.co.uk>
 <1403775093.27156.13.camel@AMDC1943>
 <53AC003E.2010608@collabora.co.uk>
Message-ID: <CAD=FV=U5sBQ4VDG65D4rTnfruo5XzQH_EMs4SMpO4BjY1UHA5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Thu, Jun 26, 2014 at 4:13 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
>>> +
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int max77802_suspend(struct device *dev)
>>> +{
>>> +    struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
>>> +    struct max77802_dev *max77802 = i2c_get_clientdata(i2c);
>>> +
>>> +    if (device_may_wakeup(dev))
>>> +            enable_irq_wake(max77802->irq);
>>> +
>>> +    disable_irq(max77802->irq);
>>
>> Can you add short comment why this is needed? I know why but just for
>> future generations which will wonder: "why do we need to disable the IRQ
>> while suspending?" :). Especially that this is rather a workaround for
>> issue in other driver (I2C bus).
>>
>
> Good idea, I'll add a comment here on next version so code archaeologists can
> figure out what what's going on here.

Is the disable_irq() needed if you have
<https://patchwork.kernel.org/patch/4421891/>?
