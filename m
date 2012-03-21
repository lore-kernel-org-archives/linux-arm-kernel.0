From: khlebnikov@openvz.org (Konstantin Khlebnikov)
Date: Wed, 21 Mar 2012 10:56:42 +0400
Subject: [PATCH 07/16] mm/arm: use vm_flags_t for vma flags
In-Reply-To: <20120321065140.13852.52315.stgit@zurg>
References: <20120321065140.13852.52315.stgit@zurg>
Message-ID: <20120321065642.13852.95838.stgit@zurg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cast vm_flags to unsigned int for __cpuc_flush_user_range(),
because its vm_flags argument declared as unsigned int.
Asssembler code wants to test VM_EXEC bit on vma->vm_flags,
but for big-endian we should get upper word for this.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/include/asm/cacheflush.h |    5 +++--
 arch/arm/kernel/asm-offsets.c     |    6 +++++-
 arch/arm/mm/fault.c               |    2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index d5d8d5c..5aab2c4 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -217,7 +217,7 @@ vivt_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 {
 	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm)))
 		__cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
-					vma->vm_flags);
+					(__force unsigned int)vma->vm_flags);
 }
 
 static inline void
@@ -225,7 +225,8 @@ vivt_flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 {
 	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
 		unsigned long addr = user_addr & PAGE_MASK;
-		__cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
+		__cpuc_flush_user_range(addr, addr + PAGE_SIZE,
+					(__force unsigned int)vma->vm_flags);
 	}
 }
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 1429d89..8150c7e 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -109,9 +109,13 @@ int main(void)
   BLANK();
 #endif
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
+#if defined(CONFIG_CPU_BIG_ENDIAN) && (NR_VMA_FLAGS > 32)
+  DEFINE(VMA_VM_FLAGS,		offsetof(struct vm_area_struct, vm_flags) + 4);
+#else
   DEFINE(VMA_VM_FLAGS,		offsetof(struct vm_area_struct, vm_flags));
+#endif
   BLANK();
-  DEFINE(VM_EXEC,	       	VM_EXEC);
+  DEFINE(VM_EXEC,		(__force unsigned int)VM_EXEC);
   BLANK();
   DEFINE(PAGE_SZ,	       	PAGE_SIZE);
   BLANK();
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 40c43a9..371ad65 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -209,7 +209,7 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
  */
 static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 {
-	unsigned int mask = VM_READ | VM_WRITE | VM_EXEC;
+	vm_flags_t mask = VM_READ | VM_WRITE | VM_EXEC;
 
 	if (fsr & FSR_WRITE)
 		mask = VM_WRITE;
