From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 26 Apr 2015 08:35:57 -0700
Subject: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling
 to the WDT driver.
In-Reply-To: <12253069.Jm7LIDAreu@wuerfel>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
 <12253069.Jm7LIDAreu@wuerfel>
Message-ID: <553D05DD.8080300@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2015 01:11 PM, Arnd Bergmann wrote:
> On Friday 24 April 2015 12:08:54 Eric Anholt wrote:
>> +/*
>> + * We can't really power off, but if we do the normal reset scheme, and
>> + * indicate to bootcode.bin not to reboot, then most of the chip will be
>> + * powered off.
>> + */
>> +static void bcm2835_power_off(void)
>> +{
>> +       struct device_node *np =
>> +               of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
>> +       struct platform_device *pdev = of_find_device_by_node(np);
>> +       struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
>> +       u32 val;
>> +
>
> Instead of doing the lookup again here, I'd suggest using a static variable
> in the driver to store the device pointer for the device used on power_off.
>
> Make sure that the device remove callback assigns it back to NULL though
> and that the function checks for NULL pointer.
>

Why would that be needed ?

Guenter
