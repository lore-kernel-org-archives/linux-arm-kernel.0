From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 26 Jun 2014 18:18:43 +0200
Subject: [PATCH v4 07/14] mfd: Add driver for Maxim 77802 Power Management
 IC
In-Reply-To: <CAD=FV=U5sBQ4VDG65D4rTnfruo5XzQH_EMs4SMpO4BjY1UHA5Q@mail.gmail.com>
References: <1403723019-6212-1-git-send-email-javier.martinez@collabora.co.uk>	<1403723019-6212-8-git-send-email-javier.martinez@collabora.co.uk>	<1403775093.27156.13.camel@AMDC1943>	<53AC003E.2010608@collabora.co.uk>
 <CAD=FV=U5sBQ4VDG65D4rTnfruo5XzQH_EMs4SMpO4BjY1UHA5Q@mail.gmail.com>
Message-ID: <53AC47E3.2030306@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 06/26/2014 06:12 PM, Doug Anderson wrote:
> Javier,
> 
> On Thu, Jun 26, 2014 at 4:13 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>>>> +
>>>> +#ifdef CONFIG_PM_SLEEP
>>>> +static int max77802_suspend(struct device *dev)
>>>> +{
>>>> +    struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
>>>> +    struct max77802_dev *max77802 = i2c_get_clientdata(i2c);
>>>> +
>>>> +    if (device_may_wakeup(dev))
>>>> +            enable_irq_wake(max77802->irq);
>>>> +
>>>> +    disable_irq(max77802->irq);
>>>
>>> Can you add short comment why this is needed? I know why but just for
>>> future generations which will wonder: "why do we need to disable the IRQ
>>> while suspending?" :). Especially that this is rather a workaround for
>>> issue in other driver (I2C bus).
>>>
>>
>> Good idea, I'll add a comment here on next version so code archaeologists can
>> figure out what what's going on here.
> 
> Is the disable_irq() needed if you have
> <https://patchwork.kernel.org/patch/4421891/>?
> 

Probably not but I added the following comment:

	/*
	 * The IRQ must be disabled during suspend since due wakeup
	 * ordering issues it may be possible that the I2C controller
	 * is still suspended when the interrupt happens so the IRQ
	 * handler will fail to read the I2C bus.
	 */
	disable_irq(max77802->irq);

since in theory this PMIC can be used in other SoCs besides
Exynos5420/Exynos5800 and it may be possible that the I2C controller driver for
these other SoCs may not resume at noirq time.

But on a second thought, this PMIC seems to be designed specially for these two
Exynos SoCs so I guess it's safe to assume that it is not needed?

Best regards,
Javier
