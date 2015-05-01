From: ayyappa.ch.linux@gmail.com (Ayyappa Ch)
Date: Fri, 1 May 2015 13:03:55 +0530
Subject: [Patchv2] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Message-ID: <CAPyr0yJ0JjxdrY7Gc+ANSM8JCMVOUGvpPxsSetWa9NHqPmidBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following Anders Roxell  patch on "Enable PREEMPT_RT_FULL" , observed
one issue with Cyclic test while running floating point operations. So
, modified below changes for that.

>From e6a5fce9b3b55f48656240036a9354a0997c2907 Mon Sep 17 00:00:00 2001
From: Ayyappa Ch <ayyappa.chandolu@amd.com>
Date: Tue, 28 Apr 2015 11:53:00 +0530
Subject: [PATCH ] floating point realtime fix

---
 arch/arm64/kernel/fpsimd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2438497..3dca156 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -166,10 +166,10 @@ void fpsimd_flush_thread(void)
  */
 void fpsimd_preserve_current_state(void)
 {
- preempt_disable();
+ migrate_disable();
  if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
  fpsimd_save_state(&current->thread.fpsimd_state);
- preempt_enable();
+ migrate_enable();
 }

 /*
@@ -179,7 +179,7 @@ void fpsimd_preserve_current_state(void)
  */
 void fpsimd_restore_current_state(void)
 {
- preempt_disable();
+ migrate_disable();
  if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
  struct fpsimd_state *st = &current->thread.fpsimd_state;

@@ -187,7 +187,7 @@ void fpsimd_restore_current_state(void)
  this_cpu_write(fpsimd_last_state, st);
  st->cpu = smp_processor_id();
  }
- preempt_enable();
+ migrate_enable();
 }

 /*
@@ -197,7 +197,7 @@ void fpsimd_restore_current_state(void)
  */
 void fpsimd_update_current_state(struct fpsimd_state *state)
 {
- preempt_disable();
+ migrate_disable();
  fpsimd_load_state(state);
  if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
  struct fpsimd_state *st = &current->thread.fpsimd_state;
@@ -205,7 +205,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
  this_cpu_write(fpsimd_last_state, st);
  st->cpu = smp_processor_id();
  }
- preempt_enable();
+ migrate_enable();
 }

 /*
@@ -239,7 +239,7 @@ void kernel_neon_begin_partial(u32 num_regs)
  * that there is no longer userland FPSIMD state in the
  * registers.
  */
- preempt_disable();
+ migrate_disable();
  if (current->mm &&
     !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
  fpsimd_save_state(&current->thread.fpsimd_state);
@@ -255,7 +255,7 @@ void kernel_neon_end(void)
  in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
  fpsimd_load_partial_state(s);
  } else {
- preempt_enable();
+ migrate_enable();
  }
 }
 EXPORT_SYMBOL(kernel_neon_end);
-- 
1.9.1
