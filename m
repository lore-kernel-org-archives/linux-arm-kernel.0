From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2016 09:47:37 -0800
Subject: [PATCH] clocksource: arm_arch_timer: print timer value at init time
Message-ID: <1482169657-15773-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is useful to get an indication of how much time we spent in firmware.

It's not guaranteed that the timer started at 0 on reset, so it's just
an approximation, and might very well be invalid on some systems. But
it's still a useful metric to have access to.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 02fef68..c26078b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -521,6 +521,8 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 
 static void arch_timer_banner(unsigned type)
 {
+	unsigned long cnt = arch_timer_read_counter();
+
 	pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
 		     type & ARCH_CP15_TIMER ? "cp15" : "",
 		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
@@ -534,6 +536,8 @@ static void arch_timer_banner(unsigned type)
 		     type & ARCH_MEM_TIMER ?
 			arch_timer_mem_use_virtual ? "virt" : "phys" :
 			"");
+	pr_info("Initial timer value: 0x%lx: %ld.%02lds\n",
+		cnt, cnt/arch_timer_rate, (cnt/(arch_timer_rate/100)) % 100);
 }
 
 u32 arch_timer_get_rate(void)
-- 
2.8.0.rc3.29.gb552ff8
