From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 9 Feb 2013 22:53:05 +0530
Subject: [PATCH V2 2/2] ARM: davinci: restart: fix wdt to machine restart
 with DT
In-Reply-To: <F3DBB1B3EF102E4994C89758CFCA32412C59EA@DBDE01.ent.ti.com>
References: <1360123204-9978-1-git-send-email-anilkumar.v@ti.com>
 <1360123204-9978-3-git-send-email-anilkumar.v@ti.com> <5113EF59.80508@ti.com>
 <F3DBB1B3EF102E4994C89758CFCA32412C59EA@DBDE01.ent.ti.com>
Message-ID: <511685F9.5080507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/8/2013 8:34 AM, Kumar, Anil wrote:

> On Thu, Feb 07, 2013 at 23:45:53, Nori, Sekhar wrote:

>> On 2/6/2013 9:30 AM, Kumar, Anil wrote:

>>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
>>> index 2d5502d..1df68fd 100644
>>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>>> @@ -359,7 +359,7 @@ static struct resource da8xx_watchdog_resources[] = {
>>>  	},
>>>  };
>>>  
>>> -struct platform_device da8xx_wdt_device = {
>>> +static struct platform_device da8xx_wdt_device = {
>>
>> Making of da8xx_wdt_device static should find a mention in description.
> 
> Ok, 
> I made da8xx_wdt_device structure static as it is used only
> in file. I will update description for this.
> 
>>
>>>  	.name		= "watchdog",
>>>  	.id		= -1,
>>>  	.num_resources	= ARRAY_SIZE(da8xx_watchdog_resources),
>>> @@ -368,7 +368,17 @@ struct platform_device da8xx_wdt_device = {
>>>  
>>>  void da8xx_restart(char mode, const char *cmd)
>>>  {
>>> -	davinci_watchdog_reset(&da8xx_wdt_device);
>>> +	struct device *dev = NULL;
>>> +	struct platform_device *wdt_device = NULL;
>>
>> No need to initialize these variables here.
> 
> Ok,
> I think no need to define wdt_device, can be used as
> 
> davinci_watchdog_reset(to_platform_device(dev));
> 
>>
>>> +
>>> +	dev = bus_find_device_by_name(&platform_bus_type, NULL, "watchdog");
>>> +	if (!dev) {
>>> +		pr_err("wdt device not found to machine reboot\n");
>>
>> Rather: "%s: failed to find watchdog device", __func__
> 
> ok

Since time is short and I really want to be able to reboot
when using DT in v3.9, I went ahead and fixed these comments.
Updated patch follows. I tested it on DA850 EVM.

Thanks,
Sekhar

----8<----
>From 19c7c0d81a9b1fe7342d0208b629b5e085e4f3ae Mon Sep 17 00:00:00 2001
From: "Kumar, Anil" <anilkumar.v@ti.com>
Date: Wed, 6 Feb 2013 09:30:04 +0530
Subject: [PATCH 3/3] ARM: davinci: da850 DT: add support for machine reboot

Update the da8xx_restart() function to support machine reboot
when booting using DT. Have the function search for the watchdog
platform device instead of always using "da8xx_wdt_device" which
is never registered in DT case.

While at it, also make da8xx_wdt_device static since there is no need
for it to be globally visible.

Tested machine reboot with both DT and non-DT boot on DA850 EVM.

Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c      |   12 ++++++++++--
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 2d5502d..cc6916d 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -359,7 +359,7 @@ static struct resource da8xx_watchdog_resources[] = {
 	},
 };
 
-struct platform_device da8xx_wdt_device = {
+static struct platform_device da8xx_wdt_device = {
 	.name		= "watchdog",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(da8xx_watchdog_resources),
@@ -368,7 +368,15 @@ struct platform_device da8xx_wdt_device = {
 
 void da8xx_restart(char mode, const char *cmd)
 {
-	davinci_watchdog_reset(&da8xx_wdt_device);
+	struct device *dev;
+
+	dev = bus_find_device_by_name(&platform_bus_type, NULL, "watchdog");
+	if (!dev) {
+		pr_err("%s: failed to find watchdog device\n", __func__);
+		return;
+	}
+
+	davinci_watchdog_reset(to_platform_device(dev));
 }
 
 int __init da8xx_register_watchdog(void)
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 700d311..ef9f70e 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -112,7 +112,6 @@ extern struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata;
 extern struct davinci_spi_platform_data da8xx_spi_pdata[];
 
-extern struct platform_device da8xx_wdt_device;
 
 extern const short da830_emif25_pins[];
 extern const short da830_spi0_pins[];
