From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 31 Jan 2011 14:03:55 -0700
Subject: [PATCH v2 1/6] arm/dt: Make __vet_atags also accept a dtb image
In-Reply-To: <20110131203626.15105.64302.stgit@localhost6.localdomain6>
References: <20110131203626.15105.64302.stgit@localhost6.localdomain6>
Message-ID: <20110131210355.15105.55634.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dtb is passed to the kernel via register r2, which is the same
method that is used to pass an atags pointer.  This patch modifies
__vet_atags to not clear r2 when it encounters a dtb image.

v2: fixed bugs pointed out by Nicolas Pitre

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/kernel/head-common.S |   24 ++++++++++++++++++------
 arch/arm/kernel/head.S        |    8 ++++----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 8f57515..882c292 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -15,6 +15,12 @@
 #define ATAG_CORE_SIZE ((2*4 + 3*4) >> 2)
 #define ATAG_CORE_SIZE_EMPTY ((2*4) >> 2)
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define OF_DT_MAGIC 0xd00dfeed
+#else
+#define OF_DT_MAGIC 0xedfe0dd0 /* 0xd00dfeed in big-endian */
+#endif
+
 /*
  * Exception handling.  Something went wrong and we can't proceed.  We
  * ought to tell the user, but since we don't have any guarantee that
@@ -105,22 +111,28 @@ __lookup_machine_type_data:
 
 /* Determine validity of the r2 atags pointer.  The heuristic requires
  * that the pointer be aligned, in the first 16k of physical RAM and
- * that the ATAG_CORE marker is first and present.  Future revisions
+ * that the ATAG_CORE marker is first and present.  If CONFIG_OF_FLATTREE
+ * is selected, then it will also accept a dtb pointer.  Future revisions
  * of this function may be more lenient with the physical address and
  * may also be able to move the ATAGS block if necessary.
  *
  * r8  = machinfo
  *
  * Returns:
- *  r2 either valid atags pointer, or zero
+ *  r2 either valid atags pointer, valid dtb pointer, or zero
  *  r5, r6 corrupted
  */
 __vet_atags:
 	tst	r2, #0x3			@ aligned?
 	bne	1f
 
-	ldr	r5, [r2, #0]			@ is first tag ATAG_CORE?
-	cmp	r5, #ATAG_CORE_SIZE
+	ldr	r5, [r2, #0]
+#ifdef CONFIG_OF_FLATTREE
+	ldr	r6, =OF_DT_MAGIC		@ is it a DTB?
+	cmp	r5, r6
+	beq	2f
+#endif
+	cmp	r5, #ATAG_CORE_SIZE		@ is first tag ATAG_CORE?
 	cmpne	r5, #ATAG_CORE_SIZE_EMPTY
 	bne	1f
 	ldr	r5, [r2, #4]
@@ -128,7 +140,7 @@ __vet_atags:
 	cmp	r5, r6
 	bne	1f
 
-	mov	pc, lr				@ atag pointer is ok
+2:	mov	pc, lr				@ atag/dtb pointer is ok
 
 1:	mov	r2, #0
 	mov	pc, lr
@@ -140,7 +152,7 @@ ENDPROC(__vet_atags)
  *
  *  r0  = cp#15 control register
  *  r1  = machine ID
- *  r2  = atags pointer
+ *  r2  = atags/dtb pointer
  *  r9  = processor ID
  */
 	__INIT
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f17d9a0..65d9489 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -66,7 +66,7 @@
  *
  * This is normally called from the decompressor code.  The requirements
  * are: MMU = off, D-cache = off, I-cache = dont care, r0 = 0,
- * r1 = machine nr, r2 = atags pointer.
+ * r1 = machine nr, r2 = atags or dtb pointer.
  *
  * This code is mostly position independent, so if you link the kernel at
  * 0xc0008000, you call this at __pa(0xc0008000).
@@ -93,7 +93,7 @@ ENTRY(stext)
 	beq	__error_a			@ yes, error 'a'
 
 	/*
-	 * r1 = machine no, r2 = atags,
+	 * r1 = machine no, r2 = atags or dtb,
 	 * r8 = machinfo, r9 = cpuid, r10 = procinfo
 	 */
 	bl	__vet_atags
@@ -335,7 +335,7 @@ __secondary_data:
  *
  *  r0  = cp#15 control register
  *  r1  = machine ID
- *  r2  = atags pointer
+ *  r2  = atags or dtb pointer
  *  r4  = page table pointer
  *  r9  = processor ID
  *  r13 = *virtual* address to jump to upon completion
@@ -372,7 +372,7 @@ ENDPROC(__enable_mmu)
  *
  *  r0  = cp#15 control register
  *  r1  = machine ID
- *  r2  = atags pointer
+ *  r2  = atags or dtb pointer
  *  r9  = processor ID
  *  r13 = *virtual* address to jump to upon completion
  *
