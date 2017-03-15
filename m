From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 14:12:39 +0100
Subject: [RFC PATCH 0/4] pinctrl: rockchip: PREEMPT_RT_FULL fixes
In-Reply-To: <20170313183813.3582-1-john@metanate.com>
References: <20170313183813.3582-1-john@metanate.com>
Message-ID: <CACRpkdZXBZr_Syur3r=3GTjjrCPx4bgj0g5iNSN6rdikqkww4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 7:38 PM, John Keeping <john@metanate.com> wrote:

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

Nice work! It all looks good to me, let's see what Heiko says.

Please keep Julia Cartwright on the CC for this patch series, she is
doing some coccinelle-based rewrites to use raw spinlocks as we
speak, and she knows this stuff.

She has not targeted the Rockchip driver yet, I guess because of
its complexity.

Yours,
Linus Walleij
