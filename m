From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 21 May 2017 10:23:37 +0000
Subject: [PATCH 2/5] crypto: arm/ghash-ce - enable module autoloading based on
 CPU feature bits
In-Reply-To: <1495362220-30044-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1495362220-30044-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1495362220-30044-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the module autoloadable by tying it to the CPU feature bit that
describes whether the optional instructions it relies on are implemented
by the current CPU.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/ghash-ce-glue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/crypto/ghash-ce-glue.c b/arch/arm/crypto/ghash-ce-glue.c
index 7546b3c02466..6bac8bea9f1e 100644
--- a/arch/arm/crypto/ghash-ce-glue.c
+++ b/arch/arm/crypto/ghash-ce-glue.c
@@ -15,6 +15,7 @@
 #include <crypto/cryptd.h>
 #include <crypto/internal/hash.h>
 #include <crypto/gf128mul.h>
+#include <linux/cpufeature.h>
 #include <linux/crypto.h>
 #include <linux/module.h>
 
@@ -311,9 +312,6 @@ static int __init ghash_ce_mod_init(void)
 {
 	int err;
 
-	if (!(elf_hwcap2 & HWCAP2_PMULL))
-		return -ENODEV;
-
 	err = crypto_register_shash(&ghash_alg);
 	if (err)
 		return err;
@@ -334,5 +332,5 @@ static void __exit ghash_ce_mod_exit(void)
 	crypto_unregister_shash(&ghash_alg);
 }
 
-module_init(ghash_ce_mod_init);
+module_cpu_feature_match(PMULL, ghash_ce_mod_init);
 module_exit(ghash_ce_mod_exit);
-- 
2.7.4
