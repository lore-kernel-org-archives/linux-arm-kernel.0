From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 5 Feb 2016 15:54:37 -0800
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <CADyBb7sP=d+BWOdmNEAs38yRcmXVjYsFX=XNffNpGqfybpxTfQ@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
 <56B24642.8090105@codeaurora.org>
 <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
 <56B24AB5.3070001@codeaurora.org>
 <CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
 <56B2DEE4.7060901@roeck-us.net>
 <CADyBb7unAHEOMfruWS82RkHK6uwPAWCxUx9jqzSkiHU4LHDSeA@mail.gmail.com>
 <56B4B4E2.40105@roeck-us.net>
 <CADyBb7sP=d+BWOdmNEAs38yRcmXVjYsFX=XNffNpGqfybpxTfQ@mail.gmail.com>
Message-ID: <56B5363D.20200@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2016 10:21 AM, Fu Wei wrote:
> On 5 February 2016 at 22:42, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 02/05/2016 01:51 AM, Fu Wei wrote:
>>>
>>> Hi Guenter,
>>>
>>> On 4 February 2016 at 13:17, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 02/03/2016 03:00 PM, Fu Wei wrote:
>>>>>
>>>>>
>>>>> On 4 February 2016 at 02:45, Timur Tabi <timur@codeaurora.org> wrote:
>>>>>>
>>>>>>
>>>>>> Fu Wei wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> As you know I have made the pre-timeout support patch, If people like
>>>>>>> it, i am happy to go on upstream it separately.
>>>>>>>
>>>>>>> If we want to use pre-timeout here, user only can use get_pretimeout
>>>>>>> and disable panic by setting pretimeout to 0
>>>>>>> but user can not really set pretimeout, because "pre-timeout  ==
>>>>>>> timeout / 2 (always)".
>>>>>>> if user want to change pretimeout, he/she has to set_time instead.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Ok, I think patches 4 and 5 should be combined, and I think the Kconfig
>>>>>> entry should be removed and just use panic_enabled.
>>>>
>>>>
>>>>
>>>> Agreed.
>>>
>>>
>>> np, will do
>>>
>>>>>
>>>>>
>>>>> NP, will update this patchset like that ,  thanks :-)
>>>>>
>>>>
>>>> Also, if panic is enabled, the timeout needs to be adjusted accordingly
>>>> (to only panic after the entire timeout period has expired, not after
>>>> half of it). We can not panic the system after timeout / 2.
>>>
>>>
>>> OK, my thought is
>>>
>>> if panic is enabled :
>>> |--------WOR-------WS0--------WOR-------WS1
>>> |------timeout------(panic)------timeout-----reset
>>>
>>> if panic is disabled .
>>> |--------WOR-------WS0--------WOR-------WS1
>>> |---------------------timeout---------------------reset
>>>
>>>    panic_enabled only can be configured when module is loaded by module
>>> parameter
>>>
>>> But user should know that max_timeout(panic_enable) =
>>> max_timeout(panic_disable) / 2
>>>
>>
>> That means you'll have to update max_timeout accordingly.
>
> panic_enabled only can be configured when module is loaded, so we
> don't need to update it.
>
> max_timeout will only be set up in the init stage.
>
> Does it make sense ? :-)
>
Not sure I understand your problem or question.

max_timeout will have to reflect the correct maximum timeout, under
all circumstances. It will have to be set to the correct value before
the watchdog driver is registered.

Guenter
