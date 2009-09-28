From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 28 Sep 2009 17:54:25 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928095945.GC6715@n2100.arm.linux.org.uk>
References: <20090928092919.GA30271@localhost>
	<20090928094140.GA6715@n2100.arm.linux.org.uk>
	<20090928095429.GB30271@localhost>
	<20090928095945.GC6715@n2100.arm.linux.org.uk>
Message-ID: <1254156865.21619.41.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-28 at 10:59 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 28, 2009 at 12:54:29PM +0300, Imre Deak wrote:
> > On Mon, Sep 28, 2009 at 11:41:40AM +0200, ext Russell King - ARM Linux wrote:
> > > On Mon, Sep 28, 2009 at 12:29:19PM +0300, Imre Deak wrote:
> > > > Hi,
> > > > 
> > > > the following test app will cause an unhandled kernel paging request
> > > > on VIPT platforms. The triggering condition is the mmap_sem held by
> > > > thread_func while the main thread performs cache flushing.
> > > > 
> > > > Since the likelihood of this to trigger is relatively low, a patch will
> > > > follow that makes similar bugs more visible.
> > > 
> > > The problem is that, unlike previous cache architectures, if a page is
> > > not present we now get a data abort during cache maintainence.  That
> > > means the cache maintainence instructions used for this call need to
> > > be marked with user fixups, so that the kernel knows how to handle
> > > such an abort.
> > > 
> > > It is not caused by the holding of mmap_sem.
> > 
> > This particular bug is caused by holding of mmap_sem, without any fixup
> > being defined.
> 
> No it is not.  The problem has nothing to do with holding of mmap_sem
> AT ALL.  In fact, do_cache_op needs to hold mmap_sem itself, to prevent
> the VMA going away beneath it.  That's not going to stop it generating
> faults, and it's not going to stop it oopsing.
> 
> The problem is that we don't have any fixup in place for this situation.

Something like this should solve the problem (not fully tested but
implemented as part of the mprotect workaround for the COW issue):


Handle possible translation errors in the ARMv6 and ARMv7 coherent user

Handle possible translation errors in the ARMv6 and ARMv7 coherent user
range functions. This is needed because applications using the
sys_cacheflush system call can pass a memory range which isn't mapped
yet even though the corresponding vma is valid.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 8364f6c..7baa6ce 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 #include "proc-macros.S"
 
@@ -129,11 +130,13 @@ ENTRY(v6_coherent_kern_range)
  *	- the Icache does not read data from the write buffer
  */
 ENTRY(v6_coherent_user_range)
-
+ UNWIND(.fnstart		)
 #ifdef HARVARD_CACHE
 	bic	r0, r0, #CACHE_LINE_SIZE - 1
-1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D line
+1:
+ USER(	mcr	p15, 0, r0, c7, c10, 1	)	@ clean D line
 	add	r0, r0, #CACHE_LINE_SIZE
+2:
 	cmp	r0, r1
 	blo	1b
 #endif
@@ -151,6 +154,19 @@ ENTRY(v6_coherent_user_range)
 	mov	pc, lr
 
 /*
+ * Fault handling for the cache operation above. If the virtual address in r0
+ * isn't mapped, just try the next page.
+ */
+9001:
+	mov	r0, r0, lsr #12
+	mov	r0, r0, lsl #12
+	add	r0, r0, #4096
+	b	2b
+ UNWIND(.fnend		)
+ENDPROC(v6_coherent_user_range)
+ENDPROC(v6_coherent_kern_range)
+
+/*
  *	v6_flush_kern_dcache_page(kaddr)
  *
  *	Ensure that the data held in the page kaddr is written back
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 29e6904..4b733d1 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 #include "proc-macros.S"
 
@@ -153,13 +154,16 @@ ENTRY(v7_coherent_kern_range)
  *	- the Icache does not read data from the write buffer
  */
 ENTRY(v7_coherent_user_range)
+ UNWIND(.fnstart		)
 	dcache_line_size r2, r3
 	sub	r3, r2, #1
 	bic	r0, r0, r3
-1:	mcr	p15, 0, r0, c7, c11, 1		@ clean D line to the point of unification
+1:
+ USER(	mcr	p15, 0, r0, c7, c11, 1	)	@ clean D line to the point of unification
 	dsb
-	mcr	p15, 0, r0, c7, c5, 1		@ invalidate I line
+ USER(	mcr	p15, 0, r0, c7, c5, 1	)	@ invalidate I line
 	add	r0, r0, r2
+2:
 	cmp	r0, r1
 	blo	1b
 	mov	r0, #0
@@ -167,6 +171,17 @@ ENTRY(v7_coherent_user_range)
 	dsb
 	isb
 	mov	pc, lr
+
+/*
+ * Fault handling for the cache operation above. If the virtual address in r0
+ * isn't mapped, just try the next page.
+ */
+9001:
+	mov	r0, r0, lsr #12
+	mov	r0, r0, lsl #12
+	add	r0, r0, #4096
+	b	2b
+ UNWIND(.fnend		)
 ENDPROC(v7_coherent_kern_range)
 ENDPROC(v7_coherent_user_range)
 

-- 
Catalin
