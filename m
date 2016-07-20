From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 20 Jul 2016 08:53:58 -0500
Subject: [PATCH V3 2/4] xen: Add generic implementation of binary search
In-Reply-To: <1469022840-2142-1-git-send-email-shankerd@codeaurora.org>
References: <1469022840-2142-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1469022840-2142-3-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the generic implementation of binary search algorithm
which is copied from Linux kernel v4.7-rc7. No functional changes.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Reviewed-by: Julien Grall <julien.grall@arm.com>
---
Changes since v2:
 Fixed the compilation issue due to a missing ';'.
 Fixed typo.

Changes since v1:
 Removed the header file xen/include/xen/bsearch.h.
 Defined function bsearch() prototype in the header file xen/lib.h.

 xen/common/Makefile   |  1 +
 xen/common/bsearch.c  | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 xen/include/xen/lib.h |  3 +++
 3 files changed, 55 insertions(+)
 create mode 100644 xen/common/bsearch.c

diff --git a/xen/common/Makefile b/xen/common/Makefile
index dbf00c6..f8123c2 100644
--- a/xen/common/Makefile
+++ b/xen/common/Makefile
@@ -43,6 +43,7 @@ obj-y += schedule.o
 obj-y += shutdown.o
 obj-y += softirq.o
 obj-y += sort.o
+obj-y += bsearch.o
 obj-y += smp.o
 obj-y += spinlock.o
 obj-y += stop_machine.o
diff --git a/xen/common/bsearch.c b/xen/common/bsearch.c
new file mode 100644
index 0000000..7090930
--- /dev/null
+++ b/xen/common/bsearch.c
@@ -0,0 +1,51 @@
+/*
+ * A generic implementation of binary search for the Linux kernel
+ *
+ * Copyright (C) 2008-2009 Ksplice, Inc.
+ * Author: Tim Abbott <tabbott@ksplice.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; version 2.
+ */
+
+#include <xen/lib.h>
+
+/*
+ * bsearch - binary search an array of elements
+ * @key: pointer to item being searched for
+ * @base: pointer to first element to search
+ * @num: number of elements
+ * @size: size of each element
+ * @cmp: pointer to comparison function
+ *
+ * This function does a binary search on the given array.  The
+ * contents of the array should already be in ascending sorted order
+ * under the provided comparison function.
+ *
+ * Note that the key need not have the same type as the elements in
+ * the array, e.g. key could be a string and the comparison function
+ * could compare the string with the struct's name field.  However, if
+ * the key and elements in the array are of the same type, you can use
+ * the same comparison function for both sort() and bsearch().
+ */
+void *bsearch(const void *key, const void *base, size_t num, size_t size,
+	      int (*cmp)(const void *key, const void *elt))
+{
+	size_t start = 0, end = num;
+	int result;
+
+	while (start < end) {
+		size_t mid = start + (end - start) / 2;
+
+		result = cmp(key, base + mid * size);
+		if (result < 0)
+			end = mid;
+		else if (result > 0)
+			start = mid + 1;
+		else
+			return (void *)base + mid * size;
+	}
+
+	return NULL;
+}
diff --git a/xen/include/xen/lib.h b/xen/include/xen/lib.h
index b1b0fb2..b90d582 100644
--- a/xen/include/xen/lib.h
+++ b/xen/include/xen/lib.h
@@ -153,4 +153,7 @@ void dump_execstate(struct cpu_user_regs *);
 
 void init_constructors(void);
 
+void *bsearch(const void *key, const void *base, size_t num, size_t size,
+              int (*cmp)(const void *key, const void *elt));
+
 #endif /* __LIB_H__ */
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
