From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 25 Aug 2016 18:24:23 +0200
Subject: [PATCH] ARM: kprobes: Use kmalloc_array() in coverage_start()
Message-ID: <bd1310f8-39e6-87cf-f54d-6d534701d9d5@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Aug 2016 18:20:30 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/probes/kprobes/test-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index 9775de2..568819a 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -822,8 +822,9 @@ static int coverage_start_fn(const struct decode_header *h, void *args)
 
 static int coverage_start(const union decode_item *table)
 {
-	coverage.base = kmalloc(MAX_COVERAGE_ENTRIES *
-				sizeof(struct coverage_entry), GFP_KERNEL);
+	coverage.base = kmalloc_array(MAX_COVERAGE_ENTRIES,
+				      sizeof(*coverage.base),
+				      GFP_KERNEL);
 	coverage.num_entries = 0;
 	coverage.nesting = 0;
 	return table_iter(table, coverage_start_fn, &coverage);
-- 
2.9.3
