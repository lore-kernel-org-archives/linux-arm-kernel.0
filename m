From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 14 Aug 2014 19:54:09 +0300
Subject: [PATCH 4/4] ARM: dts: keystone-k2hk: add dsp gpio controllers
 nodes
In-Reply-To: <1408029982.880621027@f126.i.mail.ru>
References: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>
 <1408018321.928492982@f270.i.mail.ru> <53ECDC54.3060005@ti.com>
 <1408029982.880621027@f126.i.mail.ru>
Message-ID: <53ECE9B1.4060303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2014 06:26 PM, Alexander Shiyan wrote:
> Thu, 14 Aug 2014 18:57:08 +0300 ?? Grygorii Strashko <grygorii.strashko@ti.com>:
> ...
>>>>>> +		dspgpio7: keystone_dsp_gpio at 262025C {
>>>>>> +			compatible = "ti,keystone-mctrl-gpio";
>>>>>> +			gpio-controller;
>>>>>> +			#gpio-cells = <2>;
>>>>>> +			gpio,syscon-dev = <&devctrl 0x25c>;
>>>>>> +		};
>>>>>
>>>>> So, devctrl is a syscon device and this DTS introduce several
>>>>> identical GPIO descriptions?
>>>>>
>>>>> On my opinion this should be placed in the gpio-syscon.c,
>>>>> where you can add support for ti,keystone-dsp0{..7}-gpio.
>>>>> Such change will avoid parts 2 and 3 of this patch.
>>>>>
>>>>> static const struct syscon_gpio_data ti_keystone_dsp0_gpio = {
>>>>>      .compatible = "ti,keystone-syscon",
>>>>>      .dat_bit_offset = 0x240 * 8,
>>>>>      ...
>>>>>      .set = etc...
>>>>> };
>>>>
>>>> So, if I understand you right, you propose to add 8 additional compatible
>>>> strings just to encode different register offsets. Is it?
>>>> 1) add "ti,keystone-mctrl-gpio0"..."ti,keystone-mctrl-gpio7"
>>>
>>> Yes, but replace "mctrl" with "dsp" since mctrl is not applicable here.
>>>
>>>> 2) add 8 structures keystone_mctrl_gpio0..keystone_mctrl_gpio7 in gpio-syscon.c
>>>>      (which will have only different values of field - .dat_bit_offset = 0x2yy * 8,)
>>>>
>>>> 3) add 8 additional items in array syscon_gpio_ids
>>>> 	{
>>>> 		.compatible	= "ti,keystone-mctrl-gpio0",
>>>> 		.data		= &keystone_mctrl_gpio0,
>>>> 	}, ...
>>>>
>>>> I can do it if you strictly insist, BUT I don't like it :(
>>>> - just imagine how your driver will look look like if 5 or 6 SoCs will re-use it ;)
>>>> - as I mentioned in cover letter and commit messages even each SoC revision can have
>>>>     different Syscon implementation with different registers offsets and with different
>>>>     number of Syscon register ranges (for example for Keystone 2 we already have two
>>>>     Syscon devices defined in DT).
>>>
>>> The initial version of this driver contains addresses and offsets in, but this approach has
>>> been criticized by DT maintainers.
>>
>> Could you provide link on this thread^, pls?
> 
> Here is a link to first version:
> https://www.mail-archive.com/linux-gpio at vger.kernel.org/msg01616.html

10x

> 
> Unfortunately, I lost thread for DT-related stuffs.
> 

Oh, I've just checked ARM dts directory and found that 
constructions like this:
	vendor,syscon = <&syscon_phandle>; /// or even this vendor,syscon = <&syscon_phandle 0x60 2>;
are widely used as of now.
Also, According to the bindings doc, the Syscon is not a Linux specific definition (mfd/syscon.txt).

Regards,
-grygorii
