From: jm@lentin.co.uk (Jamie Lentin)
Date: Thu, 3 May 2012 11:09:56 +0100 (BST)
Subject: [PATCH] gpio: Add simple poweroff-gpio driver
In-Reply-To: <20120503084825.GD13023@lunn.ch>
References: <20120501195603.GW25584@lunn.ch>
 <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
 <20120503084825.GD13023@lunn.ch>
Message-ID: <alpine.DEB.2.00.1205031101390.23719@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 May 2012, Andrew Lunn wrote:

>> +static int __devinit gpio_poweroff_probe(struct platform_device *pdev)
>> +{
>> +	enum of_gpio_flags flags;
>> +
>> +	gpio_num = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
>> +	if (gpio_num < 0) {
>> +		pr_err("%s: Could not get GPIO configuration: %d",
>> +		       __func__, gpio_num);
>> +		return -ENODEV;
>> +	}
>> +	gpio_active_low = flags & OF_GPIO_ACTIVE_LOW;
>
> If you look at the Kirkwood/Orion5x, most systems that could use this
> are currently not DT enabled. So i think it needs old style
> platform_data as well as OF.

I wondered about this, but if you have board support code instead of
devicetree, would you have any reasons to use this driver over just 
implementing the pm_power_off as most of them currently do? Seemed to me 
that it was better to not complicate the code with platform_data when it's 
practical use wasn't that high.

All that said, it's not a big deal to add in.

>> +static int __devexit gpio_poweroff_remove(struct platform_device *pdev)
>> +{
>> +	if (gpio_num)
>> +		gpio_free(gpio_num);
>
> GPIO 0 is a valid GPIO number. You should not need this check, since
> if the probe function succeeded, you have a valid GPIO.

Curses, you're right. Will fix this and the bug in the next mail.

Cheers,

>
>    Andrew
>

-- 
Jamie Lentin
