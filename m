From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Feb 2017 14:54:17 +0000
Subject: [PATCH 2/2] arm64: move !VHE work to end of el2_setup
In-Reply-To: <1487170457-17986-1-git-send-email-mark.rutland@arm.com>
References: <1487170457-17986-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1487170457-17986-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We only need to initialise sctlr_el1 if we're installing an EL2 stub, so
we may as well defer this until we're doing so. Similarly, we can defer
intialising CPTR_EL2 until then, as we do not access any trapped
functionality as part of el2_setup.

This patch modified el2_setup accordingly, allowing us to remove a
branch and simplify the code flow.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/head.S | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2c37334..0b13748 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -611,26 +611,6 @@ set_hcr:
 	msr	vpidr_el2, x0
 	msr	vmpidr_el2, x1
 
-	/*
-	 * When VHE is not in use, early init of EL2 and EL1 needs to be
-	 * done here.
-	 * When VHE _is_ in use, EL1 will not be used in the host and
-	 * requires no configuration, and all non-hyp-specific EL2 setup
-	 * will be done via the _EL1 system register aliases in __cpu_setup.
-	 */
-	cbnz	x2, 1f
-
-	/* sctlr_el1 */
-	mov	x0, #0x0800			// Set/clear RES{1,0} bits
-CPU_BE(	movk	x0, #0x33d0, lsl #16	)	// Set EE and E0E on BE systems
-CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
-	msr	sctlr_el1, x0
-
-	/* Coprocessor traps. */
-	mov	x0, #0x33ff
-	msr	cptr_el2, x0			// Disable copro. traps to EL2
-1:
-
 #ifdef CONFIG_COMPAT
 	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
 #endif
@@ -667,6 +647,23 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 	ret
 
 install_el2_stub:
+	/*
+	 * When VHE is not in use, early init of EL2 and EL1 needs to be
+	 * done here.
+	 * When VHE _is_ in use, EL1 will not be used in the host and
+	 * requires no configuration, and all non-hyp-specific EL2 setup
+	 * will be done via the _EL1 system register aliases in __cpu_setup.
+	 */
+	/* sctlr_el1 */
+	mov	x0, #0x0800			// Set/clear RES{1,0} bits
+CPU_BE(	movk	x0, #0x33d0, lsl #16	)	// Set EE and E0E on BE systems
+CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
+	msr	sctlr_el1, x0
+
+	/* Coprocessor traps. */
+	mov	x0, #0x33ff
+	msr	cptr_el2, x0			// Disable copro. traps to EL2
+
 	/* Hypervisor stub */
 	adr_l	x0, __hyp_stub_vectors
 	msr	vbar_el2, x0
-- 
1.9.1
