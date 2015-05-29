From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 29 May 2015 16:19:24 +0100
Subject: [PATCH v5 6/6] target-arm: kvm - re-inject guest debug exceptions
In-Reply-To: <1432912764-7073-1-git-send-email-alex.bennee@linaro.org>
References: <1432912764-7073-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1432912764-7073-7-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Benn?e <alex@bennee.com>

If we can't find details for the debug exception in our debug state
then we can assume the exception is due to debugging inside the guest.
To inject the exception into the guest state we re-use the TCG exception
code (do_interupt).

However while guest debugging is in effect we currently can't handle the
guest using single step which is heavily used by GDB.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v5:
  - new for v5
---
 target-arm/cpu.h        |  1 +
 target-arm/helper-a64.c | 17 ++++++++++++++---
 target-arm/internals.h  |  1 +
 target-arm/kvm.c        | 30 ++++++++++++++++++++++--------
 4 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/target-arm/cpu.h b/target-arm/cpu.h
index 083211c..95ae3a8 100644
--- a/target-arm/cpu.h
+++ b/target-arm/cpu.h
@@ -56,6 +56,7 @@
 #define EXCP_SMC            13   /* Secure Monitor Call */
 #define EXCP_VIRQ           14
 #define EXCP_VFIQ           15
+#define EXCP_WAPT           16
 
 #define ARMV7M_EXCP_RESET   1
 #define ARMV7M_EXCP_NMI     2
diff --git a/target-arm/helper-a64.c b/target-arm/helper-a64.c
index 861f6fa..32bd27d 100644
--- a/target-arm/helper-a64.c
+++ b/target-arm/helper-a64.c
@@ -25,6 +25,7 @@
 #include "qemu/bitops.h"
 #include "internals.h"
 #include "qemu/crc32c.h"
+#include "sysemu/kvm.h"
 #include <zlib.h> /* For crc32 */
 
 /* C2.4.7 Multiply and divide */
@@ -478,10 +479,13 @@ void aarch64_cpu_do_interrupt(CPUState *cs)
     }
 
     arm_log_exception(cs->exception_index);
-    qemu_log_mask(CPU_LOG_INT, "...from EL%d\n", arm_current_el(env));
+    qemu_log_mask(CPU_LOG_INT, "...from EL%d PC 0x%" PRIx64 "\n",
+                  arm_current_el(env), env->pc);
+
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && !excp_is_internal(cs->exception_index)) {
-        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%" PRIx32 "\n",
+        qemu_log_mask(CPU_LOG_INT, "...with ESR %x/0x%" PRIx32 "\n",
+                      env->exception.syndrome >> ARM_EL_EC_SHIFT,
                       env->exception.syndrome);
     }
 
@@ -494,6 +498,7 @@ void aarch64_cpu_do_interrupt(CPUState *cs)
     switch (cs->exception_index) {
     case EXCP_PREFETCH_ABORT:
     case EXCP_DATA_ABORT:
+    case EXCP_WAPT:
         env->cp15.far_el[new_el] = env->exception.vaddress;
         qemu_log_mask(CPU_LOG_INT, "...with FAR 0x%" PRIx64 "\n",
                       env->cp15.far_el[new_el]);
@@ -539,6 +544,12 @@ void aarch64_cpu_do_interrupt(CPUState *cs)
     aarch64_restore_sp(env, new_el);
 
     env->pc = addr;
-    cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+
+    qemu_log_mask(CPU_LOG_INT, "...to EL%d PC 0x%" PRIx64 " PSTATE 0x%x\n",
+                  new_el, env->pc, pstate_read(env));
+
+    if (!kvm_enabled()) {
+        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+    }
 }
 #endif
diff --git a/target-arm/internals.h b/target-arm/internals.h
index 2cc3017..10e8999 100644
--- a/target-arm/internals.h
+++ b/target-arm/internals.h
@@ -58,6 +58,7 @@ static const char * const excnames[] = {
     [EXCP_SMC] = "Secure Monitor Call",
     [EXCP_VIRQ] = "Virtual IRQ",
     [EXCP_VFIQ] = "Virtual FIQ",
+    [EXCP_WAPT] = "Watchpoint",
 };
 
 static inline void arm_log_exception(int idx)
diff --git a/target-arm/kvm.c b/target-arm/kvm.c
index e1fccdd..6f608d8 100644
--- a/target-arm/kvm.c
+++ b/target-arm/kvm.c
@@ -523,9 +523,11 @@ static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
     struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
     int hsr_ec = arch_info->hsr >> ARM_EL_EC_SHIFT;
     ARMCPU *cpu = ARM_CPU(cs);
+    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = &cpu->env;
+    int forward_excp = EXCP_BKPT;
 
-    /* Ensure PC is synchronised */
+    /* Ensure all state is synchronised */
     kvm_cpu_synchronize_state(cs);
 
     switch (hsr_ec) {
@@ -533,7 +535,14 @@ static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
         if (cs->singlestep_enabled) {
             return true;
         } else {
-            error_report("Came out of SINGLE STEP when not enabled");
+            /*
+             * The kernel should have supressed the guests ability to
+             * single step at this point so something has gone wrong.
+             */
+            error_report("%s: guest single-step while debugging unsupported"
+                         " (%"PRIx64", %"PRIx32")\n",
+                         __func__, env->pc, arch_info->hsr);
+            return false;
         }
         break;
     case EC_AA64_BKPT:
@@ -549,19 +558,24 @@ static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
     case EC_WATCHPOINT:
         if (kvm_arm_find_hw_watchpoint(cs, arch_info->far)) {
             return true;
+        } else {
+            forward_excp = EXCP_WAPT;
         }
         break;
     default:
         error_report("%s: unhandled debug exit (%"PRIx32", %"PRIx64")\n",
                      __func__, arch_info->hsr, env->pc);
+        return false;
     }
 
-    /* If we don't handle this it could be it really is for the
-       guest to handle */
-    qemu_log_mask(LOG_UNIMP,
-                  "%s: re-injecting exception not yet implemented"
-                  " (0x%"PRIx32", %"PRIx64")\n",
-                  __func__, hsr_ec, env->pc);
+    /* If we are not handling the debug exception it must belong to
+     * the guest. Let's re-use the existing TCG interrupt code to set
+     * everything up properly
+     */
+    cs->exception_index = forward_excp;
+    env->exception.syndrome = arch_info->hsr;
+    env->exception.vaddress = arch_info->far;
+    cc->do_interrupt(cs);
 
     return false;
 }
-- 
2.4.1
