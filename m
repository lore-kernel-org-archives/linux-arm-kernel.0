From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 23 Sep 2016 10:20:45 +0300
Subject: Regression in next with "mfd: twl6040: The chip does not support
 bulk access"
In-Reply-To: <20160922180718.kmttyt26t56fa3kp@atomide.com>
References: <20160922180718.kmttyt26t56fa3kp@atomide.com>
Message-ID: <139a8c7b-8cfe-fa21-634a-4551511f0cea@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/16 21:07, Tony Lindgren wrote:
> Hi,
> 
> Looks like commit 7a17e47f6403 ("mfd: twl6040: The chip does not
> support bulk access") breaks at least omap4-duovero.

That's odd. I see no such errors on omap4 PandaBoard-ES nor on omap5 uEVM.
The IRQ status is one register so even in bulk access it is one read. So the
use_single_rw should have no effect on the access.

The only time when regmap would try to use bulk access to twl6040 is when we
execute regcache_sync() on it after resuming the chip and this would fail at
the first time when it tries to restore more than one consecutive registers.

I just tested things on next-20160915 and I see no errors at all.

> I now get tons of errors:
> 
> Skipping twl internal clock init and using bootloader value (unknown osc rate)
> twl 0-0048: PIH (irq 332) nested IRQs
> of_get_named_gpiod_flags: parsed 'ti,audpwron-gpio' property of node '/ocp/i2c at 48070000/t
> wl at 4b[0]' - status (0)
> omap_i2c 48070000.i2c: bus 0 rev0.10 at 400 kHz
> twl6040 0-004b: Failed to read IRQ status: -16
> twl6040 0-004b: Failed to read IRQ status: -16
> twl6040 0-004b: Failed to read IRQ status: -16
> twl6040 0-004b: Failed to read IRQ status: -16
> twl6040 0-004b: Failed to read IRQ status: -16
> twl6040 0-004b: Failed to read IRQ status: -16
> twl6040 0-004b: Failed to read IRQ status: -16
> twl6040 0-004b: Failed to read IRQ status: -16
> twl6040 0-004b: Failed to read IRQ status: -16
> 
> It seems the regmap irqs don't work with use_single_rw?
> 
> Also seems that twl6040 does support bulk access as things have been
> working earlier?

Things kind of worked as we had single register reads and writes, but when I
tried to power down/up the twl6040 the regcache_sync() would fail to restore
the registers at the first place when we had two or more registers to update
in bulk mode. In that case regmap gives an error, but I have not been checking
the return of the regcache_sync() so the chip comes up, but not all settings
were restored.

> Anyways, can you please revert?

Please don't.

On which linux-next version you are seeing this?

-- 
P?ter
