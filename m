From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 22 Apr 2013 17:10:05 +0530
Subject: [PATCH v3 00/10] ARM: exynos multiplatform series, part 1
In-Reply-To: <201304191536.17796.arnd@arndb.de>
References: <1365716245-99231-1-git-send-email-arnd@arndb.de>
 <201304191536.17796.arnd@arndb.de>
Message-ID: <CAK9yfHwEZUPs70j3rS7V44RWxpZShEP8uxo3fFW54=L3NG-bDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 19 April 2013 19:06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 11 April 2013, Arnd Bergmann wrote:
>> These are the patches that I would like to apply directly to
>> the arm-soc next/multiplatform branch, unless you have any
>> objections. This would get all the simple stuff out of the
>> way, and I don't think there is a big risk of introducing
>> regressions with these.
>>
>> A lot of the other patches have already been merged into
>> subsystem trees. After this series in in arm-soc, what is
>> left comes down to
>>
>> * The ASoC conversion to dmaengine won't make it unless someone
>>   who knows that code better steps up to do it right away. This
>>   means that we won't have audio in a 3.10 multiplatform kernel
>>   on Exynos, but it will still work for users that don't enable
>>   multiplatform.
>>
>> * The irqchip (combiner), clk and clksource patches are all based
>>   on top   of other changesets we pulled in from your trees, so I
>>   would not make them part of the next/multiplatform branch. We can
>>   apply them on top of the next/drivers branch once they are
>>   tested successfully.
>>
>> * A trivial patch is needed in the end to actually make
>>   CONFIG_ARCH_EXYNOS visible in multiplatform configurations.
>>   We will do that as a separate patch once everything else is
>>   there.
>>
>> Please provide an ACK so I can put this into arm-soc, or let
>> me know if I screwed up somewhere.
>
> No reply?
>
> I'm putting them into the next/multiplatform branch now, with
> the exception of the i2c patch that is already in the i2c
> tree.
>
> I've tested this on the Arndale board and am putting it into
> the next/multiplatform branch now as a stepping stone for
> part two, which will be a late branch at best, if we decide
> to merge it in 3.10.

With this branch now available (merged) in linux-next (20130422),
looks like exynos4 DT support is broken on it. Tested on Origen 4210
and 4412 and I get the following warnings on 4412 Origen board with
exynos_defconfig (Note that clocks are all 0). However, it boots fine
on Arndale board.

SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Preemptible hierarchical RCU implementation.
NR_IRQS:549
Exynos4x12 clocks: sclk_apll = 0, sclk_mpll = 0
        sclk_epll = 0, sclk_vpll = 0, arm_clk = 0
Division by zero in kernel.
CPU: 0 PID: 0 Comm: swapper/0 Not tainted
3.9.0-rc8-next-20130422-00038-g20ff84f #50
[<c0013fc8>] (unwind_backtrace+0x0/0xf8) from [<c0010ee4>]
(show_stack+0x10/0x14)
[<c0010ee4>] (show_stack+0x10/0x14) from [<c0190704>] (Ldiv0_64+0x8/0x18)
[<c0190704>] (Ldiv0_64+0x8/0x18) from [<c00549c4>]
(__clocksource_updatefreq_scale+0x44/0x19c)
[<c00549c4>] (__clocksource_updatefreq_scale+0x44/0x19c) from
[<c0054b28>] (__clocksource_register_scale+0xc/0x44)
[<c0054b28>] (__clocksource_register_scale+0xc/0x44) from [<c04895b0>]
(exynos4_clocksource_init+0x20/0x40)
[<c04895b0>] (exynos4_clocksource_init+0x20/0x40) from [<c0489638>]
(mct_init_dt+0x68/0x74)
[<c0489638>] (mct_init_dt+0x68/0x74) from [<c0489384>]
(clocksource_of_init+0x30/0x58)
[<c0489384>] (clocksource_of_init+0x30/0x58) from [<c0473ae0>]
(time_init+0x1c/0x30)
[<c0473ae0>] (time_init+0x1c/0x30) from [<c04706a0>] (start_kernel+0x1a0/0x37c)
[<c04706a0>] (start_kernel+0x1a0/0x37c) from [<40008074>] (0x40008074)
Division by zero in kernel.


-- 
With warm regards,
Sachin
