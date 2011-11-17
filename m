From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Nov 2011 10:22:05 +0000
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <20111116235024.GH9581@n2100.arm.linux.org.uk>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
 <20111116235024.GH9581@n2100.arm.linux.org.uk>
Message-ID: <20111117102205.GF4748@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 11:50:24PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 16, 2011 at 01:23:02PM -0800, Olof Johansson wrote:
> > Agreed. Russell, please consider picking this up -- the bug is very
> > real and it sounds like the objection is vague.
> 
> No, it isn't.  It's creating an unsafe situation.  If we're going to do
> this, we might as well give up on architecture correctness because we're
> throwing out locking correctness.
> 
> 1. We look up the VMA.
> 2. We pass the VMA to the cache operation.
> 3. The cache operation dereferences the VMA to obtain the VMA flags.

Not anymore - if you look at the patch, flush_cache_user_range() no
longer gets the vma. We just use the vma to adjust the start/end and
that's done with the mmap_sem down. I won't comment on the rest of your
reply since it's based on the assumption that we pass vma to
flush_cache_user_range().


BTW, we could even go a step further an remove the vma checks entirely,
just use access_ok() since __cpuc_coherent_user_range() can handle
unmapped ranges properly (though it may introduce some latency if some
user app passes a 3G range but we can change the fixup code to abort the
operation when it gets a fault that can't be fixed up).


diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index d5d8d5c..1252a26 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -249,7 +249,7 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  * Harvard caches are synchronised for the user space address range.
  * This is used for the ARM private sys_cacheflush system call.
  */
-#define flush_cache_user_range(vma,start,end) \
+#define flush_cache_user_range(start,end) \
 	__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
 
 /*
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 99a5727..b215e39 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -474,23 +474,12 @@ static int bad_syscall(int n, struct pt_regs *regs)
 static inline void
 do_cache_op(unsigned long start, unsigned long end, int flags)
 {
-	struct mm_struct *mm = current->active_mm;
-	struct vm_area_struct *vma;
-
 	if (end < start || flags)
 		return;
+	if (!access_ok(VERIFY_WRITE, start, end - start))
+		return;
 
-	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, start);
-	if (vma && vma->vm_start < end) {
-		if (start < vma->vm_start)
-			start = vma->vm_start;
-		if (end > vma->vm_end)
-			end = vma->vm_end;
-
-		flush_cache_user_range(vma, start, end);
-	}
-	up_read(&mm->mmap_sem);
+	flush_cache_user_range(start, end);
 }
 
 /*
@@ -816,6 +805,6 @@ void __init early_trap_init(void)
 	memcpy((void *)(vectors + KERN_RESTART_CODE - CONFIG_VECTORS_BASE),
 	       syscall_restart_code, sizeof(syscall_restart_code));
 
-	flush_icache_range(vectors, vectors + PAGE_SIZE);
+	flush_icache_range(CONFIG_VECTORS_BASE, CONFIG_VECTORS_BASE+PAGE_SIZE);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
 }

-- 
Catalin
