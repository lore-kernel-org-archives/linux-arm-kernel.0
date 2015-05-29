From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 29 May 2015 19:40:11 +0800
Subject: [Query] how to handle must be always enabled clk but there's no
 driver use the clk
Message-ID: <20150529194011.033fa675@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian, Mike and all,

Let me describe the situation:

there's one clk called as perifsysclk, it's the system AXI clk and at the same
time it's the clock source of two gate clks, for example ethclk, sdioclk etc.
Once cold boot, HW enables perifsysclk by default,

Now let's assume eth driver is firstly probed, in the beginning of eth_probe()
we call clk_prepare_enable(ethclk);

but the eth_probe() fail due to something, so in its failed path, it calls

clk_disable_unprepare(ethclk);

which will finally disable the perifsysclk, so we hang here.


How to handle this situation? Register one dummy driver early then
clk_prepare_enable(perifsysclk) in the driver probe?

Thanks,
Jisheng
