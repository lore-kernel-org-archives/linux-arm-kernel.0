From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:39 -0500
Subject: [PATCH v8 04/24] lib: Add crc4 module
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-5-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Add a little helper for crc4 calculations. This works 4-bits-at-a-time,
using a simple table approach.

We will need this in the FSI core code, as well as any master
implementations that need to calculate CRCs in software.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/linux/crc4.h |  8 ++++++++
 lib/Kconfig          |  8 ++++++++
 lib/Makefile         |  1 +
 lib/crc4.c           | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100644 include/linux/crc4.h
 create mode 100644 lib/crc4.c

diff --git a/include/linux/crc4.h b/include/linux/crc4.h
new file mode 100644
index 0000000..8f739f1
--- /dev/null
+++ b/include/linux/crc4.h
@@ -0,0 +1,8 @@
+#ifndef _LINUX_CRC4_H
+#define _LINUX_CRC4_H
+
+#include <linux/types.h>
+
+extern uint8_t crc4(uint8_t c, uint64_t x, int bits);
+
+#endif /* _LINUX_CRC4_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 0c8b78a..d2fd262 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -158,6 +158,14 @@ config CRC32_BIT
 
 endchoice
 
+config CRC4
+	tristate "CRC4 functions"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require CRC4 functions, but a module built outside
+	  the kernel tree does. Such modules that use library CRC4
+	  functions require M here.
+
 config CRC7
 	tristate "CRC7 functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 0166fbc..90cf124 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_CRC_T10DIF)+= crc-t10dif.o
 obj-$(CONFIG_CRC_ITU_T)	+= crc-itu-t.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_CRC32_SELFTEST)	+= crc32test.o
+obj-$(CONFIG_CRC4)	+= crc4.o
 obj-$(CONFIG_CRC7)	+= crc7.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 obj-$(CONFIG_CRC8)	+= crc8.o
diff --git a/lib/crc4.c b/lib/crc4.c
new file mode 100644
index 0000000..cf6db46
--- /dev/null
+++ b/lib/crc4.c
@@ -0,0 +1,46 @@
+/*
+ * crc4.c - simple crc-4 calculations.
+ *
+ * This source code is licensed under the GNU General Public License, Version
+ * 2. See the file COPYING for more details.
+ */
+
+#include <linux/crc4.h>
+#include <linux/module.h>
+
+static const uint8_t crc4_tab[] = {
+	0x0, 0x7, 0xe, 0x9, 0xb, 0xc, 0x5, 0x2,
+	0x1, 0x6, 0xf, 0x8, 0xa, 0xd, 0x4, 0x3,
+};
+
+/**
+ * crc4 - calculate the 4-bit crc of a value.
+ * @crc:  starting crc4
+ * @x:    value to checksum
+ * @bits: number of bits in @x to checksum
+ *
+ * Returns the crc4 value of @x, using polynomial 0b10111.
+ *
+ * The @x value is treated as left-aligned, and bits above @bits are ignored
+ * in the crc calculations.
+ */
+uint8_t crc4(uint8_t c, uint64_t x, int bits)
+{
+	int i;
+
+	/* mask off anything above the top bit */
+	x &= (1ull << bits) - 1;
+
+	/* Align to 4-bits */
+	bits = (bits + 3) & ~0x3;
+
+	/* Calculate crc4 over four-bit nibbles, starting@the MSbit */
+	for (i = bits - 4; i >= 0; i -= 4)
+		c = crc4_tab[c ^ ((x >> i) & 0xf)];
+
+	return c;
+}
+EXPORT_SYMBOL_GPL(crc4);
+
+MODULE_DESCRIPTION("CRC4 calculations");
+MODULE_LICENSE("GPL");
-- 
1.8.2.2
