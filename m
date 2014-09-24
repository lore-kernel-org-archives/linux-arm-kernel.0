From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 24 Sep 2014 06:30:55 -0700
Subject: [PATCH v6] watchdog: Add DA9063 PMIC watchdog driver.
In-Reply-To: <20140924091055.GB25366@pengutronix.de>
References: <1410184713-6436-1-git-send-email-mpa@pengutronix.de>
 <20140911163035.GA13969@roeck-us.net> <20140924091055.GB25366@pengutronix.de>
Message-ID: <5422C78F.4020507@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2014 02:10 AM, Markus Pargmann wrote:
> Hi,
>
> sorry for the late reply, I was on vacation.
>

No problem. Hope you had fun :-)

>>> +
>>> +static int da9063_wdt_probe(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +	struct da9063 *da9063;
>>> +	struct da9063_watchdog *wdt;
>>> +
>>> +	if (!pdev->dev.parent)
>>> +		return -EINVAL;
>>> +
>>> +	da9063 = dev_get_drvdata(pdev->dev.parent);
>>> +	if (!da9063)
>>> +		return -EINVAL;
>>> +
>>
>> This is not really an invalid argument. -ENODEV seems to be more appropriate,
>> given the context (presumably it means that there is no parent mfd device).
>
> Yes, but ENODEV will not result in a probe error message because the
> driver core assumes that the driver is not for this device. I would like
> to have a probe error message so that developers immediately see that
> something went wrong. This driver without a parent is a invalid setup,
> so I chose EINVAL.
> I prefer returning -EINVAL but as an alternative I could add an error
> message here and return ENODEV.
>

Good point. Given the context, one can argue that having no driver data _is_
an invalid argument (to the function), so I am fine with that.

Guenter
