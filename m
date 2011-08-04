From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:44:37 -0700
Subject: [PATCH 01/12] ARM: Remove LATCH reference for time-acorn.c
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804134437.GB919@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE
symbol, this patch defines a sub-arch local value
for use by the time-acorn.c file. This is only used
when mach-rpc is built and the tick rate was taken
from that sub-arch's timex.h header.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/common/time-acorn.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/time-acorn.c b/arch/arm/common/time-acorn.c
index deeed56..0cc3a0d 100644
--- a/arch/arm/common/time-acorn.c
+++ b/arch/arm/common/time-acorn.c
@@ -24,6 +24,9 @@
 
 #include <asm/mach/time.h>
 
+#define ACORN_TICK_RATE         2000000
+#define ACORN_TIMER_LATCH	((CLOCK_TICK_RATE + HZ/2) / HZ)
+
 unsigned long ioc_timer_gettimeoffset(void)
 {
 	unsigned int count1, count2, status;
@@ -46,23 +49,23 @@ unsigned long ioc_timer_gettimeoffset(void)
 		 * and count2.
 		 */
 		if (status & (1 << 5))
-			offset -= LATCH;
+			offset -= ACORN_TIMER_LATCH;
 	} else if (count2 > count1) {
 		/*
 		 * We have just had another interrupt between reading
 		 * count1 and count2.
 		 */
-		offset -= LATCH;
+		offset -= ACORN_TIMER_LATCH;
 	}
 
-	offset = (LATCH - offset) * (tick_nsec / 1000);
-	return (offset + LATCH/2) / LATCH;
+	offset = (ACORN_TIMER_LATCH - offset) * (tick_nsec / 1000);
+	return (offset + ACORN_TIMER_LATCH/2) / ACORN_TIMER_LATCH;
 }
 
 void __init ioctime_init(void)
 {
-	ioc_writeb(LATCH & 255, IOC_T0LTCHL);
-	ioc_writeb(LATCH >> 8, IOC_T0LTCHH);
+	ioc_writeb(ACORN_TIMER_LATCH & 255, IOC_T0LTCHL);
+	ioc_writeb(ACORN_TIMER_LATCH >> 8, IOC_T0LTCHH);
 	ioc_writeb(0, IOC_T0GO);
 }
 
-- 
1.7.4.1
