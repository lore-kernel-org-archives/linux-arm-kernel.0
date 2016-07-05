From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 05 Jul 2016 08:33:50 +0200
Subject: clk: Per controller locks (prepare & enable)
In-Reply-To: <98eb9718-1267-dafe-2e36-323f4976ece0@osg.samsung.com>
References: <57737761.2020708@samsung.com>
 <db64b7f6-2a01-679e-df01-c9545e577e20@osg.samsung.com>
 <577A1D54.9010203@samsung.com>
 <98eb9718-1267-dafe-2e36-323f4976ece0@osg.samsung.com>
Message-ID: <577B54CE.90004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2016 05:15 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 07/04/2016 04:24 AM, Krzysztof Kozlowski wrote:
>> On 06/30/2016 06:22 PM, Javier Martinez Canillas wrote:
>>>> Question:
>>>> What do you think about it? I know that talk is cheap and code looks
>>>> better but before starting the work I would like to hear some
>>>> comments/opinions/ideas.
>>>>
>>>
>>> The problem is that the enable and prepare operations are propagated to
>>> the parents, so what the locks want to protecting is really a sub-tree
>>> of the clock tree. They currently protect the whole clock hierarchy to
>>> make sure that the changes in the clock tree are atomically.
>>
>> Although there is a hierarchy between clocks from different controllers
>> but still these are all clocks controllers coming from one hardware
>> device (like SoC). At least on Exynos, I think there is no real
>> inter-device dependencies. The deadlock you mentioned (and which I want
>> to fix) is between:
> 
> Yes, my point was that this may not be the case in all systems. IOW the
> framework should be generic enough to allow hierarchies where a parent
> clock is a clock provided by a different controller from a different HW.

Is there such configuration?

> 
>> 1. clock in PMIC (the one needed by s3c_rtc_probe()),
>> 2. clock for I2C in SoC (the one needed by regmap_write()),
>> 3. and regmap lock:
>>
>> What I want to say is that the relationship between clocks even when
>> crossing clock controller boundaries is still self-contained. It is
>> simple parent-child relationship so acquiring both
>> clock-controller-level locks is safe.
>>
> 
> Is safe if the clock controllers are always aquired in the same order but
> I'm not sure if that will always be the case. I.e: you have controllers A
> and B that have clocks A{1,2} and B{1,2} respectively. So you could have
> something like this:
> 
> A1 with parent B1
> B2 with parent A2

Again, is there such configuration? We thought here about it and at
least it is not known to us. Of course this is not a proof that such
configuration does not exist...

> 
> That can cause a deadlock since in the first case, the controller A will be
> aquired and then the controller B but in the other case, the opposite order
> will be attempted.

Yes.

> 
>> Current dead lock looks like, simplifying your code:
>> A:                            B:
>> lock(regmap)
>>                               lock(prepare)
>> lock(prepare) - wait
>>                               lock(regmap) - wait
>>
>>
>> When split locks per clock controller this would be:
>> A:                            B:
>> lock(regmap)
>>                               lock(s2mps11)
>> lock(i2c/exynos)
>>                               lock(regmap) - wait
>> do the transfer
>> unlock(i2c/exynos)
>> unlock(regmap)
>>                               lock(regmap) - acquired
>>                               lock(i2c/exynos)
>>                               do the transfer
>>                               unlock(i2c/exynos)
>>                               unlock(regmap)
>>                               unlock(s2mps11)
>>
> 
> Yes, splitting the lock per controller will fix the possible deadlock in
> this case but I think we need an approach that is safe for all possible
> scenarios. Otherwise it will work more by coincidence than due a design.

This is not a coincidence. This design is meant to fix this deadlock.
Not by coincidence. By design.

You are talking about theoretical different configurations... without
even real bug reports. I am providing an idea to fix a real deadlock and
your argument is that it might not fix other (non-reported) deadlocks.
These other deadlocks happen now as well probably...

Best regards,
Krzysztof
