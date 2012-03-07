From: robherring2@gmail.com (Rob Herring)
Date: Wed, 07 Mar 2012 13:54:44 -0600
Subject: [PATCH 6/6] ARM: at91: add Shutdown Controller (SHDWC) DT support
In-Reply-To: <201203071849.36867.arnd@arndb.de>
References: <20120302192844.GB21255@game.jcrosoft.org>
 <201203022024.19488.arnd@arndb.de> <20120307173828.GD17087@game.jcrosoft.org>
 <201203071849.36867.arnd@arndb.de>
Message-ID: <4F57BD04.5090002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2012 12:49 PM, Arnd Bergmann wrote:
> On Wednesday 07 March 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 20:24 Fri 02 Mar     , Arnd Bergmann wrote:
>>> On Friday 02 March 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>> +       }
>>>> +
>>>> +       if (of_device_is_compatible(np, "atmel,at91sam9x5-shdwc")) {
>>>> +               have_rtt = false;
>>>> +               have_rtc = true;
>>>> +       } else if (of_device_is_compatible(np, "atmel,at91sam9rl-shdwc")) {
>>>> +               have_rtt = true;
>>>> +               have_rtc = true;
>>>> +       } else {
>>>> +               have_rtt = true;
>>>> +               have_rtc = false;
>>>> +       }
>>>> +
>>>> +       if (have_rtc && of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
>>>> +                       mode |= AT91_SHDW_RTCWKEN;
>>>> +
>>>> +       if (have_rtt && of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
>>>> +                       mode |= AT91_SHDW_RTTWKEN;
>>>> +
>>>> +       at91_shdwc_write(AT91_SHDW_MR, wakeup_mode | mode);
>>>> +
>>>
>>> Hi Jean-Christophe,
>>>
>>> I don't understand why you check the specific part here. Isn't it enough to
>>> check the property when you already mandate that they can only be present
>>> on devices that support the specific wakeup?
>>>
>>> If there is a good explanation for that, maybe add a code comment why it's
>>> required.
>> some wake update source exist on few soc and we are not supposed to set the
>> bit otherwise
>>
> 
> I still don't understand: Doesn't the property already give the information?
> In general, you should try to encode these things in specific properties instead of
> checking the compatible property.
> 

Or vice-versa, the compatible properties distinguish things enough that
the property is not needed. If it is fixed in the SOC design, then you
should distinguish things with the compatible property.

Rob

> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
