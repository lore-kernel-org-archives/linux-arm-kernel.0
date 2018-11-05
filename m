From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Nov 2018 19:44:33 +0100
Subject: [PATCH 1/6] ARM: compressed: move sharpsl startup code into subroutine
In-Reply-To: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
References: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
Message-ID: <20181105184438.19494-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of relying on unspecified linker behavior, move the
SharpSL startup code into a subroutine and call it from the
location we expect the linker to put the code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/boot/compressed/head-sharpsl.S | 24 ++++++++++----------
 arch/arm/boot/compressed/head.S         |  3 +++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/compressed/head-sharpsl.S b/arch/arm/boot/compressed/head-sharpsl.S
index 992e784500fa..f4e6ad318376 100644
--- a/arch/arm/boot/compressed/head-sharpsl.S
+++ b/arch/arm/boot/compressed/head-sharpsl.S
@@ -20,9 +20,10 @@
 #error What am I doing here...
 #endif
 
-		.section        ".start", "ax"
+	.text
 
-__SharpSL_start:
+ENTRY(__SharpSL_start)
+	mov	ip, lr			@ preserve lr
 
 /* Check for TC6393 - if found we have a Tosa */
 	ldr	r7, .TOSAID
@@ -30,7 +31,7 @@ __SharpSL_start:
 	mov 	r6, #0x03
 	ldrh	r3, [r1, #8]		@ Load TC6393XB Revison: This is 0x0003
 	cmp	r6, r3
-	beq	.SHARPEND		@ Success -> tosa
+	moveq	pc, ip			@ Success -> tosa
 
 /* Check for pxa270 - if found, branch */
 	mrc p15, 0, r4, c0, c0		@ Get Processor ID
@@ -55,30 +56,30 @@ __SharpSL_start:
 	ldr	r3, .W100ID
 	ldr	r7, .POODLEID
 	cmp	r6, r3
-	bne	.SHARPEND			@ We have no w100 - Poodle
+	movne	pc, ip				@ We have no w100 - Poodle
 
 /* Check for pxa250 - if found we have a Corgi */
 	ldr	r7, .CORGIID
 	ldr	r3, .PXA255ID
 	cmp	r4, r3
-	blo	.SHARPEND			@ We have a PXA250 - Corgi
+	movlo	pc, ip				@ We have a PXA250 - Corgi
 
 /* Check for 64MiB flash - if found we have a Shepherd */
 	bl	get_flash_ids
 	ldr	r7, .SHEPHERDID
 	cmp	r3, #0x76			@ 64MiB flash
-	beq	.SHARPEND			@ We have Shepherd
+	moveq	pc, ip				@ We have Shepherd
 
 /* Must be a Husky */
 	ldr	r7, .HUSKYID		@ Must be Husky
-	b .SHARPEND
+	mov	pc, ip			@ return
 
 .PXA270:
 /* Check for 16MiB flash - if found we have Spitz */
 	bl	get_flash_ids
 	ldr	r7, .SPITZID
 	cmp	r3, #0x73			@ 16MiB flash
-	beq	.SHARPEND			@ We have Spitz
+	moveq	pc, ip				@ We have Spitz
 
 /* Check for a second SCOOP chip - if found we have Borzoi */
 	ldr	r1, .SCOOP2ADDR
@@ -87,11 +88,12 @@ __SharpSL_start:
 	strh	r6, [r1]
 	ldrh	r6, [r1]
 	cmp	r6, #0x0140
-	beq	.SHARPEND			@ We have Borzoi
+	moveq	pc, ip				@ We have Borzoi
 
 /* Must be Akita */
 	ldr	r7, .AKITAID
-	b	.SHARPEND			@ We have Borzoi
+	mov	pc, ip				@ We have Borzoi
+ENDPROC(__SharpSL_start)
 
 .PXA255ID:
 	.word	0x69052d00		@ PXA255 Processor ID
@@ -147,5 +149,3 @@ get_flash_ids:
 	ldrb	r2, [r1, #20]		@ NAND Manufacturer ID
 	ldrb	r3, [r1, #20]		@ NAND Chip ID
 	mov	pc, lr
-
-.SHARPEND:
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6c7ccb428c07..5067f287fa5a 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -213,6 +213,9 @@ not_angel:
 		 */
 
 		.text
+#ifdef CONFIG_PXA_SHARPSL_DETECT_MACH_ID
+		bl	__SharpSL_start
+#endif
 
 #ifdef CONFIG_AUTO_ZRELADDR
 		/*
-- 
2.19.1
