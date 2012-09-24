From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Sep 2012 17:14:38 -0600
Subject: [RFC 6/6] ARM: dts: exynos4210: Add platform-specific descriptions
 for pin controllers
In-Reply-To: <7891903.Qpoh0EJCQr@flatron>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
 <2359157.SFB7x6fWGY@flatron> <50609B77.2060406@wwwdotorg.org>
 <7891903.Qpoh0EJCQr@flatron>
Message-ID: <5060E95E.5030601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2012 03:31 PM, Tomasz Figa wrote:
> On Monday 24 of September 2012 11:42:15 Stephen Warren wrote:
>> On 09/21/2012 01:54 PM, Tomasz Figa wrote:
>>> On Friday 21 of September 2012 12:56:41 Stephen Warren wrote:
>>>> On 09/20/2012 02:53 AM, Tomasz Figa wrote:
>>>>> The patch "pinctrl: samsung: Parse pin banks from DT" introduced
>>>>> platform-specific data parsing from DT.
>>>>>
>>>>> This patch adds all necessary nodes and properties to exynos4210
>>>>> device
>>>>> tree sources.
>>>>>
>>>>> +++ b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
>>>>>
>>>>> +			samsung,pctl-offset = <0x000>;
>>>>> +			samsung,pin-bank = "gpa0";
>>>>> +			samsung,pin-count = <8>;
>>>>> +			samsung,func-width = <4>;
>>>>> +			samsung,pud-width = <2>;
>>>>> +			samsung,drv-width = <2>;
>>>>> +			samsung,conpdn-width = <2>;
>>>>> +			samsung,pudpdn-width = <2>;
>>>>
>>>> The properties above represent the width of the fields. Must all
>>>> fields
>>>> always be packed together into say the LSB of the registers? What if
>>>> there are gaps between the fields in a future SoC variant, or the
>>>> order
>>>> of the fields in the register changes? I think you want to add either
>>>> a
>>>> samsung,func-bit/samsung,func-position property for each of the
>>>> fields,
>>>> or change from samsung,func-width=<4> to samsung,field-mask=<0xf>.
>>>> IIRC,
>>>> the generic pinctrl binding used a mask for this purpose.
>>>>
>>>> What if a future SoC variant adds more fields to the register? At that
>>>> point, you'd need to edit the driver anyway in order to define a new
>>>> DT
>>>> property to represent the new field. Perhaps instead of having an
>>>> explicit named property per field in the register, you want a simple
>>>> list of fields:
>>>>
>>>> samsung,pin-property-names = "func", "pud", "drv", "conpdn", "pudpdn";
>>>> samsung,pin-propert-masks = <0xf 0x30 0xc0 0x300 0xc00>;
>>>>
>>>> That would allow a completely arbitrary number of fields and layouts
>>>> to
>>>> be described.
>>>>
>>>> I wonder if for absolute generality you want a samsung,pin-stride
>>>> property to represent the difference in register address per pin. I
>>>> assume that's hard-coded as 4 right now.
>>>
>>> Hmm, considering so many different possible changes, maybe a more
>>> conservative solution would be better, like reducing the amount of
>>> information held in DT to bank type, e.g.
>>>
>>> 	samsung,bank-type = "exynos4";
>>>
>>> or maybe
>>>
>>> 	compatible = "samsung,exynos4-pin-bank*;
>>>
>>> and then define supported bank types in the driver. SoC-specific data
>>> would remain in DT, i.e. pctl-offset, pin-bank, pin-count,
>>> eint-offset, etc.
>> Yes, removing much of the data from DT and putting it into a tiny table
>> in the driver makes sense to me in this case.
> 
> A hybrid solution came to my mind, define bank types in device tree once 
> and then reference them in banks. Something like:
> 
> 	pinctrl-bank-types {
> 		bank_off: bank-off {
> 			samsung,func-width = <4>;
> 			samsung,pud-width = <2>;
> 			samsung,drv-width = <2>;
> 			samsung,conpdn-width = <2>;
> 			samsung,pudpdn-width = <2>;
> 		};
> 
> 		bank_alive: bank-alive {
> 			samsung,func-width = <4>;
> 			samsung,pud-width = <2>;
> 			samsung,drv-width = <2>;
> 		};
> 	};
> 
> 	/* ... */
> 
> 	pinctrl at 12345678 {
> 		/* ... */
> 		gpa0: gpa0 {
> 			/* ... */
> 			samsung,bank-type = <&bank_off>;
> 			/* ... */
> 		};
> 		/* ... */
> 	};
> 
> This would add the possibility to define new banks types quickly, but would 
> not add too much overhead.
> 
> What do you think?

That does solve the issue of parsing those same values over and over,
but at the cost of making the binding a lot more conceptually complex.

However, it doesn't solve any of the extensibility issues I raised such
as whether pos+size or mask would be a better representation, what about
if the fields end up being in different (separate) registers on newer
SoCs, etc.

I forget, do you actually have multiple different SoCs right now (or in
the near future where the HW design is known now for certain even if the
chip isn't available) that have different values for all these *-width
properties and hence can be represented just using this binding and
without altering the driver at all? If so, I suppose the original
binding is at least useful (although I would certainly still request to
use *-mask instead of *-width properties).
