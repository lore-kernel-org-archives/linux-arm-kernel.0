From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Oct 2012 17:46:38 +0100
Subject: [PATCH 2/4] arm64: Fix the update_vsyscall() prototype
In-Reply-To: <1350406000-30882-1-git-send-email-catalin.marinas@arm.com>
References: <1350406000-30882-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1350406000-30882-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 576094b7 (time: Introduce new GENERIC_TIME_VSYSCALL) the old
update_vsyscall() prototype is no longer available. This patch updates
the arm64 port.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/kernel/vdso.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 17948fc..ba45794 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -28,6 +28,7 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
+#include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
 
 #include <asm/cacheflush.h>
@@ -222,11 +223,10 @@ struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
-void update_vsyscall(struct timespec *ts, struct timespec *wtm,
-		     struct clocksource *clock, u32 mult)
+void update_vsyscall(struct timekeeper *tk)
 {
 	struct timespec xtime_coarse;
-	u32 use_syscall = strcmp(clock->name, "arch_sys_counter");
+	u32 use_syscall = strcmp(tk->clock->name, "arch_sys_counter");
 
 	++vdso_data->tb_seq_count;
 	smp_wmb();
@@ -237,13 +237,13 @@ void update_vsyscall(struct timespec *ts, struct timespec *wtm,
 	vdso_data->xtime_coarse_nsec		= xtime_coarse.tv_nsec;
 
 	if (!use_syscall) {
-		vdso_data->cs_cycle_last	= clock->cycle_last;
-		vdso_data->xtime_clock_sec	= ts->tv_sec;
-		vdso_data->xtime_clock_nsec	= ts->tv_nsec;
-		vdso_data->cs_mult		= mult;
-		vdso_data->cs_shift		= clock->shift;
-		vdso_data->wtm_clock_sec	= wtm->tv_sec;
-		vdso_data->wtm_clock_nsec	= wtm->tv_nsec;
+		vdso_data->cs_cycle_last	= tk->clock->cycle_last;
+		vdso_data->xtime_clock_sec	= tk->xtime_sec;
+		vdso_data->xtime_clock_nsec	= tk->xtime_nsec >> tk->shift;
+		vdso_data->cs_mult		= tk->mult;
+		vdso_data->cs_shift		= tk->shift;
+		vdso_data->wtm_clock_sec	= tk->wall_to_monotonic.tv_sec;
+		vdso_data->wtm_clock_nsec	= tk->wall_to_monotonic.tv_nsec;
 	}
 
 	smp_wmb();
