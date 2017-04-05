From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 5 Apr 2017 14:21:20 -0500
Subject: [PATCH] misc: sram-exec: Use aligned fncpy instead of memcpy
Message-ID: <20170405192120.1009-1-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the sram-exec functionality, which allows allocation of
executable memory and provides an API to move code to it, is only
selected in configs for the ARM architecture. Based on commit
5756e9dd0de6 ("ARM: 6640/1: Thumb-2: Symbol manipulation macros for
function body copying") simply copying a C function pointer address
using memcpy without consideration of alignment and Thumb is unsafe on
ARM platforms.

The aforementioned patch introduces the fncpy macro which is a safe way
to copy executable code on ARM platforms, so let's make use of that here
rather than the unsafe plain memcpy that was previously used by
sram_exec_copy.

In the future, architectures hoping to make use of the sram-exec
functionality must define an fncpy macro just as ARM has done to
guarantee or check for safe copying to executable memory before allowing
the arch to select CONFIG_SRAM_EXEC.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/misc/sram-exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index ac522417c462..0057eabe5c03 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -19,6 +19,7 @@
 #include <linux/sram.h>
 
 #include <asm/cacheflush.h>
+#include <asm/fncpy.h>
 
 #include "sram.h"
 
@@ -93,7 +94,7 @@ int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
 	set_memory_nx((unsigned long)base, pages);
 	set_memory_rw((unsigned long)base, pages);
 
-	memcpy(dst, src, size);
+	fncpy(dst, src, size);
 
 	set_memory_ro((unsigned long)base, pages);
 	set_memory_x((unsigned long)base, pages);
-- 
2.11.0
