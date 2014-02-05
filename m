From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  5 Feb 2014 18:13:38 +0100
Subject: [PATCH v2 4/4] arm64: add Crypto Extensions based synchronous core
 AES cipher
In-Reply-To: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1391620418-3999-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements the core AES cipher using the Crypto Extensions,
using only NEON registers q0 - q3.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Makefile               |   1 +
 arch/arm64/crypto/Makefile        |  13 ++++
 arch/arm64/crypto/aes-ce-cipher.c | 134 ++++++++++++++++++++++++++++++++++++++
 crypto/Kconfig                    |   6 ++
 4 files changed, 154 insertions(+)
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aes-ce-cipher.c

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2fceb71ac3b7..8185a913c5ed 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -45,6 +45,7 @@ export	TEXT_OFFSET GZFLAGS
 core-y		+= arch/arm64/kernel/ arch/arm64/mm/
 core-$(CONFIG_KVM) += arch/arm64/kvm/
 core-$(CONFIG_XEN) += arch/arm64/xen/
+core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 libs-y		+= $(LIBGCC)
 
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
new file mode 100644
index 000000000000..ac58945c50b3
--- /dev/null
+++ b/arch/arm64/crypto/Makefile
@@ -0,0 +1,13 @@
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
+obj-$(CONFIG_CRYPTO_AES_ARM64_CE) += aes-ce-cipher.o
+
+CFLAGS_aes-ce-cipher.o += -march=armv8-a+crypto
diff --git a/arch/arm64/crypto/aes-ce-cipher.c b/arch/arm64/crypto/aes-ce-cipher.c
new file mode 100644
index 000000000000..6dd64106923f
--- /dev/null
+++ b/arch/arm64/crypto/aes-ce-cipher.c
@@ -0,0 +1,134 @@
+/*
+ * linux/arch/arm64/crypto/aes-ce-cipher.c
+ *
+ * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/hwcap.h>
+#include <asm/neon.h>
+#include <crypto/aes.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+
+MODULE_DESCRIPTION("Synchronous AES cipher using ARMv8 Crypto Extensions");
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_LICENSE("GPL");
+
+static int num_rounds(struct crypto_aes_ctx *ctx)
+{
+	/*
+	 * # of rounds specified by AES:
+	 * 128 bit key		10 rounds
+	 * 192 bit key		12 rounds
+	 * 256 bit key		14 rounds
+	 * => n byte key	=> 6 + (n/4) rounds
+	 */
+	return 6 + ctx->key_length / 4;
+}
+
+static void aes_cipher_encrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
+{
+	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	kernel_neon_begin_partial(4);
+
+	__asm__("	ld1		{v0.16b}, [%[in]]		;"
+		"	cmp		%[rounds], #10			;"
+		"	bmi		0f				;"
+		"	bne		3f				;"
+		"	ld1		{v3.2d}, [%[key]], #16		;"
+		"	b		2f				;"
+		"0:	ld1		{v2.2d-v3.2d}, [%[key]], #32	;"
+		"1:	aese		v0.16b, v2.16b			;"
+		"	aesmc		v0.16b, v0.16b			;"
+		"2:	aese		v0.16b, v3.16b			;"
+		"	aesmc		v0.16b, v0.16b			;"
+		"3:	ld1		{v1.2d-v3.2d}, [%[key]], #48	;"
+		"	subs		%[rounds], %[rounds], #3	;"
+		"	aese		v0.16b, v1.16b			;"
+		"	aesmc		v0.16b, v0.16b			;"
+		"	bpl		1b				;"
+		"	aese		v0.16b, v2.16b			;"
+		"	eor		v0.16b, v0.16b, v3.16b		;"
+		"	st1		{v0.16b}, [%[out]]		;"
+	: :
+		[out]		"r"(dst),
+		[in]		"r"(src),
+		[rounds]	"r"(num_rounds(ctx) - 2),
+		[key]		"r"(ctx->key_enc)
+	:			"cc", "memory");
+
+	kernel_neon_end();
+}
+
+static void aes_cipher_decrypt(struct crypto_tfm *tfm, u8 dst[], u8 const src[])
+{
+	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	kernel_neon_begin_partial(4);
+
+	__asm__("	ld1		{v0.16b}, [%[in]]		;"
+		"	cmp		%[rounds], #10			;"
+		"	bmi		0f				;"
+		"	bne		3f				;"
+		"	ld1		{v3.2d}, [%[key]], #16		;"
+		"	b		2f				;"
+		"0:	ld1		{v2.2d-v3.2d}, [%[key]], #32	;"
+		"1:	aesd		v0.16b, v2.16b			;"
+		"	aesimc		v0.16b, v0.16b			;"
+		"2:	aesd		v0.16b, v3.16b			;"
+		"	aesimc		v0.16b, v0.16b			;"
+		"3:	ld1		{v1.2d-v3.2d}, [%[key]], #48	;"
+		"	subs		%[rounds], %[rounds], #3	;"
+		"	aesd		v0.16b, v1.16b			;"
+		"	aesimc		v0.16b, v0.16b			;"
+		"	bpl		1b				;"
+		"	aesd		v0.16b, v2.16b			;"
+		"	eor		v0.16b, v0.16b, v3.16b		;"
+		"	st1		{v0.16b}, [%[out]]		;"
+	: :
+		[out]		"r"(dst),
+		[in]		"r"(src),
+		[rounds]	"r"(num_rounds(ctx) - 2),
+		[key]		"r"(ctx->key_dec)
+	:			"cc", "memory");
+
+	kernel_neon_end();
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
+	if (!(elf_hwcap & HWCAP_AES))
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
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 7bcb70d216e1..f1d98bc346b6 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -791,6 +791,12 @@ config CRYPTO_AES_ARM_BS
 	  This implementation does not rely on any lookup tables so it is
 	  believed to be invulnerable to cache timing attacks.
 
+config CRYPTO_AES_ARM64_CE
+	tristate "Synchronous AES cipher using ARMv8 Crypto Extensions"
+	depends on ARM64 && KERNEL_MODE_NEON
+	select CRYPTO_ALGAPI
+	select CRYPTO_AES
+
 config CRYPTO_ANUBIS
 	tristate "Anubis cipher algorithm"
 	select CRYPTO_ALGAPI
-- 
1.8.3.2
