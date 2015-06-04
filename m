From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu,  4 Jun 2015 14:28:37 +0100
Subject: [PATCH v2] KVM: arm64: fix misleading comments in save/restore
Message-ID: <1433424517-31816-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The elr_el2 and spsr_el2 registers in fact contain the processor state
before entry into EL2. In the case of guest state it could be in either
el0 or el1.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v2
  - s/hypervisor code/EL2/
  - comment: pc/pstate before entering/on return from el2
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
2.4.2
