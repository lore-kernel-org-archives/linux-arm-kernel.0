From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Sep 2015 15:24:07 +0100
Subject: [PATCH 1/4] arm: kvm: Move TTBCR_* definitions from kvm_arm.h into
 pgtable-3level-hwdef.h
In-Reply-To: <1443018250-22893-1-git-send-email-catalin.marinas@arm.com>
References: <1443018250-22893-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1443018250-22893-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These macros will be reused in a subsequent patch, so share the
definitions between core arm code and KVM. The patch also renames some
of the macros by appending the more appropriate _MASK suffix. Note that
these macros are only relevant to LPAE kernel builds, therefore they are
added to pgtable-3level-hwdef.h

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/kvm_arm.h              | 17 ++---------------
 arch/arm/include/asm/pgtable-3level-hwdef.h | 17 +++++++++++++++++
 arch/arm/kvm/init.S                         |  2 +-
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index d995821f1698..0ece3bb82b97 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -88,21 +88,8 @@
 #define HSCTLR_MASK	(HSCTLR_M | HSCTLR_A | HSCTLR_C | HSCTLR_I | \
 			 HSCTLR_WXN | HSCTLR_FI | HSCTLR_EE | HSCTLR_TE)
 
-/* TTBCR and HTCR Registers bits */
-#define TTBCR_EAE	(1 << 31)
-#define TTBCR_IMP	(1 << 30)
-#define TTBCR_SH1	(3 << 28)
-#define TTBCR_ORGN1	(3 << 26)
-#define TTBCR_IRGN1	(3 << 24)
-#define TTBCR_EPD1	(1 << 23)
-#define TTBCR_A1	(1 << 22)
-#define TTBCR_T1SZ	(7 << 16)
-#define TTBCR_SH0	(3 << 12)
-#define TTBCR_ORGN0	(3 << 10)
-#define TTBCR_IRGN0	(3 << 8)
-#define TTBCR_EPD0	(1 << 7)
-#define TTBCR_T0SZ	(7 << 0)
-#define HTCR_MASK	(TTBCR_T0SZ | TTBCR_IRGN0 | TTBCR_ORGN0 | TTBCR_SH0)
+/* HTCR Register bits */
+#define HTCR_MASK	(TTBCR_T0SZ_MASK | TTBCR_IRGN0_MASK | TTBCR_ORGN0_MASK | TTBCR_SH0_MASK)
 
 /* Hyp System Trap Register */
 #define HSTR_T(x)	(1 << x)
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
index f8f1cff62065..3ed7965106e3 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -105,4 +105,21 @@
 
 #define TTBR1_SIZE	(((PAGE_OFFSET >> 30) - 1) << 16)
 
+/*
+ * TTBCR register bits.
+ */
+#define TTBCR_EAE		(1 << 31)
+#define TTBCR_IMP		(1 << 30)
+#define TTBCR_SH1_MASK		(3 << 28)
+#define TTBCR_ORGN1_MASK	(3 << 26)
+#define TTBCR_IRGN1_MASK	(3 << 24)
+#define TTBCR_EPD1		(1 << 23)
+#define TTBCR_A1		(1 << 22)
+#define TTBCR_T1SZ_MASK		(7 << 16)
+#define TTBCR_SH0_MASK		(3 << 12)
+#define TTBCR_ORGN0_MASK	(3 << 10)
+#define TTBCR_IRGN0_MASK	(3 << 8)
+#define TTBCR_EPD0		(1 << 7)
+#define TTBCR_T0SZ_MASK		(7 << 0)
+
 #endif
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 3988e72d16ff..fdceab289d03 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -80,7 +80,7 @@ __do_hyp_init:
 	ldr	r2, =HTCR_MASK
 	bic	r0, r0, r2
 	mrc	p15, 0, r1, c2, c0, 2	@ TTBCR
-	and	r1, r1, #(HTCR_MASK & ~TTBCR_T0SZ)
+	and	r1, r1, #(HTCR_MASK & ~TTBCR_T0SZ_MASK)
 	orr	r0, r0, r1
 	mcr	p15, 4, r0, c2, c0, 2	@ HTCR
 
