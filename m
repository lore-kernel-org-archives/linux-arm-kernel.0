From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Mar 2017 22:39:21 +0100
Subject: [PATCH] [v2] arm64: define BUG() instruction without CONFIG_BUG
Message-ID: <20170314213939.3874497-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mirrors commit e9c38ceba8d9 ("ARM: 8455/1: define __BUG as
asm(BUG_INSTR) without CONFIG_BUG") to make the behavior of
arm64 consistent with arm and x86, and avoids lots of warnings in
randconfig builds, such as:

kernel/seccomp.c: In function '__seccomp_filter':
kernel/seccomp.c:666:1: error: no return statement in function returning non-void [-Werror=return-type]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally submitted v1 on Feb 14 as a simple addition of a few lines.
v2 is a new version doing the same thing with a cleaner rewrite of
the file, using three lines less, after a suggested from Will Deacon.

No need to get this into v4.11 though, especially as the rewrite
makes it a bit risky. Please queue this for v4.12 if you like the
new version.
---
 arch/arm64/include/asm/bug.h | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index 561190d15881..bfc6021760e5 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -20,9 +20,6 @@
 
 #include <asm/brk-imm.h>
 
-#ifdef CONFIG_GENERIC_BUG
-#define HAVE_ARCH_BUG
-
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
 #define __BUGVERBOSE_LOCATION(file, line)				\
@@ -36,28 +33,37 @@
 #define _BUGVERBOSE_LOCATION(file, line)
 #endif
 
-#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)
+#ifdef CONFIG_GENERIC_BUG
 
-#define __BUG_FLAGS(flags) asm volatile (		\
+#define __BUG_ENTRY(flags) 				\
 		".pushsection __bug_table,\"a\"\n\t"	\
 		".align 2\n\t"				\
 	"0:	.long 1f - 0b\n\t"			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		".short " #flags "\n\t"			\
 		".popsection\n"				\
-							\
-	"1:	brk %[imm]"				\
-		:: [imm] "i" (BUG_BRK_IMM)		\
-)
+	"1:	"
+#else
+#define __BUG_ENTRY(flags) ""
+#endif
+
+#define __BUG_FLAGS(flags)				\
+	asm volatile (					\
+		__BUG_ENTRY(0)				\
+		"brk %[imm]" :: [imm] "i" (BUG_BRK_IMM)	\
+	);
 
-#define BUG() do {				\
-	_BUG_FLAGS(0);				\
-	unreachable();				\
+#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)
+
+#define BUG() do {					\
+	__BUG_FLAGS(0);					\
+	unreachable();					\
 } while (0)
 
-#define __WARN_TAINT(taint) _BUG_FLAGS(BUGFLAG_TAINT(taint))
+#define __WARN_TAINT(taint) 				\
+	__BUG_FLAGS(BUGFLAG_TAINT(taint))
 
-#endif /* ! CONFIG_GENERIC_BUG */
+#define HAVE_ARCH_BUG
 
 #include <asm-generic/bug.h>
 
-- 
2.9.0
