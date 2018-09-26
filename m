From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 26 Sep 2018 14:56:23 +0100
Subject: [PATCH 6/7] arm64: Do not apply vector harderning for hyp entries
 from EL2
In-Reply-To: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1537970184-44348-7-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an EL2 entry of __kvm_hyp_vector is taken, it means an entry from a
lower EL was previously taken to exit the guest. Taking that lower EL entry
already applied vector hardening if needed, so there is no need to do it
again.

Only apply vector hardening for exception coming from lower EL.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 arch/arm64/kvm/hyp/hyp-entry.S | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 24b4fba..da31386 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -257,7 +257,15 @@ ENTRY(__kvm_hyp_vector)
 ENDPROC(__kvm_hyp_vector)

 #ifdef CONFIG_KVM_INDIRECT_VECTORS
-.macro hyp_ventry
+.macro hyp_el2_ventry
+	.align 7
+1:	b	__kvm_hyp_vector + (1b - 0b)
+	.rept 31
+	nop
+	.endr
+.endm
+
+.macro hyp_el1_ventry
 	.align 7
 1:	.rept 27
 	nop
@@ -290,8 +298,11 @@ alternative_cb_end

 .macro generate_vectors
 0:
-	.rept 16
-	hyp_ventry
+	.rept 8
+	hyp_el2_ventry
+	.endr
+	.rept 8
+	hyp_el1_ventry
 	.endr
 	.org 0b + SZ_2K		// Safety measure
 .endm
--
1.9.1
