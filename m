From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  6 Mar 2014 12:12:48 +0800
Subject: [PATCH 2/2] arm64: Add support for SHA1 using ARMv8 Crypto Extensions
In-Reply-To: <1394079168-27666-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1394079168-27666-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1394079168-27666-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the SHA1 hash algorithm using the NEON based
SHA1 instructions that were introduced in ARM v8.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/Makefile       |   2 +
 arch/arm64/crypto/sha1-ce-core.S | 121 +++++++++++++++++++++++++++++++
 arch/arm64/crypto/sha1-ce-glue.c | 149 +++++++++++++++++++++++++++++++++++++++
 crypto/Kconfig                   |   6 ++
 4 files changed, 278 insertions(+)
 create mode 100644 arch/arm64/crypto/sha1-ce-core.S
 create mode 100644 arch/arm64/crypto/sha1-ce-glue.c

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index ac58945c50b3..f66d508eff9e 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -9,5 +9,7 @@
 #
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_CE) += aes-ce-cipher.o
+obj-$(CONFIG_CRYPTO_SHA1_ARM64_CE) += sha1-ce.o
 
 CFLAGS_aes-ce-cipher.o += -march=armv8-a+crypto
+sha1-ce-y := sha1-ce-glue.o sha1-ce-core.o
diff --git a/arch/arm64/crypto/sha1-ce-core.S b/arch/arm64/crypto/sha1-ce-core.S
new file mode 100644
index 000000000000..2c05e0786949
--- /dev/null
+++ b/arch/arm64/crypto/sha1-ce-core.S
@@ -0,0 +1,121 @@
+/*
+ * linux/arch/arm64/crypto/sha1-ce-core.S
+ *
+ * Copyright (C) 2014 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+	.text
+	.arch		armv8-a+crypto
+
+	.macro		sha1_round, op, ws, dg0, dg1, dg2
+	sha1h		s\dg2, s\dg0
+	sha1\op		q\dg0, s\dg1, \ws
+	.endm
+
+	.macro		sha1_update, rc, ws, s0, s1, s2, s3
+	sha1su0		\s0, \s1, \s2
+	sha1su1		\s0, \s3
+	add		\ws, \s0, \rc
+	.endm
+
+	/*
+	 * The SHA1 round constants
+	 */
+	.align		4
+.Lsha1_rcon:
+	.word	0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6
+
+	/*
+	 * void sha1_ce_transform(u32 *state, u8 const *src, int blocks)
+	 */
+ENTRY(sha1_ce_transform)
+	/* load round constants */
+	adr		x3, .Lsha1_rcon
+	ld1r		{v0.4s}, [x3], #4
+	ld1r		{v1.4s}, [x3], #4
+	ld1r		{v2.4s}, [x3], #4
+	ld1r		{v3.4s}, [x3]
+
+	/* load state */
+	add		x3, x0, #16
+	ld1		{v15.4s}, [x0]
+	ld1		{v16.s}[0], [x3]
+
+	/* loop over src in 64 byte chunks */
+0:	sub		w2, w2, #1
+
+	/* load input */
+	ld1		{v8.4s-v11.4s}, [x1], #64
+	rev32		v8.16b, v8.16b
+	rev32		v9.16b, v9.16b
+	rev32		v10.16b, v10.16b
+	rev32		v11.16b, v11.16b
+
+	/* copy state */
+	mov		v12.16b, v15.16b
+	mov		v13.16b, v16.16b
+
+	/* round 1 */
+	add		v4.4s, v8.4s, v0.4s
+	add		v5.4s, v9.4s, v0.4s
+	add		v6.4s, v10.4s, v0.4s
+	add		v7.4s, v11.4s, v0.4s
+	sha1_round	c, v4.4s, 12, 13, 14
+	sha1_update	v0.4s, v4.4s, v8.4s, v9.4s, v10.4s, v11.4s
+	sha1_round	c, v5.4s, 12, 14, 13
+	sha1_update	v1.4s, v5.4s, v9.4s, v10.4s, v11.4s, v8.4s
+	sha1_round	c, v6.4s, 12, 13, 14
+	sha1_update	v1.4s, v6.4s, v10.4s, v11.4s, v8.4s, v9.4s
+	sha1_round	c, v7.4s, 12, 14, 13
+	sha1_update	v1.4s, v7.4s, v11.4s, v8.4s, v9.4s, v10.4s
+	sha1_round	c, v4.4s, 12, 13, 14
+	sha1_update	v1.4s, v4.4s, v8.4s, v9.4s, v10.4s, v11.4s
+
+	/* round 2 */
+	sha1_round	p, v5.4s, 12, 14, 13
+	sha1_update	v1.4s, v5.4s, v9.4s, v10.4s, v11.4s, v8.4s
+	sha1_round	p, v6.4s, 12, 13, 14
+	sha1_update	v2.4s, v6.4s, v10.4s, v11.4s, v8.4s, v9.4s
+	sha1_round	p, v7.4s, 12, 14, 13
+	sha1_update	v2.4s, v7.4s, v11.4s, v8.4s, v9.4s, v10.4s
+	sha1_round	p, v4.4s, 12, 13, 14
+	sha1_update	v2.4s, v4.4s, v8.4s, v9.4s, v10.4s, v11.4s
+	sha1_round	p, v5.4s, 12, 14, 13
+	sha1_update	v2.4s, v5.4s, v9.4s, v10.4s, v11.4s, v8.4s
+
+	/* round 3 */
+	sha1_round	m, v6.4s, 12, 13, 14
+	sha1_update	v2.4s, v6.4s, v10.4s, v11.4s, v8.4s, v9.4s
+	sha1_round	m, v7.4s, 12, 14, 13
+	sha1_update	v3.4s, v7.4s, v11.4s, v8.4s, v9.4s, v10.4s
+	sha1_round	m, v4.4s, 12, 13, 14
+	sha1_update	v3.4s, v4.4s, v8.4s, v9.4s, v10.4s, v11.4s
+	sha1_round	m, v5.4s, 12, 14, 13
+	sha1_update	v3.4s, v5.4s, v9.4s, v10.4s, v11.4s, v8.4s
+	sha1_round	m, v6.4s, 12, 13, 14
+	sha1_update	v3.4s, v6.4s, v10.4s, v11.4s, v8.4s, v9.4s
+
+	/* round 4 */
+	sha1_round	p, v7.4s, 12, 14, 13
+	sha1_update	v3.4s, v7.4s, v11.4s, v8.4s, v9.4s, v10.4s
+	sha1_round	p, v4.4s, 12, 13, 14
+	sha1_round	p, v5.4s, 12, 14, 13
+	sha1_round	p, v6.4s, 12, 13, 14
+	sha1_round	p, v7.4s, 12, 14, 13
+
+	/* update state */
+	add		v15.4s, v15.4s, v12.4s
+	add		v16.4s, v16.4s, v13.4s
+	cbnz		w2, 0b
+
+	/* store new state */
+	st1		{v15.4s}, [x0]
+	st1		{v16.s}[0], [x3]
+	ret
+ENDPROC(sha1_ce_transform)
diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
new file mode 100644
index 000000000000..7c79552bbe70
--- /dev/null
+++ b/arch/arm64/crypto/sha1-ce-glue.c
@@ -0,0 +1,149 @@
+/*
+ * linux/arch/arm64/crypto/sha1-ce-glue.c
+ *
+ * Copyright (C) 2014 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * Derived from linux/crypto/sha1_generic.c
+ *
+ * Copyright (c) Alan Smithee.
+ * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
+ * Copyright (c) Jean-Francois Dive <jef@linuxbe.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/byteorder.h>
+#include <asm/hwcap.h>
+#include <asm/neon.h>
+#include <crypto/internal/hash.h>
+#include <crypto/sha.h>
+#include <linux/cpufeature.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+
+MODULE_DESCRIPTION("SHA1 secure hash using ARMv8 Crypto Extensions");
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_LICENSE("GPL");
+
+asmlinkage void sha1_ce_transform(u32 *state, u8 const *src, int blocks);
+
+static int sha1_init(struct shash_desc *desc)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha1_state){
+		.state = { SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4 },
+	};
+
+	return 0;
+}
+
+static int sha1_update(struct shash_desc *desc, const u8 *data,
+		       unsigned int len)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+	unsigned int partial, done = 0;
+
+	partial = sctx->count % SHA1_BLOCK_SIZE;
+
+	if ((partial + len) >= SHA1_BLOCK_SIZE) {
+		int blocks;
+
+		kernel_neon_begin_partial(18);
+		if (partial) {
+			done = SHA1_BLOCK_SIZE - partial;
+			memcpy(sctx->buffer + partial, data, done);
+			sha1_ce_transform(sctx->state, sctx->buffer, 1);
+			partial = 0;
+		}
+
+		blocks = (len - done) / SHA1_BLOCK_SIZE;
+		if (blocks) {
+			sha1_ce_transform(sctx->state, &data[done], blocks);
+			done += blocks * SHA1_BLOCK_SIZE;
+		}
+		kernel_neon_end();
+	}
+	memcpy(sctx->buffer + partial, &data[done], len - done);
+	sctx->count += len;
+	return 0;
+}
+
+/* Add padding and return the message digest. */
+static int sha1_final(struct shash_desc *desc, u8 *out)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+	__be32 *dst = (__be32 *)out;
+	u32 i, index, padlen;
+	__be64 bits;
+	static const u8 padding[64] = { 0x80, };
+
+	bits = cpu_to_be64(sctx->count << 3);
+
+	/* Pad out to 56 mod 64 */
+	index = sctx->count & 0x3f;
+	padlen = (index < 56) ? (56 - index) : ((64+56) - index);
+	sha1_update(desc, padding, padlen);
+
+	/* Append length */
+	sha1_update(desc, (const u8 *)&bits, sizeof(bits));
+
+	/* Store state in digest */
+	for (i = 0; i < 5; i++)
+		dst[i] = cpu_to_be32(sctx->state[i]);
+
+	/* Wipe context */
+	memset(sctx, 0, sizeof *sctx);
+
+	return 0;
+}
+
+static int sha1_export(struct shash_desc *desc, void *out)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	memcpy(out, sctx, sizeof(*sctx));
+	return 0;
+}
+
+static int sha1_import(struct shash_desc *desc, const void *in)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	memcpy(sctx, in, sizeof(*sctx));
+	return 0;
+}
+
+static struct shash_alg alg = {
+	.digestsize		= SHA1_DIGEST_SIZE,
+	.init			= sha1_init,
+	.update			= sha1_update,
+	.final			= sha1_final,
+	.export			= sha1_export,
+	.import			= sha1_import,
+	.descsize		= sizeof(struct sha1_state),
+	.statesize		= sizeof(struct sha1_state),
+	.base			= {
+		.cra_name		= "sha1",
+		.cra_driver_name	= "sha1-ce",
+		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_ALG_TYPE_SHASH,
+		.cra_blocksize		= SHA1_BLOCK_SIZE,
+		.cra_module		= THIS_MODULE,
+	}
+};
+
+static int __init sha1_generic_mod_init(void)
+{
+	return crypto_register_shash(&alg);
+}
+
+static void __exit sha1_generic_mod_fini(void)
+{
+	crypto_unregister_shash(&alg);
+}
+
+module_cpu_feature_match(SHA1, sha1_generic_mod_init);
+module_exit(sha1_generic_mod_fini);
diff --git a/crypto/Kconfig b/crypto/Kconfig
index f1d98bc346b6..44333536127c 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -500,6 +500,12 @@ config CRYPTO_SHA1_SSSE3
 	  using Supplemental SSE3 (SSSE3) instructions or Advanced Vector
 	  Extensions (AVX), when available.
 
+config CRYPTO_SHA1_ARM64_CE
+	tristate "SHA1 digest algorithm (ARMv8 Crypto Extensions)"
+	depends on ARM64 && KERNEL_MODE_NEON
+	select CRYPTO_SHA1
+	select CRYPTO_HASH
+
 config CRYPTO_SHA256_SSSE3
 	tristate "SHA256 digest algorithm (SSSE3/AVX/AVX2)"
 	depends on X86 && 64BIT
-- 
1.8.3.2
