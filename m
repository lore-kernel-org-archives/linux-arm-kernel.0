From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 13 Oct 2013 14:15:02 +0200
Subject: [RFC v3 PATCH 6/7] ARM64: add Crypto Extensions based synchronous AES
 in CCM mode
In-Reply-To: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381666503-23726-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements the CCM AEAD chaining mode for AES using Crypto
Extensions instructions.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/Makefile    |   2 +-
 arch/arm64/crypto/aes-sync.c  | 355 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/crypto/aesce-ccm.S | 186 ++++++++++++++++++++++
 3 files changed, 538 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/crypto/aesce-ccm.S

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 269d9be..f15940c 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -8,7 +8,7 @@
 # published by the Free Software Foundation.
 #
 
-aesce-sync-y	:= aes-sync.o
+aesce-sync-y	:= aes-sync.o aesce-ccm.o
 obj-m		+= aesce-sync.o
 
 CFLAGS_aes-sync.o	+= -march=armv8-a+crypto
diff --git a/arch/arm64/crypto/aes-sync.c b/arch/arm64/crypto/aes-sync.c
index 5d7ed4e..0c0d0bd 100644
--- a/arch/arm64/crypto/aes-sync.c
+++ b/arch/arm64/crypto/aes-sync.c
@@ -9,7 +9,10 @@
  */
 
 #include <asm/neon.h>
+#include <asm/unaligned.h>
 #include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <crypto/scatterwalk.h>
 #include <linux/crypto.h>
 #include <linux/module.h>
 
@@ -69,7 +72,313 @@ static void aes_cipher_decrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
 	kernel_neon_end(regs);
 }
 
-static struct crypto_alg aes_alg = {
+struct crypto_ccm_aes_ctx {
+	struct crypto_aes_ctx	*key;
+	struct crypto_blkcipher	*blk_tfm;
+};
+
+asmlinkage void ce_aes_ccm_auth_data(u8 mac[], u8 const in[], u32 abytes,
+				     u32 const rk[], u32 rounds);
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
+				 long rounds);
+
+static int ccm_setkey(struct crypto_aead *tfm, const u8 *in_key,
+		      unsigned int key_len)
+{
+	struct crypto_ccm_aes_ctx *ctx = crypto_aead_ctx(tfm);
+	int ret;
+
+	ret = crypto_aes_expand_key(ctx->key, in_key, key_len);
+	if (!ret)
+		return 0;
+
+	tfm->base.crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+	return -EINVAL;
+}
+
+static int ccm_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
+{
+	if ((authsize & 1) || authsize < 4)
+		return -EINVAL;
+	return 0;
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
+	if (msglen >> (8 * l))
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
+	struct crypto_ccm_aes_ctx *ctx = crypto_aead_ctx(aead);
+	struct __packed { __be16 l; __be32 h; } ltag;
+	u32 rounds = 6 + ctx->key->key_length / 4;
+	struct scatter_walk walk;
+	u32 len = req->assoclen;
+	u32 macp;
+
+	/* prepend the AAD with a length tag */
+	if (len < 0xff00) {
+		ltag.l = cpu_to_be16(len);
+		macp = 2;
+	} else  {
+		ltag.l = cpu_to_be16(0xfffe);
+		put_unaligned_be32(len, &ltag.h);
+		macp = 6;
+	}
+
+	ce_aes_ccm_auth_data(mac, (u8 *)&ltag, macp, ctx->key->key_enc, rounds);
+	scatterwalk_start(&walk, req->assoc);
+
+	do {
+		u32 n = scatterwalk_clamp(&walk, len);
+		u32 m;
+		u8 *p;
+
+		if (!n) {
+			scatterwalk_start(&walk, sg_next(walk.sg));
+			n = scatterwalk_clamp(&walk, len);
+		}
+		p = scatterwalk_map(&walk);
+		m = min(n, AES_BLOCK_SIZE - macp);
+		crypto_xor(&mac[macp], p, m);
+
+		len -= n;
+		n -= m;
+		macp += m;
+		if (macp == AES_BLOCK_SIZE && (n || len)) {
+			ce_aes_ccm_auth_data(mac, &p[m], n, ctx->key->key_enc,
+					     rounds);
+			macp = n % AES_BLOCK_SIZE;
+		}
+
+		scatterwalk_unmap(p);
+		scatterwalk_advance(&walk, n + m);
+		scatterwalk_done(&walk, 0, len);
+	} while (len);
+}
+
+struct ccm_inner_desc_info {
+	u8	ctriv[AES_BLOCK_SIZE];
+	u8	mac[AES_BLOCK_SIZE];
+} __aligned(8);
+
+static int ccm_inner_encrypt(struct blkcipher_desc *desc,
+			     struct scatterlist *dst, struct scatterlist *src,
+			     unsigned int nbytes)
+{
+	struct crypto_aes_ctx *ctx = crypto_blkcipher_ctx(desc->tfm);
+	struct ccm_inner_desc_info *descinfo = desc->info;
+	u32 rounds = 6 + ctx->key_length / 4;
+	struct blkcipher_walk walk;
+	int err;
+
+	blkcipher_walk_init(&walk, dst, src, nbytes);
+	err = blkcipher_walk_virt_block(desc, &walk, AES_BLOCK_SIZE);
+
+	while (walk.nbytes) {
+		u32 tail = walk.nbytes % AES_BLOCK_SIZE;
+
+		if (walk.nbytes == nbytes)
+			tail = 0;
+
+		ce_aes_ccm_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
+				   walk.nbytes - tail, ctx->key_enc, rounds,
+				   descinfo->mac, descinfo->ctriv);
+
+		nbytes -= walk.nbytes - tail;
+		err = blkcipher_walk_done(desc, &walk, tail);
+	}
+	return err;
+}
+
+static int ccm_inner_decrypt(struct blkcipher_desc *desc,
+			     struct scatterlist *dst, struct scatterlist *src,
+			     unsigned int nbytes)
+{
+	struct crypto_aes_ctx *ctx = crypto_blkcipher_ctx(desc->tfm);
+	struct ccm_inner_desc_info *descinfo = desc->info;
+	u32 rounds = 6 + ctx->key_length / 4;
+	struct blkcipher_walk walk;
+	int err;
+
+	blkcipher_walk_init(&walk, dst, src, nbytes);
+	err = blkcipher_walk_virt_block(desc, &walk, AES_BLOCK_SIZE);
+
+	while (walk.nbytes) {
+		u32 tail = walk.nbytes % AES_BLOCK_SIZE;
+
+		if (walk.nbytes == nbytes)
+			tail = 0;
+
+		ce_aes_ccm_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
+				   walk.nbytes - tail, ctx->key_enc, rounds,
+				   descinfo->mac, descinfo->ctriv);
+
+		nbytes -= walk.nbytes - tail;
+		err = blkcipher_walk_done(desc, &walk, tail);
+	}
+	return err;
+}
+
+static int ccm_encrypt(struct aead_request *req)
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct crypto_ccm_aes_ctx *ctx = crypto_aead_ctx(aead);
+	u32 rounds = 6 + ctx->key->key_length / 4;
+	struct ccm_inner_desc_info descinfo;
+	DEFINE_NEON_REGSTACK_PARTIAL(regs, 4);
+	int err;
+
+	struct blkcipher_desc desc = {
+		.tfm	= ctx->blk_tfm,
+		.info	= &descinfo,
+		.flags = 0,
+	};
+
+	err = ccm_init_mac(req, descinfo.mac, req->cryptlen);
+	if (err)
+		return err;
+
+	kernel_neon_begin(regs);
+
+	if (req->assoclen)
+		ccm_calculate_auth_mac(req, descinfo.mac);
+
+	memcpy(descinfo.ctriv, req->iv, AES_BLOCK_SIZE);
+
+	/* call inner blkcipher to process the payload */
+	err = ccm_inner_encrypt(&desc, req->dst, req->src, req->cryptlen);
+	if (!err)
+		ce_aes_ccm_final(descinfo.mac, req->iv, ctx->key->key_enc,
+				 rounds);
+
+	kernel_neon_end(regs);
+
+	if (err)
+		return err;
+
+	/* copy authtag to end of dst */
+	scatterwalk_map_and_copy(descinfo.mac, req->dst, req->cryptlen,
+				 crypto_aead_authsize(aead), 1);
+
+	return 0;
+}
+
+static int ccm_decrypt(struct aead_request *req)
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct crypto_ccm_aes_ctx *ctx = crypto_aead_ctx(aead);
+	u32 rounds = 6 + ctx->key->key_length / 4;
+	struct ccm_inner_desc_info descinfo;
+	DEFINE_NEON_REGSTACK_PARTIAL(regs, 4);
+	u8 atag[AES_BLOCK_SIZE];
+	u32 len;
+	int err;
+
+	struct blkcipher_desc desc = {
+		.tfm	= ctx->blk_tfm,
+		.info	= &descinfo,
+		.flags = 0,
+	};
+
+	len = req->cryptlen - crypto_aead_authsize(aead);
+	err = ccm_init_mac(req, descinfo.mac, len);
+	if (err)
+		return err;
+
+	if (req->assoclen)
+		ccm_calculate_auth_mac(req, descinfo.mac);
+
+	memcpy(descinfo.ctriv, req->iv, AES_BLOCK_SIZE);
+
+	kernel_neon_begin(regs);
+
+	/* call inner blkcipher to process the payload */
+	err = ccm_inner_decrypt(&desc, req->dst, req->src, len);
+	if (!err)
+		ce_aes_ccm_final(descinfo.mac, req->iv, ctx->key->key_enc,
+				 rounds);
+
+	kernel_neon_end(regs);
+
+	if (err)
+		return err;
+
+	/* compare calculated auth tag with the stored one */
+	scatterwalk_map_and_copy(atag, req->src, len,
+				 crypto_aead_authsize(aead), 0);
+
+	if (memcmp(descinfo.mac, atag, crypto_aead_authsize(aead)))
+		return -EBADMSG;
+	return 0;
+}
+
+static int ccm_init(struct crypto_tfm *tfm)
+{
+	struct crypto_ccm_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct crypto_blkcipher *blk_tfm;
+
+	blk_tfm = crypto_alloc_blkcipher("__driver-ccm-aesce-inner", 0, 0);
+	if (IS_ERR(blk_tfm))
+		return PTR_ERR(blk_tfm);
+
+	/* did we get the right one? (sanity check) */
+	if (crypto_blkcipher_crt(blk_tfm)->encrypt != ccm_inner_encrypt) {
+		crypto_free_blkcipher(ctx->blk_tfm);
+		return -EINVAL;
+	}
+
+	ctx->blk_tfm = blk_tfm;
+	ctx->key = crypto_blkcipher_ctx(blk_tfm);
+
+	return 0;
+}
+
+static void ccm_exit(struct crypto_tfm *tfm)
+{
+	struct crypto_ccm_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	crypto_free_blkcipher(ctx->blk_tfm);
+}
+
+static struct crypto_alg aes_algs[] = { {
 	.cra_name		= "aes",
 	.cra_driver_name	= "aes-ce",
 	.cra_priority		= 300,
@@ -84,18 +393,56 @@ static struct crypto_alg aes_alg = {
 		.cia_encrypt		= aes_cipher_encrypt,
 		.cia_decrypt		= aes_cipher_decrypt
 	}
-};
+}, {
+	.cra_name		= "__ccm-aesce-inner",
+	.cra_driver_name	= "__driver-ccm-aesce-inner",
+	.cra_priority		= 0,
+	.cra_flags		= CRYPTO_ALG_TYPE_BLKCIPHER,
+	.cra_blocksize		= 1,
+	.cra_ctxsize		= sizeof(struct crypto_aes_ctx),
+	.cra_alignmask		= 7,
+	.cra_type		= &crypto_blkcipher_type,
+	.cra_module		= THIS_MODULE,
+	.cra_blkcipher = {
+		.min_keysize	= AES_MIN_KEY_SIZE,
+		.max_keysize	= AES_MAX_KEY_SIZE,
+		.ivsize		= sizeof(struct ccm_inner_desc_info),
+		.setkey		= crypto_aes_set_key,
+		.encrypt	= ccm_inner_encrypt,
+		.decrypt	= ccm_inner_decrypt,
+	},
+}, {
+	.cra_name		= "ccm(aes)",
+	.cra_driver_name	= "ccm-aes-ce",
+	.cra_priority		= 300,
+	.cra_flags		= CRYPTO_ALG_TYPE_AEAD,
+	.cra_blocksize		= 1,
+	.cra_ctxsize		= sizeof(struct crypto_ccm_aes_ctx),
+	.cra_alignmask		= 7,
+	.cra_type		= &crypto_aead_type,
+	.cra_module		= THIS_MODULE,
+	.cra_init		= ccm_init,
+	.cra_exit		= ccm_exit,
+	.cra_aead = {
+		.ivsize		= AES_BLOCK_SIZE,
+		.maxauthsize	= AES_BLOCK_SIZE,
+		.setkey		= ccm_setkey,
+		.setauthsize	= ccm_setauthsize,
+		.encrypt	= ccm_encrypt,
+		.decrypt	= ccm_decrypt,
+	}
+} };
 
 static int __init aes_mod_init(void)
 {
 	if (0) // TODO check for crypto extensions
 		return -ENODEV;
-	return crypto_register_alg(&aes_alg);
+	return crypto_register_algs(aes_algs, ARRAY_SIZE(aes_algs));
 }
 
 static void __exit aes_mod_exit(void)
 {
-	crypto_unregister_alg(&aes_alg);
+	crypto_unregister_algs(aes_algs, ARRAY_SIZE(aes_algs));
 }
 
 module_init(aes_mod_init);
diff --git a/arch/arm64/crypto/aesce-ccm.S b/arch/arm64/crypto/aesce-ccm.S
new file mode 100644
index 0000000..df1248b
--- /dev/null
+++ b/arch/arm64/crypto/aesce-ccm.S
@@ -0,0 +1,186 @@
+/*
+ * linux/arch/arm64/crypto/aesce-ccm.S - AES-CCM transform for ARMv8 with
+ *                                       Crypto Extensions
+ *
+ * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+	.text
+	.arch	armv8-a+crypto
+
+	/*
+	 * void ce_aes_ccm_auth_data(u8 mac[], u8 const in[], u32 abytes,
+	 *			     u8 const rk[], u32 rounds);
+	 */
+ENTRY(ce_aes_ccm_auth_data)
+	ld1	{v0.16b}, [x0]			/* load mac */
+0:	ld1	{v3.16b}, [x3]			/* load first round key */
+	mov	w7, w4
+	add	x6, x3, #16
+	b	2f
+1:	aese	v0.16b, v2.16b
+	subs	w7, w7, #2
+	beq	3f
+	aesmc	v0.16b, v0.16b
+2:	aese	v0.16b, v3.16b
+	ld1	{v2.16b-v3.16b}, [x6], #32	/* load next round keys */
+	aesmc	v0.16b, v0.16b
+	b	1b
+3:	eor	v0.16b, v0.16b, v3.16b		/* final round */
+	subs	w2, w2, #16			/* last data? */
+	bmi	4f
+	ld1	{v1.16b}, [x1], #16		/* load next input block */
+	eor	v0.16b, v0.16b, v1.16b		/* xor with mac */
+	bne	0b
+4:	st1	{v0.16b}, [x0]			/* store mac */
+	beq	6f
+	adds	w2, w2, #16
+	beq	6f
+5:	ldrb	w7, [x1], #1
+	umov	w6, v0.b[0]
+	eor	w6, w6, w7
+	strb	w6, [x0], #1
+	subs	w2, w2, #1
+	beq	6f
+	ext	v0.16b, v0.16b, v0.16b, #1	/* rotate out the mac bytes */
+	b	5b
+6:	ret
+ENDPROC(ce_aes_ccm_auth_data)
+
+	/*
+	 * void ce_aes_ccm_final(u8 mac[], u8 const ctr[], u8 const rk[],
+	 * 			 u32 rounds);
+	 */
+ENTRY(ce_aes_ccm_final)
+	ld1	{v0.16b}, [x0]			/* load mac */
+	ld1	{v2.16b-v3.16b}, [x2], #32	/* load first 2 round keys */
+	ld1	{v1.16b}, [x1]			/* load 1st ctriv */
+	cmp	w3, #12
+	beq	1f
+0:	aese	v0.16b, v2.16b			/* 4 rounds, 2x interleaved */
+	aese	v1.16b, v2.16b
+	aesmc	v0.16b, v0.16b
+	aesmc	v1.16b, v1.16b
+	aese	v0.16b, v3.16b
+	aese	v1.16b, v3.16b
+	subs	w3, w3, #4
+	ble	2f
+	ld1	{v2.16b-v3.16b}, [x2], #32	/* load next 2 round keys */
+	aesmc	v0.16b, v0.16b
+	aesmc	v1.16b, v1.16b
+1:	aese	v0.16b, v2.16b
+	aese	v1.16b, v2.16b
+	aesmc	v0.16b, v0.16b
+	aesmc	v1.16b, v1.16b
+	aese	v0.16b, v3.16b
+	aese	v1.16b, v3.16b
+	ld1	{v2.16b-v3.16b}, [x2], #32	/* load next 2 round keys */
+	aesmc	v0.16b, v0.16b
+	aesmc	v1.16b, v1.16b
+	b	0b
+2:	/* final round key cancels out */
+	eor	v0.16b, v0.16b, v1.16b		/* en-/decrypt the mac */
+	st1	{v0.16b}, [x0]			/* store result */
+	ret
+ENDPROC(ce_aes_ccm_final)
+
+	.macro	aes_ccm_do_crypt,enc
+	ldr	x8, [x6, #8]			/* load lower ctr */
+	ld1	{v0.16b}, [x5]			/* load mac */
+	rev	x8, x8				/* keep swabbed ctr in reg */
+	b	0f
+	.align	6
+0:	ld1	{v1.8b}, [x6]			/* load upper ctr */
+	ld1	{v3.16b}, [x3]			/* load first round key */
+	add	x8, x8, #1
+	mov	w7, w4				/* get # of rounds */
+	rev	x9, x8
+	cmp	w4, #12				/* 10, 12 or 14 rounds? */
+	add	x10, x3, #16
+	ins	v1.d[1], x9			/* no carry in lower ctr */
+	beq	3f
+	b	2f
+1:	aese	v0.16b, v2.16b			/* 4 rounds, 2x interleaved */
+	aese	v1.16b, v2.16b
+	aesmc	v0.16b, v0.16b
+	aesmc	v1.16b, v1.16b
+2:	aese	v0.16b, v3.16b
+	aese	v1.16b, v3.16b
+	ld1	{v2.16b-v3.16b}, [x10], #32	/* load next 2 round keys */
+	aesmc	v0.16b, v0.16b
+	aesmc	v1.16b, v1.16b
+	subs	w7, w7, #4
+	aese	v0.16b, v2.16b
+	aese	v1.16b, v2.16b
+	ble	4f
+	aesmc	v0.16b, v0.16b
+	aesmc	v1.16b, v1.16b
+3:	aese	v0.16b, v3.16b
+	aese	v1.16b, v3.16b
+	ld1	{v2.16b-v3.16b}, [x10], #32	/* load next 2 round keys */
+	aesmc	v0.16b, v0.16b
+	aesmc	v1.16b, v1.16b
+	b	1b
+4:	subs	w2, w2, #16
+	bmi	5f
+	ld1	{v2.16b}, [x1], #16		/* load next input block */
+	.if	\enc == 1
+	eor	v2.16b, v2.16b, v3.16b		/* final round enc+mac */
+	eor	v1.16b, v1.16b, v2.16b		/* xor with crypted ctr */
+	.else
+	eor	v2.16b, v2.16b, v1.16b		/* xor with crypted ctr */
+	eor	v1.16b, v2.16b, v3.16b		/* final round enc */
+	.endif
+	eor	v0.16b, v0.16b, v2.16b		/* xor mac with pt ^ rk[last] */
+	st1	{v1.16b}, [x0], #16		/* write output block */
+	beq	5f
+	b	0b
+5:	eor	v0.16b, v0.16b, v3.16b		/* final round mac */
+	eor	v1.16b, v1.16b, v3.16b		/* final round enc */
+	st1	{v0.16b}, [x5]			/* store mac */
+	beq	7f
+	add	w2, w2, #16			/* process partial tail block */
+6:	ldrb	w9, [x1], #1			/* get 1 byte of input */
+	umov	w6, v1.b[0]			/* get top crypted ctr byte */
+	umov	w7, v0.b[0]			/* get top mac byte */
+	.if	\enc == 1
+	eor	w7, w7, w9
+	eor	w9, w9, w6
+	.else
+	eor	w9, w9, w6
+	eor	w7, w7, w9
+	.endif
+	strb	w9, [x0], #1			/* store out byte */
+	strb	w7, [x5], #1			/* store mac byte */
+	subs	w2, w2, #1
+	beq	8f
+	ext	v0.16b, v0.16b, v0.16b, #1	/* shift out mac byte */
+	ext	v1.16b, v1.16b, v1.16b, #1	/* shift out ctr byte */
+	b	6b
+7:	rev	x8, x8
+	str	x8, [x6, #8]			/* store lsb end of ctr (BE) */
+8:	ret
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
+
-- 
1.8.1.2
