From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Sep 2017 15:09:49 +0100
Subject: [PATCH v5 5/7] arm64: head: Init PMSCR_EL2.{PA,
 PCT} when entered at EL2 without VHE
In-Reply-To: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
References: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
Message-ID: <1506607791-8621-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting at EL2, ensure that we permit the EL1 host to sample
physical addresses and physical counter values using SPE.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/head.S | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7434ec0c7a27..c370e270ae55 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -479,14 +479,21 @@ set_hcr:
 
 	/* Statistical profiling */
 	ubfx	x0, x1, #32, #4			// Check ID_AA64DFR0_EL1 PMSVer
-	cbz	x0, 6f				// Skip if SPE not present
-	cbnz	x2, 5f				// VHE?
+	cbz	x0, 7f				// Skip if SPE not present
+	cbnz	x2, 6f				// VHE?
+	mrs_s	x4, SYS_PMBIDR_EL1		// If SPE available at EL2,
+	and	x4, x4, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
+	cbnz	x4, 5f				// then permit sampling of physical
+	mov	x4, #(1 << SYS_PMSCR_EL2_PCT_SHIFT | \
+		      1 << SYS_PMSCR_EL2_PA_SHIFT)
+	msr_s	SYS_PMSCR_EL2, x4		// addresses and physical counter
+5:
 	mov	x1, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
 	orr	x3, x3, x1			// If we don't have VHE, then
-	b	6f				// use EL1&0 translation.
-5:						// For VHE, use EL2 translation
+	b	7f				// use EL1&0 translation.
+6:						// For VHE, use EL2 translation
 	orr	x3, x3, #MDCR_EL2_TPMS		// and disable access from EL1
-6:
+7:
 	msr	mdcr_el2, x3			// Configure debug traps
 
 	/* Stage-2 translation */
-- 
2.1.4
