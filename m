From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 31 Jul 2013 12:44:45 -0400
Subject: [PATCH v2 5/6] ARM: mm: Update runtime patching code to THUMB2 mode
In-Reply-To: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375289086-5315-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sricharan R <r.sricharan@ti.com>

Update the runtime patching  code to support Thumb2. In testing the
64 bit patching code, the issue was uncovered.

For better review, the patch is kept separate. If needed it can be
merged into "ARM: LPAE: Correct virt_to_phys patching for 64 bit
physical addresses"

Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Sricharan R <r.sricharan@ti.com>
[santosh.shilimkar at ti.com: reduced #ifdef, updated commit log]
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/kernel/head.S |   69 ++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index aa3b0f7..a70d330 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -573,62 +573,73 @@ ENDPROC(__fixup_pv_table)
 
 	.text
 __fixup_a_pv_table:
-#ifdef CONFIG_THUMB2_KERNEL
-	lsls	r6, #24
-	beq	2f
-	clz	r7, r6
-	lsr	r6, #24
-	lsl	r6, r7
-	bic	r6, #0x0080
-	lsrs	r7, #1
-	orrcs	r6, #0x0080
-	orr	r6, r6, r7, lsl #12
-	orr	r6, #0x4000
-	b	2f
-1:	add     r7, r3
-	ldrh	ip, [r7, #2]
-	and	ip, 0x8f00
-	orr	ip, r6	@ mask in offset bits 31-24
-	strh	ip, [r7, #2]
-2:	cmp	r4, r5
-	ldrcc	r7, [r4], #4	@ use branch for delay slot
-	bcc	1b
-	bx	lr
-#else
 	adr	r0, 5f
 	b	4f
 1:	ldr	ip, [r7, r3]
+ THUMB(	1:	add	r7, r3)
+ THUMB(	ldrh	ip, [r7])
+ THUMB(	ldrh	r6, [r7, #2])
+ THUMB(	orr	ip, r6, ip, lsl #16)
+ ARM( 1: ldr	ip, [r7, r3])
 	lsr	r6, ip, #20		@ extract opcode
 	and	r6, r6, #0x3e
-	cmp	r6, #0x28		@ check for 'add' instruction
+ THUMB(	cmp	r6, #0x10)
+ ARM(	cmp	r6, #0x28)		@ check for 'add' instruction
 	beq	2f
-	cmp	r6, #0x24		@ check for 'sub' instruction
+ THUMB( cmp	r6, #0x1a)
+ ARM(	cmp	r6, #0x24)		@ check for 'sub' instruction
 	beq	2f
-	cmp	r6, #0x2a		@ check for 'adc' instruction
+ THUMB( cmp	r6, #0x14)
+ ARM(	cmp	r6, #0x2a)		@ check for 'adc' instruction
 	beq	4f
 	ldr	r6, [r0]
 	add	r6, r6, r3
 	ldr	r6, [r6, #4]
 	mvn	r11, #0
 	cmp	r11, r6
-	and	ip, ip, #0xf000		@ Register encoded in inst
+ THUMB( and	ip, ip, #0xf00)
+ ARM(	and	ip, ip, #0xf000)	@ Register encoded in inst
 	orrne	ip, ip, r6
 	ldreq	r6, [r0, #0x4]		@ mvn if _pv_offset high bits is 0xffffffff
 	ldrne	r6, [r0, #0x8]		@ mov otherwise
-	bic	r6, r6, #0xff
-	bic	r6, r6, #0xf00
+ THUMB(	mov	r11, r6, lsr #16)
+ THUMB(	mov	r6, r6, lsl #16)
+ THUMB(	orr	r6, r11, r6)
+ THUMB(	bic	r6, r6, #0x7000)
+ THUMB(	bic	r6, r6, #0xff)
+ ARM(	bic	r6, r6, #0xff)
+ ARM(	bic	r6, r6, #0xf00)
 	orr	ip, ip, r6
 	b	3f
 2:	ldr	r6, [r0]
 	ldr	r6, [r6, r3]
+#ifdef CONFIG_THUMB2_KERNEL
+	cmp	r6, #0
+	beq	6f
+	clz	r11, r6
+	lsr	r6, #24
+	lsl	r6, r11
+	bic	r6, #0x0080
+	lsrs	r11, #1
+	orrcs	r6, #0x0080
+	orr	r6, r6, r11, lsl #12
+	orr	r6, #0x4000
+6:	bic	ip, ip, #0x7000
+	bic	ip, ip, #0xff
+	orr	ip, ip, r6		@ mask in offset bits 31-24
+3:	strh	ip, [r7, #2]
+	mov	r6, ip, lsr #16
+	strh	r6, [r7]
+#else
+
 	bic	ip, ip, #0xff
 	orr	ip, ip, r6, lsr #24	@ mask in offset bits 31-24
 3:	str	ip, [r7, r3]
+#endif
 4:	cmp	r4, r5
 	ldrcc	r7, [r4], #4	@ use branch for delay slot
 	bcc	1b
 	mov	pc, lr
-#endif
 ENDPROC(__fixup_a_pv_table)
 
 5:	.long __pv_offset
-- 
1.7.9.5
