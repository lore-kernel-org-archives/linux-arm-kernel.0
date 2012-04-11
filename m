From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 11 Apr 2012 12:16:22 -0500
Subject: [PATCH] arm: ep93xx: use gpio_led_register_device
In-Reply-To: <4F84E93C.1070004@gmail.com>
References: <201204041042.22674.hartleys@visionengravers.com>
 <4F84E93C.1070004@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206986C0542@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 10, 2012 7:15 PM, Ryan Mallon wrote:
> On 05/04/12 03:42, H Hartley Sweeten wrote:
>
>> Use gpio_led_register_device to register the two leds connected to
>> the ep93xx.
>> 
>> Add a SOC_EP93XX Kconfig option for common options needed by ep93xx
>> and use that option to select LEDS_GPIO_REGISTER.
>> 
>> Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>
> Hi Hartley,
>
> Just a couple of comments below.
>
> ~Ryan
>
>> ---
>> 
>>  arch/arm/mach-ep93xx/Kconfig |   12 ++++++++++++
>>  arch/arm/mach-ep93xx/core.c  |   16 ++++------------
>>  2 files changed, 16 insertions(+), 12 deletions(-)
>> 
>> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
>> index 97a2493..b27a8ad 100644
>> --- a/arch/arm/mach-ep93xx/Kconfig
>> +++ b/arch/arm/mach-ep93xx/Kconfig
>> @@ -2,6 +2,10 @@ if ARCH_EP93XX
>>  
>>  menu "Cirrus EP93xx Implementation Options"
>>  
>> +config SOC_EP93XX
>> +	bool
>> +	select LEDS_GPIO_REGISTER
>> +
>
>
> So, this option is currently just used to indirectly select
> LEDS_GPIO_REGISTER. Do you have plans for it to select other things?
>> Otherwise, its just a bunch of extra Kconfig lines for not much benefit.

Yes, this option will be used to indirectly select common "generic" options for
the ep93xx.  I think this is cleaner than putting them directly under ARCH_EP93XX
in arch/arm/Kconfig.

EP93XX specific options are already handled in the various subsystems with the
"depends on ARCH_EP93XX", but for generic stuff we would need to either
update the defconfig or rely on the user to select the options.

Currently, with the single option being selected, it is a bit of overkill. But as more
options (hopefully) get added it should be a benefit.

>>  config CRUNCH
>>  	bool "Support for MaverickCrunch"
>>  	help
>> @@ -48,12 +52,14 @@ endchoice
>>  config MACH_ADSSPHERE
>>  	bool "Support ADS Sphere"
>>  	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
>> +	select SOC_EP93XX
>>  	help
>>  	  Say 'Y' here if you want your kernel to support the ADS
>>  	  Sphere board.
>>  
>>  config MACH_EDB93XX
>>  	bool
>> +	select SOC_EP93XX
>>  
>>  config MACH_EDB9301
>>  	bool "Support Cirrus Logic EDB9301"
>> @@ -122,12 +128,14 @@ config MACH_EDB9315A
>>  config MACH_GESBC9312
>>  	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
>>  	bool "Support Glomation GESBC-9312-sx"
>> +	select SOC_EP93XX
>>  	help
>>  	  Say 'Y' here if you want your kernel to support the Glomation
>>  	  GESBC-9312-sx board.
>>  
>>  config MACH_MICRO9
>>  	bool
>> +	select SOC_EP93XX
>>  
>>  config MACH_MICRO9H
>>  	bool "Support Contec Micro9-High"
>> @@ -164,6 +172,7 @@ config MACH_MICRO9S
>>  config MACH_SIM_ONE
>>          bool "Support Simplemachines Sim.One board"
>>          depends on EP93XX_SDCE0_PHYS_OFFSET
>> +	select SOC_EP93XX
>
>
> The existing whitespace here is using spaces instead of tabs. If the
> result looks terrible (not aligned) then we should maybe do a separate
> patch to clean up the crappy whitespace.

I noticed that also... Hmm... who used the spaces ;-)

I agree, a separate patch should clean up the shitespace.

>>          help
>>            Say 'Y' here if you want your kernel to support the
>>            Simplemachines Sim.One board.
>> @@ -171,6 +180,7 @@ config MACH_SIM_ONE
>>  config MACH_SNAPPER_CL15
>>  	bool "Support Bluewater Systems Snapper CL15 Module"
>>  	depends on EP93XX_SDCE0_PHYS_OFFSET
>> +	select SOC_EP93XX
>>  	help
>>  	  Say 'Y' here if you want your kernel to support the Bluewater
>>  	  Systems Snapper CL15 Module.
>> @@ -178,6 +188,7 @@ config MACH_SNAPPER_CL15
>>  config MACH_TS72XX
>>  	bool "Support Technologic Systems TS-72xx SBC"
>>  	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
>> +	select SOC_EP93XX
>>  	help
>>  	  Say 'Y' here if you want your kernel to support the
>>  	  Technologic Systems TS-72xx board.
>> @@ -185,6 +196,7 @@ config MACH_TS72XX
>>  config MACH_VISION_EP9307
>>  	bool "Support Vision Engraving Systems EP9307 SoM"
>>  	depends on EP93XX_SDCE0_PHYS_OFFSET
>> +	select SOC_EP93XX
>>  	help
>>  	  Say 'Y' here if you want your kernel to support the
>>  	  Vision Engraving Systems EP9307 SoM.
>> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
>> index 8d25895..257a124 100644
>> --- a/arch/arm/mach-ep93xx/core.c
>> +++ b/arch/arm/mach-ep93xx/core.c
>> @@ -513,7 +513,7 @@ void __init ep93xx_register_spi(struct ep93xx_spi_info *info,
>>  /*************************************************************************
>>   * EP93xx LEDs
>>   *************************************************************************/
>> -static struct gpio_led ep93xx_led_pins[] = {
>> +static const struct gpio_led ep93xx_led_pins[] __initconst = {
>
>
> This fix, and related changes are not mentioned in the changelog.

Sorry about that.  From include/Linux/leds.h:

struct platform_device *gpio_led_register_device(
		int id, const struct gpio_led_platform_data *pdata);

Since pdata needs to be const I changed the two relevant static variables to const.
And, since nothing should modify them I also made them __initconst.  If you
feel this needs to be mentioned in the changelog I will resubmit the patch.

>
>>  	{
>>  		.name	= "platform:grled",
>>  		.gpio	= EP93XX_GPIO_LINE_GRLED,
>> @@ -523,20 +523,11 @@ static struct gpio_led ep93xx_led_pins[] = {
>>  	},
>>  };
>>  
>> -static struct gpio_led_platform_data ep93xx_led_data = {
>> +static const struct gpio_led_platform_data ep93xx_led_data __initconst = {
>>  	.num_leds	= ARRAY_SIZE(ep93xx_led_pins),
>>  	.leds		= ep93xx_led_pins,
>>  };
>>  
>> -static struct platform_device ep93xx_leds = {
>> -	.name		= "leds-gpio",
>> -	.id		= -1,
>> -	.dev		= {
>> -		.platform_data	= &ep93xx_led_data,
>> -	},
>> -};
>> -
>> -
>>  /*************************************************************************
>>   * EP93xx pwm peripheral handling
>>   *************************************************************************/
>> @@ -889,8 +880,9 @@ void __init ep93xx_init_devices(void)
>>  
>>  	platform_device_register(&ep93xx_rtc_device);
>>  	platform_device_register(&ep93xx_ohci_device);
>> -	platform_device_register(&ep93xx_leds);
>>  	platform_device_register(&ep93xx_wdt_device);
>> +
>> +	gpio_led_register_device(-1, &ep93xx_led_data);
>>  }
>>  
>>  void ep93xx_restart(char mode, const char *cmd)

Regards,
Hartley
