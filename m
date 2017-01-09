From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  9 Jan 2017 19:57:29 +0000
Subject: [RFC PATCH 2/2] crypto: arm/aes - add CCM driver using ARMv8 Crypto
 Extensions
In-Reply-To: <1483991849-32448-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1483991849-32448-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1483991849-32448-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a straight port of the arm64 driver that implements AES
in CCM mode using the ARMv8 Crypto Extensions instructions. It
is ~13x faster than the generic CCM code using scalar AES.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/Kconfig           |   8 +
 arch/arm/crypto/Makefile          |   2 +
 arch/arm/crypto/aes-ce-ccm-core.S | 234 +++++++++++++
 arch/arm/crypto/aes-ce-ccm-glue.c | 360 ++++++++++++++++++++
 4 files changed, 604 insertions(+)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index f1de658c3c8f..f933cae8d76b 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -92,6 +92,14 @@ config CRYPTO_AES_ARM_CE
 	  Use an implementation of AES in CBC, CTR and XTS modes that uses
 	  ARMv8 Crypto Extensions
 
+config CRYPTO_AES_ARM_CE_CCM
+	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
+	depends on KERNEL_MODE_NEON && m
+	select CRYPTO_ALGAPI
+	select CRYPTO_AES
+	select CRYPTO_AEAD
+	select CRYPTO_CCM
+
 config CRYPTO_GHASH_ARM_CE
 	tristate "PMULL-accelerated GHASH using ARMv8 Crypto Extensions"
 	depends on KERNEL_MODE_NEON
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 6eda6ffafea9..1b4f3a5f918c 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CRYPTO_SHA512_ARM) += sha512-arm.o
 obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha20-neon.o
 
 ce-obj-$(CONFIG_CRYPTO_AES_ARM_CE) += aes-arm-ce.o
+ce-obj-$(CONFIG_CRYPTO_AES_ARM_CE_CCM) += aes-ce-ccm.o
 ce-obj-$(CONFIG_CRYPTO_SHA1_ARM_CE) += sha1-arm-ce.o
 ce-obj-$(CONFIG_CRYPTO_SHA2_ARM_CE) += sha2-arm-ce.o
 ce-obj-$(CONFIG_CRYPTO_GHASH_ARM_CE) += ghash-arm-ce.o
@@ -38,6 +39,7 @@ sha512-arm-y	:= sha512-core.o sha512-glue.o $(sha512-arm-neon-y)
 sha1-arm-ce-y	:= sha1-ce-core.o sha1-ce-glue.o
 sha2-arm-ce-y	:= sha2-ce-core.o sha2-ce-glue.o
 aes-arm-ce-y	:= aes-ce-core.o aes-ce-glue.o
+aes-ce-ccm-y	:= aes-ce-ccm-core.o aes-ce-ccm-glue.o
 ghash-arm-ce-y	:= ghash-ce-core.o ghash-ce-glue.o
 crct10dif-arm-ce-y	:= crct10dif-ce-core.o crct10dif-ce-glue.o
 crc32-arm-ce-y:= crc32-ce-core.o crc32-ce-glue.o
diff --git a/arch/arm/crypto/aes-ce-ccm-core.S b/arch/arm/crypto/aes-ce-ccm-core.S
new file mode 100644
index 000000000000..6eefb7dea77e
--- /dev/null
+++ b/arch/arm/crypto/aes-ce-ccm-core.S
@@ -0,0 +1,234 @@
+/*
+ * aesce-ccm-core.S - AES-CCM transform for ARMv8 with Crypto Extensions
+ *
+ * Copyright (C) 2013 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+	.text
+	.arch		armv7-a
+	.fpu		crypto-neon-fp-armv8
+
+	/*
+	 * void ce_aes_ccm_auth_data(u8 mac[], u8 const in[], u32 abytes,
+	 *			     u32 *macp, u8 const rk[], u32 rounds);
+	 */
+ENTRY(ce_aes_ccm_auth_data)
+	push		{r4-r8, lr}
+	ldrd		r4, r5, [sp, #24]
+	ldr		r8, [r3]		/* leftover from prev round? */
+	vld1.8		{q0}, [r0]		/* load mac */
+	teq		r8, #0
+	beq		1f
+	sub		r8, r8, #16
+	veor		q1, q1, q1
+0:	ldrb		r7, [r1], #1		/* get 1 byte of input */
+	subs		r2, r2, #1
+	add		r8, r8, #1
+	vmov.8		d2[0], r7
+	vext.8		q1, q1, q1, #1		/* rotate in the input bytes */
+	beq		8f			/* out of input? */
+	teq		r8, #0
+	bne		0b
+	veor		q0, q0, q1
+1:	vld1.32		{q3}, [r4]		/* load first round key */
+	cmp		r5, #12			/* which key size? */
+	add		r6, r4, #16
+	sub		r7, r5, #2		/* modified # of rounds */
+	bmi		2f
+	bne		5f
+	vmov		q5, q3
+	b		4f
+2:	vmov		q4, q3
+	vld1.32		{q5}, [r6]!		/* load 2nd round key */
+3:	aese.8		q0, q4
+	aesmc.8		q0, q0
+4:	vld1.32		{q3}, [r6]!		/* load next round key */
+	aese.8		q0, q5
+	aesmc.8		q0, q0
+5:	vld1.32		{q4}, [r6]!		/* load next round key */
+	subs		r7, r7, #3
+	aese.8		q0, q3
+	aesmc.8		q0, q0
+	vld1.32		{q5}, [r6]!		/* load next round key */
+	bpl		3b
+	aese.8		q0, q4
+	subs		r2, r2, #16		/* last data? */
+	veor		q0, q0, q5		/* final round */
+	bmi		6f
+	vld1.8		{q1}, [r1]!		/* load next input block */
+	veor		q0, q0, q1		/* xor with mac */
+	bne		1b
+6:	vst1.8		{q0}, [r0]		/* store mac */
+	beq		10f
+	adds		r2, r2, #16
+	beq		10f
+	mov		r8, r2
+7:	ldrb		r7, [r1], #1
+	vmov		r6, d0[0]
+	eor		r6, r6, r7
+	strb		r6, [r0], #1
+	subs		r2, r2, #1
+	beq		10f
+	vext.8		q0, q0, q0, #1		/* rotate out the mac bytes */
+	b		7b
+8:	mov		r7, r8
+	add		r8, r8, #16
+9:	vext.8		q1, q1, q1, #1
+	adds		r7, r7, #1
+	bne		9b
+	veor		q0, q0, q1
+	vst1.8		{q0}, [r0]
+10:	str		r8, [r3]
+	pop		{r4-r8, pc}
+ENDPROC(ce_aes_ccm_auth_data)
+
+	/*
+	 * void ce_aes_ccm_final(u8 mac[], u8 const ctr[], u8 const rk[],
+	 * 			 u32 rounds);
+	 */
+ENTRY(ce_aes_ccm_final)
+	vld1.32		{q3}, [r2]!		/* load first round key */
+	vld1.8		{q0}, [r0]		/* load mac */
+	cmp		r3, #12			/* which key size? */
+	sub		r3, r3, #2		/* modified # of rounds */
+	vld1.8		{q1}, [r1]		/* load 1st ctriv */
+	bmi		0f
+	bne		3f
+	vmov		q5, q3
+	b		2f
+0:	vmov		q4, q3
+1:	vld1.32		{q5}, [r2]!		/* load next round key */
+	aese.8		q0, q4
+	aesmc.8		q0, q0
+	aese.8		q1, q4
+	aesmc.8		q1, q1
+2:	vld1.32		{q3}, [r2]!		/* load next round key */
+	aese.8		q0, q5
+	aesmc.8		q0, q0
+	aese.8		q1, q5
+	aesmc.8		q1, q1
+3:	vld1.32		{q4}, [r2]!		/* load next round key */
+	subs		r3, r3, #3
+	aese.8		q0, q3
+	aesmc.8		q0, q0
+	aese.8		q1, q3
+	aesmc.8		q1, q1
+	bpl		1b
+	aese.8		q0, q4
+	aese.8		q1, q4
+	/* final round key cancels out */
+	veor		q0, q0, q1		/* en-/decrypt the mac */
+	vst1.8		{q0}, [r0]		/* store result */
+	bx		lr
+ENDPROC(ce_aes_ccm_final)
+
+	.macro		aes_ccm_do_crypt, enc
+	push		{r4-r10, lr}
+	ldrd		r4, r5, [sp, #32]
+	ldr		r6, [sp, #40]
+
+	ldr		r8, [r6, #12]		/* load lower ctr */
+	vld1.8		{q0}, [r5]		/* load mac */
+#ifndef CONFIG_CPU_BIG_ENDIAN
+	rev		r8, r8			/* keep swabbed ctr in reg */
+#endif
+0:	/* outer loop */
+	vld1.8		{q1}, [r6]		/* load upper ctr */
+	add		r8, r8, #1
+	rev		r9, r8
+	cmp		r4, #12			/* which key size? */
+	sub		r7, r4, #2		/* get modified # of rounds */
+	vmov.32		d3[1], r9		/* no carry in lower ctr */
+	vld1.8		{q3}, [r3]		/* load first round key */
+	add		r10, r3, #16
+	bmi		1f
+	bne		4f
+	vmov		q5, q3
+	b		3f
+1:	vmov		q4, q3
+	vld1.32		{q5}, [r10]!		/* load 2nd round key */
+2:	/* inner loop: 3 rounds, 2x interleaved */
+	aese.8		q0, q4
+	aesmc.8		q0, q0
+	aese.8		q1, q4
+	aesmc.8		q1, q1
+3:	vld1.32		{q3}, [r10]!		/* load next round key */
+	aese.8		q0, q5
+	aesmc.8		q0, q0
+	aese.8		q1, q5
+	aesmc.8		q1, q1
+4:	vld1.32		{q4}, [r10]!		/* load next round key */
+	subs		r7, r7, #3
+	aese.8		q0, q3
+	aesmc.8		q0, q0
+	aese.8		q1, q3
+	aesmc.8		q1, q1
+	vld1.32		{q5}, [r10]!		/* load next round key */
+	bpl		2b
+	aese.8		q0, q4
+	aese.8		q1, q4
+	subs		r2, r2, #16
+	bmi		6f			/* partial block? */
+	vld1.8		{q2}, [r1]!		/* load next input block */
+	.if		\enc == 1
+	veor		q2, q2, q5		/* final round enc+mac */
+	veor		q1, q1, q2		/* xor with crypted ctr */
+	.else
+	veor		q2, q2, q1		/* xor with crypted ctr */
+	veor		q1, q2, q5		/* final round enc */
+	.endif
+	veor		q0, q0, q2		/* xor mac with pt ^ rk[last] */
+	vst1.8		{q1}, [r0]!		/* write output block */
+	bne		0b
+#ifndef CONFIG_CPU_BIG_ENDIAN
+	rev		r8, r8
+#endif
+	vst1.8		{q0}, [r5]		/* store mac */
+	str		r8, [r6, #12]		/* store lsb end of ctr (BE) */
+5:	pop		{r4-r10, pc}
+
+6:	veor		q0, q0, q5		/* final round mac */
+	veor		q1, q1, q5		/* final round enc */
+	vst1.8		{q0}, [r5]		/* store mac */
+	add		r2, r2, #16		/* process partial tail block */
+7:	ldrb		r9, [r1], #1		/* get 1 byte of input */
+	vmov.u8		r6, d2[0]		/* get top crypted ctr byte */
+	vmov.u8		r7, d0[0]		/* get top mac byte */
+	.if		\enc == 1
+	eor		r7, r7, r9
+	eor		r9, r9, r6
+	.else
+	eor		r9, r9, r6
+	eor		r7, r7, r9
+	.endif
+	strb		r9, [r0], #1		/* store out byte */
+	strb		r7, [r5], #1		/* store mac byte */
+	subs		r2, r2, #1
+	beq		5b
+	vext.8		q0, q0, q0, #1		/* shift out mac byte */
+	vext.8		q1, q1, q1, #1		/* shift out ctr byte */
+	b		7b
+	.endm
+
+	/*
+	 * void ce_aes_ccm_encrypt(u8 out[], u8 const in[], u32 cbytes,
+	 * 			   u8 const rk[], u32 rounds, u8 mac[],
+	 * 			   u8 ctr[]);
+	 * void ce_aes_ccm_decrypt(u8 out[], u8 const in[], u32 cbytes,
+	 * 			   u8 const rk[], u32 rounds, u8 mac[],
+	 * 			   u8 ctr[]);
+	 */
+ENTRY(ce_aes_ccm_encrypt)
+	aes_ccm_do_crypt	1
+ENDPROC(ce_aes_ccm_encrypt)
+
+ENTRY(ce_aes_ccm_decrypt)
+	aes_ccm_do_crypt	0
+ENDPROC(ce_aes_ccm_decrypt)
diff --git a/arch/arm/crypto/aes-ce-ccm-glue.c b/arch/arm/crypto/aes-ce-ccm-glue.c
new file mode 100644
index 000000000000..137ff7dded6b
--- /dev/null
+++ b/arch/arm/crypto/aes-ce-ccm-glue.c
@@ -0,0 +1,360 @@
+/*
+ * aes-ccm-glue.c - AES-CCM transform for ARMv8 with Crypto Extensions
+ *
+ * Copyright (C) 2013 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/neon.h>
+#include <asm/unaligned.h>
+#include <crypto/aes.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/module.h>
+
+struct crypto_aes_ccm_ctx {
+	struct crypto_aes_ctx	key;
+	struct crypto_aead	*fallback;
+};
+
+asmlinkage void ce_aes_ccm_auth_data(u8 mac[], u8 const in[], u32 abytes,
+				     u32 *macp, u32 const rk[], u32 rounds);
+
+asmlinkage void ce_aes_ccm_encrypt(u8 out[], u8 const in[], u32 cbytes,
+				   u32 const rk[], u32 rounds, u8 mac[],
+				   u8 ctr[]);
+
+asmlinkage void ce_aes_ccm_decrypt(u8 out[], u8 const in[], u32 cbytes,
+				   u32 const rk[], u32 rounds, u8 mac[],
+				   u8 ctr[]);
+
+asmlinkage void ce_aes_ccm_final(u8 mac[], u8 const ctr[], u32 const rk[],
+				 u32 rounds);
+
+static int num_rounds(struct crypto_aes_ccm_ctx *ctx)
+{
+	/*
+	 * # of rounds specified by AES:
+	 * 128 bit key		10 rounds
+	 * 192 bit key		12 rounds
+	 * 256 bit key		14 rounds
+	 * => n byte key	=> 6 + (n/4) rounds
+	 */
+	return 6 + ctx->key.key_length / 4;
+}
+
+static int ccm_setkey(struct crypto_aead *tfm, const u8 *in_key,
+		      unsigned int key_len)
+{
+	struct crypto_aes_ccm_ctx *ctx = crypto_aead_ctx(tfm);
+	int ret;
+
+	ret = crypto_aes_expand_key(&ctx->key, in_key, key_len);
+	if (ret) {
+		tfm->base.crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return ret;
+	}
+
+	ret = crypto_aead_setkey(ctx->fallback, in_key, key_len);
+	if (ret) {
+		tfm->base.crt_flags |= (ctx->fallback->base.crt_flags &
+					CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ccm_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
+{
+	struct crypto_aes_ccm_ctx *ctx = crypto_aead_ctx(tfm);
+
+	if ((authsize & 1) || authsize < 4)
+		return -EINVAL;
+
+	return crypto_aead_setauthsize(ctx->fallback, authsize);
+}
+
+static int ccm_init_mac(struct aead_request *req, u8 maciv[], u32 msglen)
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	__be32 *n = (__be32 *)&maciv[AES_BLOCK_SIZE - 8];
+	u32 l = req->iv[0] + 1;
+
+	/* verify that CCM dimension 'L' is set correctly in the IV */
+	if (l < 2 || l > 8)
+		return -EINVAL;
+
+	/* verify that msglen can in fact be represented in L bytes */
+	if (l < 4 && msglen >> (8 * l))
+		return -EOVERFLOW;
+
+	/*
+	 * Even if the CCM spec allows L values of up to 8, the Linux cryptoapi
+	 * uses a u32 type to represent msglen so the top 4 bytes are always 0.
+	 */
+	n[0] = 0;
+	n[1] = cpu_to_be32(msglen);
+
+	memcpy(maciv, req->iv, AES_BLOCK_SIZE - l);
+
+	/*
+	 * Meaning of byte 0 according to CCM spec (RFC 3610/NIST 800-38C)
+	 * - bits 0..2	: max # of bytes required to represent msglen, minus 1
+	 *                (already set by caller)
+	 * - bits 3..5	: size of auth tag (1 => 4 bytes, 2 => 6 bytes, etc)
+	 * - bit 6	: indicates presence of authenticate-only data
+	 */
+	maciv[0] |= (crypto_aead_authsize(aead) - 2) << 2;
+	if (req->assoclen)
+		maciv[0] |= 0x40;
+
+	memset(&req->iv[AES_BLOCK_SIZE - l], 0, l);
+	return 0;
+}
+
+static void ccm_calculate_auth_mac(struct aead_request *req, u8 mac[])
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct crypto_aes_ccm_ctx *ctx = crypto_aead_ctx(aead);
+	struct __packed { __be16 l; __be32 h; u16 len; } ltag;
+	struct scatter_walk walk;
+	u32 len = req->assoclen;
+	u32 macp = 0;
+
+	/* prepend the AAD with a length tag */
+	if (len < 0xff00) {
+		ltag.l = cpu_to_be16(len);
+		ltag.len = 2;
+	} else  {
+		ltag.l = cpu_to_be16(0xfffe);
+		put_unaligned_be32(len, &ltag.h);
+		ltag.len = 6;
+	}
+
+	ce_aes_ccm_auth_data(mac, (u8 *)&ltag, ltag.len, &macp,
+			     ctx->key.key_enc, num_rounds(ctx));
+	scatterwalk_start(&walk, req->src);
+
+	do {
+		u32 n = scatterwalk_clamp(&walk, len);
+		u8 *p;
+
+		if (!n) {
+			scatterwalk_start(&walk, sg_next(walk.sg));
+			n = scatterwalk_clamp(&walk, len);
+		}
+		p = scatterwalk_map(&walk);
+		ce_aes_ccm_auth_data(mac, p, n, &macp, ctx->key.key_enc,
+				     num_rounds(ctx));
+		len -= n;
+
+		scatterwalk_unmap(p);
+		scatterwalk_advance(&walk, n);
+		scatterwalk_done(&walk, 0, len);
+	} while (len);
+}
+
+static int ccm_encrypt(struct aead_request *req)
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct crypto_aes_ccm_ctx *ctx = crypto_aead_ctx(aead);
+	struct skcipher_walk walk;
+	u8 __aligned(8) mac[AES_BLOCK_SIZE];
+	u8 buf[AES_BLOCK_SIZE];
+	u32 len = req->cryptlen;
+	int err;
+
+	if (in_irq()) {
+		struct aead_request *fallback_req;
+
+		fallback_req = aead_request_alloc(ctx->fallback, GFP_ATOMIC);
+		if (!fallback_req)
+			return -ENOMEM;
+
+		aead_request_set_ad(fallback_req, req->assoclen);
+		aead_request_set_crypt(fallback_req, req->src, req->dst,
+				       req->cryptlen, req->iv);
+
+		err = crypto_aead_encrypt(fallback_req);
+		aead_request_free(fallback_req);
+		return err;
+	}
+
+	err = ccm_init_mac(req, mac, len);
+	if (err)
+		return err;
+
+	kernel_neon_begin();
+
+	if (req->assoclen)
+		ccm_calculate_auth_mac(req, mac);
+
+	/* preserve the original iv for the final round */
+	memcpy(buf, req->iv, AES_BLOCK_SIZE);
+
+	err = skcipher_walk_aead_encrypt(&walk, req, true);
+
+	while (walk.nbytes) {
+		u32 tail = walk.nbytes % AES_BLOCK_SIZE;
+
+		if (walk.nbytes == walk.total)
+			tail = 0;
+
+		ce_aes_ccm_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
+				   walk.nbytes - tail, ctx->key.key_enc,
+				   num_rounds(ctx), mac, walk.iv);
+
+		err = skcipher_walk_done(&walk, tail);
+	}
+	if (!err)
+		ce_aes_ccm_final(mac, buf, ctx->key.key_enc, num_rounds(ctx));
+
+	kernel_neon_end();
+
+	if (err)
+		return err;
+
+	/* copy authtag to end of dst */
+	scatterwalk_map_and_copy(mac, req->dst, req->assoclen + req->cryptlen,
+				 crypto_aead_authsize(aead), 1);
+
+	return 0;
+}
+
+static int ccm_decrypt(struct aead_request *req)
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct crypto_aes_ccm_ctx *ctx = crypto_aead_ctx(aead);
+	unsigned int authsize = crypto_aead_authsize(aead);
+	struct skcipher_walk walk;
+	u8 __aligned(8) mac[AES_BLOCK_SIZE];
+	u8 buf[AES_BLOCK_SIZE];
+	u32 len = req->cryptlen - authsize;
+	int err;
+
+	if (in_irq()) {
+		struct aead_request *fallback_req;
+
+		fallback_req = aead_request_alloc(ctx->fallback, GFP_ATOMIC);
+		if (!fallback_req)
+			return -ENOMEM;
+
+		aead_request_set_ad(fallback_req, req->assoclen);
+		aead_request_set_crypt(fallback_req, req->src, req->dst,
+				       req->cryptlen, req->iv);
+
+		err = crypto_aead_decrypt(fallback_req);
+		aead_request_free(fallback_req);
+		return err;
+	}
+
+	err = ccm_init_mac(req, mac, len);
+	if (err)
+		return err;
+
+	kernel_neon_begin();
+
+	if (req->assoclen)
+		ccm_calculate_auth_mac(req, mac);
+
+	/* preserve the original iv for the final round */
+	memcpy(buf, req->iv, AES_BLOCK_SIZE);
+
+	err = skcipher_walk_aead_decrypt(&walk, req, true);
+
+	while (walk.nbytes) {
+		u32 tail = walk.nbytes % AES_BLOCK_SIZE;
+
+		if (walk.nbytes == walk.total)
+			tail = 0;
+
+		ce_aes_ccm_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
+				   walk.nbytes - tail, ctx->key.key_enc,
+				   num_rounds(ctx), mac, walk.iv);
+
+		err = skcipher_walk_done(&walk, tail);
+	}
+	if (!err)
+		ce_aes_ccm_final(mac, buf, ctx->key.key_enc, num_rounds(ctx));
+
+	kernel_neon_end();
+
+	if (err)
+		return err;
+
+	/* compare calculated auth tag with the stored one */
+	scatterwalk_map_and_copy(buf, req->src,
+				 req->assoclen + req->cryptlen - authsize,
+				 authsize, 0);
+
+	if (crypto_memneq(mac, buf, authsize))
+		return -EBADMSG;
+	return 0;
+}
+
+static int ccm_init(struct crypto_aead *aead)
+{
+	struct crypto_aes_ccm_ctx *ctx = crypto_aead_ctx(aead);
+	struct crypto_aead *tfm;
+
+	tfm = crypto_alloc_aead("ccm(aes)", 0,
+				CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
+
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	ctx->fallback = tfm;
+	return 0;
+}
+
+static void ccm_exit(struct crypto_aead *aead)
+{
+	struct crypto_aes_ccm_ctx *ctx = crypto_aead_ctx(aead);
+
+	crypto_free_aead(ctx->fallback);
+}
+
+static struct aead_alg ccm_aes_alg = {
+	.base.cra_name		= "ccm(aes)",
+	.base.cra_driver_name	= "ccm-aes-ce",
+	.base.cra_priority	= 300,
+	.base.cra_blocksize	= 1,
+	.base.cra_ctxsize	= sizeof(struct crypto_aes_ccm_ctx),
+	.base.cra_module	= THIS_MODULE,
+	.base.cra_flags		= CRYPTO_ALG_NEED_FALLBACK,
+
+	.ivsize			= AES_BLOCK_SIZE,
+	.chunksize		= AES_BLOCK_SIZE,
+	.maxauthsize		= AES_BLOCK_SIZE,
+	.setkey			= ccm_setkey,
+	.setauthsize		= ccm_setauthsize,
+	.encrypt		= ccm_encrypt,
+	.decrypt		= ccm_decrypt,
+	.init			= ccm_init,
+	.exit			= ccm_exit,
+};
+
+static int __init aes_mod_init(void)
+{
+	if (!(elf_hwcap2 & HWCAP2_AES))
+		return -ENODEV;
+	return crypto_register_aead(&ccm_aes_alg);
+}
+
+static void __exit aes_mod_exit(void)
+{
+	crypto_unregister_aead(&ccm_aes_alg);
+}
+
+module_init(aes_mod_init);
+module_exit(aes_mod_exit);
+
+MODULE_DESCRIPTION("Synchronous AES in CCM mode using ARMv8 Crypto Extensions");
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("ccm(aes)");
-- 
2.7.4
