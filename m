From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Jun 2015 13:53:11 +0100
Subject: [PATCH 07/12] KVM: arm64: fix misleading comments in save/restore
In-Reply-To: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
References: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1434718396-13110-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Benn?e <alex.bennee@linaro.org>

The elr_el2 and spsr_el2 registers in fact contain the processor state
before entry into EL2. In the case of guest state it could be in either
el0 or el1.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 5befd01..519805f 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -50,8 +50,8 @@
 	stp	x29, lr, [x3, #80]
 
 	mrs	x19, sp_el0
-	mrs	x20, elr_el2		// EL1 PC
-	mrs	x21, spsr_el2		// EL1 pstate
+	mrs	x20, elr_el2		// pc before entering el2
+	mrs	x21, spsr_el2		// pstate before entering el2
 
 	stp	x19, x20, [x3, #96]
 	str	x21, [x3, #112]
@@ -82,8 +82,8 @@
 	ldr	x21, [x3, #16]
 
 	msr	sp_el0, x19
-	msr	elr_el2, x20 				// EL1 PC
-	msr	spsr_el2, x21 				// EL1 pstate
+	msr	elr_el2, x20 		// pc on return from el2
+	msr	spsr_el2, x21 		// pstate on return from el2
 
 	add	x3, x2, #CPU_XREG_OFFSET(19)
 	ldp	x19, x20, [x3]
-- 
2.1.4
