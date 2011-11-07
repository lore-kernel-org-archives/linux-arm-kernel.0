From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon,  7 Nov 2011 16:16:57 +0000
Subject: [PATCH v8 15/16] ARM: LPAE: add support for ATAG_MEM64
In-Reply-To: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1320682618-1182-16-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

LPAE provides support for memory banks with physical addresses of up
to 40 bits.

This patch adds a new atag, ATAG_MEM64, so that the Kernel can be
informed about memory that exists above the 4GB boundary.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/setup.h |    8 ++++++++
 arch/arm/kernel/setup.c      |   23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 915696d..3842ce7 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -43,6 +43,13 @@ struct tag_mem32 {
 	__u32	start;	/* physical start address */
 };
 
+#define ATAG_MEM64	0x54420002
+
+struct tag_mem64 {
+	__u32	size;
+	__u64	start;	/* physical start address */
+};
+
 /* VGA text type displays */
 #define ATAG_VIDEOTEXT	0x54410003
 
@@ -148,6 +155,7 @@ struct tag {
 	union {
 		struct tag_core		core;
 		struct tag_mem32	mem;
+		struct tag_mem64	mem64;
 		struct tag_videotext	videotext;
 		struct tag_ramdisk	ramdisk;
 		struct tag_initrd	initrd;
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 7e7977a..223af71 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -638,6 +638,29 @@ static int __init parse_tag_mem32(const struct tag *tag)
 
 __tagtable(ATAG_MEM, parse_tag_mem32);
 
+static int __init parse_tag_mem64(const struct tag *tag)
+{
+	/* We only use 32-bits for the size. */
+	unsigned long size;
+	phys_addr_t start, end;
+
+	start = tag->u.mem64.start;
+	size = tag->u.mem64.size;
+	end = start + size;
+
+	/* Ensure that the memory region is in range. */
+	if (end & ~PHYS_MASK)
+		pr_warning("Ignoring out-of-range mem64 tag (%.8llx-%.8llx)\n",
+			   (unsigned long long)start,
+			   (unsigned long long)end - 1);
+	else
+		arm_add_memory(start, size);
+
+	return 0;
+}
+
+__tagtable(ATAG_MEM64, parse_tag_mem64);
+
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 struct screen_info screen_info = {
  .orig_video_lines	= 30,
