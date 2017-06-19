From: psodagud@codeaurora.org (Prasad Sodagudi)
Date: Mon, 19 Jun 2017 08:53:16 -0700
Subject: [PATCH] compiler, clang: Add always_inline attribute to inline
In-Reply-To: <20170615155440.GC26471@leverpostej>
References: <20170615155440.GC26471@leverpostej>
Message-ID: <1497887596-8731-1-git-send-email-psodagud@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit abb2ea7dfd82 ("compiler, clang: suppress warning for unused
static inline functions") re-defining the 'inline' macro but
__attribute__((always_inline)) is missing. Some compilers may
not honor inline hint if always_iniline attribute not there.
So add always_inline attribute to inline as done by
compiler-gcc.h file.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 include/linux/compiler-clang.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index d614c5e..deb65b3 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -22,4 +22,9 @@
  * directives.  Suppress the warning in clang as well.
  */
 #undef inline
+#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
+    !defined(CONFIG_OPTIMIZE_INLINING)
+#define inline inline __attribute__((always_inline)) __attribute__((unused)) notrace
+#else
 #define inline inline __attribute__((unused)) notrace
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
