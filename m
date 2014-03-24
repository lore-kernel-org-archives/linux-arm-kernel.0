From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 24 Mar 2014 12:34:23 +0800
Subject: [PATCH] gpio: mxs: Allow for recursive enable_irq_wake() call
In-Reply-To: <1395628690-7225-1-git-send-email-marex@denx.de>
References: <1395628690-7225-1-git-send-email-marex@denx.de>
Message-ID: <20140324043421.GA10180@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 03:38:10AM +0100, Marek Vasut wrote:
> The scenario here is that someone calls enable_irq_wake() from somewhere
> in the code. This will result in the lockdep producing a backtrace as can
> be seen below. In my case, this problem is triggered when using the wl1271
> (TI WlCore) driver found in drivers/net/wireless/ti/ .
> 
> The problem cause is rather obvious from the backtrace, but let's outline
> the dependency. enable_irq_wake() grabs the IRQ buslock in irq_set_irq_wake(),
> which in turns calls mxs_gpio_set_wake_irq() . But mxs_gpio_set_wake_irq()
> calls enable_irq_wake() again on the one-level-higher IRQ , thus it tries to
> grab the IRQ buslock again in irq_set_irq_wake() . Because the spinlock in
> irq_set_irq_wake()->irq_get_desc_buslock()->__irq_get_desc_lock() is not
> marked as recursive, lockdep will spew the stuff below.
> 
> We know we can safely re-enter the lock, so use IRQ_GC_INIT_NESTED_LOCK to
> fix the spew.

...

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
