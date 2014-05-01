From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  1 May 2014 17:49:33 +0200
Subject: [PATCH resend 01/15] asm-generic: allow generic unaligned access if
 the arch supports it
In-Reply-To: <1398959381-8126-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1398959381-8126-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1398959381-8126-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the default unaligned access method to 'hardware implemented'
if HAVE_EFFICIENT_UNALIGNED_ACCESS is set.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/unaligned.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 03cf5936bad6..1ac097279db1 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -4,22 +4,27 @@
 /*
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
- *
- * If an architecture can handle unaligned accesses in hardware,
- * it may want to use the linux/unaligned/access_ok.h implementation
- * instead.
  */
 #include <asm/byteorder.h>
 
+/* Set by the arch if it can handle unaligned accesses in hardware. */
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+# include <linux/unaligned/access_ok.h>
+#endif
+
 #if defined(__LITTLE_ENDIAN)
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
+# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#  include <linux/unaligned/le_struct.h>
+#  include <linux/unaligned/be_byteshift.h>
+# endif
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_le
 # define put_unaligned	__put_unaligned_le
 #elif defined(__BIG_ENDIAN)
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
+# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#  include <linux/unaligned/be_struct.h>
+#  include <linux/unaligned/le_byteshift.h>
+# endif
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_be
 # define put_unaligned	__put_unaligned_be
-- 
1.8.3.2
