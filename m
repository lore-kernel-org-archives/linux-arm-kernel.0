From: stefan@agner.ch (Stefan Agner)
Date: Mon, 15 Oct 2018 20:55:00 +0200
Subject: [PATCH v2] ARM: error out if compiling ARMv6 using Clang before 8.0
Message-ID: <20181015185500.679-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel passes the ArmV6K architecture to the compiler when
using the multi platform selection and enabling ARMv6. Clang
older than version 8.0 emit assembly with an non-existing CPU,
which then makes the GNU assembler fail. Warn users when
compiling ARMv6 using Clang before 8.0.

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Link: https://github.com/ClangBuiltLinux/linux/issues/55
---
 include/linux/compiler-clang.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..9df8713bef38 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -3,6 +3,10 @@
 #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
 #endif
 
+#if defined(CONFIG_ARCH_MULTI_V6) && CONFIG_CLANG_VERSION < 80000
+#error "Sorry, your compiler is too old - please upgrade it."
+#endif
+
 /* Some compiler specific definitions are overwritten here
  * for Clang compiler
  */
-- 
2.19.1
