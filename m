From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 24 May 2013 14:44:58 +0200
Subject: clock framework: Don't disable a clock already enabled by boot loader?
Message-ID: <519F60CA.6090302@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

we register a clock using clk_register_clkdev() etc already enabled by a 
boot loader. We are doing only the clk_register_clkdev(), but no 
clock_enable() etc on this clock.

With this, enable_count for this clock is zero, while in fact it's 
already on. I.e. the kernel doesn't know that it is on.

This results in

late_initcall(clk_disable_unused())

disabling this clock because the kernel thinks it's unused.

Is this the intended behavior? Is there a way to let the kernel know 
"the clock is enabled already, set enable_count != 0"? Or is the only 
way to do this correctly calling clock_enable() on an already enabled clock?

Many thanks and best regards

Dirk
