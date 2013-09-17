From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Sep 2013 19:16:35 +0200
Subject: [PATCH v2] ARM: fix Thumb-2 bug in AES assembler code
Message-ID: <1379438195-6911-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 638591c enabled building the AES assembler code in Thumb2 mode.
However, this code used arithmetic involving PC rather than adr{l}
instructions to generate PC-relative references to the lookup tables,
and this break in Thumb mode due to the different PC offset.

Use adr instructions instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

v2:
- use 'adr' instruction rather than explicit PC arithmetic
- move the tables around so they are in range for 'adr' in each mode

 arch/arm/crypto/aes-armv4.S | 388 ++++++++++++++++++++++----------------------
 1 file changed, 193 insertions(+), 195 deletions(-)

diff --git a/arch/arm/crypto/aes-armv4.S b/arch/arm/crypto/aes-armv4.S
index 19d6cd6..7c10292 100644
--- a/arch/arm/crypto/aes-armv4.S
+++ b/arch/arm/crypto/aes-armv4.S
@@ -38,6 +38,102 @@
 
 .text
 
+@ void AES_encrypt(const unsigned char *in, unsigned char *out,
+@ 		 const AES_KEY *key) {
+.align	5
+ENTRY(AES_encrypt)
+	stmdb   sp!,{r1,r4-r12,lr}
+	mov	r12,r0		@ inp
+	mov	r11,r2
+	adr	r10, AES_Te	@ Te
+#if __ARM_ARCH__<7
+	ldrb	r0,[r12,#3]	@ load input data in endian-neutral
+	ldrb	r4,[r12,#2]	@ manner...
+	ldrb	r5,[r12,#1]
+	ldrb	r6,[r12,#0]
+	orr	r0,r0,r4,lsl#8
+	ldrb	r1,[r12,#7]
+	orr	r0,r0,r5,lsl#16
+	ldrb	r4,[r12,#6]
+	orr	r0,r0,r6,lsl#24
+	ldrb	r5,[r12,#5]
+	ldrb	r6,[r12,#4]
+	orr	r1,r1,r4,lsl#8
+	ldrb	r2,[r12,#11]
+	orr	r1,r1,r5,lsl#16
+	ldrb	r4,[r12,#10]
+	orr	r1,r1,r6,lsl#24
+	ldrb	r5,[r12,#9]
+	ldrb	r6,[r12,#8]
+	orr	r2,r2,r4,lsl#8
+	ldrb	r3,[r12,#15]
+	orr	r2,r2,r5,lsl#16
+	ldrb	r4,[r12,#14]
+	orr	r2,r2,r6,lsl#24
+	ldrb	r5,[r12,#13]
+	ldrb	r6,[r12,#12]
+	orr	r3,r3,r4,lsl#8
+	orr	r3,r3,r5,lsl#16
+	orr	r3,r3,r6,lsl#24
+#else
+	ldr	r0,[r12,#0]
+	ldr	r1,[r12,#4]
+	ldr	r2,[r12,#8]
+	ldr	r3,[r12,#12]
+#ifdef __ARMEL__
+	rev	r0,r0
+	rev	r1,r1
+	rev	r2,r2
+	rev	r3,r3
+#endif
+#endif
+	bl	_armv4_AES_encrypt
+
+	ldr	r12,[sp],#4		@ pop out
+#if __ARM_ARCH__>=7
+#ifdef __ARMEL__
+	rev	r0,r0
+	rev	r1,r1
+	rev	r2,r2
+	rev	r3,r3
+#endif
+	str	r0,[r12,#0]
+	str	r1,[r12,#4]
+	str	r2,[r12,#8]
+	str	r3,[r12,#12]
+#else
+	mov	r4,r0,lsr#24		@ write output in endian-neutral
+	mov	r5,r0,lsr#16		@ manner...
+	mov	r6,r0,lsr#8
+	strb	r4,[r12,#0]
+	strb	r5,[r12,#1]
+	mov	r4,r1,lsr#24
+	strb	r6,[r12,#2]
+	mov	r5,r1,lsr#16
+	strb	r0,[r12,#3]
+	mov	r6,r1,lsr#8
+	strb	r4,[r12,#4]
+	strb	r5,[r12,#5]
+	mov	r4,r2,lsr#24
+	strb	r6,[r12,#6]
+	mov	r5,r2,lsr#16
+	strb	r1,[r12,#7]
+	mov	r6,r2,lsr#8
+	strb	r4,[r12,#8]
+	strb	r5,[r12,#9]
+	mov	r4,r3,lsr#24
+	strb	r6,[r12,#10]
+	mov	r5,r3,lsr#16
+	strb	r2,[r12,#11]
+	mov	r6,r3,lsr#8
+	strb	r4,[r12,#12]
+	strb	r5,[r12,#13]
+	strb	r6,[r12,#14]
+	strb	r3,[r12,#15]
+#endif
+	ldmia	sp!,{r4-r12,pc}
+ENDPROC(AES_encrypt)
+
 .type	AES_Te,%object
 .align	5
 AES_Te:
@@ -144,103 +240,6 @@ AES_Te:
 .word	0x1B000000, 0x36000000, 0, 0, 0, 0, 0, 0
 .size	AES_Te,.-AES_Te
 
-@ void AES_encrypt(const unsigned char *in, unsigned char *out,
-@ 		 const AES_KEY *key) {
-.align	5
-ENTRY(AES_encrypt)
-	sub	r3,pc,#8		@ AES_encrypt
-	stmdb   sp!,{r1,r4-r12,lr}
-	mov	r12,r0		@ inp
-	mov	r11,r2
-	sub	r10,r3,#AES_encrypt-AES_Te	@ Te
-#if __ARM_ARCH__<7
-	ldrb	r0,[r12,#3]	@ load input data in endian-neutral
-	ldrb	r4,[r12,#2]	@ manner...
-	ldrb	r5,[r12,#1]
-	ldrb	r6,[r12,#0]
-	orr	r0,r0,r4,lsl#8
-	ldrb	r1,[r12,#7]
-	orr	r0,r0,r5,lsl#16
-	ldrb	r4,[r12,#6]
-	orr	r0,r0,r6,lsl#24
-	ldrb	r5,[r12,#5]
-	ldrb	r6,[r12,#4]
-	orr	r1,r1,r4,lsl#8
-	ldrb	r2,[r12,#11]
-	orr	r1,r1,r5,lsl#16
-	ldrb	r4,[r12,#10]
-	orr	r1,r1,r6,lsl#24
-	ldrb	r5,[r12,#9]
-	ldrb	r6,[r12,#8]
-	orr	r2,r2,r4,lsl#8
-	ldrb	r3,[r12,#15]
-	orr	r2,r2,r5,lsl#16
-	ldrb	r4,[r12,#14]
-	orr	r2,r2,r6,lsl#24
-	ldrb	r5,[r12,#13]
-	ldrb	r6,[r12,#12]
-	orr	r3,r3,r4,lsl#8
-	orr	r3,r3,r5,lsl#16
-	orr	r3,r3,r6,lsl#24
-#else
-	ldr	r0,[r12,#0]
-	ldr	r1,[r12,#4]
-	ldr	r2,[r12,#8]
-	ldr	r3,[r12,#12]
-#ifdef __ARMEL__
-	rev	r0,r0
-	rev	r1,r1
-	rev	r2,r2
-	rev	r3,r3
-#endif
-#endif
-	bl	_armv4_AES_encrypt
-
-	ldr	r12,[sp],#4		@ pop out
-#if __ARM_ARCH__>=7
-#ifdef __ARMEL__
-	rev	r0,r0
-	rev	r1,r1
-	rev	r2,r2
-	rev	r3,r3
-#endif
-	str	r0,[r12,#0]
-	str	r1,[r12,#4]
-	str	r2,[r12,#8]
-	str	r3,[r12,#12]
-#else
-	mov	r4,r0,lsr#24		@ write output in endian-neutral
-	mov	r5,r0,lsr#16		@ manner...
-	mov	r6,r0,lsr#8
-	strb	r4,[r12,#0]
-	strb	r5,[r12,#1]
-	mov	r4,r1,lsr#24
-	strb	r6,[r12,#2]
-	mov	r5,r1,lsr#16
-	strb	r0,[r12,#3]
-	mov	r6,r1,lsr#8
-	strb	r4,[r12,#4]
-	strb	r5,[r12,#5]
-	mov	r4,r2,lsr#24
-	strb	r6,[r12,#6]
-	mov	r5,r2,lsr#16
-	strb	r1,[r12,#7]
-	mov	r6,r2,lsr#8
-	strb	r4,[r12,#8]
-	strb	r5,[r12,#9]
-	mov	r4,r3,lsr#24
-	strb	r6,[r12,#10]
-	mov	r5,r3,lsr#16
-	strb	r2,[r12,#11]
-	mov	r6,r3,lsr#8
-	strb	r4,[r12,#12]
-	strb	r5,[r12,#13]
-	strb	r6,[r12,#14]
-	strb	r3,[r12,#15]
-#endif
-	ldmia	sp!,{r4-r12,pc}
-ENDPROC(AES_encrypt)
-
 .type   _armv4_AES_encrypt,%function
 .align	2
 _armv4_AES_encrypt:
@@ -381,7 +380,6 @@ _armv4_AES_encrypt:
 .align	5
 ENTRY(private_AES_set_encrypt_key)
 _armv4_AES_set_encrypt_key:
-	sub	r3,pc,#8		@ AES_set_encrypt_key
 	teq	r0,#0
 	moveq	r0,#-1
 	beq	.Labrt
@@ -398,7 +396,7 @@ _armv4_AES_set_encrypt_key:
 	bne	.Labrt
 
 .Lok:	stmdb   sp!,{r4-r12,lr}
-	sub	r10,r3,#_armv4_AES_set_encrypt_key-AES_Te-1024	@ Te4
+	adr	r10, (AES_Te + 1024)	@ Te4
 
 	mov	r12,r0		@ inp
 	mov	lr,r1			@ bits
@@ -737,6 +735,102 @@ ENTRY(private_AES_set_decrypt_key)
 	ldmia	sp!,{r4-r12,pc}
 ENDPROC(private_AES_set_decrypt_key)
 
+@ void AES_decrypt(const unsigned char *in, unsigned char *out,
+@ 		 const AES_KEY *key) {
+.align	5
+ENTRY(AES_decrypt)
+	stmdb   sp!,{r1,r4-r12,lr}
+	mov	r12,r0		@ inp
+	mov	r11,r2
+	adr	r10, AES_Td	@ Td
+#if __ARM_ARCH__<7
+	ldrb	r0,[r12,#3]	@ load input data in endian-neutral
+	ldrb	r4,[r12,#2]	@ manner...
+	ldrb	r5,[r12,#1]
+	ldrb	r6,[r12,#0]
+	orr	r0,r0,r4,lsl#8
+	ldrb	r1,[r12,#7]
+	orr	r0,r0,r5,lsl#16
+	ldrb	r4,[r12,#6]
+	orr	r0,r0,r6,lsl#24
+	ldrb	r5,[r12,#5]
+	ldrb	r6,[r12,#4]
+	orr	r1,r1,r4,lsl#8
+	ldrb	r2,[r12,#11]
+	orr	r1,r1,r5,lsl#16
+	ldrb	r4,[r12,#10]
+	orr	r1,r1,r6,lsl#24
+	ldrb	r5,[r12,#9]
+	ldrb	r6,[r12,#8]
+	orr	r2,r2,r4,lsl#8
+	ldrb	r3,[r12,#15]
+	orr	r2,r2,r5,lsl#16
+	ldrb	r4,[r12,#14]
+	orr	r2,r2,r6,lsl#24
+	ldrb	r5,[r12,#13]
+	ldrb	r6,[r12,#12]
+	orr	r3,r3,r4,lsl#8
+	orr	r3,r3,r5,lsl#16
+	orr	r3,r3,r6,lsl#24
+#else
+	ldr	r0,[r12,#0]
+	ldr	r1,[r12,#4]
+	ldr	r2,[r12,#8]
+	ldr	r3,[r12,#12]
+#ifdef __ARMEL__
+	rev	r0,r0
+	rev	r1,r1
+	rev	r2,r2
+	rev	r3,r3
+#endif
+#endif
+	bl	_armv4_AES_decrypt
+
+	ldr	r12,[sp],#4		@ pop out
+#if __ARM_ARCH__>=7
+#ifdef __ARMEL__
+	rev	r0,r0
+	rev	r1,r1
+	rev	r2,r2
+	rev	r3,r3
+#endif
+	str	r0,[r12,#0]
+	str	r1,[r12,#4]
+	str	r2,[r12,#8]
+	str	r3,[r12,#12]
+#else
+	mov	r4,r0,lsr#24		@ write output in endian-neutral
+	mov	r5,r0,lsr#16		@ manner...
+	mov	r6,r0,lsr#8
+	strb	r4,[r12,#0]
+	strb	r5,[r12,#1]
+	mov	r4,r1,lsr#24
+	strb	r6,[r12,#2]
+	mov	r5,r1,lsr#16
+	strb	r0,[r12,#3]
+	mov	r6,r1,lsr#8
+	strb	r4,[r12,#4]
+	strb	r5,[r12,#5]
+	mov	r4,r2,lsr#24
+	strb	r6,[r12,#6]
+	mov	r5,r2,lsr#16
+	strb	r1,[r12,#7]
+	mov	r6,r2,lsr#8
+	strb	r4,[r12,#8]
+	strb	r5,[r12,#9]
+	mov	r4,r3,lsr#24
+	strb	r6,[r12,#10]
+	mov	r5,r3,lsr#16
+	strb	r2,[r12,#11]
+	mov	r6,r3,lsr#8
+	strb	r4,[r12,#12]
+	strb	r5,[r12,#13]
+	strb	r6,[r12,#14]
+	strb	r3,[r12,#15]
+#endif
+	ldmia	sp!,{r4-r12,pc}
+ENDPROC(AES_decrypt)
+
 .type	AES_Td,%object
 .align	5
 AES_Td:
@@ -839,102 +933,6 @@ AES_Td:
 .byte	0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d
 .size	AES_Td,.-AES_Td
 
-@ void AES_decrypt(const unsigned char *in, unsigned char *out,
-@ 		 const AES_KEY *key) {
-.align	5
-ENTRY(AES_decrypt)
-	sub	r3,pc,#8		@ AES_decrypt
-	stmdb   sp!,{r1,r4-r12,lr}
-	mov	r12,r0		@ inp
-	mov	r11,r2
-	sub	r10,r3,#AES_decrypt-AES_Td		@ Td
-#if __ARM_ARCH__<7
-	ldrb	r0,[r12,#3]	@ load input data in endian-neutral
-	ldrb	r4,[r12,#2]	@ manner...
-	ldrb	r5,[r12,#1]
-	ldrb	r6,[r12,#0]
-	orr	r0,r0,r4,lsl#8
-	ldrb	r1,[r12,#7]
-	orr	r0,r0,r5,lsl#16
-	ldrb	r4,[r12,#6]
-	orr	r0,r0,r6,lsl#24
-	ldrb	r5,[r12,#5]
-	ldrb	r6,[r12,#4]
-	orr	r1,r1,r4,lsl#8
-	ldrb	r2,[r12,#11]
-	orr	r1,r1,r5,lsl#16
-	ldrb	r4,[r12,#10]
-	orr	r1,r1,r6,lsl#24
-	ldrb	r5,[r12,#9]
-	ldrb	r6,[r12,#8]
-	orr	r2,r2,r4,lsl#8
-	ldrb	r3,[r12,#15]
-	orr	r2,r2,r5,lsl#16
-	ldrb	r4,[r12,#14]
-	orr	r2,r2,r6,lsl#24
-	ldrb	r5,[r12,#13]
-	ldrb	r6,[r12,#12]
-	orr	r3,r3,r4,lsl#8
-	orr	r3,r3,r5,lsl#16
-	orr	r3,r3,r6,lsl#24
-#else
-	ldr	r0,[r12,#0]
-	ldr	r1,[r12,#4]
-	ldr	r2,[r12,#8]
-	ldr	r3,[r12,#12]
-#ifdef __ARMEL__
-	rev	r0,r0
-	rev	r1,r1
-	rev	r2,r2
-	rev	r3,r3
-#endif
-#endif
-	bl	_armv4_AES_decrypt
-
-	ldr	r12,[sp],#4		@ pop out
-#if __ARM_ARCH__>=7
-#ifdef __ARMEL__
-	rev	r0,r0
-	rev	r1,r1
-	rev	r2,r2
-	rev	r3,r3
-#endif
-	str	r0,[r12,#0]
-	str	r1,[r12,#4]
-	str	r2,[r12,#8]
-	str	r3,[r12,#12]
-#else
-	mov	r4,r0,lsr#24		@ write output in endian-neutral
-	mov	r5,r0,lsr#16		@ manner...
-	mov	r6,r0,lsr#8
-	strb	r4,[r12,#0]
-	strb	r5,[r12,#1]
-	mov	r4,r1,lsr#24
-	strb	r6,[r12,#2]
-	mov	r5,r1,lsr#16
-	strb	r0,[r12,#3]
-	mov	r6,r1,lsr#8
-	strb	r4,[r12,#4]
-	strb	r5,[r12,#5]
-	mov	r4,r2,lsr#24
-	strb	r6,[r12,#6]
-	mov	r5,r2,lsr#16
-	strb	r1,[r12,#7]
-	mov	r6,r2,lsr#8
-	strb	r4,[r12,#8]
-	strb	r5,[r12,#9]
-	mov	r4,r3,lsr#24
-	strb	r6,[r12,#10]
-	mov	r5,r3,lsr#16
-	strb	r2,[r12,#11]
-	mov	r6,r3,lsr#8
-	strb	r4,[r12,#12]
-	strb	r5,[r12,#13]
-	strb	r6,[r12,#14]
-	strb	r3,[r12,#15]
-#endif
-	ldmia	sp!,{r4-r12,pc}
-ENDPROC(AES_decrypt)
 
 .type   _armv4_AES_decrypt,%function
 .align	2
-- 
1.8.1.2
