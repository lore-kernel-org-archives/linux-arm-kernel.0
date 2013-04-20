From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Apr 2013 17:29:06 -0700
Subject: [PATCH 4/4] ARM: arch_timer: Move to setup_sched_clock_64()
In-Reply-To: <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
References: <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1366417746-24990-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register with the ARM sched_clock framework now that it supports
64 bits. This also fixes two problems with the current sched_clock
support for machines using the archited timers. First off, we
don't subtract the start value from subsequent sched_clock calls
so we can potentially start off with sched_clock returning
gigantic numbers. Second, there is no support for suspend/resume
handling so problems such as discussed in 6a4dae5 (ARM: 7565/1:
sched: stop sched_clock() during suspend, 2012-10-23) can happen.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/sched_clock.h |  3 ---
 arch/arm/kernel/arch_timer.c       | 14 ++------------
 arch/arm/kernel/sched_clock.c      |  3 ++-
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
index 7fcd2ee..e6f765a 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -10,9 +10,6 @@
 
 extern void sched_clock_postinit(void);
 extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
-
-extern unsigned long long (*sched_clock_func)(void);
-
 extern void setup_sched_clock_64(u64 (*read)(void), int bits,
 				 unsigned long rate);
 #endif
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 59dcdce..b45250b 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -22,13 +22,6 @@ static unsigned long arch_timer_read_counter_long(void)
 	return arch_timer_read_counter();
 }
 
-static u32 sched_clock_mult __read_mostly;
-
-static unsigned long long notrace arch_timer_sched_clock(void)
-{
-	return arch_timer_read_counter() * sched_clock_mult;
-}
-
 static struct delay_timer arch_delay_timer;
 
 static void __init arch_timer_delay_timer_register(void)
@@ -48,11 +41,8 @@ int __init arch_timer_arch_init(void)
 
 	arch_timer_delay_timer_register();
 
-	/* Cache the sched_clock multiplier to save a divide in the hot path. */
-	sched_clock_mult = NSEC_PER_SEC / arch_timer_rate;
-	sched_clock_func = arch_timer_sched_clock;
-	pr_info("sched_clock: ARM arch timer >56 bits at %ukHz, resolution %uns\n",
-		arch_timer_rate / 1000, sched_clock_mult);
+	/* 56 bits minimum, so we assume worst case rollover */
+	setup_sched_clock_64(arch_timer_read_counter, 56, arch_timer_rate);
 
 	return 0;
 }
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 7875e9e..b6067d8 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -181,7 +181,8 @@ static unsigned long long notrace sched_clock_32(void)
 	return cyc_to_sched_clock(cyc, sched_clock_mask);
 }
 
-unsigned long long __read_mostly (*sched_clock_func)(void) = sched_clock_32;
+static unsigned long long __read_mostly
+(*sched_clock_func)(void) = sched_clock_32;
 
 static unsigned long long notrace sched_clock_64(void)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
