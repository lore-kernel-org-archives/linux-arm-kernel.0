From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:31:00 -0700
Subject: [PATCH 01/18] ARM: timer-sp: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1375309877-16617-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface. Also mark the read function notrace since we're here
and failure to do so would cause ftrace to break.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/common/timer-sp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 023ee63..766e317 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -66,7 +66,7 @@ static long __init sp804_get_clock_rate(struct clk *clk)
 
 static void __iomem *sched_clock_base;
 
-static u32 sp804_read(void)
+static u64 notrace sp804_read(void)
 {
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
@@ -104,7 +104,7 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 
 	if (use_sched_clock) {
 		sched_clock_base = base;
-		setup_sched_clock(sp804_read, 32, rate);
+		sched_clock_register(sp804_read, 32, rate);
 	}
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
