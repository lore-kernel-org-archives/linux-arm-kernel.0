From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  4 Mar 2015 14:35:51 +0000
Subject: [PATCH v2 4/6] target-arm: kvm64 sync FP register state
In-Reply-To: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1425479753-18349-5-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For migration to work we need to sync all of the register state. This is
especially noticeable when GCC starts using FP registers as spill
registers even with integer programs.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
index 8cf3a62..c60e989 100644
--- a/target-arm/kvm64.c
+++ b/target-arm/kvm64.c
@@ -126,9 +126,17 @@ bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
 #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
                  KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
 
+/* The linux headers don't define a 128 bit wide SIMD macro for us */
+#define AARCH64_SIMD_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U128 | \
+                 KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
+
+#define AARCH64_SIMD_CTRL_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U32 | \
+                 KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
     struct kvm_one_reg reg;
+    uint32_t fpr;
     uint64_t val;
     int i;
     int ret;
@@ -207,13 +215,36 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
     }
 
+    /* Advanced SIMD and FP registers */
+    for (i = 0; i < 32; i++) {
+        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
+        reg.addr = (uintptr_t)(&env->vfp.regs[i]);
+        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+        reg.id++;
+    }
+
+    reg.addr = (uintptr_t)(&fpr);
+    fpr = vfp_get_fpsr(env);
+    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
+    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    fpr = vfp_get_fpcr(env);
+    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
+    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
     if (!write_list_to_kvmstate(cpu)) {
         return EINVAL;
     }
 
-    /* TODO:
-     * FP state
-     */
     return ret;
 }
 
@@ -221,6 +252,7 @@ int kvm_arch_get_registers(CPUState *cs)
 {
     struct kvm_one_reg reg;
     uint64_t val;
+    uint32_t fpr;
     int i;
     int ret;
 
@@ -302,9 +334,36 @@ int kvm_arch_get_registers(CPUState *cs)
         }
     }
 
+    /* Advanced SIMD and FP registers */
+    for (i = 0; i < 32; i++) {
+        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
+        reg.addr = (uintptr_t)(&env->vfp.regs[i]);
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+        reg.id++;
+    }
+
+    reg.addr = (uintptr_t)(&fpr);
+    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
+    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+    vfp_set_fpsr(env, fpr);
+
+    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
+    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+    vfp_set_fpcr(env, fpr);
+
     if (!write_kvmstate_to_list(cpu)) {
         return EINVAL;
     }
+
     /* Note that it's OK to have registers which aren't in CPUState,
      * so we can ignore a failure return here.
      */
-- 
2.3.1
