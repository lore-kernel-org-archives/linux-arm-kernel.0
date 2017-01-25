From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jan 2017 23:24:33 +0100
Subject: [PATCH] ARM: decompressor: add strlen prototype
Message-ID: <20170125222442.1244908-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The decompress.c file contains a declaration for strstr() so we can
include some compression library code.

With the updated LZ4 implementation, we run into the same problem again
for strlen():

In file included from ../include/linux/rcupdate.h:40:0,
                 from ../include/linux/srcu.h:33,
                 from ../include/linux/notifier.h:15,
                 from ../include/linux/memory_hotplug.h:6,
                 from ../include/linux/mmzone.h:749,
                 from ../include/linux/gfp.h:5,
                 from ../include/linux/kmod.h:22,
                 from ../include/linux/module.h:13,
                 from ../arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
                 from ../arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:13,
                 from ../arch/arm/boot/compressed/decompress.c:55:
include/linux/cpumask.h: In function 'cpumask_parse':
include/linux/cpumask.h:592:53: error: implicit declaration of function 'strlen';did you mean 'strstr'? [-Werror=implicit-function-declaration]

This adds another declaration to work around the new problem.

Fixes: ce83d9ab80d6 ("lib: update LZ4 compressor module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/decompress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index a0765e7ed6c7..ea7832702a8f 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -32,6 +32,7 @@ extern void error(char *);
 
 /* Not needed, but used in some headers pulled in by decompressors */
 extern char * strstr(const char * s1, const char *s2);
+extern size_t strlen(const char *s);
 
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
-- 
2.9.0
