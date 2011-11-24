From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 23 Nov 2011 19:32:58 -0500 (EST)
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <alpine.LFD.2.02.1111231402370.17904@xanadu.home>
References: <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
 <20111123120534.GO21073@opensource.wolfsonmicro.com>
 <20111123122855.GB7382@totoro>
 <20111123130134.GB12227@opensource.wolfsonmicro.com>
 <20111123133237.GC7382@totoro>
 <20111123135033.GA20272@opensource.wolfsonmicro.com>
 <20111123143322.GD7382@totoro>
 <20111123145517.GE20272@opensource.wolfsonmicro.com>
 <4ECD32CA.2030601@gmail.com>
 <20111123175446.GI30049@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111231402370.17904@xanadu.home>
Message-ID: <alpine.LFD.2.02.1111231929050.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Nov 2011, Nicolas Pitre wrote:

> On Wed, 23 Nov 2011, Mark Brown wrote:
> 
> > On Wed, Nov 23, 2011 at 11:52:10AM -0600, Rob Herring wrote:
> > > On 11/23/2011 08:55 AM, Mark Brown wrote:
> > 
> > > > My bisect turned up a second candidate - Nicholas' commit 549158d (ARM:
> > > > move iotable mappings within the vmalloc region).  I reverted that and
> > > > subsequent commits depending on it and my system now appears to boot
> > > > fine with -next (with OF turned on to get the ops for the VIC).  This
> > > > code is all a bit deep for me so I've no real idea what might be wrong.
> > 
> > > The first suspect should be overlapping static mappings in the iotable.
> > > This was allowed before and now is not. Looking at some of the 6410
> > > platforms, I don't see any though. But you didn't mention which platform
> > > you are on. There is a 1KB mapping which is a bit unusual.
> > 
> > I'm on Cragganmore 6410 which just calls a bunch of arch-generic stuff
> > (though now I look I do see a comment saying that we're relying on some
> > setup from the bootloader which I get may have been trashed...).
> 
> I'm working on a way to get sensible debug messages out.
> 
> The problem is that, as soon as we execute this loop in 
> devicemaps_init():
> 
>         for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
>                 pmd_clear(pmd_off_k(addr));
> 
> we lose all means of communication with the outside world until 
> mdesc->map_io() and the following TLB/cache flushes are done.  It is 
> most likely that you are having a problem in the middle of that.

OK, here it is.  Please try this patch:

-------- >8
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index acb2c7ec0a..51b4307591 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -939,23 +939,54 @@ void __init arm_mm_memblock_reserve(void)
 #endif
 }
 
+#ifdef CONFIG_DEBUG_LL
+
 /*
- * Set up the device mappings.  Since we clear out the page tables for all
- * mappings above VMALLOC_START, we will remove any debug device mappings.
- * This means you have to be careful how you debug this function, or any
- * called function.  This means you can't use any function or debugging
- * method which may touch any device, otherwise the kernel _will_ crash.
+ * The remainder of the page table containing debug mappings will be
+ * cleared and recreated by devicemaps_init().  To allow for debug devices
+ * to remain accessible, we create a temporary copy of the current page table
+ * here and switch to it, and switch back once the final mappings have
+ * been created.
+ */
+
+static pgd_t * __init install_temp_mm(void)
+{
+	pgd_t *temp_pgd = early_alloc(PTRS_PER_PGD * sizeof(pgd_t));
+	pgd_t *init_pgd = pgd_offset_k(0);
+	memcpy(temp_pgd + USER_PTRS_PER_PGD, init_pgd + USER_PTRS_PER_PGD,
+	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	clean_dcache_area(temp_pgd, PTRS_PER_PGD * sizeof(pgd_t));
+	cpu_switch_mm(temp_pgd, &init_mm);
+	return temp_pgd;
+}
+
+static void __init clear_temp_mm(pgd_t *temp_pgd)
+{
+	cpu_switch_mm(init_mm.pgd, &init_mm);
+	memblock_free(__pa(temp_pgd), PTRS_PER_PGD * sizeof(pgd_t));
+}
+
+#else
+#define set_temp_mm()	(NULL)
+#define clear_temp_mm()	do { } while (0)
+#endif
+
+/*
+ * Set up the device mappings.
  */
 static void __init devicemaps_init(struct machine_desc *mdesc)
 {
 	struct map_desc map;
 	unsigned long addr;
+	pgd_t *temp_pgd;
 
 	/*
 	 * Allocate the vector page early.
 	 */
 	vectors_page = early_alloc(PAGE_SIZE);
 
+	temp_pgd = install_temp_mm();
+
 	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
@@ -1012,6 +1043,8 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	if (mdesc->map_io)
 		mdesc->map_io();
 
+	clear_temp_mm(temp_pgd);
+
 	/*
 	 * Finally flush the caches and tlb to ensure that we're in a
 	 * consistent state wrt the writebuffer.  This also ensures that
-------- >8

Then, if you didn't already do so, you should enable CONFIG_DEBUG_LL 
and hack something like this into the printk code:

-------- >8
diff --git a/kernel/printk.c b/kernel/printk.c
index 1455a0d4ee..b543370cfd 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -876,6 +876,11 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	printed_len += vscnprintf(printk_buf + printed_len,
 				  sizeof(printk_buf) - printed_len, fmt, args);
 
+	{
+		extern void printascii(char *);
+		printascii(printk_buf);
+	}
+
 	p = printk_buf;
 
 	/* Read log level and handle special printk prefix */
-------- >8

That should provide you with the ability to figure out what's wrong.


Nicolas
