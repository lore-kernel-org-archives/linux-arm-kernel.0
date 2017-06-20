From: rientjes@google.com (David Rientjes)
Date: Tue, 20 Jun 2017 16:12:32 -0700 (PDT)
Subject: [PATCH] compiler, clang: Add always_inline attribute to inline
In-Reply-To: <20170620105937.GD28157@leverpostej>
References: <20170615155440.GC26471@leverpostej>
 <1497887596-8731-1-git-send-email-psodagud@codeaurora.org>
 <alpine.DEB.2.10.1706191322590.95967@chino.kir.corp.google.com>
 <47bd7df20466d5f7f557ca087b0189cf@codeaurora.org>
 <alpine.DEB.2.10.1706191439090.2360@chino.kir.corp.google.com>
 <f8ee882e9859f24dac24832bfb5ae0f1@codeaurora.org>
 <20170620105937.GD28157@leverpostej>
Message-ID: <alpine.DEB.2.10.1706201604540.146880@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jun 2017, Mark Rutland wrote:

> As with my reply to David, my preference would be that we:
> 
> 1) Align compiler-clang.h with the compiler-gcc.h inlining behaviour, so
>    that things work by default.
> 
> 2) Fix up the arm64 core code (and drivers for architected / common
>    peripherals) to use __always_inline where we always require inlining.
> 
> 3) Have arm64 select CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING, and have
>    people test-build configurations with CONFIG_OPTIMIZE_INLINING, with
>    both GCC and clang.
> 
> 4) Fix up drivers, etc, as appropriate.
> 
> 5) Once that's largely stable, and if there's a benefit, have arm64
>    select CONFIG_OPTIMIZE_INLINING by default.
> 
> That should avoid undue breakage, while enabling this ASAP.
> 

Sounds good, but I think we should simply deal with the 
__attribute__((unused)) needed for clang as part of compiler-gcc.h by 
simply adding it to the inline override there to avoid duplicated code.

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -15,11 +15,3 @@
  * with any version that can compile the kernel
  */
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
-
-/*
- * GCC does not warn about unused static inline functions for
- * -Wunused-function.  This turns out to avoid the need for complex #ifdef
- * directives.  Suppress the warning in clang as well.
- */
-#undef inline
-#define inline inline __attribute__((unused)) notrace
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 0efef9cf014f..71fe0994cf1a 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -66,18 +66,22 @@
 
 /*
  * Force always-inline if the user requests it so via the .config,
- * or if gcc is too old:
+ * or if gcc is too old.
+ * GCC does not warn about unused static inline functions for
+ * -Wunused-function.  This turns out to avoid the need for complex #ifdef
+ * directives.  Suppress the warning in clang as well by using "unused"
+ * function attribute, which is redundant but not harmful for gcc.
  */
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
     !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
-#define inline		inline		__attribute__((always_inline)) notrace
-#define __inline__	__inline__	__attribute__((always_inline)) notrace
-#define __inline	__inline	__attribute__((always_inline)) notrace
+#define inline inline		__attribute__((always_inline,unused)) notrace
+#define __inline__ __inline__	__attribute__((always_inline,unused)) notrace
+#define __inline __inline	__attribute__((always_inline,unused)) notrace
 #else
 /* A lot of inline functions can cause havoc with function tracing */
-#define inline		inline		notrace
-#define __inline__	__inline__	notrace
-#define __inline	__inline	notrace
+#define inline inline		__attribute__((unused)) notrace
+#define __inline__ __inline__	__attribute__((unused)) notrace
+#define __inline __inline	__attribute__((unused)) notrace
 #endif
 
 #define __always_inline	inline __attribute__((always_inline))
