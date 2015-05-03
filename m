From: andrew@ncrmnt.org (Andrew)
Date: Sun, 03 May 2015 13:18:22 +0300
Subject: Fwd: Re: [PATCH 2/2] ARM: mvebu: dts: Add dts file for DLink
 DNS-327L
In-Reply-To: <55351898.60604@free-electrons.com>
References: <b6534b962d2cf9d21cb72d43f19a6574@mail.ncrmnt.org>
 <552A6209.9040903@gmail.com>
 <cd7445f789f1082f464d464f77807f12@mail.ncrmnt.org>
 <20150412145857.GA14038@lunn.ch>
 <b172d775afa24cea69a9490f531c6b37@mail.ncrmnt.org>
 <20150412194735.GA27921@lunn.ch> <552BCFAA.2020109@free-electrons.com>
 <1ec8906f00468ca5a9fa227f8c83fe69@mail.ncrmnt.org>
 <55351569.7000307@free-electrons.com>
 <d28764ea5d0d5f4c2e5d3e9ca1d7217a@mail.ncrmnt.org>
 <55351898.60604@free-electrons.com>
Message-ID: <4e7e91562aac6a260885bf2d12174060@mail.ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory CLEMENT ????? 20.04.2015 18:17:
> On 20/04/2015 17:15, Andrew wrote:
>> Gregory CLEMENT ????? 20.04.2015 18:04:
>>> Hi Andrew,
>>> 
>>> On 13/04/2015 16:32, Andrew wrote:
>>>> Gregory CLEMENT ????? 13.04.2015 17:16:
>>>>> Hi Andrew(s),
>>>>> 
>>>>> On 12/04/2015 21:47, Andrew Lunn wrote:
>>>>>> On Sun, Apr 12, 2015 at 06:41:31PM +0300, Andrew wrote:
>>>>>>> Andrew Lunn ?????????? 12.04.2015 17:58:
>>>>>>>>> Okay, got it.
>>>>>>>>> I'll file a bug about this issue to the the bugzilla. However
>>>>>>>>> something
>>>>>>>>> tells me it might not be cpuidle, but D-link. This one's sounds
>>>>>>>>> nasty
>>>>>>>>> and it has been around since 3.16.x. How could it go unnoticed?
>>>>>>>>> Unfortunately I have no other armada-370 hardware to test it.
>>>>>>>> 
>>>>>>>> Hi Andrew
>>>>>>>> 
>>>>>>>> A few of us here do have hardware to test with. Please give a
>>>>>>>> detailed
>>>>>>>> description of how you reproduce the issue, and your kernel
>>>>>>>> configuration, if different from mvebu_v7_defconfig, or
>>>>>>>> multi_v7_defconfig.
>>>>>>>> 
>>>>>>>> 	Thanks
>>>>>>>> 		Andrew
>>>>>>> 
>>>>>>> 
>>>>>>> arch/arm/configs/mvebu_v7_defconfig has
>>>>>>> CONFIG_ARM_MVEBU_V7_CPUIDLE=y,
>>>>>>> so it should be sufficient to reproduce the issue. I first
>>>>>>> encountered
>>>>>>> this issue using that very config and observed it on 2 DNS-327L
>>>>>>> boxes
>>>>>>> I
>>>>>>> own.
>>>>>>> 
>>>>>>> All I have to do to trigger the bug - enable cpuidle driver and 
>>>>>>> let
>>>>>>> the box
>>>>>>> sit for some 4-12 hours, till it hard-freezes. If wdt is enabled 
>>>>>>> -
>>>>>>> wdt reboot
>>>>>>> will happen.
>>>>>> 
>>>>>> That simple! Well i've got a 370RD which has been sat mostly idle
>>>>>> for
>>>>>> weeks, using the mvebu_v7_defconfig, with a few addition things
>>>>>> turned
>>>>>> on for testing the Ethernet switch on the board. I've not had that
>>>>>> lockup.
>>>>>> 
>>>>>> One thing you can try to narrow it down is the disable the second
>>>>>> idle
>>>>>> mode. Take a look at armada370_idle_driver. Keep the
>>>>>> ARM_CPUIDLE_WFI_STATE but disable the "Deep Idle" state.
>>>>> 
>>>>> Actually you don't have to modify the kernel you can setup the CPU
>>>>> idle
>>>>> level
>>>>> you want at runtime:
>>>>> 
>>>>> echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/state1/disable
>>>>> 
>>>>> will disable the state1. By doing this on Armada 370 then you
>>>>> will only use the WFI state.
>>>>> 
>>>>> Do you still have this issue on v4.0-rc7?
>>>> 
>>>> Yep, I can confirm having this issue on 4.0-rc7. I will only be able
>>>> to
>>>> test if
>>>> disabling state1 fixes it the next weekend.
>>> 
>>> Did you manage to do some test this week-end?
>>> 
>>> Thanks,
>>> 
>>> Gregory
>>> 
>>> 
>>>> 
>>>>> 
>>>>> Thanks,
>>>>> 
>>>>> Gregory
>>>>> 
>>>>> 
>>>>> 
>>>>>> 
>>>>>>       Andrew
>>>>>> 
>>>> 
>> 
>> Sorry, I've been away for the weekend but managed to take the
> 
> No problem
> 
>> hardware home on my way back. I'll rig it for a long test today
>> in the evening. Expect some test results somewhere around Wednesday.
>> (Guess it doesn't count unless it's stable for 24+ hours).
> 
> 
> great! thanks to take care of it.
> 
> Gregory
>> 

Sorry for the long delay with testing, but here come the results.
I've rebased everything to 4.1-rc1

1. WFI + DeepIdle => freeze after approx:
   * 1 hours and 30 minutes, first test
   * 3 hours and 40 minutes, second test
2. WFI only (DeepIdle disabled via sysfs) => Still alive after 13 hours 
and counting

The proper patchset will follow as soon as I figure out what change 
broke
dns320l-daemon (The utility that speaks to weltrend mcu on ttyS1)
It was working on 3.18.6, on 3.19 and up - it writes data to the port 
(and mcu acks it),
but can't read any responses.

Same thing happens to the python (pyserial inside) implementation of the 
fan-daemon:
https://github.com/martignlo/DNS-320L

-- 
Regards,
Andrew
