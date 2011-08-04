From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:53:42 -0700
Subject: [PATCH 11/12] ARM: sa1100:  Remove LATCH and CLOCK_TICK_RATE
	dependency
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804135342.GI1019@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
sa1100 code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/mach-sa1100/time.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index fa66024..d4de620 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -127,6 +127,9 @@ static void __init sa1100_timer_init(void)
 }
 
 #ifdef CONFIG_PM
+#define SA1100_TICK_RATE	3686400
+#define SA1100_TIMER_LATCH	((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
+
 unsigned long osmr[4], oier;
 
 static void sa1100_timer_suspend(void)
@@ -150,7 +153,7 @@ static void sa1100_timer_resume(void)
 	/*
 	 * OSMR0 is the system timer: make sure OSCR is sufficiently behind
 	 */
-	OSCR = OSMR0 - LATCH;
+	OSCR = OSMR0 - SA1100_TIMER_LATCH;
 }
 #else
 #define sa1100_timer_suspend NULL
-- 
1.7.4.1
