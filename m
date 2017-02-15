From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Feb 2017 14:54:16 +0000
Subject: [PATCH 1/2] arm64: reduce el2_setup branching
In-Reply-To: <1487170457-17986-1-git-send-email-mark.rutland@arm.com>
References: <1487170457-17986-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1487170457-17986-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early el2_setup code is a little convoluted, with two branches where
one would do. This makes the code more painful to read than is
necessary.

We can remove a branch and simplify the logic by moving the early return
in the booted-at-EL1 case earlier in the function. This separates it
from all the setup logic that only makes sense for EL2.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/head.S | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4fb6ccd..2c37334 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -534,13 +534,8 @@ ENTRY(kimage_vaddr)
 ENTRY(el2_setup)
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
-	b.ne	1f
-	mrs	x0, sctlr_el2
-CPU_BE(	orr	x0, x0, #(1 << 25)	)	// Set the EE bit for EL2
-CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
-	msr	sctlr_el2, x0
-	b	2f
-1:	mrs	x0, sctlr_el1
+	b.eq	1f
+	mrs	x0, sctlr_el1
 CPU_BE(	orr	x0, x0, #(3 << 24)	)	// Set the EE and E0E bits for EL1
 CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	msr	sctlr_el1, x0
@@ -548,7 +543,11 @@ CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	isb
 	ret
 
-2:
+1:	mrs	x0, sctlr_el2
+CPU_BE(	orr	x0, x0, #(1 << 25)	)	// Set the EE bit for EL2
+CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
+	msr	sctlr_el2, x0
+
 #ifdef CONFIG_ARM64_VHE
 	/*
 	 * Check for VHE being present. For the rest of the EL2 setup,
-- 
1.9.1
