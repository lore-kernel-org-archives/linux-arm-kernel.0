From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 16 Aug 2016 18:49:18 +0100
Subject: [PATCH v2] kvm: arm: Enforce some NS-SVC initialisation
In-Reply-To: <5322cdb9cb397741d15b60c6693ad39dbf74b6d5.1469101945.git.robin.murphy@arm.com>
References: <5322cdb9cb397741d15b60c6693ad39dbf74b6d5.1469101945.git.robin.murphy@arm.com>
Message-ID: <6d030bee2db08c2fe1b7569e692e8f66800b1e4c.1471369569.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the non-secure copies of banked registers lack architecturally
defined reset values, there is no actual guarantee when entering in Hyp
from secure-only firmware that the Non-Secure PL1 state will look the
way that kernel entry (in particular the decompressor stub) expects.
So far, we've been getting away with it thanks to implementation details
of ARMv7 cores and/or bootloader behaviour, but for the sake of forwards
compatibility let's try to ensure that we have a minimally sane state
before dropping down into it.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Initialise SED/ITD to safe values as well.

 arch/arm/kernel/hyp-stub.S | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 0b1e4a93d67e..15d073ae5da2 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -142,6 +142,19 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
 	and	r7, #0x1f		@ Preserve HPMN
 	mcr	p15, 4, r7, c1, c1, 1	@ HDCR
 
+	@ Make sure NS-SVC is initialised appropriately
+	mrc	p15, 0, r7, c1, c0, 0	@ SCTLR
+	orr	r7, #(1 << 5)		@ CP15 barriers enabled
+	bic	r7, #(3 << 7)		@ Clear SED/ITD for v8 (RES0 for v7)
+	bic	r7, #(3 << 19)		@ WXN and UWXN disabled
+	mcr	p15, 0, r7, c1, c0, 0	@ SCTLR
+
+	mrc	p15, 0, r7, c0, c0, 0	@ MIDR
+	mcr	p15, 4, r7, c0, c0, 0	@ VPIDR
+
+	mrc	p15, 0, r7, c0, c0, 5	@ MPIDR
+	mcr	p15, 4, r7, c0, c0, 5	@ VMPIDR
+
 #if !defined(ZIMAGE) && defined(CONFIG_ARM_ARCH_TIMER)
 	@ make CNTP_* and CNTPCT accessible from PL1
 	mrc	p15, 0, r7, c0, c1, 1	@ ID_PFR1
-- 
2.8.1.dirty
