From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Jan 2017 13:01:53 +0000
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <1485087662.1518.1.camel@crowfest.net>
References: <1485072424.14066.2.camel@crowfest.net>
 <1485075528.14345.1.camel@crowfest.net>
 <CAKv+Gu8LU3QjrUa6wMJF3WBNrhx34Pi_0ZUQVfrZy7w7y7237w@mail.gmail.com>
 <22169925.OhJ0QcnbHM@localhost> <1485087662.1518.1.camel@crowfest.net>
Message-ID: <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 22 Jan 2017, at 12:21, Michael Zoran <mzoran@crowfest.net> wrote:
> 
>> On Sun, 2017-01-22 at 12:46 +0100, Alexander Stein wrote:
>>>  On Sunday, January 22, 2017, 9:09:37 AM CET Ard Biesheuvel wrote:
>>> On 22 January 2017 at 08:58, Michael Zoran <mzoran@crowfest.net>
>>> wrote:
>>>> On Sun, 2017-01-22 at 09:52 +0100, Alexander Stein wrote:
>>>>> Hi Michael,
>>>>> 
>>>>> On Sunday, January 22, 2017, 12:07:04 AM CET Michael Zoran
>>>>> wrote:
>>>>>> I'm not sure if this if the correct place to be asking
>>>>>> this.   The
>>>>>> RPI
>>>>>> 3 running ARM64 is slowly reaching the point of being about
>>>>>> to
>>>>>> seriously run a 32 bit vender OS like Raspbian.  When running
>>>>>> Raspbian,
>>>>>> I'm seeing a very large number(thousands) of kernel log
>>>>>> messages
>>>>>> about
>>>>>> deprecated instructions especially setend and barrier
>>>>>> instuctions.
>>>>>> This can be very annoying and is completely filling the
>>>>>> kernel log.
>>>>>> 
>>>>>> I'm considering submitting a patch to add a Kconfig option to
>>>>>> disable
>>>>>> these warnings with the default being to keep the warnings
>>>>>> enabled.  I
>>>>>> was wondering if such a patch could be seriously considered.
>>>>> 
>>>>> Could you please provide an example of those warning an what is
>>>>> trigging
>>>>> those?
>>>>> 
>>>>> Thanks and best regards,
>>>>> Alexander
>>>> 
>>>> Sure, here is a snipped from dmesg.  I think this is happening
>>>> because
>>>> the entire Raspbian OS is compiled with a custom gcc compiler
>>>> that is
>>>> targeting arm6+VFP.
>>>> 
>>>> I can double check, but I think the instructions are being
>>>> emulated in
>>>> hardware so they are just filling the log and slowing things
>>>> down.
>>>> 
>>>> [10685.558480] cp15barrier_handler: 197896 callbacks suppressed
>>>> [10685.558487] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf707fe9c
>>>> [10685.558504] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf7015944
>>>> [10685.558511] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf7012494
>>>> [10685.558518] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf70159b4
>>>> [10685.558527] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf7011478
>>>> [10685.558533] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf70114e8
>>>> [10685.558540] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf7015944
>>>> [10685.558547] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf7012494
>>>> [10685.558553] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf70159b4
>>>> [10685.558560] "Xorg" (656) uses deprecated CP15 Barrier
>>>> instruction at
>>>> 0xf7011478
>>>> [10685.559179] compat_setend_handler: 1078 callbacks suppressed
>>>> [10685.559188] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a66f4
>>>> [10685.559196] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a6bd8
>>>> [10685.559209] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a66f4
>>>> [10685.559216] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a6bd8
>>>> [10685.559231] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a66f4
>>>> [10685.559237] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a6bd8
>>>> [10685.559246] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a66f4
>>>> [10685.559253] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a6bd8
>>>> [10685.559269] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a66f4
>>>> [10685.559276] "systemd-journal" (138) uses deprecated setend
>>>> instruction at 0xf76a6bd8
>>> 
>>> You can disable the emulation by doing
>>> 
>>> echo 2 >/proc/sys/abi/setend
>>> echo 2 >/proc/sys/abi/cp15_barrier
>> 
>> This reminds me of /proc/cpu/alignment to detect alignment problems
>> in your 
>> application. Although armv6+ can handle unaligned access in most (!)
>> cases you 
>> might want to trap thos cases. I would consider this a similar way.

Emulating unaligned access in the ARM kernel was a mistake: it even emulates unaligned accesses for instructions like ldm and ldrd, which require word alignment at the hardware level even in the latest v8 version of the architecture. In contrast, the v8 deprecation warnings are about enforcing compliance.

>> IMHO raspbian, still supporting raspberry pi 1 (armv6), should
>> silence those 
>> warnings.
>> 
>> Best regards,
>> Alexander
>> 
> 
> Thanks, but I see multiple ways this could be solved which is partially
> why I sent out the initial e-mail.
> 
> Here are just a few of the options.
> 1. Add a .config option to silence the warning.

It is perfectly reasonable for a kernel that targets architecture version 8 and later to warn by default about the use of instructions that were deprecated already in v7, especially given the runtime knob to control it.

> 2. Detect the binary type to detectermine if it should be silenced.

The controls are system wide, not per process. And I think the somewhat unconventional requirement to run a v6 compatible userland justifies adding a line to the boot script that simply disarms all the deprecation warnings.

Any political differences in the rpi project regarding support of the 64 bit kernel are not upstream's problem imo

> 3. #ifdef out the complaining code in downstream sources.
> 4. Have various distributions write to /proc/sys/abi/* at system boot.
> 
> The list is probably endless.
> 

No it is not. And presenting them like this suggests that they are equally controversial and intrusive, which is really not the case.

> And I think this is closely related to the other topic of setting the
> linux personality based on detection of the binary.
> 

I wonder why Mathematica cares about the personality. If it makes inferences about the architecture level to decide which instructions to use, it is clearly abusing the facility. Any clue?
