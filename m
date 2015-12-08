From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue,  8 Dec 2015 18:32:29 +0000
Subject: [PATCH v10 2/6] target-arm: kvm - implement software breakpoints
In-Reply-To: <1449599553-24713-1-git-send-email-alex.bennee@linaro.org>
References: <1449599553-24713-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1449599553-24713-3-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These don't involve messing around with debug registers, just setting
the breakpoint instruction in memory. GDB will not use this mechanism if
it can't access the memory to write the breakpoint.

All the kernel has to do is ensure the hypervisor traps the breakpoint
exceptions and returns to userspace.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

--
v2
  - handle debug exit with new hsr exception info
  - add verbosity to UNIMP message
v3
  - sync with kvm_cpu_synchronize_state() before checking PC.
  - use internals.h defines
  - use env->pc
  - use proper format types
v9
  - add include for error_report
  - define a brk_insn constant
v10
  - fix up for arm32 compile
  - move sw_bp_code to kvm32 (stubs)/64 (working)
  - move kvm_handle_debug to kvm32/64 as kvm_arm_handle_debug
  - don't enable SW_BP unless the define is there
  - wrap in have_guest_debug check
---
 target-arm/kvm.c     | 39 +++++++++++++++++-----------
 target-arm/kvm32.c   | 18 +++++++++++++
 target-arm/kvm64.c   | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target-arm/kvm_arm.h |  9 +++++++
 4 files changed, 123 insertions(+), 15 deletions(-)

diff --git a/target-arm/kvm.c b/target-arm/kvm.c
index 79ef4c6..7f44e22 100644
--- a/target-arm/kvm.c
+++ b/target-arm/kvm.c
@@ -17,6 +17,7 @@
 
 #include "qemu-common.h"
 #include "qemu/timer.h"
+#include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
@@ -516,9 +517,23 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
     return MEMTXATTRS_UNSPECIFIED;
 }
 
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
-    return 0;
+    int ret = 0;
+
+    switch (run->exit_reason) {
+    case KVM_EXIT_DEBUG:
+        if (kvm_arm_handle_debug(cs, &run->debug.arch)) {
+            ret = EXCP_DEBUG;
+        } /* otherwise return to guest */
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
+                      __func__, run->exit_reason);
+        break;
+    }
+    return ret;
 }
 
 bool kvm_arch_stop_on_emulation_error(CPUState *cs)
@@ -541,16 +556,16 @@ int kvm_arch_on_sigbus(int code, void *addr)
     return 1;
 }
 
+/* The #ifdef protections are until 32bit headers are imported and can
+ * be removed once both 32 and 64 bit reach feature parity.
+ */
 void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-}
-
-int kvm_arch_insert_sw_breakpoint(CPUState *cs,
-                                  struct kvm_sw_breakpoint *bp)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-    return -EINVAL;
+#ifdef KVM_GUESTDBG_USE_SW_BP
+    if (kvm_sw_breakpoints_active(cs)) {
+        dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
+    }
+#endif
 }
 
 int kvm_arch_insert_hw_breakpoint(target_ulong addr,
@@ -567,12 +582,6 @@ int kvm_arch_remove_hw_breakpoint(target_ulong addr,
     return -EINVAL;
 }
 
-int kvm_arch_remove_sw_breakpoint(CPUState *cs,
-                                  struct kvm_sw_breakpoint *bp)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-    return -EINVAL;
-}
 
 void kvm_arch_remove_all_hw_breakpoints(void)
 {
diff --git a/target-arm/kvm32.c b/target-arm/kvm32.c
index df1e2b0..5ce969f 100644
--- a/target-arm/kvm32.c
+++ b/target-arm/kvm32.c
@@ -475,3 +475,21 @@ int kvm_arch_get_registers(CPUState *cs)
 
     return 0;
 }
+
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: guest debug not yet implemented\n", __func__);
+    return -EINVAL;
+}
+
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: guest debug not yet implemented\n", __func__);
+    return -EINVAL;
+}
+
+bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: guest debug not yet implemented\n", __func__);
+    return false;
+}
diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
index d087794..3b3929d 100644
--- a/target-arm/kvm64.c
+++ b/target-arm/kvm64.c
@@ -18,6 +18,7 @@
 #include "config-host.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
+#include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
@@ -481,3 +482,74 @@ int kvm_arch_get_registers(CPUState *cs)
     /* TODO: other registers */
     return ret;
 }
+
+/* C6.6.29 BRK instruction */
+static const uint32_t brk_insn = 0xd4200000;
+
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    if (have_guest_debug) {
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
+            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
+            return -EINVAL;
+        }
+        return 0;
+    } else {
+        error_report("guest debug not supported on this kernel");
+        return -EINVAL;
+    }
+}
+
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    static uint32_t brk;
+
+    if (have_guest_debug) {
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
+            brk != brk_insn ||
+            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
+            return -EINVAL;
+        }
+        return 0;
+    } else {
+        error_report("guest debug not supported on this kernel");
+        return -EINVAL;
+    }
+}
+
+/* See v8 ARM ARM D7.2.27 ESR_ELx, Exception Syndrome Register
+ *
+ * To minimise translating between kernel and user-space the kernel
+ * ABI just provides user-space with the full exception syndrome
+ * register value to be decoded in QEMU.
+ */
+
+bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
+{
+    int hsr_ec = debug_exit->hsr >> ARM_EL_EC_SHIFT;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /* Ensure PC is synchronised */
+    kvm_cpu_synchronize_state(cs);
+
+    switch (hsr_ec) {
+    case EC_AA64_BKPT:
+        if (kvm_find_sw_breakpoint(cs, env->pc)) {
+            return true;
+        }
+        break;
+    default:
+        error_report("%s: unhandled debug exit (%"PRIx32", %"PRIx64")\n",
+                     __func__, debug_exit->hsr, env->pc);
+    }
+
+    /* If we don't handle this it could be it really is for the
+       guest to handle */
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: re-injecting exception not yet implemented"
+                  " (0x%"PRIx32", %"PRIx64")\n",
+                  __func__, hsr_ec, env->pc);
+
+    return false;
+}
diff --git a/target-arm/kvm_arm.h b/target-arm/kvm_arm.h
index b516041..88f5b37 100644
--- a/target-arm/kvm_arm.h
+++ b/target-arm/kvm_arm.h
@@ -215,4 +215,13 @@ static inline const char *gic_class_name(void)
  */
 const char *gicv3_class_name(void);
 
+/**
+ * kvm_arm_handle_debug:
+ * @cs: CPUState
+ * @debug_exit: debug part of the KVM exit structure
+ *
+ * Returns: TRUE is the debug exception was handled.
+ */
+bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit);
+
 #endif
-- 
2.6.3
