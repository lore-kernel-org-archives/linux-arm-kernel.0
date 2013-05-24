From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 25 May 2013 01:00:21 +0200
Subject: clock framework: Don't disable a clock already enabled by boot
 loader?
In-Reply-To: <519F60CA.6090302@de.bosch.com>
References: <519F60CA.6090302@de.bosch.com>
Message-ID: <20130524230021.GF31135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On Fri, May 24, 2013 at 02:44:58PM +0200, Dirk Behme wrote:
> Hi,
> 
> we register a clock using clk_register_clkdev() etc already enabled
> by a boot loader. We are doing only the clk_register_clkdev(), but
> no clock_enable() etc on this clock.
> 
> With this, enable_count for this clock is zero, while in fact it's
> already on. I.e. the kernel doesn't know that it is on.
> 
> This results in
> 
> late_initcall(clk_disable_unused())
> 
> disabling this clock because the kernel thinks it's unused.
> 
> Is this the intended behavior?

Yes, and it's great since after this point the hardware state is in sync
with the enable counter.

> Is there a way to let the kernel know
> "the clock is enabled already, set enable_count != 0"? Or is the
> only way to do this correctly calling clock_enable() on an already
> enabled clock?

You could set the CLK_IGNORE_UNUSED flag in the clock, but I suggest to
just clk_get/clk_enable the clock in the driver using it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
