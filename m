From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue,  8 Dec 2015 18:32:28 +0000
Subject: [PATCH v10 1/6] target-arm: kvm64 - introduce kvm_arm_init_debug()
In-Reply-To: <1449599553-24713-1-git-send-email-alex.bennee@linaro.org>
References: <1449599553-24713-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1449599553-24713-2-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we haven't always had guest debug support we need to probe for it.
Additionally we don't do this in the start-up capability code so we
don't fall over on old kernels.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 target-arm/kvm64.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
index ceebfeb..d087794 100644
--- a/target-arm/kvm64.c
+++ b/target-arm/kvm64.c
@@ -25,6 +25,22 @@
 #include "internals.h"
 #include "hw/arm/arm.h"
 
+static bool have_guest_debug;
+
+/**
+ * kvm_arm_init_debug()
+ * @cs: CPUState
+ *
+ * Check for guest debug capabilities.
+ *
+ */
+static void kvm_arm_init_debug(CPUState *cs)
+{
+    have_guest_debug = kvm_check_extension(cs->kvm_state,
+                                           KVM_CAP_SET_GUEST_DEBUG);
+    return;
+}
+
 static inline void set_feature(uint64_t *features, int feature)
 {
     *features |= 1ULL << feature;
@@ -121,6 +137,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
+    kvm_arm_init_debug(cs);
+
     return kvm_arm_init_cpreg_list(cpu);
 }
 
-- 
2.6.3
