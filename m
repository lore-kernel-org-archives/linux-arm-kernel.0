From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 25 May 2016 17:49:57 +0800
Subject: [PATCH 0/5] clocksource: rockchip/timer: Support rktimer for rk3399
Message-ID: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches had been tested on rockchip inside kernel.
In order to support the rk3399 SoC timer and turn off interrupts and IPIs to
save power in idle.
Okay, it still works bootup on rk3288/other SoCs, even though many socs hasn't used
the broadcast timer.

Easy to test for my borad.
localhost / # cat /proc/interrupts
CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
1:          0          0          0          0          0          0     GICv3  29 Edge      arch_timer
...
5:          0          0          0          0          0          0     GICv3 113 Level     rk_timer
..

localhost / # cat /proc/timer_list | grep event_handler
get "event_handler:  hrtimer_interrupt"
event_handler:  tick_handle_oneshot_broadcast
event_handler:  hrtimer_interrupt

That should work for my board.



Huang Tao (5):
  dt-bindings: document rk3399 rk-timer bindings
  clocksource: rockchip: remove unnecessary clear irq before request_irq
  clocksource: rockchip: add dynamic irq flag to the timer
  clocksource: rockchip: add support for rk3399 SoC
  ARM64: dts: rockchip: add rktimer device node for rk3399

 ...chip,rk3288-timer.txt => rockchip,rk-timer.txt} |   6 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   8 ++
 drivers/clocksource/rockchip_timer.c               | 120 ++++++++++++++++-----
 3 files changed, 106 insertions(+), 28 deletions(-)
 rename Documentation/devicetree/bindings/timer/{rockchip,rk3288-timer.txt => rockchip,rk-timer.txt} (75%)

-- 
1.9.1
