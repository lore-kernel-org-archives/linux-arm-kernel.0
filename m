From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:27:09 -0600
Subject: [PATCH v2 06/18] drivers/fsi: Add FSI crc calculators to library
Message-ID: <1484260029-79307-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Add some helpers for the crc checks for the slave configuration table.
This works 4-bits-at-a-time, using a simple table approach.

We will need this in the FSI core code, as well as any master
implementations that need to calculate CRCs in software.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>

---

V2 - Move crc utilities out of the FSI core and move into linux/lib.
---
 include/linux/crc-fsi.h | 29 +++++++++++++++++++++++++++++
 lib/Makefile            |  1 +
 lib/crc-fsi.c           | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 include/linux/crc-fsi.h
 create mode 100644 lib/crc-fsi.c

diff --git a/include/linux/crc-fsi.h b/include/linux/crc-fsi.h
new file mode 100644
index 0000000..e96d2f0
--- /dev/null
+++ b/include/linux/crc-fsi.h
@@ -0,0 +1,29 @@
+/*
+ * FSI CRC calculator
+ *
+ * Copyright (C) IBM Corporation 2016
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *
+ * Implements the standard FSI CRC:
+ *
+ *   Width 1 - 32
+ *   Poly  0x0017 (x^4 + x^2 + x^1 + x^0)
+ */
+
+#ifndef CRC_FSI_H
+#define CRC_FSI_H
+
+#include <linux/types.h>
+
+uint8_t crc_fsi(uint8_t c, uint64_t x, int bits);
+
+#endif /* CRC_FSI_H */
diff --git a/lib/Makefile b/lib/Makefile
index 50144a3..c840628 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -230,3 +230,4 @@ obj-$(CONFIG_UBSAN) += ubsan.o
 UBSAN_SANITIZE_ubsan.o := n
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
+obj-$(CONFIG_FSI) += crc-fsi.o
diff --git a/lib/crc-fsi.c b/lib/crc-fsi.c
new file mode 100644
index 0000000..55cfe9d
--- /dev/null
+++ b/lib/crc-fsi.c
@@ -0,0 +1,39 @@
+/*
+ * FSI CRC calculator
+ *
+ * Copyright (C) IBM Corporation 2016
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/crc-fsi.h>
+
+/* crc helpers */
+static const uint8_t crc_fsi_tab[] = {
+	0x0, 0x7, 0xe, 0x9, 0xb, 0xc, 0x5, 0x2,
+	0x1, 0x6, 0xf, 0x8, 0xa, 0xd, 0x4, 0x3,
+};
+
+uint8_t crc_fsi(uint8_t c, uint64_t x, int bits)
+{
+	int i;
+
+	/* Align to 4-bits */
+	bits = (bits + 3) & ~0x3;
+
+	/* Calculate crc4 over four-bit nibbles, starting at the MSbit */
+	for (i = bits; i >= 0; i -= 4)
+		c = crc_fsi_tab[c ^ ((x >> i) & 0xf)];
+
+	return c;
+}
+EXPORT_SYMBOL_GPL(crc_fsi);
-- 
1.8.2.2
