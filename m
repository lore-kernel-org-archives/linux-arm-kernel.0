From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 27 Apr 2015 05:44:14 -0700
Subject: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling
 to the WDT driver.
In-Reply-To: <2979294.WseZH0BUZW@wuerfel>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <12253069.Jm7LIDAreu@wuerfel> <553D05DD.8080300@roeck-us.net>
 <2979294.WseZH0BUZW@wuerfel>
Message-ID: <553E2F1E.5070909@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2015 02:18 AM, Arnd Bergmann wrote:
> On Sunday 26 April 2015 08:35:57 Guenter Roeck wrote:
>> On 04/25/2015 01:11 PM, Arnd Bergmann wrote:
>>> On Friday 24 April 2015 12:08:54 Eric Anholt wrote:
>>>> +/*
>>>> + * We can't really power off, but if we do the normal reset scheme, and
>>>> + * indicate to bootcode.bin not to reboot, then most of the chip will be
>>>> + * powered off.
>>>> + */
>>>> +static void bcm2835_power_off(void)
>>>> +{
>>>> +       struct device_node *np =
>>>> +               of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
>>>> +       struct platform_device *pdev = of_find_device_by_node(np);
>>>> +       struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
>>>> +       u32 val;
>>>> +
>>>
>>> Instead of doing the lookup again here, I'd suggest using a static variable
>>> in the driver to store the device pointer for the device used on power_off.
>>>
>>> Make sure that the device remove callback assigns it back to NULL though
>>> and that the function checks for NULL pointer.
>>>
>>
>> Why would that be needed ?
>
> devices can be unbound from drivers through sysfs, or using dynamic DT
> updates. If one does that, the watchdog driver will correctly destroy
> all information it has about the device, so if the power_off function
> still uses that pointer, it will crash.
>
Without calling its remove function ? That sounds odd. Lots of drivers
would break if that was really the case.

Guenter
