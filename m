From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 31 Mar 2015 16:40:44 +0100
Subject: [PATCH v2 2/4] target-arm: kvm - implement software breakpoints
In-Reply-To: <1427816446-31586-1-git-send-email-alex.bennee@linaro.org>
References: <1427816446-31586-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1427816446-31586-3-git-send-email-alex.bennee@linaro.org>
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

diff --git a/target-arm/kvm.c b/target-arm/kvm.c
index 72c1fa1..290c1fe 100644
--- a/target-arm/kvm.c
+++ b/target-arm/kvm.c
@@ -25,6 +25,7 @@
 #include "hw/arm/arm.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
+    KVM_CAP_INFO(SET_GUEST_DEBUG),
     KVM_CAP_LAST_INFO
 };
 
@@ -466,9 +467,57 @@ void kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 {
 }
 
+/* See ARM ARM D7.2.27 ESR_ELx, Exception Syndrome Register
+**
+** To minimise translating between kernel and user-space the kernel
+** ABI just provides user-space with the full exception syndrome
+** register value to be decoded in QEMU.
+*/
+
+#define HSR_EC_SHIFT            26
+#define HSR_EC_SW_BKPT          0x3c
+
+static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
+{
+    struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
+    int hsr_ec = arch_info->hsr >> HSR_EC_SHIFT;
+
+    switch (hsr_ec) {
+    case HSR_EC_SW_BKPT:
+        if (kvm_find_sw_breakpoint(cs, arch_info->pc)) {
+            return true;
+        }
+        break;
+    default:
+        error_report("%s: unhandled debug exit (%x, %llx)\n",
+                     __func__, arch_info->hsr, arch_info->pc);
+    }
+
+    /* If we don't handle this it could be it really is for the
+       guest to handle */
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: re-injecting exception not yet implemented (0x%x, %llx)\n",
+                  __func__, hsr_ec, arch_info->pc);
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
@@ -493,14 +542,33 @@ int kvm_arch_on_sigbus(int code, void *addr)
 
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
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-    return -EINVAL;
+    static const uint32_t brk = 0xd4200000;
+
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
+        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 1)) {
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
+        brk != 0xd4200000 ||
+        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
+        return -EINVAL;
+    }
+    return 0;
 }
 
 int kvm_arch_insert_hw_breakpoint(target_ulong addr,
@@ -517,12 +585,6 @@ int kvm_arch_remove_hw_breakpoint(target_ulong addr,
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
2.3.4
