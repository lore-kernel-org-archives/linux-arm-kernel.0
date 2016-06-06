From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 17:59:39 +0100
Subject: [PATCH kexec-tools v2 11/32] kexec: add mem_regions sorting
 implementation
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xsJ-0003sU-LJ@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a mem_regions sorting implementation taken from the arm code.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/mem_regions.c | 27 +++++++++++++++++++++++++++
 kexec/mem_regions.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
index a4952ff..804984a 100644
--- a/kexec/mem_regions.c
+++ b/kexec/mem_regions.c
@@ -1,6 +1,33 @@
+#include <stdlib.h>
+
 #include "kexec.h"
 #include "mem_regions.h"
 
+static int mem_range_cmp(const void *a1, const void *a2)
+{
+	const struct memory_range *r1 = a1;
+	const struct memory_range *r2 = a2;
+
+	if (r1->start > r2->start)
+		return 1;
+	if (r1->start < r2->start)
+		return -1;
+
+	return 0;
+}
+
+/**
+ * mem_regions_sort() - sort ranges into ascending address order
+ * @ranges: ranges to sort
+ *
+ * Sort the memory regions into ascending address order.
+ */
+void mem_regions_sort(struct memory_ranges *ranges)
+{
+	qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges),
+	      mem_range_cmp);
+}
+
 /**
  * mem_regions_add() - add a memory region to a set of ranges
  * @ranges: ranges to add the memory region to
diff --git a/kexec/mem_regions.h b/kexec/mem_regions.h
index b9cfba1..da7b5e8 100644
--- a/kexec/mem_regions.h
+++ b/kexec/mem_regions.h
@@ -3,6 +3,8 @@
 
 struct memory_ranges;
 
+void mem_regions_sort(struct memory_ranges *ranges);
+
 int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
                     unsigned long long length, int type);
 
-- 
1.9.1
