From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 12 Jun 2015 05:18:15 -0700
Subject: [PATCH 2/3] watchdog: bcm2835: Add poweroff code for the Raspberry
 Pi
In-Reply-To: <557AC203.6060600@lategoodbye.de>
References: <1433845305-17329-1-git-send-email-noralf@tronnes.org>
 <1433845305-17329-2-git-send-email-noralf@tronnes.org>
 <557AC203.6060600@lategoodbye.de>
Message-ID: <557ACE07.3040104@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2015 04:26 AM, Stefan Wahren wrote:
> Hi Noralf,
>
> Am 09.06.2015 um 12:21 schrieb Noralf Tr?nnes:
>> This adds a new poweroff function to the watchdog driver for the
>> Raspberry Pi. Currently poweroff/halt results in a reboot.
>>
>> [...]
>>
>> +static void rpi_power_off(void)
>> +{
>> +    struct device_node *np =
>> +        of_find_compatible_node(NULL, NULL, "brcm,raspberrypi-pm-wdt");
>> +    struct platform_device *pdev = of_find_device_by_node(np);
>> +    struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
>> +    u32 val;
>> +
>> +    val = readl_relaxed(wdt->base + PM_RSTS);
>
> do you think it's safe here to assume wdt could never be NULL?
>

If the call is made, the driver must be instantiated. We can therefore assume
that neither np, pdev, nor wdt is NULL. If one of those is NULL, it would be
a bug, which should not be ignored.

Guenter
