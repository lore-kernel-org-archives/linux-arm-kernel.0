From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 08 Feb 2010 23:40:28 -0500 (EST)
Subject: race between kmap shootdown and cache maintenance
In-Reply-To: <A0A1E7539300DF49AA383E614C7827BC048DB10984@HQMAIL01.nvidia.com>
References: <A0A1E7539300DF49AA383E614C7827BC048DB1096B@HQMAIL01.nvidia.com>
	<20100207153045.GA30457@n2100.arm.linux.org.uk>
	<A0A1E7539300DF49AA383E614C7827BC048DB10979@HQMAIL01.nvidia.com>
	<alpine.LFD.2.00.1002082229480.1681@xanadu.home>
	<A0A1E7539300DF49AA383E614C7827BC048DB10984@HQMAIL01.nvidia.com>
Message-ID: <alpine.LFD.2.00.1002082310420.1681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Feb 2010, Gary King wrote:

> The patch is not a no-op; without this patch I was seeing panics in 
> v7_flush_kern_dcache about 1 time in 3 boots, with it the crash has 
> not reproduced in hundreds of boots.

I would still like to understand why.  Without a good explanation this 
might simply be covering another bug.

> However, from re-reading the highmem code, I think my original 
> description of the cause of the crash was slightly mistaken:
> 
> Kmap zero-flushing is lazy (it happens on the subsequent call to 
> kmap), and the page_address is not set to NULL until the lazy-flush 
> happens. In this case, if page_address is called immediately following 
> a kunmap call which resulted in the pin count dropping to 1, a valid 
> address will be returned.

But that's where things seem wrong.  There should no be any caller of 
flush_dcache_page() passing a page with no "owner".

Can you try this patch and see if it actually triggers, and if so what 
the call backtrace is?

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 6f3a4b7..7afdb4b 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -125,6 +125,8 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 	 * coherent with the kernels mapping.
 	 */
 #ifdef CONFIG_HIGHMEM
+	extern int kmap_high_pinned(struct page *);
+	BUG_ON(addr && PageHighMem(page) && !kmap_high_pinned(page));
 	/*
 	 * kmap_atomic() doesn't set the page virtual address, and
 	 * kunmap_atomic() takes care of cache flushing already.
diff --git a/mm/highmem.c b/mm/highmem.c
index 9c1e627..f50d83e 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -238,6 +238,18 @@ void *kmap_high_get(struct page *page)
 	unlock_kmap_any(flags);
 	return (void*) vaddr;
 }
+
+int kmap_high_pinned(struct page *page)
+{
+	unsigned long vaddr, flags;
+	int res;
+
+	lock_kmap_any(flags);
+	vaddr = (unsigned long)page_address(page);
+	res = (vaddr && pkmap_count[PKMAP_NR(vaddr)] >= 2);
+	unlock_kmap_any(flags);
+	return res;
+}
 #endif
 
 /**

Nicolas
