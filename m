From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 17:37:50 +0100
Subject: [PATCH 1/5] arm64: el2_setup: Make sure ICC_SRE_EL2.SRE sticks before
 using GICv3 sysregs
In-Reply-To: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
References: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443803874-9566-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contrary to what was originally expected, EL3 firmware can (for whatever
reason) disable GICv3 system register access. In this case, the kernel
explodes very early.

Work around this by testing if the SRE bit sticks or not. If it doesn't,
abort the GICv3 setup, and pray that the firmware has passed a DT that
doesn't contain a GICv3 node.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 90d09ed..351a4de 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -498,6 +498,8 @@ CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	orr	x0, x0, #ICC_SRE_EL2_ENABLE	// Set ICC_SRE_EL2.Enable==1
 	msr_s	ICC_SRE_EL2, x0
 	isb					// Make sure SRE is now set
+	mrs_s	x0, ICC_SRE_EL2			// Read SRE back,
+	tbz	x0, #0, 3f			// and check that it sticks
 	msr_s	ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
 
 3:
-- 
2.1.4
