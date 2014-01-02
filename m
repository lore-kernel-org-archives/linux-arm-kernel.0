From: gioh.kim@lge.com (Gioh Kim)
Date: Thu, 2 Jan 2014 19:04:13 +0900
Subject: ARM: mm: Could I change module space size or place modules in vmalloc
 area?
Message-ID: <002001cf07a1$fd4bdc10$f7e39430$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi,

I run out of module space because I have several big driver modules.
I know I can strip the modules to decrease size but I need debug info now.

The default size of module is 16MB and the size is statically defined in the
header file. 
But a description for the module space size tells that it can be
configurable at most 32MB.

I have changed the module space size to 18MB and tested my platform.
It has been looking good.

I am not sure my patch is proper solution.
Anyway, could I configure the module space size?

Or could I place the modules into vmalloc area?



Signed-off-by: Gioh Kim <gioh.kim@lge.com>
---
 arch/arm/Kconfig              |    4 ++++
 arch/arm/include/asm/memory.h |   10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index c1f1a7e..cf1fb55
100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2257,6 +2257,10 @@ config ARM_CPU_SUSPEND

 endmenu

+config MODULES_AREA_SIZE
+       int
+       default 0x1000000
+
 source "net/Kconfig"

 source "drivers/Kconfig"
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 6976b03..3396758 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -32,13 +32,17 @@

 #ifdef CONFIG_MMU

+#if CONFIG_MODULES_AREA_SIZE > SZ_32M
+#error Too much space for modules
+#endif
+
 /*
  * PAGE_OFFSET - the virtual address of the start of the kernel image
  * TASK_SIZE - the maximum size of a user space task.
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
  */
-#define PAGE_OFFSET            UL(CONFIG_PAGE_OFFSET)
-#define TASK_SIZE              (UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
+#define PAGE_OFFSET    UL(CONFIG_PAGE_OFFSET)
+#define TASK_SIZE      (UL(CONFIG_PAGE_OFFSET) -
UL(CONFIG_MODULES_AREA_SIZE))
 #define TASK_UNMAPPED_BASE     ALIGN(TASK_SIZE / 3, SZ_16M)

 /*
@@ -51,7 +55,7 @@
  * and PAGE_OFFSET - it must be within 32MB of the kernel text.
  */
 #ifndef CONFIG_THUMB2_KERNEL
-#define MODULES_VADDR          (PAGE_OFFSET - SZ_16M)
+#define MODULES_VADDR          (PAGE_OFFSET - CONFIG_MODULES_AREA_SIZE)
 #else
 /* smaller range for Thumb-2 symbols relocation (2^24)*/
 #define MODULES_VADDR          (PAGE_OFFSET - SZ_8M)
--
1.7.9.5
