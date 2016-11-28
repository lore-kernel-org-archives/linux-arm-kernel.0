From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon, 28 Nov 2016 11:37:39 -0500
Subject: [PATCH] arm64: head.S: Fix CNTHCTL_EL2 access on VHE system
Message-ID: <1480351059-11370-1-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jintack <jintack@cs.columbia.edu>

Bit positions of CNTHCTL_EL2 are changing depending on HCR_EL2.E2H bit.
EL1PCEN and EL1PCTEN are 1st and 0th bits when E2H is not set, but they
are 11th and 10th bits respectively when E2H is set.  Current code is
unintentionally setting wrong bits to CNTHCTL_EL2 with E2H set.

In fact, we don't need to set those two bits, which allow EL1 and EL0 to
access physical timer and counter respectively, if E2H and TGE are set
for the host kernel. They will be configured later as necessary. First,
we don't need to configure those bits for EL1, since the host kernel
runs in EL2.  It is a hypervisor's responsibility to configure them
before entering a VM, which runs in EL0 and EL1. Second, EL0 accesses
are configured in the later stage of boot process.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kernel/head.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 332e331..bc3d2db 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -524,10 +524,16 @@ set_hcr:
 	msr	hcr_el2, x0
 	isb
 
-	/* Generic timers. */
+	/*
+	 * Allow Non-secure EL1 and EL0 to access physical timer and counter.
+	 * This is not necessary for VHE, since the host kernel runs in EL2,
+	 * and EL0 accesses are configured in the later stage of boot process.
+	 */
+	cbnz	x2, 1f
 	mrs	x0, cnthctl_el2
 	orr	x0, x0, #3			// Enable EL1 physical timers
 	msr	cnthctl_el2, x0
+1:
 	msr	cntvoff_el2, xzr		// Clear virtual offset
 
 #ifdef CONFIG_ARM_GIC_V3
-- 
1.9.1
