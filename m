From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  4 Mar 2015 14:35:48 +0000
Subject: [PATCH v2 1/6] target-arm: kvm: save/restore mp state
In-Reply-To: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1425479753-18349-2-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the saving and restore of the current Multi-Processing state
of the machine. While the KVM_GET/SET_MP_STATE API exposes a number of
potential states for x86 we only use two for ARM. Either the process is
running or not. We then save this state into the cpu_powered TCG state
to avoid changing the serialisation format.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v2
  - make mpstate field runtime dependant (kvm_enabled())
  - drop initial KVM_CAP_MP_STATE requirement
  - re-use cpu_powered instead of new field

diff --git a/target-arm/machine.c b/target-arm/machine.c
index 9446e5a..185f9a2 100644
--- a/target-arm/machine.c
+++ b/target-arm/machine.c
@@ -161,6 +161,7 @@ static const VMStateInfo vmstate_cpsr = {
     .put = put_cpsr,
 };
 
+
 static void cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -170,6 +171,20 @@ static void cpu_pre_save(void *opaque)
             /* This should never fail */
             abort();
         }
+#if defined CONFIG_KVM
+        if (kvm_check_extension(CPU(cpu)->kvm_state, KVM_CAP_MP_STATE)) {
+            struct kvm_mp_state mp_state;
+            int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
+            if (ret) {
+                fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
+                        __func__, ret, strerror(ret));
+                abort();
+            }
+            cpu->powered_off =
+                (mp_state.mp_state == KVM_MP_STATE_RUNNABLE)
+                ? false : true;
+        }
+#endif
     } else {
         if (!write_cpustate_to_list(cpu)) {
             /* This should never fail. */
@@ -222,6 +237,20 @@ static int cpu_post_load(void *opaque, int version_id)
          * we're using it.
          */
         write_list_to_cpustate(cpu);
+#if defined CONFIG_KVM
+        if (kvm_check_extension(CPU(cpu)->kvm_state, KVM_CAP_MP_STATE)) {
+            struct kvm_mp_state mp_state = {
+                .mp_state =
+                cpu->powered_off ? KVM_MP_STATE_HALTED : KVM_MP_STATE_RUNNABLE
+            };
+            int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
+            if (ret) {
+                fprintf(stderr, "%s: failed to set MP_STATE %d/%s\n",
+                        __func__, ret, strerror(ret));
+                return -1;
+            }
+        }
+#endif
     } else {
         if (!write_list_to_cpustate(cpu)) {
             return -1;
-- 
2.3.1
