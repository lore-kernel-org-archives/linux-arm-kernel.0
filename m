From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jan 2013 18:17:19 +0000
Subject: [PATCH 1/2] ARM: memory: use SZ_ constants for defining the virtual
 memory layout
Message-ID: <1359656239-18171-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parts of the virtual memory layout (mainly the modules area) are
described using open-coded immediate values.

Use the SZ_ definitions from linux/sizes.h instead to make the code
clearer.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>

KernelVersion: 3.8-rc5
---
 arch/arm/include/asm/memory.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 73cf03a..924320f 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -36,23 +36,23 @@
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
  */
 #define PAGE_OFFSET		UL(CONFIG_PAGE_OFFSET)
-#define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(0x01000000))
+#define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
 #define TASK_UNMAPPED_BASE	(UL(CONFIG_PAGE_OFFSET) / 3)
 
 /*
  * The maximum size of a 26-bit user space task.
  */
-#define TASK_SIZE_26		UL(0x04000000)
+#define TASK_SIZE_26		(UL(1) << 26)
 
 /*
  * The module space lives between the addresses given by TASK_SIZE
  * and PAGE_OFFSET - it must be within 32MB of the kernel text.
  */
 #ifndef CONFIG_THUMB2_KERNEL
-#define MODULES_VADDR		(PAGE_OFFSET - 16*1024*1024)
+#define MODULES_VADDR		(PAGE_OFFSET - SZ_16M)
 #else
 /* smaller range for Thumb-2 symbols relocation (2^24)*/
-#define MODULES_VADDR		(PAGE_OFFSET - 8*1024*1024)
+#define MODULES_VADDR		(PAGE_OFFSET - SZ_8M)
 #endif
 
 #if TASK_SIZE > MODULES_VADDR
-- 
1.8.0
