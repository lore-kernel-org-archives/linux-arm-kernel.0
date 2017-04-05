From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed,  5 Apr 2017 09:56:03 -0700
Subject: [PATCH] crypto: arm64/sha: use %c constraint code in ASM_EXPORT
Message-ID: <20170405165603.87264-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Hackmann <ghackmann@google.com>

The current definition of ASM_EXPORT doesn't work properly with clang,
according to https://bugs.llvm.org//show_bug.cgi?id=27250#c3 it relies on
gcc specific behavior. Change the constraint from an intermediate to an
output expression which works with both gcc and clang.

From: Greg Hackmann <ghackmann@google.com>
Commit-message-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/crypto/sha1-ce-glue.c | 2 +-
 arch/arm64/crypto/sha2-ce-glue.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
index aefda9868627..c71e94ba0e43 100644
--- a/arch/arm64/crypto/sha1-ce-glue.c
+++ b/arch/arm64/crypto/sha1-ce-glue.c
@@ -18,7 +18,7 @@
 #include <linux/module.h>
 
 #define ASM_EXPORT(sym, val) \
-	asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
+	asm(".globl " #sym "; .set " #sym ", %c0" :: "I"(val));
 
 MODULE_DESCRIPTION("SHA1 secure hash using ARMv8 Crypto Extensions");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
index 7cd587564a41..381b5fb2dcb2 100644
--- a/arch/arm64/crypto/sha2-ce-glue.c
+++ b/arch/arm64/crypto/sha2-ce-glue.c
@@ -18,7 +18,7 @@
 #include <linux/module.h>
 
 #define ASM_EXPORT(sym, val) \
-	asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
+	asm(".globl " #sym "; .set " #sym ", %c0" :: "I"(val));
 
 MODULE_DESCRIPTION("SHA-224/SHA-256 secure hash using ARMv8 Crypto Extensions");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
-- 
2.12.2.715.g7642488e1d-goog
