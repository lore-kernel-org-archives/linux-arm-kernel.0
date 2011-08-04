From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:47:57 -0700
Subject: [PATCH 03/12] ARM: unicore32: Remove depency on LATCH
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804134757.GA1019@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
at91 code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/unicore32/include/asm/timex.h |    2 ++
 arch/unicore32/kernel/time.c       |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/unicore32/include/asm/timex.h b/arch/unicore32/include/asm/timex.h
index faf16ba..e0fed26 100644
--- a/arch/unicore32/include/asm/timex.h
+++ b/arch/unicore32/include/asm/timex.h
@@ -29,6 +29,8 @@
 
 #endif
 
+#define TIMER_LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)
+
 #include <asm-generic/timex.h>
 
 #endif
diff --git a/arch/unicore32/kernel/time.c b/arch/unicore32/kernel/time.c
index 080710c..3ed4ef9 100644
--- a/arch/unicore32/kernel/time.c
+++ b/arch/unicore32/kernel/time.c
@@ -134,7 +134,7 @@ void puv3_timer_resume(void)
 	/*
 	 * OSMR0 is the system timer: make sure OSCR is sufficiently behind
 	 */
-	writel(readl(OST_OSMR0) - LATCH, OST_OSCR);
+	writel(readl(OST_OSMR0) - TIMER_LATCH, OST_OSCR);
 }
 #else
 void puv3_timer_suspend(void) { };
-- 
1.7.4.1
