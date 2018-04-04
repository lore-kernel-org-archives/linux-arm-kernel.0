From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Apr 2018 14:30:50 +0200
Subject: [PATCH] arm: decompressor: mark error() as __noreturn
Message-ID: <20180404123117.3575773-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc complains about fortify_panic() possibly returning:

arch/arm/boot/compressed/misc.c: In function 'fortify_panic':
arch/arm/boot/compressed/misc.c:167:1: error: 'noreturn' function does return [-Werror]

This annotates the error() function as __noreturn, which lets gcc
see in all configurations that it fortify_panic() cannot return either.

Fixes: ee333554fed5 ("ARM: 8749/1: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 009db7d275f8..313a587d656b 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -24,7 +24,7 @@ unsigned int __machine_arch_type;
 #include <linux/linkage.h>
 
 static void putstr(const char *ptr);
-extern void error(char *x);
+extern void error(char *x) __noreturn;
 
 #include CONFIG_UNCOMPRESS_INCLUDE
 
-- 
2.9.0
