From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Fri, 18 Aug 2017 22:23:45 +0800
Subject: [PATCH v11 4/6] target-arm: kvm64: detect guest RAS EXTENSION feature
In-Reply-To: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1503066227-18251-5-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

check if kvm supports guest RAS EXTENSION. if so, set
corresponding feature bit for vcpu.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 linux-headers/linux/kvm.h | 1 +
 target/arm/cpu.h          | 3 +++
 target/arm/kvm64.c        | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 7971a4f..2aa176e 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -929,6 +929,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
+#define KVM_CAP_ARM_RAS_EXTENSION 150
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b39d64a..6b0961b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -611,6 +611,8 @@ struct ARMCPU {
 
     /* CPU has memory protection unit */
     bool has_mpu;
+    /* CPU has ras extension unit */
+    bool has_ras_extension;
     /* PMSAv7 MPU number of supported regions */
     uint32_t pmsav7_dregion;
 
@@ -1229,6 +1231,7 @@ enum arm_features {
     ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
+    ARM_FEATURE_RAS_EXTENSION, /*has RAS extension support */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index a16abc8..0781367 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -518,6 +518,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
         unset_feature(&env->features, ARM_FEATURE_PMU);
     }
 
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_RAS_EXTENSION)) {
+        cpu->has_ras_extension = true;
+        set_feature(&env->features, ARM_FEATURE_RAS_EXTENSION);
+    } else {
+        cpu->has_ras_extension = false;
+        unset_feature(&env->features, ARM_FEATURE_RAS_EXTENSION);
+    }
+
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cs);
     if (ret) {
-- 
1.8.3.1
