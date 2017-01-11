From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Jan 2017 17:01:55 +0000
Subject: [PATCH v2 2/5] crypto: arm/aes-ce - enable module autoloading based
 on CPU feature bits
In-Reply-To: <1484154118-22139-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484154118-22139-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1484154118-22139-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the module autoloadable by tying it to the CPU feature bit that
describes whether the optional instructions it relies on are implemented
by the current CPU.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/aes-ce-glue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/crypto/aes-ce-glue.c b/arch/arm/crypto/aes-ce-glue.c
index 8857531915bf..98c68ad101e5 100644
--- a/arch/arm/crypto/aes-ce-glue.c
+++ b/arch/arm/crypto/aes-ce-glue.c
@@ -14,6 +14,7 @@
 #include <crypto/aes.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
+#include <linux/cpufeature.h>
 #include <linux/module.h>
 #include <crypto/xts.h>
 
@@ -428,9 +429,6 @@ static int __init aes_init(void)
 	int err;
 	int i;
 
-	if (!(elf_hwcap2 & HWCAP2_AES))
-		return -ENODEV;
-
 	err = crypto_register_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
 	if (err)
 		return err;
@@ -454,5 +452,5 @@ static int __init aes_init(void)
 	return err;
 }
 
-module_init(aes_init);
+module_cpu_feature_match(AES, aes_init);
 module_exit(aes_exit);
-- 
2.7.4
