From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 06 Nov 2015 16:53:19 +0900
Subject: [PATCH] ARM: proc-v7: Put stack in data section, handle XIP case
Message-ID: <20151106075319.19378.64286.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the ARM v7 setup code to put the temporary stack in the
data section and also use PLAT_PHYS_OFFSET to handle the XIP case.

The common case of XIP=n the code is considered to be position
independent while for XIP=y PLAT_PHYS_OFFSET is fixed. This
is based on that early code in head.S invoking PROCINFO_INITFUNC
seems position independent.

At this point two places in proc-v7.S make use of the temporary
stack so the PLAT_PHYS_OFFSET calculation is duplicated.

The XIP=n case has been tested with CPU Hotplug on r8a7779
(Cortex A9 Quad) and Chris [CCed] has tested the XIP=y
case.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Tested-by: Chris.Brandt at renesas.com
---

 Please let me know if considering XIP=y position independent
 is overkill, or if it is better to share code somehow.

 arch/arm/mm/proc-v7.S |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mm/proc-v7.S
+++ work/arch/arm/mm/proc-v7.S	2015-11-06 16:32:13.370513000 +0900
@@ -274,7 +274,15 @@ __v7_ca15mp_setup:
 __v7_b15mp_setup:
 __v7_ca17mp_setup:
 	mov	r10, #0
-1:	adr	r12, __v7_setup_stack		@ the local stack
+1:	adr	r11, __v7_setup_stack_ptr	@ pointer to local stack
+	ldmia	r11, {r0, r12}
+#ifdef CONFIG_XIP_KERNEL
+	ldr	r11, =PLAT_PHYS_OFFSET		@ fixed address
+#else
+	sub	r11, r11, r0			@ position independent offset
+#endif
+	add	r12, r12, r11			@ phys address
+	sub	r12, #PAGE_OFFSET
 	stmia	r12, {r0-r5, lr}		@ v7_invalidate_l1 touches r0-r6
 	bl      v7_invalidate_l1
 	ldmia	r12, {r0-r5, lr}
@@ -415,7 +423,15 @@ __v7_pj4b_setup:
 #endif /* CONFIG_CPU_PJ4B */
 
 __v7_setup:
-	adr	r12, __v7_setup_stack		@ the local stack
+	adr	r11, __v7_setup_stack_ptr	@ pointer to local stack
+	ldmia	r11, {r0, r12}
+#ifdef CONFIG_XIP_KERNEL
+	ldr	r11, =PLAT_PHYS_OFFSET		@ fixed address
+#else
+	sub	r11, r11, r0			@ position independent offset
+#endif
+	add	r12, r12, r11			@ phys address
+	sub	r12, #PAGE_OFFSET
 	stmia	r12, {r0-r5, lr}		@ v7_invalidate_l1 touches r0-r6
 	bl      v7_invalidate_l1
 	ldmia	r12, {r0-r5, lr}
@@ -482,6 +498,11 @@ __errata_finish:
 	ret	lr				@ return to head.S:__ret
 ENDPROC(__v7_setup)
 
+__v7_setup_stack_ptr:
+	.long	.
+	.long	__v7_setup_stack
+
+	.data
 	.align	2
 __v7_setup_stack:
 	.space	4 * 7				@ 12 registers
