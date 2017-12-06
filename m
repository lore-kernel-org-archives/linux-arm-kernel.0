From: will.deacon@arm.com (Will Deacon)
Date: Wed,  6 Dec 2017 12:35:38 +0000
Subject: [PATCH v3 19/20] arm64: mm: Introduce TTBR_ASID_MASK for getting at
 the ASID in the TTBR
In-Reply-To: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
Message-ID: <1512563739-25239-20-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are now a handful of open-coded masks to extract the ASID from a
TTBR value, so introduce a TTBR_ASID_MASK and use that instead.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 3 ++-
 arch/arm64/include/asm/mmu.h         | 1 +
 arch/arm64/include/asm/uaccess.h     | 4 ++--
 arch/arm64/kernel/entry.S            | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 21b8cf304028..f4f234b6155e 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -4,6 +4,7 @@
 
 #include <asm/alternative.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/mmu.h>
 #include <asm/sysreg.h>
 #include <asm/assembler.h>
 
@@ -17,7 +18,7 @@
 	msr	ttbr0_el1, \tmp1		// set reserved TTBR0_EL1
 	isb
 	sub	\tmp1, \tmp1, #SWAPPER_DIR_SIZE
-	bic	\tmp1, \tmp1, #(0xffff << 48)
+	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
 	msr	ttbr1_el1, \tmp1		// set reserved ASID
 	isb
 	.endm
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index da6f12e40714..6f7bdb89817f 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,6 +18,7 @@
 
 #define MMCF_AARCH32	0x1	/* mm context flag for AArch32 executables */
 #define USER_ASID_FLAG	(UL(1) << 48)
+#define TTBR_ASID_MASK	(UL(0xffff) << 48)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 750a3b76a01c..6eadf55ebaf0 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -112,7 +112,7 @@ static inline void __uaccess_ttbr0_disable(void)
 	write_sysreg(ttbr + SWAPPER_DIR_SIZE, ttbr0_el1);
 	isb();
 	/* Set reserved ASID */
-	ttbr &= ~(0xffffUL << 48);
+	ttbr &= ~TTBR_ASID_MASK;
 	write_sysreg(ttbr, ttbr1_el1);
 	isb();
 }
@@ -131,7 +131,7 @@ static inline void __uaccess_ttbr0_enable(void)
 
 	/* Restore active ASID */
 	ttbr1 = read_sysreg(ttbr1_el1);
-	ttbr1 |= ttbr0 & (0xffffUL << 48);
+	ttbr1 |= ttbr0 & TTBR_ASID_MASK;
 	write_sysreg(ttbr1, ttbr1_el1);
 	isb();
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 5d51bdbb2131..3eabcb194c87 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -205,7 +205,7 @@ alternative_else_nop_endif
 
 	.if	\el != 0
 	mrs	x21, ttbr1_el1
-	tst	x21, #0xffff << 48		// Check for the reserved ASID
+	tst	x21, #TTBR_ASID_MASK		// Check for the reserved ASID
 	orr	x23, x23, #PSR_PAN_BIT		// Set the emulated PAN in the saved SPSR
 	b.eq	1f				// TTBR0 access already disabled
 	and	x23, x23, #~PSR_PAN_BIT		// Clear the emulated PAN in the saved SPSR
-- 
2.1.4
