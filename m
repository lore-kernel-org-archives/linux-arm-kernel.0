From: liuwenliang@huawei.com (Abbott Liu)
Date: Wed, 11 Oct 2017 16:22:20 +0800
Subject: [PATCH 04/11] Define the virtual space of KASan's shadow region
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <20171011082227.20546-5-liuwenliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define KASAN_SHADOW_OFFSET,KASAN_SHADOW_START and KASAN_SHADOW_END for arm
kernel address sanitizer.

     +----+ 0xffffffff
     |    |
     |    |
     |    |
     +----+ CONFIG_PAGE_OFFSET
     |    |\
     |    | |->  module virtual address space area.
     |    |/
     +----+ MODULE_VADDR = KASAN_SHADOW_END
     |    |\
     |    | |-> the shadow area of kernel virtual address.
     |    |/
     +----+ TASK_SIZE(start of kernel space) = KASAN_SHADOW_START  the shadow address of MODULE_VADDR
     |    |\
     |    | ---------------------+
     |    |                      |
     +    + KASAN_SHADOW_OFFSET  |-> the user space area. Kernel address sanitizer do not use this space.
     |    |                      |
     |    | ---------------------+
     |    |/
     ------ 0

1)KASAN_SHADOW_OFFSET:
  This value is used to map an address to the corresponding shadow address by the
following formula:
  shadow_addr = (address >> 3) + KASAN_SHADOW_OFFSET;

2)KASAN_SHADOW_START
  This value is the MODULE_VADDR's shadow address. It is the start of kernel virtual
space.

3) KASAN_SHADOW_END
  This value is the 0x100000000's shadow address. It is the end of kernel address
sanitizer's shadow area. It is also the start of the module area.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/include/asm/kasan_def.h | 51 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/memory.h    |  5 ++++
 arch/arm/kernel/entry-armv.S     |  7 +++++-
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/kasan_def.h

diff --git a/arch/arm/include/asm/kasan_def.h b/arch/arm/include/asm/kasan_def.h
new file mode 100644
index 0000000..7746908
--- /dev/null
+++ b/arch/arm/include/asm/kasan_def.h
@@ -0,0 +1,51 @@
+#ifndef __ASM_KASAN_DEF_H
+#define __ASM_KASAN_DEF_H
+
+#ifdef CONFIG_KASAN
+
+/*
+ *    +----+ 0xffffffff
+ *    |    |
+ *    |    |
+ *    |    |
+ *    +----+ CONFIG_PAGE_OFFSET
+ *    |    |\
+ *    |    | |->  module virtual address space area.
+ *    |    |/
+ *    +----+ MODULE_VADDR = KASAN_SHADOW_END
+ *    |    |\
+ *    |    | |-> the shadow area of kernel virtual address.
+ *    |    |/
+ *    +----+ TASK_SIZE(start of kernel space) = KASAN_SHADOW_START  the shadow address of MODULE_VADDR
+ *    |    |\
+ *    |    | ---------------------+
+ *    |    |                      |
+ *    +    + KASAN_SHADOW_OFFSET  |-> the user space area. Kernel address sanitizer do not use this space.
+ *    |    |                      |
+ *    |    | ---------------------+
+ *    |    |/
+ *    ------ 0
+ *
+ *1)KASAN_SHADOW_OFFSET:
+ *    This value is used to map an address to the corresponding shadow address by the
+ * following formula:
+ * shadow_addr = (address >> 3) + KASAN_SHADOW_OFFSET;
+ *
+ * 2)KASAN_SHADOW_START
+ *     This value is the MODULE_VADDR's shadow address. It is the start of kernel virtual
+ * space.
+ *
+ * 3) KASAN_SHADOW_END
+ *   This value is the 0x100000000's shadow address. It is the end of kernel address
+ * sanitizer's shadow area. It is also the start of the module area.
+ *
+ */
+
+#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1<<29))
+
+#define KASAN_SHADOW_START      ((KASAN_SHADOW_END >> 3) + KASAN_SHADOW_OFFSET)
+
+#define KASAN_SHADOW_END        (UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
+
+#endif
+#endif
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 1f54e4e..069710d 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -21,6 +21,7 @@
 #ifdef CONFIG_NEED_MACH_MEMORY_H
 #include <mach/memory.h>
 #endif
+#include <asm/kasan_def.h>
 
 /*
  * Allow for constants defined here to be used from assembly code
@@ -37,7 +38,11 @@
  * TASK_SIZE - the maximum size of a user space task.
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
  */
+#ifndef CONFIG_KASAN
 #define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
+#else
+#define TASK_SIZE               (KASAN_SHADOW_START)
+#endif
 #define TASK_UNMAPPED_BASE	ALIGN(TASK_SIZE / 3, SZ_16M)
 
 /*
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index fbc7076..f9efea3 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -187,7 +187,12 @@ ENDPROC(__und_invalid)
 
 	get_thread_info tsk
 	ldr	r0, [tsk, #TI_ADDR_LIMIT]
-	mov	r1, #TASK_SIZE
+#ifdef CONFIG_KASAN
+	movw r1, #:lower16:TASK_SIZE
+	movt r1, #:upper16:TASK_SIZE
+#else
+	mov r1, #TASK_SIZE
+#endif
 	str	r1, [tsk, #TI_ADDR_LIMIT]
 	str	r0, [sp, #SVC_ADDR_LIMIT]
 
-- 
2.9.0
