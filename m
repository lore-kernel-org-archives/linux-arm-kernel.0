From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 29 May 2015 16:19:20 +0100
Subject: [PATCH v5 2/6] target-arm: kvm64: introduce kvm_arm_init_debug()
In-Reply-To: <1432912764-7073-1-git-send-email-alex.bennee@linaro.org>
References: <1432912764-7073-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1432912764-7073-3-git-send-email-alex.bennee@linaro.org>
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
index 93c1ca8..61592d2 100644
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
@@ -107,6 +123,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    kvm_arm_init_debug(cs);
+
     return kvm_arm_init_cpreg_list(cpu);
 }
 
-- 
2.4.1
