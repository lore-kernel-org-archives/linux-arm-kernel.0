From: geoff@infradead.org (Geoff Levand)
Date: Wed, 18 Jun 2014 16:03:42 -0700
Subject: [PATCH] arm64: Add byte order to image header
In-Reply-To: <20140618164927.GA9612@leverpostej>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
 <1402950432.3708.22.camel@smoke> <20140618164927.GA9612@leverpostej>
Message-ID: <1403132622.17030.35.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When working with a raw arm64 image one needs to know the byte order of the
image header to properly interpret the multi-byte values of the header.  Add
a character value to the image header indicating the byte order the image was
built with:

  1=LSB (little endian), 2=MSB (big endian), 0=no support.

A zero value will indicate a kernel that pre-dates this change.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi,

I noticed there was a change to the image header for COFF compatibility
that conflicted with my old patch.  Here's an update that also changes
booting.txt.

I'll also post a patch that adds a new file asm/image.h to describe
the header.

-Geoff

 Documentation/arm64/booting.txt | 10 ++++++----
 arch/arm64/kernel/head.S        |  7 ++++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index beb754e..525e37c 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -73,13 +73,15 @@ The decompressed kernel image contains a 64-byte header as follows:
   u32 code0;			/* Executable code */
   u32 code1;			/* Executable code */
   u64 text_offset;		/* Image load offset */
-  u64 res0	= 0;		/* reserved */
-  u64 res1	= 0;		/* reserved */
-  u64 res2	= 0;		/* reserved */
+  u8  byte_order;		/* 1=LSB (little endian), 2=MSB (big endian) */
+  u8[3] res1;			/* reserved */
+  u32 res2	= 0;		/* reserved */
   u64 res3	= 0;		/* reserved */
   u64 res4	= 0;		/* reserved */
+  u64 res5	= 0;		/* reserved */
+  u64 res6	= 0;		/* reserved */
   u32 magic	= 0x644d5241;	/* Magic number, little endian, "ARM\x64" */
-  u32 res5 = 0;      		/* reserved */
+  u32 res7 = 0;      		/* reserved */
 
 
 Header notes:
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b96a732..08cd054 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -111,7 +111,12 @@
 	b	stext				// branch to kernel start, magic
 	.long	0				// reserved
 	.quad	TEXT_OFFSET			// Image load offset from start of RAM
-	.quad	0				// reserved
+	CPU_LE(.byte	1)			// 1=LSB (little endian)
+	CPU_BE(.byte	2)			// 2=MSB (big endian)
+	.byte	0				// reserved
+	.byte	0				// reserved
+	.byte	0				// reserved
+	.word	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
-- 
1.9.1
