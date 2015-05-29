From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 29 May 2015 16:19:22 +0100
Subject: [PATCH v5 4/6] target-arm: kvm - support for single step
In-Reply-To: <1432912764-7073-1-git-send-email-alex.bennee@linaro.org>
References: <1432912764-7073-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1432912764-7073-5-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for single-step. There isn't much to do on the QEMU
side as after we set-up the request for single step via the debug ioctl
it is all handled within the kernel.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v2
  - convert to using HSR_EC
v3
  - use internals.h definitions
---
 target-arm/kvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target-arm/kvm.c b/target-arm/kvm.c
index c3bad6f..de2865a 100644
--- a/target-arm/kvm.c
+++ b/target-arm/kvm.c
@@ -528,6 +528,13 @@ static int kvm_handle_debug(CPUState *cs, struct kvm_run *run)
     kvm_cpu_synchronize_state(cs);
 
     switch (hsr_ec) {
+    case EC_SOFTWARESTEP:
+        if (cs->singlestep_enabled) {
+            return true;
+        } else {
+            error_report("Came out of SINGLE STEP when not enabled");
+        }
+        break;
     case EC_AA64_BKPT:
         if (kvm_find_sw_breakpoint(cs, env->pc)) {
             return true;
@@ -588,6 +595,9 @@ int kvm_arch_on_sigbus(int code, void *addr)
 
 void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
 {
+    if (cs->singlestep_enabled) {
+        dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
+    }
     if (kvm_sw_breakpoints_active(cs)) {
         dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
     }
-- 
2.4.1
