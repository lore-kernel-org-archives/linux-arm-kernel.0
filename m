From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 15:58:34 -0500
Subject: [PATCH v2 3/3] ARM: arch_timer: use full 64-bit counter for
 sched_clock
In-Reply-To: <1364849914-26420-1-git-send-email-robherring2@gmail.com>
References: <1364849914-26420-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364849914-26420-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Only 32-bits of the arch timer were being used and wrapping was needlessly
being done in s/w. By using the full counter (56-64 bits), we don't need
to deal with wrapping and can simplify the implementation when using
arch timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/arch_timer.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index d957a51..a7536d4 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -22,9 +22,11 @@ static unsigned long arch_timer_read_counter_long(void)
 	return arch_timer_read_counter();
 }
 
-static u32 arch_timer_read_counter_u32(void)
+static u32 sched_clock_mult __read_mostly;
+
+static unsigned long long notrace arch_timer_sched_clock(void)
 {
-	return arch_timer_read_counter();
+	return arch_timer_read_counter() * sched_clock_mult;
 }
 
 static struct delay_timer arch_delay_timer;
@@ -52,10 +54,13 @@ int __init arch_timer_of_register(void)
 
 int __init arch_timer_sched_clock_init(void)
 {
-	if (arch_timer_get_rate() == 0)
+        u32 arch_timer_rate = arch_timer_get_rate();
+
+	if (arch_timer_rate == 0)
 		return -ENXIO;
 
-	setup_sched_clock(arch_timer_read_counter_u32,
-			  32, arch_timer_get_rate());
+	/* Cache the sched_clock multiplier to save a divide in the hot path. */
+	sched_clock_mult = NSEC_PER_SEC / arch_timer_rate;
+	sched_clock_func = arch_timer_sched_clock;
 	return 0;
 }
-- 
1.7.10.4
