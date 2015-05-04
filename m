From: js07.lee@gmail.com (Jungseung Lee)
Date: Mon,  4 May 2015 19:33:48 +0900
Subject: [PATCH] arm64: mm: Fix build error with CONFIG_SPARSEMEM_VMEMMAP
 disabled
Message-ID: <1430735628-14455-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fix the below build error:

arch/arm64/mm/dump.c: In function ?ptdump_init?:
arch/arm64/mm/dump.c:331:18: error: ?VMEMMAP_START_NR? undeclared (first use in this function)
  address_markers[VMEMMAP_START_NR].start_address =
                  ^
arch/arm64/mm/dump.c:331:18: note: each undeclared identifier is reported only once for each
function it appears in
arch/arm64/mm/dump.c:333:18: error: ?VMEMMAP_END_NR? undeclared (first use in this function)
  address_markers[VMEMMAP_END_NR].start_address =
                  ^

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm64/mm/dump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 74c2567..f3d6221 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -328,10 +328,12 @@ static int ptdump_init(void)
 			for (j = 0; j < pg_level[i].num; j++)
 				pg_level[i].mask |= pg_level[i].bits[j].mask;
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 	address_markers[VMEMMAP_START_NR].start_address =
 				(unsigned long)virt_to_page(PAGE_OFFSET);
 	address_markers[VMEMMAP_END_NR].start_address =
 				(unsigned long)virt_to_page(high_memory);
+#endif
 
 	pe = debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
 				 &ptdump_fops);
-- 
1.9.1
