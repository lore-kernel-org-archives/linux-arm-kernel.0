From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:15 -0700
Subject: [PATCH v4 02/17] sched_clock: Use seqcount instead of rolling our own
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're going to increase the cyc value to 64 bits in the near
future. Doing that is going to break the custom seqcount
implementation in the sched_clock code because 64 bit numbers
aren't guaranteed to be atomic. Replace the cyc_copy with a
seqcount to avoid this problem.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 kernel/time/sched_clock.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index a326f27..396f7b9 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -14,11 +14,12 @@
 #include <linux/syscore_ops.h>
 #include <linux/timer.h>
 #include <linux/sched_clock.h>
+#include <linux/seqlock.h>
 
 struct clock_data {
 	u64 epoch_ns;
 	u32 epoch_cyc;
-	u32 epoch_cyc_copy;
+	seqcount_t seq;
 	unsigned long rate;
 	u32 mult;
 	u32 shift;
@@ -54,23 +55,16 @@ static unsigned long long notrace sched_clock_32(void)
 	u64 epoch_ns;
 	u32 epoch_cyc;
 	u32 cyc;
+	unsigned long seq;
 
 	if (cd.suspended)
 		return cd.epoch_ns;
 
-	/*
-	 * Load the epoch_cyc and epoch_ns atomically.  We do this by
-	 * ensuring that we always write epoch_cyc, epoch_ns and
-	 * epoch_cyc_copy in strict order, and read them in strict order.
-	 * If epoch_cyc and epoch_cyc_copy are not equal, then we're in
-	 * the middle of an update, and we should repeat the load.
-	 */
 	do {
+		seq = read_seqcount_begin(&cd.seq);
 		epoch_cyc = cd.epoch_cyc;
-		smp_rmb();
 		epoch_ns = cd.epoch_ns;
-		smp_rmb();
-	} while (epoch_cyc != cd.epoch_cyc_copy);
+	} while (read_seqcount_retry(&cd.seq, seq));
 
 	cyc = read_sched_clock();
 	cyc = (cyc - epoch_cyc) & sched_clock_mask;
@@ -90,16 +84,12 @@ static void notrace update_sched_clock(void)
 	ns = cd.epoch_ns +
 		cyc_to_ns((cyc - cd.epoch_cyc) & sched_clock_mask,
 			  cd.mult, cd.shift);
-	/*
-	 * Write epoch_cyc and epoch_ns in a way that the update is
-	 * detectable in cyc_to_fixed_sched_clock().
-	 */
+
 	raw_local_irq_save(flags);
-	cd.epoch_cyc_copy = cyc;
-	smp_wmb();
+	write_seqcount_begin(&cd.seq);
 	cd.epoch_ns = ns;
-	smp_wmb();
 	cd.epoch_cyc = cyc;
+	write_seqcount_end(&cd.seq);
 	raw_local_irq_restore(flags);
 }
 
@@ -195,7 +185,6 @@ static int sched_clock_suspend(void)
 static void sched_clock_resume(void)
 {
 	cd.epoch_cyc = read_sched_clock();
-	cd.epoch_cyc_copy = cd.epoch_cyc;
 	cd.suspended = false;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
