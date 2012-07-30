From: Barry.Song@csr.com (Barry Song)
Date: Mon, 30 Jul 2012 13:29:30 +0800
Subject: [PATCH] ARM: PRIMA2: delete redundant codes to restore LATCHED when
 timer resumes
Message-ID: <1343626170-27831-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

The only way to write LATCHED registers to write LATCH_BIT to LATCH register,
that will latch COUNTER into LATCHED.e.g.
writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base +
	SIRFSOC_TIMER_LATCH);

Writing values to LATCHED registers directly is useless at all.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/timer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
index 0de592e..d95bf25 100644
--- a/arch/arm/mach-prima2/timer.c
+++ b/arch/arm/mach-prima2/timer.c
@@ -134,11 +134,11 @@ static void sirfsoc_clocksource_resume(struct clocksource *cs)
 {
 	int i;
 
-	for (i = 0; i < SIRFSOC_TIMER_REG_CNT; i++)
+	for (i = 0; i < SIRFSOC_TIMER_REG_CNT - 2; i++)
 		writel_relaxed(sirfsoc_timer_reg_val[i], sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
 
-	writel_relaxed(sirfsoc_timer_reg_val[i - 2], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
-	writel_relaxed(sirfsoc_timer_reg_val[i - 1], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
+	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 2], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
+	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 1], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
 }
 
 static struct clock_event_device sirfsoc_clockevent = {
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog@www.csr.com/blog
