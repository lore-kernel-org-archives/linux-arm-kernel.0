From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:48 +0200
Subject: [PATCH 16/21] staging/zsmalloc: don't use pgtable-mapping from modules
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-17-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building zsmalloc as a module does not work on ARM because it uses
an interface that is not exported:

ERROR: "flush_tlb_kernel_range" [drivers/staging/zsmalloc/zsmalloc.ko] undefined!

Since this is only used as a performance optimization and only on ARM,
we can avoid the problem simply by not using that optimization when
building zsmalloc it is a loadable module.

flush_tlb_kernel_range is often an inline function, but out of the
architectures that use an extern function, only powerpc exports
it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>
Cc: Nitin Gupta <ngupta@vflare.org>
---
 drivers/staging/zsmalloc/zsmalloc-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/zsmalloc/zsmalloc-main.c b/drivers/staging/zsmalloc/zsmalloc-main.c
index e78d262..291c1d8 100644
--- a/drivers/staging/zsmalloc/zsmalloc-main.c
+++ b/drivers/staging/zsmalloc/zsmalloc-main.c
@@ -225,7 +225,7 @@ struct zs_pool {
  * so that USE_PGTABLE_MAPPING is defined. This causes zsmalloc to use
  * page table mapping rather than copying for object mapping.
 */
-#if defined(CONFIG_ARM)
+#if defined(CONFIG_ARM) && !defined(MODULE)
 #define USE_PGTABLE_MAPPING
 #endif
 
-- 
1.8.1.2
