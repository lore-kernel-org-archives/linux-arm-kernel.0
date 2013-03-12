From: robherring2@gmail.com (Rob Herring)
Date: Mon, 11 Mar 2013 21:26:36 -0500
Subject: [PATCH 2/3] ARM: sched_clock: support 64-bit counters
In-Reply-To: <1363055197-17296-1-git-send-email-robherring2@gmail.com>
References: <1363055197-17296-1-git-send-email-robherring2@gmail.com>
Message-ID: <1363055197-17296-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With architected timers, we now have 64-bit counters which can be used
directly for sched_clock. However, the ARM sched_clock code currently just
uses the lower 32-bits and handles wrapping in software. Add support for
using the full 64-bit counter values. If multiple counters are registered,
a 64-bit counter is preferred.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/sched_clock.h |    1 +
 arch/arm/kernel/sched_clock.c      |   29 +++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
index e3f7572..e093ea4 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -10,5 +10,6 @@
 
 extern void sched_clock_postinit(void);
 extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
+extern void setup_sched_clock_64(u64 (*read)(void), unsigned long rate);
 
 #endif
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 040168e..1708357 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -45,6 +45,7 @@ static u32 notrace jiffy_sched_clock_read(void)
 }
 
 static u32 __read_mostly (*read_sched_clock)(void) = jiffy_sched_clock_read;
+static u64 __read_mostly (*read_sched_clock_64)(void);
 
 static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 {
@@ -165,14 +166,38 @@ void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
 	pr_debug("Registered %pF as sched_clock source\n", read);
 }
 
+void __init setup_sched_clock_64(u64 (*read)(void), unsigned long rate)
+{
+	if (cd.rate > rate)
+		return;
+
+	WARN_ON(!irqs_disabled());
+	read_sched_clock_64 = read;
+	cd.rate = rate;
+
+	/* Cache the sched_clock multiplier to save a divide in the hot path. */
+	cd.mult = NSEC_PER_SEC / rate;
+	cd.shift = 0;
+
+	/* Enable IRQ time accounting if we have a fast enough sched_clock */
+	if (irqtime > 0 || (irqtime == -1 && rate >= 1000000))
+		enable_sched_clock_irqtime();
+
+	pr_debug("Registered %pF as sched_clock source\n", read);
+}
+
 unsigned long long notrace sched_clock(void)
 {
-	u32 cyc = read_sched_clock();
-	return cyc_to_sched_clock(cyc, sched_clock_mask);
+	if (read_sched_clock_64)
+		return cyc_to_ns(read_sched_clock_64(), cd.mult, cd.shift);
+
+	return cyc_to_sched_clock(read_sched_clock(), sched_clock_mask);
 }
 
 void __init sched_clock_postinit(void)
 {
+	if (read_sched_clock_64)
+		return;
 	/*
 	 * If no sched_clock function has been provided at that point,
 	 * make it the final one one.
-- 
1.7.10.4
