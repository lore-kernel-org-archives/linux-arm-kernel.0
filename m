From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 22 Nov 2010 18:04:24 +0000
Subject: [PATCH v2 8/9] ARM: Thumb-2: Fix long-distance conditional branches
	in head.S for Thumb-2.
In-Reply-To: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1290449065-28843-9-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32-bit conditional branches in Thumb-2 have a shorter range (+/-512K)
than their ARM counterparts (+/-32MB).  The linker does not currently
generate trampolines to extend the range of these Thumb-2 conditional
branches, resulting in link errors when vmlinux is sufficiently large, e.g.:

head.o:(.text+0x464): relocation truncated to fit: R_ARM_THM_JUMP19

This patch forces the longer-range, unconditional branch encoding by
use of an explicit IT instruction.  The resulting branches are triggered on
the same conditions as before.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/head.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 591c097..6bd82d2 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -85,9 +85,11 @@ ENTRY(stext)
 	mrc	p15, 0, r9, c0, c0		@ get processor id
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
 	movs	r10, r5				@ invalid processor (r5=0)?
+ THUMB( it	eq )		@ force fixup-able long branch encoding
 	beq	__error_p			@ yes, error 'p'
 	bl	__lookup_machine_type		@ r5=machinfo
 	movs	r8, r5				@ invalid machine (r5=0)?
+ THUMB( it	eq )		@ force fixup-able long branch encoding
 	beq	__error_a			@ yes, error 'a'
 	bl	__vet_atags
 #ifdef CONFIG_SMP_ON_UP
@@ -283,6 +285,7 @@ ENTRY(secondary_startup)
 	bl	__lookup_processor_type
 	movs	r10, r5				@ invalid processor?
 	moveq	r0, #'p'			@ yes, error 'p'
+ THUMB( it	eq )		@ force fixup-able long branch encoding
 	beq	__error_p
 
 	/*
-- 
1.7.1
