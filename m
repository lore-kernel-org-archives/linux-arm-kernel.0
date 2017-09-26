From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 15:37:37 +0200
Subject: [PATCH v2 02/10] pinctrl: axp209: add pinctrl features
In-Reply-To: <20170926132709.od3myumh5xtungvs@flea>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
 <6b89df1bf07dac2ab295fca5fdf0e55179c47ed6.1506428208.git-series.quentin.schulz@free-electrons.com>
 <20170926130009.r5isgrjvkwmm44nn@flea>
 <5596280a-51bb-7491-31f4-5800219888ad@free-electrons.com>
 <20170926132709.od3myumh5xtungvs@flea>
Message-ID: <0bc7efe6-8d0e-ddae-617b-36e4357f76ce@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/2017 15:27, Maxime Ripard wrote:
> On Tue, Sep 26, 2017 at 01:08:21PM +0000, Quentin Schulz wrote:
>> Hi Maxime,
>>
>> On 26/09/2017 15:00, Maxime Ripard wrote:
>>> On Tue, Sep 26, 2017 at 12:17:12PM +0000, Quentin Schulz wrote:
>>>> +static const struct axp20x_desc_pin axp209_pins[] = {
>>>> +	AXP20X_PIN(AXP20X_PINCTRL_PIN(0, "GPIO0"),
>>>> +		   AXP20X_FUNCTION(0x0, "gpio_out"),
>>>> +		   AXP20X_FUNCTION(0x2, "gpio_in"),
>>>> +		   AXP20X_FUNCTION(0x3, "ldo"),
>>>> +		   AXP20X_FUNCTION(0x4, "adc")),
>>>> +	AXP20X_PIN(AXP20X_PINCTRL_PIN(1, "GPIO1"),
>>>> +		   AXP20X_FUNCTION(0x0, "gpio_out"),
>>>> +		   AXP20X_FUNCTION(0x2, "gpio_in"),
>>>> +		   AXP20X_FUNCTION(0x3, "ldo"),
>>>> +		   AXP20X_FUNCTION(0x4, "adc")),
>>>> +	AXP20X_PIN(AXP20X_PINCTRL_PIN(2, "GPIO2"),
>>>> +		   AXP20X_FUNCTION(0x0, "gpio_out"),
>>>> +		   AXP20X_FUNCTION(0x2, "gpio_in")),
>>>> +};
>>>
>>> If all the functions are the same, and at the same offset, can't we
>>> just hardcode it, instead of having (and duplicate) all the logic
>>> below?
>>>
>>
>> AXP20X_PIN(AXP20X_PINCTRL_PIN(0, "GPIO0"),
>> 		AXP20X_GPIO_OUT,
>> 		AXP20X_GPIO_IN,
>> 		AXP20X_LDO,
>> 		AXP20X_ADC))
>>
>> That's what you mean?
> 
> What I mean is:
> 
> static int axp20x_get_func(char *func)
> {
> 	if (!strcmp(func, "gpio_out"))
> 		return 0;
> 
> 	if (!strcmp(func, "gpio_in"))
> 		return 2;
>  
> 	if (!strcmp(func, "ldo"))
>  		return 3;
>  
> 	if (!strcmp(func, "adc"))
>  		return 4;
> 
> 	return -EINVAL;
> }
> 

GPIO2 on AXP209 does not support ldo nor adc.
GPIO1 on AXP813 does not support adc.

I find it more complex to handle those two cases in a function than by
hardcoding it in structures like above.

Moreover, nothing tells us that it would be the same offset for other PMICs.

Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/ff97d032/attachment.sig>
