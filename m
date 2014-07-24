From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Jul 2014 18:03:26 +0200
Subject: [PATCH] arm64/crypto: fix makefile rule for aes-glue-%.o
Message-ID: <1406217806-15538-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas Schwab <schwab@suse.de>

This fixes the following build failure when building with CONFIG_MODVERSIONS
enabled:

  CC [M]  arch/arm64/crypto/aes-glue-ce.o
ld: cannot find arch/arm64/crypto/aes-glue-ce.o: No such file or directory
make[1]: *** [arch/arm64/crypto/aes-ce-blk.o] Error 1
make: *** [arch/arm64/crypto] Error 2

The $(obj)/aes-glue-%.o rule only creates $(obj)/.tmp_aes-glue-ce.o, it
should use if_changed_rule instead of if_changed_dep.

Signed-off-by: Andreas Schwab <schwab@suse.de>
[ardb: mention CONFIG_MODVERSIONS in commit log]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Catalin,

Could you take this for 3.17 please? It fixes a build error when building
aes-ce-blk and/or aes-neon-blk as modules with CONFIG_MODVERSIONS enabled.

Cheers,
Ard.


 arch/arm64/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 2070a56ecc46..a3f935fde975 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -35,4 +35,4 @@ AFLAGS_aes-neon.o	:= -DINTERLEAVE=4
 CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_EXTENSIONS
 
 $(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
-	$(call if_changed_dep,cc_o_c)
+	$(call if_changed_rule,cc_o_c)
-- 
1.8.3.2
