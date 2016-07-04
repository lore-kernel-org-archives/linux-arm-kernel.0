From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 4 Jul 2016 11:15:22 -0400
Subject: clk: Per controller locks (prepare & enable)
In-Reply-To: <577A1D54.9010203@samsung.com>
References: <57737761.2020708@samsung.com>
 <db64b7f6-2a01-679e-df01-c9545e577e20@osg.samsung.com>
 <577A1D54.9010203@samsung.com>
Message-ID: <98eb9718-1267-dafe-2e36-323f4976ece0@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 07/04/2016 04:24 AM, Krzysztof Kozlowski wrote:
> On 06/30/2016 06:22 PM, Javier Martinez Canillas wrote:
>>> Question:
>>> What do you think about it? I know that talk is cheap and code looks
>>> better but before starting the work I would like to hear some
>>> comments/opinions/ideas.
>>>
>>
>> The problem is that the enable and prepare operations are propagated to
>> the parents, so what the locks want to protecting is really a sub-tree
>> of the clock tree. They currently protect the whole clock hierarchy to
>> make sure that the changes in the clock tree are atomically.
> 
> Although there is a hierarchy between clocks from different controllers
> but still these are all clocks controllers coming from one hardware
> device (like SoC). At least on Exynos, I think there is no real
> inter-device dependencies. The deadlock you mentioned (and which I want
> to fix) is between:

Yes, my point was that this may not be the case in all systems. IOW the
framework should be generic enough to allow hierarchies where a parent
clock is a clock provided by a different controller from a different HW.

> 1. clock in PMIC (the one needed by s3c_rtc_probe()),
> 2. clock for I2C in SoC (the one needed by regmap_write()),
> 3. and regmap lock:
> 
> What I want to say is that the relationship between clocks even when
> crossing clock controller boundaries is still self-contained. It is
> simple parent-child relationship so acquiring both
> clock-controller-level locks is safe.
>

Is safe if the clock controllers are always aquired in the same order but
I'm not sure if that will always be the case. I.e: you have controllers A
and B that have clocks A{1,2} and B{1,2} respectively. So you could have
something like this:

A1 with parent B1
B2 with parent A2

That can cause a deadlock since in the first case, the controller A will be
aquired and then the controller B but in the other case, the opposite order
will be attempted.

> Current dead lock looks like, simplifying your code:
> A:                            B:
> lock(regmap)
>                               lock(prepare)
> lock(prepare) - wait
>                               lock(regmap) - wait
> 
> 
> When split locks per clock controller this would be:
> A:                            B:
> lock(regmap)
>                               lock(s2mps11)
> lock(i2c/exynos)
>                               lock(regmap) - wait
> do the transfer
> unlock(i2c/exynos)
> unlock(regmap)
>                               lock(regmap) - acquired
>                               lock(i2c/exynos)
>                               do the transfer
>                               unlock(i2c/exynos)
>                               unlock(regmap)
>                               unlock(s2mps11)
>

Yes, splitting the lock per controller will fix the possible deadlock in
this case but I think we need an approach that is safe for all possible
scenarios. Otherwise it will work more by coincidence than due a design.

> I still have to figure out how to properly protect the entire tree
> hierarchy. Maybe the global prepare_lock should be used only for that -
> for traversing the hierarchy.
>

Other thing to figure out is how to determine when a parent belongs to a
different controller to get its lock in clk_{prepare,enable}(), at least
part of the hierarchy has to be traversed on prepare/enable to propagate
the operations to the parents clocks.

>>
>> So a clock per controller won't suffice since you can have a parent for
>> a clock provided by a different controller and that won't be protected.
>>
>> Another option is to have a prepare and enable locks per clock. Since
>> the operations are always propagated in the same direction, I think is
>> safe to do it.
>>
>> But even in the case of a more fine-grained locking, I believe the
>> mentioned deadlocks can still happen. For example in 10ff4c5239a1 the
>> issue was that the s2mps11 PMIC has both regulators and clocks that are
>> controlled via I2C so the regulator and clocks drivers shares the same
>> I2C regmap.
>>
>> What happened was something like this:
>>
>>          CPU0                                   CPU1
>>          ----                                   ----
>>   regulator_set_voltage()                s3c_rtc_probe()
>>   regmap_write()                         clk_prepare()
>>   /* regmap->lock was aquired */         /* prepare_lock was aquired */
>>   regmap_i2c_write()                     s2mps11_clk_prepare()
>>   i2c_transfer()                         regmap_write()
>>   exynos5_i2c_xfer()                     /* deadlock due regmap->lock */
>>   clk_prepare_enable()
>>   clk_prepare_lock()
>>   /* prepare_lock was aquired */
>>
>> So if for example a per clock lock is used, the deadlock can still happen
>> if both the I2C clock and S3C RTC source clock share the same parent in a
>> part of the hierarchy. But as you said this is less likely in practice so
>> probably is not an issue.
> 
> I think these clocks do not share the parent.
>

Yes, I meant the issue of having a shared parent in general and not in this
particular case that no parent is shared. Sorry for the ambiguous sentence.

> Best regards,
> Krzysztof
>

So in summary, my point is that we should first define what these locks are
protecting. The good practice in the kernel is to protect data structures
instead of code, but the prepare and enable locks are not doing the former.

My understanding is that what the locks are protecting is a sub-tree of the
hierarchy but there isn't a data structure to represent a sub-tree so global
locks are used to protect the whole tree instead.

Moving the lock to a per controller/provider seems like an arbitrary thing
to me since what's important AFAIU is the clock hierarchy and not from where
these clocks come from.

But I'm very far from being a lock expert so maybe my assumptions are wrong,
I'll let Stephen and Mike to comment on this.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
