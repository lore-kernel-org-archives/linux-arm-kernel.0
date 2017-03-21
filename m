From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 21 Mar 2017 09:02:00 +0100
Subject: [PATCH v6 0/5] Implement clocksource for rockchip SoC using
 rockchip timer
In-Reply-To: <F14EA552-9783-4083-A00F-9151AB7E5C99@gmail.com>
References: <1485866596-32254-1-git-send-email-al.kochet@gmail.com>
 <F14EA552-9783-4083-A00F-9151AB7E5C99@gmail.com>
Message-ID: <6b897768-d11f-bfd2-7eeb-bd7a41ea7669@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/2017 14:18, Alexander Kochetkov wrote:
> Hello, Daniel.
> 
> Sorry for bothering you, but could you please take a look at v6[1] series and tell what do you think about it?
> I see your commit[2] in the git, but I don?t understand well how to use it in rockchip driver.
> 
> [1] https://lkml.org/lkml/2017/1/31/401
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/clocksource?id=376bc27150f180d9f5eddec6a14117780177589d

Hi Alexander,

I have been through the patchset and it is ok except for the patch 3/5.
I wanted to investigate a bit on this one because of the patch [2] you
are mentioning.

I think there is small missing piece of devicetree binding to specify
'clocksource' or 'clockevent'. Rob Herring is ok with an attribute of
this kind.

That would help to clearly separate these drivers without ambiguity.

However, it results on some duplicated code I'm not very happy with, so
that is my major issue with this approach I would like to solve. That is
the status today.

I wanted to take the opportunity of your changes to investigate this area.


>> 31 ???. 2017 ?., ? 15:43, Alexander Kochetkov <al.kochet@gmail.com> ???????(?):
>>
>> From: Alexander Kochetkov <akochetkov@lintech.ru>
>>
>> Hello, Daniel, Heiko.
>>
>> Here is try 6 :) Thanks a lot for helping me to bring the code
>> into kernel!
>>
>> This patch series contain:
>> - devicetree bindings clarification for rockchip timers
>> - dts files fixes for rk3228-evb, rk3229-evb and rk3188
>> - implementation of clocksource and sched clock for rockchip SoC
>>
>> The clock supplying the arm-global-timer on the rk3188 is coming from the
>> the cpu clock itself and thus changes its rate everytime cpufreq adjusts
>> the cpu frequency making this timer unsuitable as a stable clocksource.
>>
>> The rk3188, rk3288 and following socs share a separate timer block already
>> handled by the rockchip-timer driver. Therefore adapt this driver to also
>> be able to act as clocksource on rk3188.
>>
>> In order to test clocksource you can run following commands and check
>> how much time it take in real. On rk3188 it take about ~45 seconds.
>>
>>       cpufreq-set -f 1.6GHZ
>>       date; sleep 60; date
>>
>> rk3288 (and probably anything newer) is irrelevant to this patch,
>> as it has the arch timer interface. This patch may be usefull
>> for Cortex-A9/A5 based parts.
>>
>> Regards,
>> Alexander.
>>
>> Changes in v6:
>> - Removed Reviewed-by: Heiko St?bner <heiko@sntech.de> tag
>> - Merge 5/8, 6/8, 7/8, 8/9 into single file
>> - split init paths into rk_clkevt_init() and rk_clksrc_init()
>>  so the driver code could be adopted to CLOCKEVENT_OF_DECLARE()
>> - clockevents implemented using clocksource_mmio_init()
>> - fixed commit message for 4/8 (thanks a lot Daniel)
>>
>> Changes in v5:
>> - Add Acked-by: Rob Herring <robh@kernel.org> to 1/8
>>  http://lists.infradead.org/pipermail/linux-rockchip/2016-December/013308.html
>> - Add Reviwed-by: Heiko St?bner <heiko@sntech.de> to series
>> - change timer compatible property in the rk322x.dtsi 2/8
>>  http://lists.infradead.org/pipermail/linux-rockchip/2017-January/013784.html
>> - updated comment message for 4/8
>>  http://lists.infradead.org/pipermail/linux-rockchip/2017-January/013786.html
>> - updated comment message for 5/8
>>  http://lists.infradead.org/pipermail/linux-rockchip/2017-January/013787.html
>> - fixed build error for 8/8
>>  http://lists.infradead.org/pipermail/linux-rockchip/2017-January/013789.html
>>
>> Alexander Kochetkov (5):
>>  dt-bindings: clarify compatible property for rockchip timers
>>  ARM: dts: rockchip: update compatible property for rk322x timer
>>  clocksource/drivers/rockchip_timer: implement clocksource timer
>>  ARM: dts: rockchip: add timer entries to rk3188 SoC
>>  ARM: dts: rockchip: disable arm-global-timer for rk3188
>>
>> .../bindings/timer/rockchip,rk-timer.txt           |   12 +-
>> arch/arm/boot/dts/rk3188.dtsi                      |   17 ++
>> arch/arm/boot/dts/rk322x.dtsi                      |    2 +-
>> drivers/clocksource/Kconfig                        |    1 +
>> drivers/clocksource/rockchip_timer.c               |  218 ++++++++++++++------
>> 5 files changed, 185 insertions(+), 65 deletions(-)
>>
>> -- 
>> 1.7.9.5
>>
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
