From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Oct 2016 11:52:18 +0100
Subject: [PATCH 4/5] crypto: arm/sha1-ce - enable module autoloading based on
 CPU feature bits
In-Reply-To: <1476787939-21889-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476787939-21889-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1476787939-21889-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the module autoloadable by tying it to the CPU feature bit that
describes whether the optional instructions it relies on are implemented
by the current CPU.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/sha1-ce-glue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/crypto/sha1-ce-glue.c b/arch/arm/crypto/sha1-ce-glue.c
index 80bc2fcd241a..555f72b5e659 100644
--- a/arch/arm/crypto/sha1-ce-glue.c
+++ b/arch/arm/crypto/sha1-ce-glue.c
@@ -11,6 +11,7 @@
 #include <crypto/internal/hash.h>
 #include <crypto/sha.h>
 #include <crypto/sha1_base.h>
+#include <linux/cpufeature.h>
 #include <linux/crypto.h>
 #include <linux/module.h>
 
@@ -82,8 +83,6 @@ static struct shash_alg alg = {
 
 static int __init sha1_ce_mod_init(void)
 {
-	if (!(elf_hwcap2 & HWCAP2_SHA1))
-		return -ENODEV;
 	return crypto_register_shash(&alg);
 }
 
@@ -92,5 +91,5 @@ static void __exit sha1_ce_mod_fini(void)
 	crypto_unregister_shash(&alg);
 }
 
-module_init(sha1_ce_mod_init);
+module_cpu_feature_match(SHA1, sha1_ce_mod_init);
 module_exit(sha1_ce_mod_fini);
-- 
2.7.4
