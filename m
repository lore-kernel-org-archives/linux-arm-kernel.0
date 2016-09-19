From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 19 Sep 2016 13:09:10 +0530
Subject: [PATCH v6 0/8] power: add power sequence library
In-Reply-To: <CAPDyKFp0w0mBGNgu6uk7UevUka_ha6MvaVyOzXjCg3S8kdF7tg@mail.gmail.com>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <b1848eb2-9298-9089-ee4d-5356998c6c08@linaro.org>
 <20160824085335.GB27233@shlinux2> <20160829111045.GB3736@b29397-desktop>
 <3a45793f-18d9-0688-d2ab-ef79432c473c@linaro.org>
 <20160831095220.GA11938@b29397-desktop>
 <fd94340b-1c1d-2307-7e57-5b05f1655d2c@linaro.org>
 <20160902011046.GB11262@shlinux2>
 <eb032ff2-dac4-5efe-dda0-96404f290aa8@linaro.org>
 <CAPDyKFp0w0mBGNgu6uk7UevUka_ha6MvaVyOzXjCg3S8kdF7tg@mail.gmail.com>
Message-ID: <ecbc3c0d-4ce7-758d-7f7d-4b3f3003c1ac@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 09 September 2016 02:17 PM, Ulf Hansson wrote:
> [...]
>
>>>>> We had an agreement that keep mmc's pwrseq framework unchanging.
>>>>> Unless Ulf and rob both agree to change.
>>>> Why 2 separate approach for same problem ?
>>>> And I see this as possible duplication of code/functionality :)
>>> How the new kernel compatibles old dts? If we do not need to
>>> consider this problem, the mmc can try to use power sequence library
>>> too in future.
>>
>> I think we should attempt to get both MMC and USB power seq
>> come on one agreement, so that it can be reused.
> That would be nice. Although, to do that you would have to allow some
> DT bindings to be deprecated in the new generic power seq bindings, as
> otherwise you would break existing DTBs.
>
> I guess that is what Rob was objecting to!?

yeah, thats right.

So lets adopt similar implementation for USB as well instead of
library, but keeping MMC untouched as of now.

What I am trying to propose here is,

Lets have power-sequence framework (similar to V1 of this series),
with,

pwrseq: Core framework for power sequence.
pwrseq_generic/simple: for all generic control, like reset and clock
pwrseq_emmc: probably duplication of existing code - the idea
                           here is, all future code should be using this new
                           binding, so that we can deprecate the 
drivers/mmc/core/pwrseq
pwrseq_arche: The usecase which I am dealing with today, which is more
                          complex in nature.

Then the respective drivers can add their drivers (if needed) based on
complexity.

comments ??

>> MMC Power Seq :
>>   It is based on platform_device/platform_driver approach,
> We recently converted MMC to this. It's has a clear benefit as you can
> rely on the behaviour from the driver core and PM core. So, it simply
> avoids duplication of code.

Agreed.

>> USB Power seq :
>>   We are trying to propose library approach, with compatible string match.
>>
>> We should try to have one approach.
>>>
>>>>>>    - Lets also add suspend/resume callback to struct pwrseq
>>>>>>
>>>>> Why suspend/resume can't do at related driver's suspend/resume API?
>>>> Nope...
>>>> The pwrseq library would have taken ownership of resources, so
>>>> related driver cannot suspend the device. Again it is architecture
>>>> specific, but we should have provision to handle this.
>>>>
>>>> The system I am dealing with today, does need suspend/resume
>>>> callback. To be precise, suspend is close to off state for some devices
>>>> or
>>>> they could enter standby or different low power state, but to do that,
>>>> we need same resource as used for ON/OFF functionality.
>>>>
>>> Ok, I will have API for suspend/resume. You can implement it at your own
>>> library or generic one.
> As stated, using a platform device + driver would simplify this, as
> you wouldn't need an API but only a driver. I guess.

Exactly.

Thanks,
Vaibhav
