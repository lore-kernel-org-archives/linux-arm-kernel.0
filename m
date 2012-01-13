From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 13 Jan 2012 18:00:36 +1100
Subject: [PATCH 04/11] ep93xx: Configure GPIO ports in core code
In-Reply-To: <20120113062707.GA4147@mwesterb-mobl.ger.corp.intel.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-5-git-send-email-rmallon@gmail.com>
 <20120113062707.GA4147@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <4F0FD694.4060705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/12 17:27, Mika Westerberg wrote:
> On Wed, Jan 11, 2012 at 02:14:29PM +1100, Ryan Mallon wrote:
>> Move the pinmux setting of the EP93xx GPIOs to the core code. This
>> removes the need for the GPIO driver to have access to the system
>> controller registers.
>>
>> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Mika Westerberg <mika.westerberg@iki.fi>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
>> ---
>>  arch/arm/mach-ep93xx/core.c |    7 +++++++
>>  drivers/gpio/gpio-ep93xx.c  |    7 -------
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
>> index dcb10c2..978c5a6 100644
>> --- a/arch/arm/mach-ep93xx/core.c
>> +++ b/arch/arm/mach-ep93xx/core.c
>> @@ -896,6 +896,13 @@ void __init ep93xx_init_devices(void)
>>  	/* Disallow access to MaverickCrunch initially */
>>  	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_CPENA);
>>  
>> +	/* Default all ports to GPIO */
>> +	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
>> +			       EP93XX_SYSCON_DEVCFG_GONK |
>> +			       EP93XX_SYSCON_DEVCFG_EONIDE |
>> +			       EP93XX_SYSCON_DEVCFG_GONIDE |
>> +			       EP93XX_SYSCON_DEVCFG_HONIDE);
>> +
> Doesn't this now change the behaviour? Now you unconditionally mux the pins
> whereas before they were only muxed if we had GPIO driver enabled.

True, but I think the previous behaviour was broken anyway. If the gpio
driver was installed after any driver which has muxed gpio pins for
other purposes then it will override those settings. All of the ep93xx
drivers will mux the pins they need at probe time. IIRC, before the gpio
driver was moved out of arch/arm/mach-ep93xx we muxed all the pins
unconditionally anyway.

I can update the changelog to reflect the changed behaviour, but I don't
think it will cause problems for anyone. Will see if Hartley has any
comments.

~Ryan

>>  	/* Get the GPIO working early, other devices need it */
>>  	platform_device_register(&ep93xx_gpio_device);
>>  
>> diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
>> index 1c0fc37..4ca5642 100644
>> --- a/drivers/gpio/gpio-ep93xx.c
>> +++ b/drivers/gpio/gpio-ep93xx.c
>> @@ -378,13 +378,6 @@ static int __devinit ep93xx_gpio_probe(struct platform_device *pdev)
>>  	}
>>  	ep93xx_gpio->mmio_base = mmio;
>>  
>> -	/* Default all ports to GPIO */
>> -	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
>> -			       EP93XX_SYSCON_DEVCFG_GONK |
>> -			       EP93XX_SYSCON_DEVCFG_EONIDE |
>> -			       EP93XX_SYSCON_DEVCFG_GONIDE |
>> -			       EP93XX_SYSCON_DEVCFG_HONIDE);
>> -
>>  	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_banks); i++) {
>>  		struct bgpio_chip *bgc = &ep93xx_gpio->bgc[i];
>>  		struct ep93xx_gpio_bank *bank = &ep93xx_gpio_banks[i];
>> -- 
>> 1.7.0.4
