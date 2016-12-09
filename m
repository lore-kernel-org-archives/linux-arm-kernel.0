From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 9 Dec 2016 17:44:53 -0600
Subject: [PATCH] usb: dwc3: omap: remove devm_request_threaded_irq
In-Reply-To: <20161209233728.GP4920@atomide.com>
References: <20161209205508.6456-1-grygorii.strashko@ti.com>
 <20161209215958.GN4920@atomide.com>
 <db75608b-f92c-6bfa-80a9-a3ab3adf7c23@ti.com>
 <20161209230457.GO4920@atomide.com>
 <e394c44c-3ae3-b0ac-2b02-a886ca2510bd@ti.com>
 <20161209233728.GP4920@atomide.com>
Message-ID: <32eba9f6-c3c7-c56a-88c4-cf0fed569aba@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/09/2016 05:37 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [161209 15:32]:
>>
>>
>> On 12/09/2016 05:04 PM, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko@ti.com> [161209 14:46]:
>>>>
>>>>
>>>> On 12/09/2016 03:59 PM, Tony Lindgren wrote:
>>>>> * Grygorii Strashko <grygorii.strashko@ti.com> [161209 12:55]:
>>>>>> Switch back from devm_request_threaded_irq() to request_threaded_irq() to
>>>>>> avoid races between interrupt handler execution and PM runtime in error
>>>>>> handling code path in probe and in dwc3_omap_remove():
>>>>>
>>>>> Can't you just call disable_irq() on the exit path instead of removing
>>>>> devm?
>>>>>
>>>>
>>>> I can. But what will be the benefit from using devm then?
>>>
>>> Hmm good point. Probably the least number of code would be to just
>>> do NOAUTOEN before devm_request_irq(), then only do enable_irq()
>>> just before returning from the probe. After all, we don't really
>>> want the irq running until the probe is done.
>>>
>>> I think that would leave out the extra handling from the error
>>> path?
>>>
>>
>> Good question here is - do we need this irq to be enabled for sub-device
>> probing from of_platform_populate()? ;)
>
> No!

Ok, then it should work this way.

-- 
regards,
-grygorii
