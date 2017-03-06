From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 14:24:42 +0000
Subject: [PATCH v3 09/25] ARM: KVM: Convert KVM to use HVC_GET_VECTORS
In-Reply-To: <20170306142458.8875-1-marc.zyngier@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
Message-ID: <20170306142458.8875-10-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The conversion of the HYP stub ABI to something similar to arm64
left the KVM code broken, as it doesn't know about the new
stub numbering. Let's move the various #defines to virt.h, and
let KVM use HVC_GET_VECTORS.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/virt.h  | 8 ++++++++
 arch/arm/kernel/hyp-stub.S   | 4 ----
 arch/arm/kvm/hyp/hyp-entry.S | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 6dae1956c74d..4ea16fcaf2ed 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -94,6 +94,14 @@ extern char __hyp_text_start[];
 extern char __hyp_text_end[];
 #endif
 
+#else
+
+/* Only assembly code should need those */
+
+#define HVC_GET_VECTORS 0
+#define HVC_SET_VECTORS 1
+#define HVC_SOFT_RESTART 2
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! VIRT_H */
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 82915231c6f8..8301db963d83 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -22,10 +22,6 @@
 #include <asm/assembler.h>
 #include <asm/virt.h>
 
-#define HVC_GET_VECTORS 0
-#define HVC_SET_VECTORS 1
-#define HVC_SOFT_RESTART 2
-
 #ifndef ZIMAGE
 /*
  * For the kernel proper, we need to find out the CPU boot mode long after
diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
index 96beb53934c9..1f8db7d21fc5 100644
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -127,7 +127,7 @@ hyp_hvc:
 	pop	{r0, r1, r2}
 
 	/* Check for __hyp_get_vectors */
-	cmp	r0, #-1
+	cmp	r0, #HVC_GET_VECTORS
 	mrceq	p15, 4, r0, c12, c0, 0	@ get HVBAR
 	beq	1f
 
-- 
2.11.0
