From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Jun 2017 17:38:39 +0200
Subject: [PATCH] ARM: decompressor: add a memcmp() declaration
Message-ID: <20170630153908.3439707-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A reference to memcmp() was added to bitmap.h, which causes another
build warning in the decompressor due to the incompatibility with the
regular kernel string functions:

In file included from /git/arm-soc/include/linux/nodemask.h:94:0,
                 from /git/arm-soc/include/linux/mmzone.h:16,
                 from /git/arm-soc/include/linux/gfp.h:5,
                 from /git/arm-soc/include/linux/kmod.h:22,
                 from /git/arm-soc/include/linux/module.h:13,
                 from /git/arm-soc/arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
                 from /git/arm-soc/arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:13,
                 from /git/arm-soc/arch/arm/boot/compressed/decompress.c:56:
include/linux/bitmap.h: In function 'bitmap_equal':
include/linux/bitmap.h:270:11: error: implicit declaration of function 'memcmp'; did you mean 'memchr'? [-Werror=implicit-function-declaration]

This adds one more declaration along with the existing ones.
It would be nice to find a more generic solution here so we don't
have to do this again the next time, but I couldn't think of a good
way to do that.

Fixes: 2118d3a701a8 ("bitmap: Use memcmp optimisation in more situations")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The patch causing it is currently in linux-next through mmotm,
so I'd expect the fix to go through the same tree, provided
Russell is ok with it.
---
 arch/arm/boot/compressed/decompress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index ea7832702a8f..f3a4bedd1afc 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -33,6 +33,7 @@ extern void error(char *);
 /* Not needed, but used in some headers pulled in by decompressors */
 extern char * strstr(const char * s1, const char *s2);
 extern size_t strlen(const char *s);
+extern int memcmp(const void *cs, const void *ct, size_t count);
 
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
-- 
2.9.0
