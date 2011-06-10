From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 10 Jun 2011 11:21:06 -0700
Subject: [PATCH] ARM: bug.h: fix sparse error: symbol '__bug' redeclared
Message-ID: <201106101121.07197.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbol '__bug' is declared in arch/arm/include/asm/bug.h as:

extern void __bug(const char *file, int line) __attribute__((noreturn));

But is defined in arch/arm/kernel/traps.c as:

void __attribute__((noreturn)) __bug(const char *file, int line)

The different position of the __attribute_((noreturn)) causes a sparse error.

Change the declaration to match the definition to quiet the error.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Russell King <linux@arm.linux.org.uk> 

---

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 4d88425..0e56435 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -4,7 +4,7 @@
 
 #ifdef CONFIG_BUG
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-extern void __bug(const char *file, int line) __attribute__((noreturn));
+extern void __attribute__((noreturn)) __bug(const char *file, int line);
 
 /* give file/line information */
 #define BUG()		__bug(__FILE__, __LINE__)
