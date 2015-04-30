From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:27 -0500
Subject: [PATCH 12/18] ARM: imx: Remove one global variable in
 mxc_clocksource_init
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-13-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed the use of global variable "timer_base" in the function of
mxc_clocksource_init, and get the register address from the
input parameter.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index b20ee80..4a6c625 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -202,16 +202,17 @@ static int __init mxc_clocksource_init(struct clk *timer_clk,
 				void __iomem *addr)
 {
 	unsigned int c = clk_get_rate(timer_clk);
-	void __iomem *reg = timer_base + (timer_is_v2() ? V2_TCN : MX1_2_TCN);
+
+	BUG_ON(!addr);
 
 	imx_delay_timer.read_current_timer = &imx_read_current_timer;
 	imx_delay_timer.freq = c;
 	register_current_timer_delay(&imx_delay_timer);
 
-	sched_clock_reg = reg;
+	sched_clock_reg = addr;
 
 	sched_clock_register(mxc_read_sched_clock, 32, c);
-	return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
+	return clocksource_mmio_init(addr, "mxc_timer1", c, 200, 32,
 			clocksource_mmio_readl_up);
 }
 
-- 
1.9.1
