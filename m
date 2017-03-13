From: john@metanate.com (John Keeping)
Date: Mon, 13 Mar 2017 18:38:09 +0000
Subject: [RFC PATCH 0/4] pinctrl: rockchip: PREEMPT_RT_FULL fixes
Message-ID: <20170313183813.3582-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As described in Documentation/gpio/driver.txt, we should not be using
sleepable APIs in the irqchip implementation.  Since this includes the
regmap API, this patch series ends up moving the mux setup for IRQs into
an irq_bus_sync_unlock() handler which may result in the IRQ being
configured before the port has been muxed as a GPIO.

I've marked the series as RFC because I'm not sure if this is the best
way to accomplish this or if there is another approach that is cleaner.
Also, the first patch may not be correct on RK3399 because I originally
wrote the patch for RK3288 on top of v4.4 where all drive updates only
affect a single register.  We don't need locking in this case because
regmap_update_bits() takes a lock on the regmap internally, but if these
two registers need to be updated atomically then another lock will
be required here - slock cannot be used if it is converted to a raw
spinlock since with full RT preemption the regmap's spinlock may sleep.

John Keeping (4):
  pinctrl: rockchip: remove unnecessary locking
  pinctrl: rockchip: convert to raw spinlock
  pinctrl: rockchip: split out verification of mux settings
  pinctrl: rockchip: avoid hardirq-unsafe functions in irq_chip

 drivers/pinctrl/pinctrl-rockchip.c | 140 +++++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 54 deletions(-)

-- 
2.12.0.377.gf910686b23.dirty
