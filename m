From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Tue,  8 Oct 2013 16:02:15 +0530
Subject: [PATCH] zsmalloc: Fix "map_vm_area" undefined reference errors.
Message-ID: <1381228335-18213-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a MMU dependency to configure the ZSMALLOC in
drivers/staging/zsmalloc/Kconfig. Without this patch, build
system can lead to build failure. This was observed during
randconfig testing, in which ZSMALLOC was enabled w/o MMU being
enabled. Following was the error:

LD      vmlinux
drivers/built-in.o: In function `__zs_map_object':
drivers/staging/zsmalloc/zsmalloc-main.c:650: undefined reference to `map_vm_area'
make: *** [vmlinux] Error 1

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: devel at driverdev.osuosl.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/staging/zsmalloc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/zsmalloc/Kconfig b/drivers/staging/zsmalloc/Kconfig
index 7fab032..0ae13cd 100644
--- a/drivers/staging/zsmalloc/Kconfig
+++ b/drivers/staging/zsmalloc/Kconfig
@@ -1,5 +1,6 @@
 config ZSMALLOC
 	bool "Memory allocator for compressed pages"
+	depends on MMU
 	default n
 	help
 	  zsmalloc is a slab-based memory allocator designed to store
-- 
1.7.9.5
