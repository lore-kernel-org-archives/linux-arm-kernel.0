From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 12 Jul 2011 12:44:59 +0100
Subject: [PATCH v2] ARM: head, zImage: Always Enter the kernel in ARM state
Message-ID: <1310471099-28369-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the documented kernel entry requirements are not
explicit about whether the kernel should be entered in ARM or
Thumb, leading to an ambiguitity about how to enter Thumb-2
kernels.  As a result, the kernel is reliant on the zImage
decompressor to enter the kernel proper in the correct instruction
set state.

This patch changes the boot entry protocol for head.S and Image to
be the same as for zImage: in all cases, the kernel is now entered
in ARM.

Documentation/arm/Booting is updated to reflect this new policy.

A different rule will be needed for Cortex-M class CPUs as and when
support for those lands in mainline, since these CPUs don't support
the ARM instruction set at all: a note is added to the effect that
the kernel must be entered in Thumb on such systems.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
Reposting for comments.

This was posted some weeks ago, and the feedback received has been
addressed.

 Documentation/arm/Booting       |    5 +++++
 arch/arm/boot/compressed/head.S |    3 ++-
 arch/arm/kernel/head-nommu.S    |    8 ++++++++
 arch/arm/kernel/head.S          |    8 ++++++++
 4 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index 4e686a2..a341d87 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -164,3 +164,8 @@ In either case, the following conditions must be met:
 - The boot loader is expected to call the kernel image by jumping
   directly to the first instruction of the kernel image.
 
+  On CPUs supporting the ARM instruction set, the entry must be
+  made in ARM state, even for a Thumb-2 kernel.
+
+  On CPUs supporting only the Thumb instruction set such as
+  Cortex-M class CPUs, the entry must be made in Thumb state.
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index f9da419..51af709 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -353,7 +353,8 @@ not_relocated:	mov	r0, #0
 		mov	r0, #0			@ must be zero
 		mov	r1, r7			@ restore architecture number
 		mov	r2, r8			@ restore atags pointer
-		mov	pc, r4			@ call kernel
+ ARM(		mov	pc, r4	)		@ call kernel
+ THUMB(		bx	r4	)		@ entry point is always ARM
 
 		.align	2
 		.type	LC0, #object
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 6b1e0ad..d46f259 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -32,8 +32,16 @@
  * numbers for r1.
  *
  */
+	.arm
+
 	__HEAD
 ENTRY(stext)
+
+ THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
+ THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
+ THUMB(	.thumb			)	@ switch to Thumb now.
+ THUMB(1:			)
+
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
 #ifndef CONFIG_CPU_CP15
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 278c1b0..742b610 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -71,8 +71,16 @@
  * crap here - that's what the boot loader (or in extreme, well justified
  * circumstances, zImage) is for.
  */
+	.arm
+
 	__HEAD
 ENTRY(stext)
+
+ THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
+ THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
+ THUMB(	.thumb			)	@ switch to Thumb now.
+ THUMB(1:			)
+
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
 	mrc	p15, 0, r9, c0, c0		@ get processor id
-- 
1.7.4.1
