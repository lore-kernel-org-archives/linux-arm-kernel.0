From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 13 Oct 2013 14:15:01 +0200
Subject: [RFC v3 PATCH 5/7] ARM64: add Crypto Extensions based synchronous
 core AES cipher
In-Reply-To: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381666503-23726-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements the core AES cipher using the Crypto Extensions,
using only NEON register q0 and q1.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Makefile          |  11 +++--
 arch/arm64/crypto/Makefile   |  14 ++++++
 arch/arm64/crypto/aes-sync.c | 106 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aes-sync.c

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index d90cf79..d1ca9d8 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,11 +36,12 @@ TEXT_OFFSET := 0x00080000
 
 export	TEXT_OFFSET GZFLAGS
 
-core-y		+= arch/arm64/kernel/ arch/arm64/mm/
-core-$(CONFIG_KVM) += arch/arm64/kvm/
-core-$(CONFIG_XEN) += arch/arm64/xen/
-libs-y		:= arch/arm64/lib/ $(libs-y)
-libs-y		+= $(LIBGCC)
+core-y			+= arch/arm64/kernel/ arch/arm64/mm/
+core-$(CONFIG_KVM)	+= arch/arm64/kvm/
+core-$(CONFIG_XEN)	+= arch/arm64/xen/
+core-$(CONFIG_CRYPTO)	+= arch/arm64/crypto/
+libs-y			:= arch/arm64/lib/ $(libs-y)
+libs-y			+= $(LIBGCC)
 
 # Default target when executing plain make
 KBUILD_IMAGE	:= Image.gz
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
new file mode 100644
index 0000000..269d9be
--- /dev/null
+++ b/arch/arm64/crypto/Makefile
@@ -0,0 +1,14 @@
+#
+# linux/arch/arm64/crypto/Makefile
+#
+# Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+
+aesce-sync-y	:= aes-sync.o
+obj-m		+= aesce-sync.o
+
+CFLAGS_aes-sync.o	+= -march=armv8-a+crypto
diff --git a/arch/arm64/crypto/aes-sync.c b/arch/arm64/crypto/aes-sync.c
new file mode 100644
index 0000000..5d7ed4e
--- /dev/null
+++ b/arch/arm64/crypto/aes-sync.c
@@ -0,0 +1,106 @@
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
+#include <asm/neon.h>
+#include <crypto/aes.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+
+static void aes_cipher_encrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
+{
+	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	u32 rounds = 6 + ctx->key_length / 4;
+	DEFINE_NEON_REGSTACK_PARTIAL(regs, 2);
+
+	kernel_neon_begin(regs);
+
+	__asm__("	ld1		{v0.16b}, [%[in]]		;"
+		"	ld1		{v1.16b}, [%[key]], #16		;"
+		"0:	aese		v0.16b, v1.16b			;"
+		"	subs		%[rounds], %[rounds], #1	;"
+		"	ld1		{v1.16b}, [%[key]], #16		;"
+		"	beq		1f				;"
+		"	aesmc		v0.16b, v0.16b			;"
+		"	b		0b				;"
+		"1:	eor		v0.16b, v0.16b, v1.16b		;"
+		"	st1		{v0.16b}, [%[out]]		;"
+	: :
+		[out]		"r"(dst),
+		[in]		"r"(src),
+		[rounds]	"r"(rounds),
+		[key]		"r"(ctx->key_enc)
+	:			"cc");
+
+	kernel_neon_end(regs);
+}
+
+static void aes_cipher_decrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
+{
+	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	u32 rounds = 6 + ctx->key_length / 4;
+	DEFINE_NEON_REGSTACK_PARTIAL(regs, 2);
+
+	kernel_neon_begin(regs);
+
+	__asm__("	ld1		{v0.16b}, [%[in]]		;"
+		"	ld1		{v1.16b}, [%[key]], #16		;"
+		"0:	aesd		v0.16b, v1.16b			;"
+		"	ld1		{v1.16b}, [%[key]], #16		;"
+		"	subs		%[rounds], %[rounds], #1	;"
+		"	beq		1f				;"
+		"	aesimc		v0.16b, v0.16b			;"
+		"	b		0b				;"
+		"1:	eor		v0.16b, v0.16b, v1.16b		;"
+		"	st1		{v0.16b}, [%[out]]		;"
+	: :
+		[out]		"r"(dst),
+		[in]		"r"(src),
+		[rounds]	"r"(rounds),
+		[key]		"r"(ctx->key_dec)
+	:			"cc");
+
+	kernel_neon_end(regs);
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
