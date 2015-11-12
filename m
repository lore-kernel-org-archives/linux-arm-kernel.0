From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 12 Nov 2015 16:20:47 +0000
Subject: [PATCH v9 2/6] target-arm: kvm - implement software breakpoints
In-Reply-To: <1447345251-22625-1-git-send-email-alex.bennee@linaro.org>
References: <1447345251-22625-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1447345251-22625-3-git-send-email-alex.bennee@linaro.org>
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
---
 target-arm/kvm.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 12 deletions(-)

diff --git a/target-arm/kvm.c b/target-arm/kvm.c
index 79ef4c6..50f70ef 100644
--- a/target-arm/kvm.c
+++ b/target-arm/kvm.c
@@ -17,6 +17,7 @@
 
 #include "qemu-common.h"
 #include "qemu/timer.h"
+#include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
@@ -516,9 +517,60 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
     return MEMTXATTRS_UNSPECIFIED;
 }
 
+/* See v8 ARM ARM D7.2.27 ESR_ELx, Exception Syndrome Register
+ *
+ * To minimise translating between kernel and user-space the kernel
+ * ABI just provides user-space with the full exception syndrome
+ * register value to be decoded in QEMU.
+ */
+
+static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
+{
+    struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
+    int hsr_ec = arch_info->hsr >> ARM_EL_EC_SHIFT;
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
+                     __func__, arch_info->hsr, env->pc);
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
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
-    return 0;
+    int ret = 0;
+
+    switch (run->exit_reason) {
+    case KVM_EXIT_DEBUG:
+        if (kvm_handle_debug(cs, run)) {
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
@@ -543,14 +595,34 @@ int kvm_arch_on_sigbus(int code, void *addr)
 
 void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
+    if (kvm_sw_breakpoints_active(cs)) {
+        dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
+    }
 }
 
-int kvm_arch_insert_sw_breakpoint(CPUState *cs,
-                                  struct kvm_sw_breakpoint *bp)
+/* C6.6.29 BRK instruction */
+static const uint32_t brk_insn = 0xd4200000;
+
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-    return -EINVAL;
+
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
+        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    static uint32_t brk;
+
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
+        brk != brk_insn ||
+        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
+        return -EINVAL;
+    }
+    return 0;
 }
 
 int kvm_arch_insert_hw_breakpoint(target_ulong addr,
@@ -567,12 +639,6 @@ int kvm_arch_remove_hw_breakpoint(target_ulong addr,
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
-- 
2.6.3
