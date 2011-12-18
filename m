From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 19 Dec 2011 00:31:15 +0100
Subject: [PATCH] ux500: fix the smp_twd clock calculation
Message-ID: <1324251075-3248-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The clock for the smp_twd block is not equal to the CPU
frequency, actually it is divided by two, so fix this,
and set the initial frequency to half of 1GHz which is
the most common case.

Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 2ebf998..7379075 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -651,7 +651,7 @@ err_out:
 late_initcall(clk_debugfs_init);
 #endif /* defined(CONFIG_DEBUG_FS) */
 
-unsigned long clk_smp_twd_rate = 400000000;
+unsigned long clk_smp_twd_rate = 500000000;
 
 unsigned long clk_smp_twd_get_rate(struct clk *clk)
 {
@@ -677,7 +677,7 @@ static int clk_twd_cpufreq_transition(struct notifier_block *nb,
 
 	if (state == CPUFREQ_PRECHANGE) {
 		/* Save frequency in simple Hz */
-		clk_smp_twd_rate = f->new * 1000;
+		clk_smp_twd_rate = (f->new * 1000) / 2;
 	}
 
 	return NOTIFY_OK;
-- 
1.7.8
