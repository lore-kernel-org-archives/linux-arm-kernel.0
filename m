From: stefan@agner.ch (Stefan Agner)
Date: Sun,  9 Sep 2018 23:04:55 -0700
Subject: [PATCH] include/linux/compiler-clang.h: define __naked
Message-ID: <20180910060455.20409-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM32 arch code uses the __naked attribute. This has previously been
defined in include/linux/compiler-gcc.h, which is no longer included
for Clang. Define __naked for Clang. Conservatively add all attributes
previously used (and supported by Clang).

This fixes compile errors when building ARM32 using Clang:
  arch/arm/mach-exynos/mcpm-exynos.c:193:13: error: variable has incomplete type 'void'
  static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
              ^

Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 include/linux/compiler-clang.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..a593e3ac0720 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -23,6 +23,12 @@
 
 #define __no_sanitize_address __attribute__((no_sanitize("address")))
 
+/*
+ * ARM32 is currently the only user of __naked supported by Clang. Follow
+ * gcc: Do not trace naked functions and make sure they don't get inlined.
+ */
+#define __naked __attribute__((naked)) noinline notrace
+
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
-- 
2.18.0
