From: geoff@infradead.org (Geoff Levand)
Date: Wed, 18 Jun 2014 16:07:54 -0700
Subject: [PATCH] arm64: Add new file asm/image.h
In-Reply-To: <1403132622.17030.35.camel@smoke>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
 <1402950432.3708.22.camel@smoke> <20140618164927.GA9612@leverpostej>
 <1403132622.17030.35.camel@smoke>
Message-ID: <1403132874.17030.38.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new file asm/image.h that exports a structure arm64_image_header and
some constants to user space that describe the arm64 image header.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 Documentation/arm64/booting.txt | 21 ++--------------
 arch/arm64/include/asm/Kbuild   |  2 ++
 arch/arm64/include/asm/image.h  | 53 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/include/asm/image.h

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 525e37c..55f246b 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -68,25 +68,8 @@ Image target is available instead.
 
 Requirement: MANDATORY
 
-The decompressed kernel image contains a 64-byte header as follows:
-
-  u32 code0;			/* Executable code */
-  u32 code1;			/* Executable code */
-  u64 text_offset;		/* Image load offset */
-  u8  byte_order;		/* 1=LSB (little endian), 2=MSB (big endian) */
-  u8[3] res1;			/* reserved */
-  u32 res2	= 0;		/* reserved */
-  u64 res3	= 0;		/* reserved */
-  u64 res4	= 0;		/* reserved */
-  u64 res5	= 0;		/* reserved */
-  u64 res6	= 0;		/* reserved */
-  u32 magic	= 0x644d5241;	/* Magic number, little endian, "ARM\x64" */
-  u32 res7 = 0;      		/* reserved */
-
-
-Header notes:
-
-- code0/code1 are responsible for branching to stext.
+The decompressed kernel image contains a 64-byte header as described in
+arch/arm64/include/asm/image.h.
 
 The image must be placed at the specified offset (currently 0x80000)
 from the start of the system RAM and called there. The start of the
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 42c7eec..f73e67a 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -55,3 +55,5 @@ generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
 generic-y += xor.h
+
+header-y += image.h
diff --git a/arch/arm64/include/asm/image.h b/arch/arm64/include/asm/image.h
new file mode 100644
index 0000000..7d56872
--- /dev/null
+++ b/arch/arm64/include/asm/image.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2014 Linaro.
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#if !defined(__ASSEMBLY__)
+
+/**
+ * struct arm64_image_header - arm64 kernel image header.
+ *
+ * @branch_code: Reserved for instructions to branch to stext.
+ * @text_offset: Image load offset.
+ * @endian: Image byte order: 1=LSB (little endian), 2=MSB (big endian).
+ * @reserved_1: Reserved.
+ * @reserved_2: Reserved.
+ * @reserved_3: Reserved.
+ * @magic: Magic number, "ARM\x64".
+ * @reserved_4: Reserved.
+ **/
+
+struct arm64_image_header {
+	uint32_t branch_code[2];
+	uint64_t text_offset;
+	uint8_t endian;
+	uint8_t reserved_1[3];
+	uint32_t reserved_2;
+	uint64_t reserved_3[4];
+	uint8_t magic[4];
+	uint32_t reserved_4;
+};
+
+enum {arm64_image_le = 1, arm64_image_be = 2};
+
+static const uint8_t arm64_image_magic[4] = {'A', 'R', 'M', 0x64};
+static const uint32_t arm64_image_magic_lsb = 0x644d5241U;
+static const uint32_t arm64_image_magic_msb = 0x41524d64U;
+
+#endif /* !defined(__ASSEMBLY__) */
+
+#endif /* __ASM_IMAGE_H */
-- 
1.9.1
