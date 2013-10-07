From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  7 Oct 2013 14:12:29 +0200
Subject: [RFC PATCH 3/5] ARM64: add Crypto Extensions based synchronous core
 AES cipher
In-Reply-To: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381147951-7609-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements the core AES cipher using the Crypto Extensions,
using only NEON register q0 and q1.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/Makefile   |  5 +++
 arch/arm64/crypto/aes-sync.c | 95 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 arch/arm64/crypto/aes-sync.c

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index f87ec80..e598c0a 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -9,3 +9,8 @@
 #
 
 obj-y += aesce-emu.o
+
+ifeq ($(CONFIG_KERNEL_MODE_SYNC_CE_CRYPTO),y)
+aesce-sync-y	:= aes-sync.o
+obj-m		+= aesce-sync.o
+endif
diff --git a/arch/arm64/crypto/aes-sync.c b/arch/arm64/crypto/aes-sync.c
new file mode 100644
index 0000000..5c5d641
--- /dev/null
+++ b/arch/arm64/crypto/aes-sync.c
@@ -0,0 +1,95 @@
+/*
+ * linux/arch/arm64/crypto/aes-sync.c
+ *
+ * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <crypto/aes.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+
+static void aes_cipher_encrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
+{
+	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	int rounds = 6 + ctx->key_length / 4;
+
+	__asm__("	.arch		armv8-a+crypto			\n\t"
+		"	ld1		{v0.16b}, [%[in]]		\n\t"
+		"	ld1		{v1.16b}, [%[key]], #16		\n\t"
+		"0:	aese		v0.16b, v1.16b			\n\t"
+		"	subs		%[rounds], %[rounds], #1	\n\t"
+		"	ld1		{v1.16b}, [%[key]], #16		\n\t"
+		"	beq		1f				\n\t"
+		"	aesmc		v0.16b, v0.16b			\n\t"
+		"	b		0b				\n\t"
+		"1:	eor		v0.16b, v0.16b, v1.16b		\n\t"
+		"	st1		{v0.16b}, [%[out]]		\n\t"
+	: :
+		[out]		"r"(dst),
+		[in]		"r"(src),
+		[rounds]	"r"(rounds),
+		[key]		"r"(ctx->key_enc));
+}
+
+static void aes_cipher_decrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
+{
+	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	int rounds = 6 + ctx->key_length / 4;
+
+	__asm__("	.arch		armv8-a+crypto			\n\t"
+		"	ld1		{v0.16b}, [%[in]]		\n\t"
+		"	ld1		{v1.16b}, [%[key]], #16		\n\t"
+		"0:	aesd		v0.16b, v1.16b			\n\t"
+		"	ld1		{v1.16b}, [%[key]], #16		\n\t"
+		"	subs		%[rounds], %[rounds], #1	\n\t"
+		"	beq		1f				\n\t"
+		"	aesimc		v0.16b, v0.16b			\n\t"
+		"	b		0b				\n\t"
+		"1:	eor		v0.16b, v0.16b, v1.16b		\n\t"
+		"	st1		{v0.16b}, [%[out]]		\n\t"
+	: :
+		[out]		"r"(dst),
+		[in]		"r"(src),
+		[rounds]	"r"(rounds),
+		[key]		"r"(ctx->key_dec));
+}
+
+static struct crypto_alg aes_alg = {
+	.cra_name		= "aes",
+	.cra_driver_name	= "aes-ce",
+	.cra_priority		= 300,
+	.cra_flags		= CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		= AES_BLOCK_SIZE,
+	.cra_ctxsize		= sizeof(struct crypto_aes_ctx),
+	.cra_module		= THIS_MODULE,
+	.cra_cipher = {
+		.cia_min_keysize	= AES_MIN_KEY_SIZE,
+		.cia_max_keysize	= AES_MAX_KEY_SIZE,
+		.cia_setkey		= crypto_aes_set_key,
+		.cia_encrypt		= aes_cipher_encrypt,
+		.cia_decrypt		= aes_cipher_decrypt
+	}
+};
+
+static int __init aes_mod_init(void)
+{
+	if (0) // TODO check for crypto extensions
+		return -ENODEV;
+	return crypto_register_alg(&aes_alg);
+}
+
+static void __exit aes_mod_exit(void)
+{
+	crypto_unregister_alg(&aes_alg);
+}
+
+module_init(aes_mod_init);
+module_exit(aes_mod_exit);
+
+MODULE_DESCRIPTION("Synchronous AES using ARMv8 Crypto Extensions");
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_LICENSE("GPL");
-- 
1.8.1.2
