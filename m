From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Oct 2016 11:52:16 +0100
Subject: [PATCH 2/5] crypto: arm/aes-ce - enable module autoloading based on
 CPU feature bits
In-Reply-To: <1476787939-21889-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476787939-21889-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1476787939-21889-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the module autoloadable by tying it to the CPU feature bit that
describes whether the optional instructions it relies on are implemented
by the current CPU.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/aes-ce-glue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/crypto/aes-ce-glue.c b/arch/arm/crypto/aes-ce-glue.c
index aef022a87c53..5b1af6f8b2b5 100644
--- a/arch/arm/crypto/aes-ce-glue.c
+++ b/arch/arm/crypto/aes-ce-glue.c
@@ -14,6 +14,7 @@
 #include <crypto/aes.h>
 #include <crypto/ablk_helper.h>
 #include <crypto/algapi.h>
+#include <linux/cpufeature.h>
 #include <linux/module.h>
 #include <crypto/xts.h>
 
@@ -515,8 +516,6 @@ static struct crypto_alg aes_algs[] = { {
 
 static int __init aes_init(void)
 {
-	if (!(elf_hwcap2 & HWCAP2_AES))
-		return -ENODEV;
 	return crypto_register_algs(aes_algs, ARRAY_SIZE(aes_algs));
 }
 
@@ -525,5 +524,5 @@ static void __exit aes_exit(void)
 	crypto_unregister_algs(aes_algs, ARRAY_SIZE(aes_algs));
 }
 
-module_init(aes_init);
+module_cpu_feature_match(AES, aes_init);
 module_exit(aes_exit);
-- 
2.7.4
