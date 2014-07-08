From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  8 Jul 2014 14:50:02 +0200
Subject: [RFC PATCH 2/3] arm64: add C struct definition for Image header
In-Reply-To: <1404823803-7317-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1404823803-7317-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1404823803-7317-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to interpret the Image header from C code, we need a
struct definition that reflects the specification for Image headers as laid
out in Documentation/arm64/booting.txt.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/image_hdr.h | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 arch/arm64/include/asm/image_hdr.h

diff --git a/arch/arm64/include/asm/image_hdr.h b/arch/arm64/include/asm/image_hdr.h
new file mode 100644
index 000000000000..16d32600fb18
--- /dev/null
+++ b/arch/arm64/include/asm/image_hdr.h
@@ -0,0 +1,53 @@
+/*
+ * image_hdr.h - C struct definition of the Image header format
+ *
+ * Copyright (C) 2014 Linaro Ltd  <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_IMAGE_HDR_H
+#define __ASM_IMAGE_HDR_H
+
+#include <linux/bug.h>
+#include <linux/byteorder/generic.h>
+#include <linux/types.h>
+
+/*
+ * As defined in Documentation/arm64/booting.txt
+ */
+#define IMAGE_HDR_SIZE		64
+
+struct image_hdr {
+	u32	code0;		/* Executable code */
+	u32	code1;		/* Executable code */
+	__le64	text_offset;	/* Image load offset */
+	u64	res0;		/* Reserved, must be 0 */
+	u64	res1;		/* Reserved, must be 0 */
+	u64	res2;		/* Reserved, must be 0 */
+	u64	res3;		/* Reserved, must be 0 */
+	u64	res4;		/* Reserved, must be 0 */
+	__le32	magic;		/* Magic number, little endian, "ARM\x64" */
+	__le32	pehdr_offset;	/* PE header offset, only used by EFI */
+};
+
+/*
+ * bool image_hdr_check() - checks the Image header for inconsistencies.
+ */
+static inline bool image_hdr_check(struct image_hdr const *hdr)
+{
+	BUILD_BUG_ON(sizeof(struct image_hdr) != IMAGE_HDR_SIZE);
+
+	if (hdr->res0 | hdr->res1 | hdr->res2 | hdr->res3 | hdr->res4)
+		return false;
+	return hdr->magic == cpu_to_le32(0x644d5241);
+}
+
+static inline u64 image_hdr_text_offset(struct image_hdr const *hdr)
+{
+	return le64_to_cpu(hdr->text_offset);
+}
+
+#endif
-- 
1.8.3.2
