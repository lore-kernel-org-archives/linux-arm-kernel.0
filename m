From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 04 Jul 2016 10:24:52 +0200
Subject: clk: Per controller locks (prepare & enable)
In-Reply-To: <db64b7f6-2a01-679e-df01-c9545e577e20@osg.samsung.com>
References: <57737761.2020708@samsung.com>
 <db64b7f6-2a01-679e-df01-c9545e577e20@osg.samsung.com>
Message-ID: <577A1D54.9010203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2016 06:22 PM, Javier Martinez Canillas wrote:
>> Question:
>> What do you think about it? I know that talk is cheap and code looks
>> better but before starting the work I would like to hear some
>> comments/opinions/ideas.
>>
> 
> The problem is that the enable and prepare operations are propagated to
> the parents, so what the locks want to protecting is really a sub-tree
> of the clock tree. They currently protect the whole clock hierarchy to
> make sure that the changes in the clock tree are atomically.

Although there is a hierarchy between clocks from different controllers
but still these are all clocks controllers coming from one hardware
device (like SoC). At least on Exynos, I think there is no real
inter-device dependencies. The deadlock you mentioned (and which I want
to fix) is between:
1. clock in PMIC (the one needed by s3c_rtc_probe()),
2. clock for I2C in SoC (the one needed by regmap_write()),
3. and regmap lock:

What I want to say is that the relationship between clocks even when
crossing clock controller boundaries is still self-contained. It is
simple parent-child relationship so acquiring both
clock-controller-level locks is safe.

Current dead lock looks like, simplifying your code:
A:                            B:
lock(regmap)
                              lock(prepare)
lock(prepare) - wait
                              lock(regmap) - wait


When split locks per clock controller this would be:
A:                            B:
lock(regmap)
                              lock(s2mps11)
lock(i2c/exynos)
                              lock(regmap) - wait
do the transfer
unlock(i2c/exynos)
unlock(regmap)
                              lock(regmap) - acquired
                              lock(i2c/exynos)
                              do the transfer
                              unlock(i2c/exynos)
                              unlock(regmap)
                              unlock(s2mps11)

I still have to figure out how to properly protect the entire tree
hierarchy. Maybe the global prepare_lock should be used only for that -
for traversing the hierarchy.

> 
> So a clock per controller won't suffice since you can have a parent for
> a clock provided by a different controller and that won't be protected.
> 
> Another option is to have a prepare and enable locks per clock. Since
> the operations are always propagated in the same direction, I think is
> safe to do it.
> 
> But even in the case of a more fine-grained locking, I believe the
> mentioned deadlocks can still happen. For example in 10ff4c5239a1 the
> issue was that the s2mps11 PMIC has both regulators and clocks that are
> controlled via I2C so the regulator and clocks drivers shares the same
> I2C regmap.
> 
> What happened was something like this:
> 
>          CPU0                                   CPU1
>          ----                                   ----
>   regulator_set_voltage()                s3c_rtc_probe()
>   regmap_write()                         clk_prepare()
>   /* regmap->lock was aquired */         /* prepare_lock was aquired */
>   regmap_i2c_write()                     s2mps11_clk_prepare()
>   i2c_transfer()                         regmap_write()
>   exynos5_i2c_xfer()                     /* deadlock due regmap->lock */
>   clk_prepare_enable()
>   clk_prepare_lock()
>   /* prepare_lock was aquired */
> 
> So if for example a per clock lock is used, the deadlock can still happen
> if both the I2C clock and S3C RTC source clock share the same parent in a
> part of the hierarchy. But as you said this is less likely in practice so
> probably is not an issue.

I think these clocks do not share the parent.

Best regards,
Krzysztof
