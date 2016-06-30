From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 30 Jun 2016 12:22:28 -0400
Subject: clk: Per controller locks (prepare & enable)
In-Reply-To: <57737761.2020708@samsung.com>
References: <57737761.2020708@samsung.com>
Message-ID: <db64b7f6-2a01-679e-df01-c9545e577e20@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 06/29/2016 03:23 AM, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> Problems:
> 1. Deadlocks on prepare lock in following scenario:
>  - prepare_enable(some external clock through i2c)
>    - i2c transfer
>      - prepare_enable(i2c lock in SoC)
>        - deadlock
> See [1]. We implemented a workaround for this in few places like
> 10ff4c5239a1 ("i2c: exynos5: Fix possible ABBA deadlock by keeping I2C
> clock prepared") and 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA deadlock by
> keeping clock prepared")
> 
> The goal would be to remove also this workaround.
>
> 2. The global prepare and enable locks are over-used. I didn't test the
> congestion but intuition says that they could be improved.
> 
> 
> Solution:
> Make this locks per controller. This will directly solve problem #1
> because these are different controllers. Still in-controller deadlock
> could occur but we couldn't find a real case with it.
>

Yes, I also tried first to remove the global locks but then noticed that
changing the global lock wouldn't be trivial, so I decided to got with
the workaround instead at the end.

> 
> Question:
> What do you think about it? I know that talk is cheap and code looks
> better but before starting the work I would like to hear some
> comments/opinions/ideas.
>

The problem is that the enable and prepare operations are propagated to
the parents, so what the locks want to protecting is really a sub-tree
of the clock tree. They currently protect the whole clock hierarchy to
make sure that the changes in the clock tree are atomically.

So a clock per controller won't suffice since you can have a parent for
a clock provided by a different controller and that won't be protected.

Another option is to have a prepare and enable locks per clock. Since
the operations are always propagated in the same direction, I think is
safe to do it.

But even in the case of a more fine-grained locking, I believe the
mentioned deadlocks can still happen. For example in 10ff4c5239a1 the
issue was that the s2mps11 PMIC has both regulators and clocks that are
controlled via I2C so the regulator and clocks drivers shares the same
I2C regmap.

What happened was something like this:

         CPU0                                   CPU1
         ----                                   ----
  regulator_set_voltage()                s3c_rtc_probe()
  regmap_write()                         clk_prepare()
  /* regmap->lock was aquired */         /* prepare_lock was aquired */
  regmap_i2c_write()                     s2mps11_clk_prepare()
  i2c_transfer()                         regmap_write()
  exynos5_i2c_xfer()                     /* deadlock due regmap->lock */
  clk_prepare_enable()
  clk_prepare_lock()
  /* prepare_lock was aquired */

So if for example a per clock lock is used, the deadlock can still happen
if both the I2C clock and S3C RTC source clock share the same parent in a
part of the hierarchy. But as you said this is less likely in practice so
probably is not an issue. 

The disadvantage with a per clock lock is that it may be too fine-grained,
so even when it will help with parallelism and scalability, it will hurt
performance since will be too costly to do a prepare and enable operation.

> 
> Best regards,
> Krzysztof
> 
> 
> [1]
> http://www.krzk.eu/builders/boot-odroid-xu3-multi_v7/builds/34/steps/Boot%20odroid/logs/serial
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
