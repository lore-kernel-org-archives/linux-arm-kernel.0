From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:17 +0100
Subject: [PATCH 11/14] arm64: big-endian: set correct endianess on kernel entry
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-12-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The endianness of memory accesses at EL2 and EL1 are configured by
SCTLR_EL2.EE and SCTLR_EL1.EE respectively. When the kernel is booted,
the state of SCTLR_EL{2,1}.EE is unknown, and thus the kernel must
ensure that they are set before performing any memory accesses.

This patch ensures that SCTLR_EL{2,1} are configured appropriately at
boot for kernels of either endianness.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm64/kernel/head.S |   17 ++++++++++++++---
 arch/arm64/mm/proc.S     |    4 ++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b3fcdf4..cd0ecb1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -159,12 +159,22 @@ ENTRY(el2_setup)
 	mrs	x0, CurrentEL
 	cmp	x0, #PSR_MODE_EL2t
 	ccmp	x0, #PSR_MODE_EL2h, #0x4, ne
-	b.eq	1f
+	b.ne	1f
+	mrs	x0, sctlr_el2
+CPU_BE(	orr	x0, x0, #(1 << 25)	)	// Set the EE bit for EL2
+CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
+	msr	sctlr_el2, x0
+	b	2f
+1:	mrs	x0, sctlr_el1
+CPU_BE(	orr	x0, x0, #(2 << 24)	)	// Set the EE and E0E bits for EL1
+CPU_LE(	bic	x0, x0, #(2 << 24)	)	// Clear the EE and E0E bits for EL1
+	msr	sctlr_el1, x0
 	mov	w20, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
+	isb
 	ret
 
 	/* Hyp configuration. */
-1:	mov	x0, #(1 << 31)			// 64-bit EL1
+2:	mov	x0, #(1 << 31)			// 64-bit EL1
 	msr	hcr_el2, x0
 
 	/* Generic timers. */
@@ -181,7 +191,8 @@ ENTRY(el2_setup)
 
 	/* sctlr_el1 */
 	mov	x0, #0x0800			// Set/clear RES{1,0} bits
-	movk	x0, #0x30d0, lsl #16
+CPU_BE(	movk	x0, #0x33d0, lsl #16	)	// Set EE and E0E on BE systems
+CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 	msr	sctlr_el1, x0
 
 	/* Coprocessor traps. */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index b1b31bb..421b99f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -162,9 +162,9 @@ ENDPROC(__cpu_setup)
 	 *       CE0      XWHW CZ     ME TEEA S
 	 * .... .IEE .... NEAI TE.I ..AD DEN0 ACAM
 	 * 0011 0... 1101 ..0. ..0. 10.. .... .... < hardware reserved
-	 * .... .100 .... 01.1 11.1 ..01 0001 1101 < software settings
+	 * .... .1.. .... 01.1 11.1 ..01 0001 1101 < software settings
 	 */
 	.type	crval, #object
 crval:
-	.word	0x030802e2			// clear
+	.word	0x000802e2			// clear
 	.word	0x0405d11d			// set
-- 
1.7.9.5
