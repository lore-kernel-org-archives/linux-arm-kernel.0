From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed, 25 Feb 2015 16:02:33 +0000
Subject: [PATCH 1/6] target-arm: kvm: save/restore mp state
In-Reply-To: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1424880159-29348-2-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the saving and restore of the current Multi-Processing state
of the machine. While the KVM_GET/SET_MP_STATE API exposes a number of
potential states for x86 we only use two for ARM. Either the process is
running or not.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/target-arm/kvm.c b/target-arm/kvm.c
index 23cefe9..8732854 100644
--- a/target-arm/kvm.c
+++ b/target-arm/kvm.c
@@ -25,6 +25,7 @@
 #include "hw/arm/arm.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
+    KVM_CAP_INFO(MP_STATE),
     KVM_CAP_LAST_INFO
 };
 
diff --git a/target-arm/machine.c b/target-arm/machine.c
index 9446e5a..70b1bc4 100644
--- a/target-arm/machine.c
+++ b/target-arm/machine.c
@@ -161,6 +161,34 @@ static const VMStateInfo vmstate_cpsr = {
     .put = put_cpsr,
 };
 
+#if defined CONFIG_KVM
+static int get_mpstate(QEMUFile *f, void *opaque, size_t size)
+{
+    ARMCPU *cpu = opaque;
+    struct kvm_mp_state mp_state = { .mp_state =  qemu_get_be32(f)};
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
+}
+
+static void put_mpstate(QEMUFile *f, void *opaque, size_t size)
+{
+    ARMCPU *cpu = opaque;
+    struct kvm_mp_state mp_state;
+    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
+    if (ret) {
+        fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
+                __func__, ret, strerror(ret));
+        abort();
+    }
+    qemu_put_be32(f, mp_state.mp_state);
+}
+
+static const VMStateInfo vmstate_mpstate = {
+    .name = "mpstate",
+    .get = get_mpstate,
+    .put = put_mpstate,
+};
+#endif
+
 static void cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -244,6 +272,16 @@ const VMStateDescription vmstate_arm_cpu = {
         VMSTATE_UINT32_ARRAY(env.regs, ARMCPU, 16),
         VMSTATE_UINT64_ARRAY(env.xregs, ARMCPU, 32),
         VMSTATE_UINT64(env.pc, ARMCPU),
+#if defined CONFIG_KVM
+        {
+            .name = "mp_state",
+            .version_id = 0,
+            .size = sizeof(uint32_t),
+            .info = &vmstate_mpstate,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
+#endif
         {
             .name = "cpsr",
             .version_id = 0,
-- 
2.3.0
