From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 21 May 2017 10:23:36 +0000
Subject: [PATCH 1/5] crypto: arm/aes-ce - enable module autoloading based on
 CPU feature bits
In-Reply-To: <1495362220-30044-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1495362220-30044-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1495362220-30044-2-git-send-email-ard.biesheuvel@linaro.org>
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
index 883b84d828c5..0f966a8ca1ce 100644
--- a/arch/arm/crypto/aes-ce-glue.c
+++ b/arch/arm/crypto/aes-ce-glue.c
@@ -14,6 +14,7 @@
 #include <crypto/aes.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
+#include <linux/cpufeature.h>
 #include <linux/module.h>
 #include <crypto/xts.h>
 
@@ -425,9 +426,6 @@ static int __init aes_init(void)
 	int err;
 	int i;
 
-	if (!(elf_hwcap2 & HWCAP2_AES))
-		return -ENODEV;
-
 	err = crypto_register_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
 	if (err)
 		return err;
@@ -451,5 +449,5 @@ static int __init aes_init(void)
 	return err;
 }
 
-module_init(aes_init);
+module_cpu_feature_match(AES, aes_init);
 module_exit(aes_exit);
-- 
2.7.4
