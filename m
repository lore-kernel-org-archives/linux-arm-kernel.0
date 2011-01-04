From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 04 Jan 2011 20:22:57 +0000
Subject: [RFC 3/5] ARM: P2V: make head.S use PLAT_PHYS_OFFSET
In-Reply-To: <20110104202052.GE24935@n2100.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
Message-ID: <E1PaDPF-00023h-V5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

head.S makes use of PHYS_OFFSET.  When it becomes a variable, the
assembler won't understand this.  Switch it to use PLAT_PHYS_OFFSET
for the time being, until this code is properly updated.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/head.S |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f17d9a0..aedd80e 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -26,12 +26,12 @@
 #include <mach/debug-macro.S>
 #endif
 
-#if (PHYS_OFFSET & 0x001fffff)
-#error "PHYS_OFFSET must be at an even 2MiB boundary!"
+#if (PLAT_PHYS_OFFSET & 0x001fffff)
+#error "PLAT_PHYS_OFFSET must be at an even 2MiB boundary!"
 #endif
 
 #define KERNEL_RAM_VADDR	(PAGE_OFFSET + TEXT_OFFSET)
-#define KERNEL_RAM_PADDR	(PHYS_OFFSET + TEXT_OFFSET)
+#define KERNEL_RAM_PADDR	(PLAT_PHYS_OFFSET + TEXT_OFFSET)
 
 
 /*
@@ -208,9 +208,9 @@ __create_page_tables:
 	 * Then map first 1MB of ram in case it contains our boot params.
 	 */
 	add	r0, r4, #PAGE_OFFSET >> 18
-	orr	r6, r7, #(PHYS_OFFSET & 0xff000000)
-	.if	(PHYS_OFFSET & 0x00f00000)
-	orr	r6, r6, #(PHYS_OFFSET & 0x00f00000)
+	orr	r6, r7, #(PLAT_PHYS_OFFSET & 0xff000000)
+	.if	(PLAT_PHYS_OFFSET & 0x00f00000)
+	orr	r6, r6, #(PLAT_PHYS_OFFSET & 0x00f00000)
 	.endif
 	str	r6, [r0]
 
-- 
1.6.2.5
