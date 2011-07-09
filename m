From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 09 Jul 2011 17:33:11 +0100
Subject: [PATCH 2/3] ARM: vfp: rename check_exception to vfp_hw_state_valid
In-Reply-To: <20110709163207.GN4812@n2100.arm.linux.org.uk>
References: <20110709163207.GN4812@n2100.arm.linux.org.uk>
Message-ID: <E1QfaSt-0006QJ-Or@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename this branch to more accurately reflect why its taken, rather
than what the following code does.  It is the only caller of this code.
This helps to clarify following changes, yet this change results in no
actual code change.

Document the VFP hardware state at the target of this branch.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/vfp/vfphw.S |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index c75443e..404538a 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -81,11 +81,8 @@ ENTRY(vfp_support_entry)
 	orr	r1, r1, #FPEXC_EN	@ user FPEXC has the enable bit set
 	ldr	r4, [r3, r11, lsl #2]	@ vfp_current_hw_state pointer
 	bic	r5, r1, #FPEXC_EX	@ make sure exceptions are disabled
-	cmp	r4, r10
-	beq	check_for_exception	@ we are returning to the same
-					@ process, so the registers are
-					@ still there.  In this case, we do
-					@ not want to drop a pending exception.
+	cmp	r4, r10			@ this thread owns the hw context?
+	beq	vfp_hw_state_valid
 
 	VFPFMXR	FPEXC, r5		@ enable VFP, disable any pending
 					@ exceptions, so we can get at the
@@ -132,7 +129,8 @@ no_old_VFP_process:
 #endif
 	VFPFMXR	FPSCR, r5		@ restore status
 
-check_for_exception:
+@ The context stored in the VFP hardware is up to date with this thread
+vfp_hw_state_valid:
 	tst	r1, #FPEXC_EX
 	bne	process_exception	@ might as well handle the pending
 					@ exception before retrying branch
-- 
1.7.4.4
