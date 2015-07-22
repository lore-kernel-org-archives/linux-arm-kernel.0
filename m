From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 22 Jul 2015 13:30:34 +0300
Subject: [PATCH v3 2/5] arm64: introduce VA_START macro - the first kernel
 virtual address.
In-Reply-To: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
References: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1437561037-31995-3-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to not use lengthy (UL(0xffffffffffffffff) << VA_BITS) everywhere,
replace it with VA_START.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm64/include/asm/memory.h  | 2 ++
 arch/arm64/include/asm/pgtable.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f800d45..288c19d 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -42,12 +42,14 @@
  * PAGE_OFFSET - the virtual address of the start of the kernel image (top
  *		 (VA_BITS - 1))
  * VA_BITS - the maximum number of bits for virtual addresses.
+ * VA_START - the first kernel virtual address.
  * TASK_SIZE - the maximum size of a user space task.
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
  * The module space lives between the addresses given by TASK_SIZE
  * and PAGE_OFFSET - it must be within 128MB of the kernel text.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
+#define VA_START		(UL(0xffffffffffffffff) << VA_BITS)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
 #define MODULES_END		(PAGE_OFFSET)
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 56283f8..a1f9f61 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -40,7 +40,7 @@
  *	fixed mappings and modules
  */
 #define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
-#define VMALLOC_START		(UL(0xffffffffffffffff) << VA_BITS)
+#define VMALLOC_START		(VA_START)
 #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
 
 #define vmemmap			((struct page *)(VMALLOC_END + SZ_64K))
-- 
2.4.5
