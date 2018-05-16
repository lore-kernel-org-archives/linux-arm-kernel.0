From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 16 May 2018 12:01:49 +0100
Subject: [PATCH 14/14] ARM: KVM: report support for SMCCC_ARCH_WORKAROUND_1
In-Reply-To: <20180516105949.GJ16141@n2100.armlinux.org.uk>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
Message-ID: <E1fIuBp-0003qn-1h@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Report support for SMCCC_ARCH_WORKAROUND_1 to KVM guests for affected
CPUs.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/kvm_host.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 248b930563e5..11f91744ffb0 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -21,6 +21,7 @@
 
 #include <linux/types.h>
 #include <linux/kvm_types.h>
+#include <asm/cputype.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
@@ -311,8 +312,17 @@ static inline void kvm_arm_vhe_guest_exit(void) {}
 
 static inline bool kvm_arm_harden_branch_predictor(void)
 {
-	/* No way to detect it yet, pretend it is not there. */
-	return false;
+	switch(read_cpuid_part()) {
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	case ARM_CPU_PART_BRAHMA_B15:
+	case ARM_CPU_PART_CORTEX_A12:
+	case ARM_CPU_PART_CORTEX_A15:
+	case ARM_CPU_PART_CORTEX_A17:
+		return true;
+#endif
+	default:
+		return false;
+	}
 }
 
 #endif /* __ARM_KVM_HOST_H__ */
-- 
2.7.4
