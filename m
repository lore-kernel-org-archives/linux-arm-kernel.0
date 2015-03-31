From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 31 Mar 2015 16:40:45 +0100
Subject: [PATCH v2 3/4] target-arm: kvm - support for single step
In-Reply-To: <1427816446-31586-1-git-send-email-alex.bennee@linaro.org>
References: <1427816446-31586-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1427816446-31586-4-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for single-step. There isn't much to do on the QEMU
side as after we set-up the request for single step via the debug ioctl
it is all handled within the kernel.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v2
  - convert to using HSR_EC

diff --git a/target-arm/kvm.c b/target-arm/kvm.c
index 290c1fe..ae0f8b2 100644
--- a/target-arm/kvm.c
+++ b/target-arm/kvm.c
@@ -475,6 +475,7 @@ void kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 */
 
 #define HSR_EC_SHIFT            26
+#define HSR_EC_SOFT_STEP        0x32
 #define HSR_EC_SW_BKPT          0x3c
 
 static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
@@ -483,6 +484,13 @@ static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
     int hsr_ec = arch_info->hsr >> HSR_EC_SHIFT;
 
     switch (hsr_ec) {
+    case HSR_EC_SOFT_STEP:
+        if (cs->singlestep_enabled) {
+            return true;
+        } else {
+            error_report("Came out of SINGLE STEP when not enabled");
+        }
+        break;
     case HSR_EC_SW_BKPT:
         if (kvm_find_sw_breakpoint(cs, arch_info->pc)) {
             return true;
@@ -542,6 +550,9 @@ int kvm_arch_on_sigbus(int code, void *addr)
 
 void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
 {
+    if (cs->singlestep_enabled) {
+        dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
+    }
     if (kvm_sw_breakpoints_active(cs)) {
         dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
     }
-- 
2.3.4
