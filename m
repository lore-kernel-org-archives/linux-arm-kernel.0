From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 18 Apr 2016 15:18:19 -0400
Subject: [PATCH] i2c: exynos5: Fix possible ABBA deadlock by keeping I2C
 clock prepared
In-Reply-To: <5714E12A.8090100@osg.samsung.com>
References: <1460757887-18128-1-git-send-email-javier@osg.samsung.com>
 <571491AE.30908@samsung.com> <5714E12A.8090100@osg.samsung.com>
Message-ID: <571532FB.9050302@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding clk maintainers/list to cc]

On 04/18/2016 09:29 AM, Javier Martinez Canillas wrote:
> Hello Marek,
> 
> On 04/18/2016 03:50 AM, Marek Szyprowski wrote:
>> Hello,
>>
>> On 2016-04-16 00:04, Javier Martinez Canillas wrote:
>>> The exynos5 I2C controller driver always prepares and enables a clock
>>> before using it and then disables unprepares it when the clock is not
>>> used anymore.
>>>
>>> But this can cause a possible ABBA deadlock in some scenarios since a
>>> driver that uses regmap to access its I2C registers, will first grab
>>> the regmap lock and then the I2C xfer function will grab the prepare
>>> lock when preparing the I2C clock. But since the clock driver also
>>> uses regmap for I2C accesses, preparing a clock will first grab the
>>> prepare lock and then the regmap lock when using the regmap API.
>>>
>>> An example of this happens on the Exynos5422 Odroid XU board where a
>>> s2mps11 PMIC is used and both the s2mps11 regulators and clk drivers
>>> share the same I2C regmap.
>>>
>>> The possible deadlock is reported by the kernel lockdep:
>>>
>>>    Possible unsafe locking scenario:
>>>
>>>          CPU0                    CPU1
>>>          ----                    ----
>>>     lock(sec_core:428:(regmap)->lock);
>>>                                  lock(prepare_lock);
>>>                                  lock(sec_core:428:(regmap)->lock);
>>>     lock(prepare_lock);
>>>
>>>    *** DEADLOCK ***
>>>
>>> Fix this by only preparing the clock on probe and {en,dis}able in the
>>> rest of the driver.
>>>
>>> This patch is similar to commit 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA
>>> deadlock by keeping clock prepared") that fixes the same bug in other
>>> driver for an I2C controller found in Samsung SoCs.
>>
>> I'm sorry, but this is not the right approach imho. It is just a workaround
>> applied to specific driver, it also duplicates incorrect clock usage
>> pattern (there is really no point keeping clock prepared all the time).
>>
>> IMHO this ABBA deadlock should be really fixed in clocks core (probably
>> by removing global prepare mutex and replacing it with per clock
>> controller mutexes). Without a proper patch this issue will hit us again
>> with other i2c controllers or other drivers as well.
>>
> 
> Agreed, Krzysztof mentioned the same before. I'll take a look to the global
> mutex to see how I can make it more fine grained to prevent these deadlocks.
>  

I've been looking at the Common Clk Framework and it seems that removing the
global prepare_lock mutex and making more fine grained (i.e: per controller)
is not trivial since clocks prepare operations are propagated to the parents
so the lock is not just used to have mutual exclusion of the clocks in the
same controller but is to prevent concurrent access to the whole hierarchy.

Also, I wonder why the clock usage pattern of leaving the clock prepared and
just {en,dis}able the clock at runtime is that bad since many drivers do it?

In fact, most I2C controllers drivers manage their clocks that way and that
is why I thought that this patch had merits on its own and the fact that the
deadlock was fixed was just a nice side effect of $SUBJECT.

Finally, Krzysztof was able to hit the deadlock so this is not just about a
theoretical deadlock but an important bug that should be fixed and $SUBJECT
is a possible fix until the CCF gets rids of the global mutex IMHO.

Stephen, Mike:

Some context has already been removed in the thread (including the patch
diff) so you can find the original patch here if you need more context:

https://lkml.org/lkml/2016/4/15/900

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
