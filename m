From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 19 Dec 2013 22:57:09 +0100
Subject: [PATCH] ARM: rpc: stop using <mach/timex.h>
In-Reply-To: <87bo0clved.fsf@linaro.org>
References: <87bo0clved.fsf@linaro.org>
Message-ID: <1387490229-28147-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rpc timekeeping code uses the symbol LATCH which depends on
CLOCK_TICK_RATE which is defined in rpc's <mach/timex.h>. As this header
will go away in a later patch introduce a local variable holding the
same value as LATCH and use that instead.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-rpc/time.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rpc/time.c b/arch/arm/mach-rpc/time.c
index 9a6def1..99363ae 100644
--- a/arch/arm/mach-rpc/time.c
+++ b/arch/arm/mach-rpc/time.c
@@ -24,6 +24,9 @@
 
 #include <asm/mach/time.h>
 
+#define RPC_CLOCK_FREQ 2000000
+#define RPC_LATCH DIV_ROUND_CLOSEST(RPC_CLOCK_FREQ, HZ)
+
 static u32 ioc_timer_gettimeoffset(void)
 {
 	unsigned int count1, count2, status;
@@ -46,23 +49,23 @@ static u32 ioc_timer_gettimeoffset(void)
 		 * and count2.
 		 */
 		if (status & (1 << 5))
-			offset -= LATCH;
+			offset -= RPC_LATCH;
 	} else if (count2 > count1) {
 		/*
 		 * We have just had another interrupt between reading
 		 * count1 and count2.
 		 */
-		offset -= LATCH;
+		offset -= RPC_LATCH;
 	}
 
-	offset = (LATCH - offset) * (tick_nsec / 1000);
-	return ((offset + LATCH/2) / LATCH) * 1000;
+	offset = (RPC_LATCH - offset) * (tick_nsec / 1000);
+	return DIV_ROUND_CLOSEST(offset, RPC_LATCH) * 1000;
 }
 
 void __init ioctime_init(void)
 {
-	ioc_writeb(LATCH & 255, IOC_T0LTCHL);
-	ioc_writeb(LATCH >> 8, IOC_T0LTCHH);
+	ioc_writeb(RPC_LATCH & 255, IOC_T0LTCHL);
+	ioc_writeb(RPC_LATCH >> 8, IOC_T0LTCHH);
 	ioc_writeb(0, IOC_T0GO);
 }
 
-- 
1.8.4.4
