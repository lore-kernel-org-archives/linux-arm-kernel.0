From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 28 Feb 2011 11:25:42 +0100
Subject: [PATCH 08/09] ARM: s3c2440: gta02: Request usb pullup pin before
	using it
In-Reply-To: <000301cbd70f$12367070$36a35150$%kim@samsung.com>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
	<1297043521-21903-8-git-send-email-lars@metafoo.de>
	<000301cbd70f$12367070$36a35150$%kim@samsung.com>
Message-ID: <4D6B7826.1030500@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2011 07:16 AM, Kukjin Kim wrote:
> Lars-Peter Clausen wrote:
>>
>> Request the gpio pin used to control the usb pullup before using it to
> avoid
>> a
>> runtime warning about an auto-requested gpio.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  arch/arm/mach-s3c2440/mach-gta02.c |   17 +++++++++++++++--
>>  1 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-s3c2440/mach-gta02.c
> b/arch/arm/mach-s3c2440/mach-
>> gta02.c
>> index 1396639..94456fa 100644
>> --- a/arch/arm/mach-s3c2440/mach-gta02.c
>> +++ b/arch/arm/mach-s3c2440/mach-gta02.c
>> @@ -451,11 +451,11 @@ static void gta02_udc_command(enum s3c2410_udc_cmd_e
>> cmd)
>>  	switch (cmd) {
>>  	case S3C2410_UDC_P_ENABLE:
>>  		pr_debug("%s S3C2410_UDC_P_ENABLE\n", __func__);
>> -		gpio_direction_output(GTA02_GPIO_USB_PULLUP, 1);
>> +		gpio_set_value(GTA02_GPIO_USB_PULLUP, 1);
> 
> How about following instead?
> 	gpio_request(GTA02_GPIO_USB_PULLUP, "USB_PULLUP");
> 	gpio_direction_output(GTA02_GPIO_USB_PULLUP, 1);
> 	gpio_free(GTA02_GPIO_USB_PULLUP);
> 

I don't think that is a good idea. This gpio should really be reserved for the
udc driver. If it is freed again, it could be requested from someone else which
could lead to undefined behaviour.


>>  		break;
>>  	case S3C2410_UDC_P_DISABLE:
>>  		pr_debug("%s S3C2410_UDC_P_DISABLE\n", __func__);
>> -		gpio_direction_output(GTA02_GPIO_USB_PULLUP, 0);
>> +		gpio_set_value(GTA02_GPIO_USB_PULLUP, 0);
>>  		break;
>>  	case S3C2410_UDC_P_RESET:
>>  		pr_debug("%s S3C2410_UDC_P_RESET\n", __func__);
>> @@ -572,11 +572,24 @@ static void gta02_poweroff(void)
>>  	pcf50633_reg_set_bit_mask(gta02_pcf, PCF50633_REG_OOCSHDWN, 1, 1);
>>  }
>>
>> +static void gta02_request_gpios(void)
>> +{
>> +	int ret;
>> +	ret = gpio_request_one(GTA02_GPIO_USB_PULLUP, GPIOF_OUT_INIT_LOW,
>> +				"USB pullup");
>> +	if (ret) {
>> +		printk(KERN_ERR "Failed to request USB pullup gpio pin:
> %d\n",
>> +			ret);
>> +	}
>> +}
>> +
>>  static void __init gta02_machine_init(void)
>>  {
>>  	/* Set the panic callback to turn AUX LED on or off. */
>>  	panic_blink = gta02_panic_blink;
>>
>> +	gta02_request_gpios();
>> +
>>  	s3c_pm_init();
>>
>>  #ifdef CONFIG_CHARGER_PCF50633
>> --
> 
> 
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
