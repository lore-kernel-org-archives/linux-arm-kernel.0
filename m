From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:31:03 -0700
Subject: [PATCH 04/18] ARM: imx: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1375309877-16617-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-imx/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index cd46529..7ab3b9c6 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -111,7 +111,7 @@ static void gpt_irq_acknowledge(void)
 
 static void __iomem *sched_clock_reg;
 
-static u32 notrace mxc_read_sched_clock(void)
+static u64 notrace mxc_read_sched_clock(void)
 {
 	return sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
 }
@@ -123,7 +123,7 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 
 	sched_clock_reg = reg;
 
-	setup_sched_clock(mxc_read_sched_clock, 32, c);
+	sched_clock_register(mxc_read_sched_clock, 32, c);
 	return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
 			clocksource_mmio_readl_up);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
