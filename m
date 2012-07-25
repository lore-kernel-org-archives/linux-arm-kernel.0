From: ccross@android.com (Colin Cross)
Date: Tue, 24 Jul 2012 19:49:44 -0700
Subject: [RFC v2] ARM: sched_clock: update epoch_cyc on resume
Message-ID: <1343184588-20239-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many clocks that are used to provide sched_clock will reset during
suspend.  If read_sched_clock returns 0 after suspend, sched_clock will
appear to jump forward.  This patch resets cd.epoch_cyc to the current
value of read_sched_clock during resume, which causes sched_clock() just
after suspend to return the same value as sched_clock() just before
suspend.

In addition, during the window where epoch_ns has been updated before
suspend, but epoch_cyc has not been updated after suspend, it is unknown
whether the clock has reset or not, and sched_clock() could return a
bogus value.  Add a suspended flag, and return the pre-suspend epoch_ns
value during this period.

The new behavior is triggered by calling setup_sched_clock_needs_suspend
instead of setup_sched_clock.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/include/asm/sched_clock.h |    2 ++
 arch/arm/kernel/sched_clock.c      |   24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
index e3f7572..05b8e82 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -10,5 +10,7 @@
 
 extern void sched_clock_postinit(void);
 extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
+extern void setup_sched_clock_needs_suspend(u32 (*read)(void), int bits,
+		unsigned long rate);
 
 #endif
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 27d186a..f451539 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -21,6 +21,8 @@ struct clock_data {
 	u32 epoch_cyc_copy;
 	u32 mult;
 	u32 shift;
+	bool suspended;
+	bool needs_suspend;
 };
 
 static void sched_clock_poll(unsigned long wrap_ticks);
@@ -49,6 +51,9 @@ static unsigned long long cyc_to_sched_clock(u32 cyc, u32 mask)
 	u64 epoch_ns;
 	u32 epoch_cyc;
 
+	if (cd.suspended)
+		return cd.epoch_ns;
+
 	/*
 	 * Load the epoch_cyc and epoch_ns atomically.  We do this by
 	 * ensuring that we always write epoch_cyc, epoch_ns and
@@ -98,6 +103,13 @@ static void sched_clock_poll(unsigned long wrap_ticks)
 	update_sched_clock();
 }
 
+void __init setup_sched_clock_needs_suspend(u32 (*read)(void), int bits,
+		unsigned long rate)
+{
+	setup_sched_clock(read, bits, rate);
+	cd.needs_suspend = true;
+}
+
 void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
 {
 	unsigned long r, w;
@@ -169,11 +181,23 @@ void __init sched_clock_postinit(void)
 static int sched_clock_suspend(void)
 {
 	sched_clock_poll(sched_clock_timer.data);
+	if (cd.needs_suspend)
+		cd.suspended = true;
 	return 0;
 }
 
+static void sched_clock_resume(void)
+{
+	if (cd.needs_suspend) {
+		cd.epoch_cyc = read_sched_clock();
+		cd.epoch_cyc_copy = cd.epoch_cyc;
+		cd.suspended = false;
+	}
+}
+
 static struct syscore_ops sched_clock_ops = {
 	.suspend = sched_clock_suspend,
+	.resume = sched_clock_resume,
 };
 
 static int __init sched_clock_syscore_init(void)
-- 
1.7.7.3
