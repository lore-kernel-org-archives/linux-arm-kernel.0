From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Mon, 14 May 2018 12:04:01 -0500
Subject: [PATCH] edac: altera: Fix ARM64 warning
Message-ID: <1526317441-4996-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The kbuild test robot reported the following warning on altera_edac.c:

drivers//edac/altera_edac.c: In function 'ocram_free_mem':
drivers//edac/altera_edac.c:1410:42: warning: cast from pointer to integer
      of different size [-Wpointer-to-int-cast]
  gen_pool_free((struct gen_pool *)other, (u32)p, size);
                                           ^^^
After adding support for ARM64 architectures, the unsigned long parameter
is 64bits and causes a build warning with arm64-allyesconfig
Fix by casting to the correct size (unsigned long) instead of u32.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 5672f6718262..c5104ea7e1fb 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1415,7 +1415,7 @@ static void *ocram_alloc_mem(size_t size, void **other)
 
 static void ocram_free_mem(void *p, size_t size, void *other)
 {
-	gen_pool_free((struct gen_pool *)other, (u32)p, size);
+	gen_pool_free((struct gen_pool *)other, (unsigned long)p, size);
 }
 
 static const struct edac_device_prv_data ocramecc_data = {
-- 
2.7.4
