From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 4 May 2014 14:50:57 +0200
Subject: [PATCH 3/4] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <534D6106.1070005@arm.com>
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
 <1397072736-10793-4-git-send-email-matthias.bgg@gmail.com>
 <CAL_JsqJowqV2bsxE2VeYXQQSj4_L_KcH+C_dD=ZUvC=1crN4dA@mail.gmail.com>
 <87ha6136dz.fsf@approximate.cambridge.arm.com>
 <CABuKBeKLexBsTwF-nX15AYfLNA9bFDRm2XyeLpwQg9+3m6Xf=w@mail.gmail.com>
 <5347B942.2040703@arm.com>
 <CABuKBeLLC2xApUMpT=u5nq4kxp9f4AotQCdk0nRU=aREM6Bwkg@mail.gmail.com>
 <534D6106.1070005@arm.com>
Message-ID: <CABuKBeKEPcwwQNDegUPybcM54utUfk+UmkUT2+6pfLU+7gehYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-15 18:40 GMT+02:00 Marc Zyngier <marc.zyngier@arm.com>:
> On 15/04/14 17:09, Matthias Brugger wrote:
>> 2014-04-11 11:43 GMT+02:00 Marc Zyngier <marc.zyngier@arm.com>:
>>> On 11/04/14 10:11, Matthias Brugger wrote:
>>>> 2014-04-10 11:01 GMT+02:00 Marc Zyngier <marc.zyngier@arm.com>:
>>>>> A couple of things on top of Rob's comments:
>>>>>
>>>>> On Wed, Apr 09 2014 at 10:50:33 pm BST, Rob Herring <robherring2@gmail.com> wrote:
>>>>>> On Wed, Apr 9, 2014 at 2:45 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>>>>>> This adds a generic devicetree board file and a dtsi for boards
>>>>>>> based on the MT6589 SoCs from Mediatek.
>>>>>>>
>>>>>>> Apart from the generic parts (gic, clocks) the only component
>>>>>>> currently supported are the timers.
>>>>>>>
>>>>>>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>>>>
>>>>> [...]
>>>>>
>>>>>>> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
>>>>>>> new file mode 100644
>>>>>>> index 0000000..c0139ca
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm/mach-mediatek/Kconfig
>>>>>>> @@ -0,0 +1,14 @@
>>>>>>> +config ARCH_MEDIATEK
>>>>>>> +       bool "Mediatek MT6589 SoC" if ARCH_MULTI_V7
>>>>>>> +       select ARCH_REQUIRE_GPIOLIB
>>>>>>
>>>>>> Then where is your GPIO driver?
>>>>>>
>>>>>>> +       select ARM_GIC
>>>>>>> +       select CACHE_L2X0
>>>>>>> +       select HAVE_ARM_TWD if LOCAL_TIMERS
>>>>>
>>>>> Hell no! ;-) ARM_ARCH_TIMER is the way (please also add the missing
>>>>> node).
>>>>
>>>> I considered this, but the timer wasn't able to get it's clock frequency:
>>>> "Architected timer frequency not available
>>>> Division by zero in kernel."
>>>
>>> This is because your bootloader/firmware is utterly broken, and doesn't
>>> set CNTFRQ (it must be set on all CPUs, from secure mode). As a
>>> *workaround*, you can set the timer frequency in the timer node, but
>>> that's just a hack, and will prevent virtual machines from running on
>>> such hardware.
>>
>> The last days I tried to get the ARM_ARCH_TIMER working, but I wasn't
>> able to do so.
>> I set the frequency in the DT node.
>> But reading CNTP_TVAL at the end of arch_timer_init, it always returns
>> the same value.
>> When reading CNTPCT at the same place, returns zero.
>> As far as I understand CNTPCT will be always incremented, am I right?
>>
>> Consequently, when calling mdelay in arch_timer_init the system hangs.
>>
>> So can it be, that the timers are not working due to a screwed up chip
>> design? Or do I miss something here?
>
> That would indicate that the clock that feeds into the timer is gated.
> Other SoC vendors have done the same thing. Do you have access to
> documentation describing the clock tree?
>
> Of course, a broken design is always possible, but let's not think of
> the worse just yet... ;-)

The clock tree documentation is really spare but I tried to made some
changes to the registers which controls the clock gates and the DCMs.
But with no luck.
So for me it looks like a broken design :(
It looks like we need the global timer from mediatek.

I will try to update the patch series with the comments given and send
a v2 the next days.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...



-- 
motzblog.wordpress.com
