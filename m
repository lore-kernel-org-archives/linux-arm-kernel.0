From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 15:58:32 -0500
Subject: [PATCH v2 1/3] ARM: sched_clock: allow changing to higher frequency
 counter
In-Reply-To: <1364849914-26420-1-git-send-email-robherring2@gmail.com>
References: <1364849914-26420-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364849914-26420-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Allow multiple calls to setup_sched_clock and switch to the new counter
if it is higher frequency.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/sched_clock.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index bd6f56b..040168e 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -20,6 +20,7 @@ struct clock_data {
 	u64 epoch_ns;
 	u32 epoch_cyc;
 	u32 epoch_cyc_copy;
+	unsigned long rate;
 	u32 mult;
 	u32 shift;
 	bool suspended;
@@ -113,11 +114,14 @@ void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
 	u64 res, wrap;
 	char r_unit;
 
+	if (cd.rate > rate)
+		return;
+
 	BUG_ON(bits > 32);
 	WARN_ON(!irqs_disabled());
-	WARN_ON(read_sched_clock != jiffy_sched_clock_read);
 	read_sched_clock = read;
 	sched_clock_mask = (1 << bits) - 1;
+	cd.rate = rate;
 
 	/* calculate the mult/shift to convert counter ticks to ns. */
 	clocks_calc_mult_shift(&cd.mult, &cd.shift, rate, NSEC_PER_SEC, 0);
-- 
1.7.10.4
