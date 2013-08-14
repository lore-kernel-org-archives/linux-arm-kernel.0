From: roy.franz@linaro.org (Roy Franz)
Date: Wed, 14 Aug 2013 16:10:00 -0700
Subject: [PATCH] arm64: Expand arm64 image header
Message-ID: <1376521800-967-1-git-send-email-roy.franz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expand the arm64 image header to allow for co-existance with
PE/COFF header required by the EFI stub.  The PE/COFF format
requires the "MZ" header to be at offset 0, and the offset
to the PE/COFF header to be at offset 0x3c.  The image
header is expanded to allow 2 instructions at the beginning
to accommodate a benign intruction at offset 0 that includes
the "MZ" header, a magic number, and the offset to the PE/COFF
header.


Signed-off-by: Roy Franz <roy.franz@linaro.org>
---
 Documentation/arm64/booting.txt |   16 +++++++++++++---
 arch/arm64/kernel/head.S        |    8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 9c4d388..5273c4d 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -68,13 +68,23 @@ Image target is available instead.
 
 Requirement: MANDATORY
 
-The decompressed kernel image contains a 32-byte header as follows:
+The decompressed kernel image contains a 64-byte header as follows:
 
-  u32 magic	= 0x14000008;	/* branch to stext, little-endian */
-  u32 res0	= 0;		/* reserved */
+  u32 code0;			/* Executable code */
+  u32 code1;			/* Executable code */
   u64 text_offset;		/* Image load offset */
+  u64 res0	= 0;		/* reserved */
   u64 res1	= 0;		/* reserved */
   u64 res2	= 0;		/* reserved */
+  u64 res3	= 0;		/* reserved */
+  u64 res4	= 0;		/* reserved */
+  u32 magic	= 0x644d5241;	/* Magic number, little endian, "ARM\x64" */
+  u32 res5 = 0;      		/* reserved */
+
+
+Header notes:
+
+- code0/code1 are responsible for branching to stext.
 
 The image must be placed at the specified offset (currently 0x80000)
 from the start of the system RAM and called there. The start of the
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 53dcae4..7090c12 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -112,6 +112,14 @@
 	.quad	TEXT_OFFSET			// Image load offset from start of RAM
 	.quad	0				// reserved
 	.quad	0				// reserved
+	.quad	0				// reserved
+	.quad	0				// reserved
+	.quad	0				// reserved
+	.byte	0x41				// Magic number, "ARM\x64"
+	.byte	0x52
+	.byte	0x4d
+	.byte	0x64
+	.word	0				// reserved
 
 ENTRY(stext)
 	mov	x21, x0				// x21=FDT
-- 
1.7.10.4
