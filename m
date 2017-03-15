From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Mar 2017 18:09:52 +0100
Subject: [RFC PATCH 0/4] pinctrl: rockchip: PREEMPT_RT_FULL fixes
In-Reply-To: <20170313183813.3582-1-john@metanate.com>
References: <20170313183813.3582-1-john@metanate.com>
Message-ID: <2965030.XxB81LuoOf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 13. M?rz 2017, 18:38:09 CET schrieb John Keeping:
> As described in Documentation/gpio/driver.txt, we should not be using
> sleepable APIs in the irqchip implementation.  Since this includes the
> regmap API, this patch series ends up moving the mux setup for IRQs into
> an irq_bus_sync_unlock() handler which may result in the IRQ being
> configured before the port has been muxed as a GPIO.
> 
> I've marked the series as RFC because I'm not sure if this is the best
> way to accomplish this or if there is another approach that is cleaner.
> Also, the first patch may not be correct on RK3399 because I originally
> wrote the patch for RK3288 on top of v4.4 where all drive updates only
> affect a single register.  We don't need locking in this case because
> regmap_update_bits() takes a lock on the regmap internally, but if these
> two registers need to be updated atomically then another lock will
> be required here - slock cannot be used if it is converted to a raw
> spinlock since with full RT preemption the regmap's spinlock may sleep.

With the issue in patch2 fixed and top of the current head of Linus T's tree 
(4.11-rc2 + some patches), at least rk3036, rk3288, rk3368 and rk3399 come up 
nicely including multiple (1 to 3 per board) gpio-interrupts, so this series

Tested-by: Heiko Stuebner <heiko@sntech.de>
