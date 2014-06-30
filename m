From: schwab@suse.de (Andreas Schwab)
Date: Mon, 30 Jun 2014 15:14:33 +0200
Subject: [PATCH] arm64/crypto: fix makefile rule for aes-glue-%.o
Message-ID: <mvmvbri4k06.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following build failure:

  CC [M]  arch/arm64/crypto/aes-glue-ce.o
ld: cannot find arch/arm64/crypto/aes-glue-ce.o: No such file or directory
scripts/Makefile.build:393: recipe for target 'arch/arm64/crypto/aes-ce-blk.o' failed
make[1]: *** [arch/arm64/crypto/aes-ce-blk.o] Error 1
Makefile:893: recipe for target 'arch/arm64/crypto' failed
make: *** [arch/arm64/crypto] Error 2

The $(obj)/aes-glue-%.o rule only creates $(obj)/.tmp_aes-glue-ce.o, it
should use if_changed_rule instead of if_changed_dep.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/arm64/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 2070a56..a3f935f 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -35,4 +35,4 @@ AFLAGS_aes-neon.o	:= -DINTERLEAVE=4
 CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_EXTENSIONS
 
 $(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
-	$(call if_changed_dep,cc_o_c)
+	$(call if_changed_rule,cc_o_c)
-- 
2.0.1

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
