From: panto@antoniou-consulting.com (Pantelis Antoniou)
Date: Fri,  4 Jan 2013 00:32:33 +0200
Subject: [PATCH] arm: Export cache flush management symbols when !MULTI_CACHE
Message-ID: <1357252353-6200-1-git-send-email-panto@antoniou-consulting.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling a kernel without CONFIG_MULTI_CACHE enabled the
dma access functions end up not being exported. Fix it.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 arch/arm/kernel/setup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3f6cbb2..4540dad 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -931,3 +931,12 @@ const struct seq_operations cpuinfo_op = {
 	.stop	= c_stop,
 	.show	= c_show
 };
+
+/* export the cache management functions */
+#ifndef MULTI_CACHE
+
+EXPORT_SYMBOL(__glue(_CACHE,_dma_map_area));
+EXPORT_SYMBOL(__glue(_CACHE,_dma_unmap_area));
+EXPORT_SYMBOL(__glue(_CACHE,_dma_flush_range));
+
+#endif
-- 
1.7.12
