From: stefan@agner.ch (Stefan Agner)
Date: Sun, 22 Mar 2015 00:45:35 +0100
Subject: [PATCH] ARM: cygnus: fix const declaration bcm_cygnus_dt_compat
Message-ID: <1426981535-1800-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The const declaration for char* is actually duplicated, however
the array of strings is currently not constant. However, typically
the dt_compat array is declared as const char *const. Follow
that convention and also add the __initconst macro for constant
initialization data.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This was uncovered by a LLVM/clang warning:
arch/arm/mach-bcm/bcm_cygnus.c:16:19: warning: duplicate 'const' declaration
specifier [-Wduplicate-decl-specifier]
static const char const *bcm_cygnus_dt_compat[] = {
                  ^~~~~~
1 warning generated.

 arch/arm/mach-bcm/bcm_cygnus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/bcm_cygnus.c b/arch/arm/mach-bcm/bcm_cygnus.c
index 30dc58b..7ae894c 100644
--- a/arch/arm/mach-bcm/bcm_cygnus.c
+++ b/arch/arm/mach-bcm/bcm_cygnus.c
@@ -13,7 +13,7 @@
 
 #include <asm/mach/arch.h>
 
-static const char const *bcm_cygnus_dt_compat[] = {
+static const char * const bcm_cygnus_dt_compat[] __initconst = {
 	"brcm,cygnus",
 	NULL,
 };
-- 
2.3.3
