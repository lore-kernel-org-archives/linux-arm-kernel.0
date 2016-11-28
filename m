From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Mon, 28 Nov 2016 17:31:15 +0300
Subject: [PATCHv2 00/11] Implement clocksource for rockchip SoC using rockchip
 timer
Message-ID: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series contain:
- devicetree bindings clarification for rockchip timers
- dts files fixes for rk3228-evb, rk3229-evb and rk3188
- implementation of clocksource for rockchip SoC

The clock supplying the arm-global-timer on the rk3188 is coming from the
the cpu clock itself and thus changes its rate everytime cpufreq adjusts
the cpu frequency making this timer unsuitable as a stable clocksource.
    
The rk3188, rk3288 and following socs share a separate timer block already
handled by the rockchip-timer driver. Therefore adapt this driver to also
be able to act as clocksource on rk3188.
    
In order to test clocksource you can run following commands and check
how much time it take in real. On rk3188 it take about ~45 seconds.
Such error cannot be fixed using NTP. Haven't test clocksource
on rk3288 and onwards. Guess they can also have unstable clocksource.
    
        cpufreq-set -f 1.6GHZ
        date; sleep 60; date

Regards,
Alexander.

This is try 2. Please discard all previous patches:

devicetree:
https://patchwork.ozlabs.org/patch/699019/
https://patchwork.ozlabs.org/patch/699020/

kernel:
https://patchwork.kernel.org/patch/9443975/
https://patchwork.kernel.org/patch/9443971/
https://patchwork.kernel.org/patch/9443959/
https://patchwork.kernel.org/patch/9443963/
https://patchwork.kernel.org/patch/9443979/
https://patchwork.kernel.org/patch/9443989/
https://patchwork.kernel.org/patch/9443987/
https://patchwork.kernel.org/patch/9443977/
https://patchwork.kernel.org/patch/9443991/

Old thread:
http://lists.infradead.org/pipermail/linux-rockchip/2016-November/013147.html

Alexander Kochetkov (11):
  dt-bindings: clarify compatible property for rockchip timers
  ARM: dts: rockchip: update compatible property for rk3228 timer
  ARM: dts: rockchip: update compatible property for rk3229 timer
  ARM: dts: rockchip: add timer entries to rk3188 dtsi
  clocksource/drivers/rockchip_timer: split bc_timer into rk_timer and
    rk_clock_event_device
  clocksource/drivers/rockchip_timer: low level routines take rk_timer
    as parameter
  clocksource/drivers/rockchip_timer: drop unused rk_base() and
    rk_ctrl()
  clocksource/drivers/rockchip_timer: move TIMER_INT_UNMASK out of
    rk_timer_enable()
  clocksource/drivers/rockchip_timer: implement loading 64bit value
    into timer
  clocksource/drivers/rockchip_timer: implement reading 64bit value
    from timer
  clocksource/drivers/rockchip_timer: implement clocksource timer

 .../bindings/timer/rockchip,rk-timer.txt           |   12 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   16 ++
 arch/arm/boot/dts/rk3228-evb.dts                   |    4 +
 arch/arm/boot/dts/rk3229-evb.dts                   |    4 +
 drivers/clocksource/rockchip_timer.c               |  202 +++++++++++++++-----
 5 files changed, 184 insertions(+), 54 deletions(-)

-- 
1.7.9.5
