From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Oct 2010 18:09:27 +0100
Subject: [PATCH 04/10] ARM: cleanup boot cpu calling __mmap_switched
Message-ID: <E1P2oXX-00020Q-V2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to relocate __mmap_switched and associated data away
from the head section.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/head-common.S |    3 +--
 arch/arm/kernel/head.S        |    3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 6ad24d2..9f473ef 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -18,7 +18,6 @@
 	.align	2
 	.type	__switch_data, %object
 __switch_data:
-	.long	__mmap_switched
 	.long	__data_loc			@ r4
 	.long	_data				@ r5
 	.long	__bss_start			@ r6
@@ -39,7 +38,7 @@ __switch_data:
  *  r9  = processor ID
  */
 __mmap_switched:
-	adr	r3, __switch_data + 4
+	adr	r3, __switch_data
 
 	ldmia	r3!, {r4, r5, r6, r7}
 	cmp	r4, r5				@ Copy data segment if needed
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..aa6ab9d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -95,13 +95,14 @@ ENTRY(stext)
 	 * above.  On return, the CPU will be ready for the MMU to be
 	 * turned on, and r0 will hold the CPU control register value.
 	 */
-	ldr	r13, __switch_data		@ address to jump to after
+	ldr	r13, =__mmap_switched		@ address to jump to after
 						@ mmu has been enabled
 	adr	lr, BSYM(__enable_mmu)		@ return (PIC) address
  ARM(	add	pc, r10, #PROCINFO_INITFUNC	)
  THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
  THUMB(	mov	pc, r12				)
 ENDPROC(stext)
+	.ltorg
 
 #if defined(CONFIG_SMP)
 ENTRY(secondary_startup)
-- 
1.6.2.5
