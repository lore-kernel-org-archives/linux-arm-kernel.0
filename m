From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Mar 2018 16:50:44 +0000
Subject: [PATCH v6 21/26] arm64: KVM: Reserve 4 additional instructions in the
 BPI template
In-Reply-To: <20180314165049.30105-1-marc.zyngier@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
Message-ID: <20180314165049.30105-22-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, we only reserve a single instruction in the BPI template in
order to branch to the vectors. As we're going to stuff a few more
instructions there, let's reserve a total of 5 instructions, which
we're going to patch later on as required.

We also introduce a small refactor of the vectors themselves, so that
we stop carrying the target branch around.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/bpi.S | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
index 447188e2a664..ce1cfe3b24e6 100644
--- a/arch/arm64/kernel/bpi.S
+++ b/arch/arm64/kernel/bpi.S
@@ -19,33 +19,24 @@
 #include <linux/linkage.h>
 #include <linux/arm-smccc.h>
 
-.macro ventry target
-	.rept 31
+.macro hyp_ventry
+	.align 7
+1:	.rept 27
 	nop
 	.endr
-	b	\target
+	b	__kvm_hyp_vector + (1b - 0b)
+	nop
+	nop
+	nop
+	nop
 .endm
 
-.macro vectors target
-	ventry \target + 0x000
-	ventry \target + 0x080
-	ventry \target + 0x100
-	ventry \target + 0x180
-
-	ventry \target + 0x200
-	ventry \target + 0x280
-	ventry \target + 0x300
-	ventry \target + 0x380
-
-	ventry \target + 0x400
-	ventry \target + 0x480
-	ventry \target + 0x500
-	ventry \target + 0x580
-
-	ventry \target + 0x600
-	ventry \target + 0x680
-	ventry \target + 0x700
-	ventry \target + 0x780
+.macro generate_vectors
+0:
+	.rept 16
+	hyp_ventry
+	.endr
+	.org 0b + SZ_2K		// Safety measure
 .endm
 
 
@@ -55,7 +46,7 @@
 	.align	11
 ENTRY(__bp_harden_hyp_vecs_start)
 	.rept 4
-	vectors __kvm_hyp_vector
+	generate_vectors
 	.endr
 ENTRY(__bp_harden_hyp_vecs_end)
 
-- 
2.14.2
