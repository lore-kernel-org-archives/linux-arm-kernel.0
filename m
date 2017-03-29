From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 29 Mar 2017 16:22:15 +0300
Subject: [PATCH v7 0/7] Implement clocksource for rockchip SoC using
 rockchip timer
In-Reply-To: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
Message-ID: <DAFDD95C-3244-4217-B3A4-E9FB176AE989@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Daniel.

Due to recent comments from Mark[1], may be is better to apply v6[2] series instead of v7[3]?
Because my main goal was to fix wall time on rk3188. And I did it the same way how that was
already done for other timer drivers (one of possible solution).

You can rename CLOCKSOURCE_OF to TIMER_OF later. I can help with that, but I don?t
think it is good idea to combine my changes and timer framework cleanups/improvements
into single series.

And I thinks, that probably is is better to drop [3] and [4] and revert 0c8893c9095d ("clockevents: Add a
clkevt-of mechanism like clksrc-of?).

What do you think?

[1] https://lkml.org/lkml/2017/3/29/286
[2] https://lkml.org/lkml/2017/1/31/401
[3] https://lkml.org/lkml/2017/3/22/508
[4] https://lkml.org/lkml/2017/3/22/420
[5] https://lkml.org/lkml/2017/3/22/426

> 22 ????? 2017 ?., ? 18:48, Alexander Kochetkov <al.kochet@gmail.com> ???????(?):
> 
> Hello, Daniel, Heiko.
> 
> Here is try 7 :) Could you please take a look into it?
> 
> rockchip_timer init code implemented using CLOCKEVENT_OF_DECLARE()
> introduced in commit 0c8893c9095d ("clockevents: Add a clkevt-of
> mechanism like clksrc-of")
> 
> There is change in the arch/arm/mach-rockchip/rockchip.c.
> 
> This series should be applied after the commit:
> https://lkml.org/lkml/2017/3/22/426
> 
> As without the commit, you will get linker error ("clkevt-probe.c:63:
> undefined reference to `__clkevt_of_table?")
> 
> Regards,
> Alexander.
> 
> 
> Alexander Kochetkov (6):
>  dt-bindings: clarify compatible property for rockchip timers
>  ARM: dts: rockchip: update compatible property for rk322x timer
>  ARM: dts: rockchip: add clockevent attribute to rockchip timers
>  clocksource/drivers/rockchip_timer: implement clocksource timer
>  ARM: dts: rockchip: add timer entries to rk3188 SoC
>  ARM: dts: rockchip: disable arm-global-timer for rk3188
> 
> Daniel Lezcano (1):
>  clocksource/drivers/clksrc-evt-probe: Describe with the DT both the
>    clocksource and the clockevent
> 
> .../bindings/timer/rockchip,rk-timer.txt           |   12 +-
> Documentation/devicetree/bindings/timer/timer.txt  |   38 ++++
> arch/arm/boot/dts/rk3036.dtsi                      |    1 +
> arch/arm/boot/dts/rk3188.dtsi                      |   19 ++
> arch/arm/boot/dts/rk322x.dtsi                      |    3 +-
> arch/arm/boot/dts/rk3288.dtsi                      |    1 +
> arch/arm/mach-rockchip/rockchip.c                  |    2 +
> arch/arm64/boot/dts/rockchip/rk3368.dtsi           |    1 +
> drivers/clocksource/Kconfig                        |    2 +
> drivers/clocksource/clkevt-probe.c                 |    7 +
> drivers/clocksource/clksrc-probe.c                 |    7 +
> drivers/clocksource/rockchip_timer.c               |  215 ++++++++++++++------
> 12 files changed, 241 insertions(+), 67 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/timer/timer.txt
> 
> -- 
> 1.7.9.5
> 
