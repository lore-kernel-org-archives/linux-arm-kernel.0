From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 15:21:27 +0100
Subject: [PATCH] printk-nmi: use %zu format string for size_t
Message-ID: <3363644.unjjqdaQx2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newly added code in vprintk_nmi prints a size_t using %lu, which causes
a warning on architectures like ARM where it is defined as unsigned int:

kernel/printk/nmi.c: In function '__printk_nmi_flush':
kernel/printk/nmi.c:143:10: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]

This uses the format string that works on all architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0dcfca2060ee ("printk-nmi-generic-solution-for-safe-printk-in-nmi-v4")
---
Found on arm randconfig builds

Please fold this into the patch that caused the warning

diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 92c61e960c4a..cdee2707a1f2 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -140,7 +140,7 @@ more:
 	 * @len must only increase.
 	 */
 	if (i && i >= len)
-		pr_err("printk_nmi_flush: internal error: i=%d >= len=%lu\n",
+		pr_err("printk_nmi_flush: internal error: i=%d >= len=%zu\n",
 		       i, len);
 
 	if (!len)
