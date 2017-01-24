From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 24 Jan 2017 15:16:35 +0300
Subject: [PATCH v5 0/8] Implement clocksource for rockchip SoC using rockchip
 timer
Message-ID: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series contain:
- devicetree bindings clarification for rockchip timers
- dts files fixes for rk3228-evb, rk3229-evb and rk3188
- implementation of clocksource and sched clock for rockchip SoC

The clock supplying the arm-global-timer on the rk3188 is coming from the
the cpu clock itself and thus changes its rate everytime cpufreq adjusts
the cpu frequency making this timer unsuitable as a stable clocksource.

The rk3188, rk3288 and following socs share a separate timer block already
handled by the rockchip-timer driver. Therefore adapt this driver to also
be able to act as clocksource on rk3188.

In order to test clocksource you can run following commands and check
how much time it take in real. On rk3188 it take about ~45 seconds.

       cpufreq-set -f 1.6GHZ
       date; sleep 60; date

rk3288 (and probably anything newer) is irrelevant to this patch,
as it has the arch timer interface. This patch may be usefull
for Cortex-A9/A5 based parts.

Regards,
Alexander.

Changes in v5:
- Add 'Acked-by: Rob Herring <robh@kernel.org>' to 1/8
  http://lists.infradead.org/pipermail/linux-rockchip/2016-December/013308.html
- Add 'Reviwed-by: Heiko St?bner <heiko@sntech.de>' to series
- change timer compatible property in the rk322x.dtsi 2/8
  http://lists.infradead.org/pipermail/linux-rockchip/2017-January/013784.html
- updated comment message for 4/8
  http://lists.infradead.org/pipermail/linux-rockchip/2017-January/013786.html
- updated comment message for 5/8
  http://lists.infradead.org/pipermail/linux-rockchip/2017-January/013787.html
- fixed build error for 8/8
  http://lists.infradead.org/pipermail/linux-rockchip/2017-January/013789.html

Changes in v4:
merged 7 and 8 from series 3
merged 10, 11, 12, 13 from series 3
fixed commit message

Changes in v3:
added patches:
ARM: dts: rockchip: disable arm-global-timer for rk3188
clocksource/drivers/rockchip_timer: Prevent ftrace recursion

devicetree v1 patches:
https://patchwork.ozlabs.org/patch/699019/
https://patchwork.ozlabs.org/patch/699020/

kernel v1 patches:
https://patchwork.kernel.org/patch/9443975/
https://patchwork.kernel.org/patch/9443971/
https://patchwork.kernel.org/patch/9443959/
https://patchwork.kernel.org/patch/9443963/
https://patchwork.kernel.org/patch/9443979/
https://patchwork.kernel.org/patch/9443989/
https://patchwork.kernel.org/patch/9443987/
https://patchwork.kernel.org/patch/9443977/
https://patchwork.kernel.org/patch/9443991/

Alexander Kochetkov (8):
  dt-bindings: clarify compatible property for rockchip timers
  ARM: dts: rockchip: update compatible property for rk322x timer
  ARM: dts: rockchip: add timer entries to rk3188 SoC
  ARM: dts: rockchip: disable arm-global-timer for rk3188
  clocksource/drivers/rockchip_timer: split bc_timer into rk_timer and
    rk_clock_event_device
  clocksource/drivers/rockchip_timer: low level routines take rk_timer
    as parameter
  clocksource/drivers/rockchip_timer: move TIMER_INT_UNMASK out of
    rk_timer_enable()
  clocksource/drivers/rockchip_timer: implement clocksource timer

 .../bindings/timer/rockchip,rk-timer.txt           |   12 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   17 ++
 arch/arm/boot/dts/rk322x.dtsi                      |    2 +-
 drivers/clocksource/rockchip_timer.c               |  207 +++++++++++++++-----
 4 files changed, 183 insertions(+), 55 deletions(-)

-- 
1.7.9.5
