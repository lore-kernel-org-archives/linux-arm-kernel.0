From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 24 Jan 2011 10:47:36 +0200
Subject: HIGHMEM is broken when working in SMP V6 mode
In-Reply-To: <20110123170830.GG30094@n2100.arm.linux.org.uk>
References: <AANLkTikjcgRgPd7oLjf0ESxeyC2BHpaaRi8DiMz3b+JQ@mail.gmail.com>
	<20110123145639.GB30094@n2100.arm.linux.org.uk>
	<AANLkTi=HtLjnOLGVVqWvqToiXdQAm_+cDdZf51M+ABV4@mail.gmail.com>
	<20110123170830.GG30094@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim3VVYTrWZX+UJUtK73bUkmSufW_4awhgQcVeNZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >> I've port 2.6.35 to SMP system that runs in V6 mode, this system
>> >> doesn't support TLB operations broadcasting by hw, so it uses IPI
>> >> messages for that. ?when enabling DEBUG_LOCKDEP, I got the following
>> >> error message while booting the system from NFS:
>> >
>> > You've bypassed this check:
>> >
>> > ? ? ? ? ? ? ? ?if (is_smp() && tlb_ops_need_broadcast()) {
>> > ? ? ? ? ? ? ? ? ? ? ? ?/*
>> > ? ? ? ? ? ? ? ? ? ? ? ? * kmap_high needs to occasionally flush TLB entries,
>> > ? ? ? ? ? ? ? ? ? ? ? ? * however, if the TLB entries need to be broadcast
>> > ? ? ? ? ? ? ? ? ? ? ? ? * we may deadlock:
>> > ? ? ? ? ? ? ? ? ? ? ? ? * ?kmap_high(irqs off)->flush_all_zero_pkmaps->
>> > ? ? ? ? ? ? ? ? ? ? ? ? * ?flush_tlb_kernel_range->smp_call_function_many
>> > ? ? ? ? ? ? ? ? ? ? ? ? * ? (must not be called with irqs off)
>> > ? ? ? ? ? ? ? ? ? ? ? ? */
>> > ? ? ? ? ? ? ? ? ? ? ? ?reason = "without hardware TLB ops broadcasting";
>> > ? ? ? ? ? ? ? ?}
>> >
>> > so you lose. ?There's reasons why such checks are put in. ?We can not
>> > support SMP and highmem on systems which do not have TLB broadcasting.
>> > That's not because the code doesn't support it, it's because there are
>> > deadlocks which will occur.
>> thanks, I missed that
>> >
>> > The fact is that it is unsafe to send IPIs with IRQs disabled, which
>> > means you can't IPI a TLB operation and wait for it to complete with IRQs
>> > disabled.
>> as I understand it, the lock_kmap() started to disable IRQs in order
>> to support the vivt and vipt caches, but in SMP (at least in my case),
>> the caches are PIPT, so I think I can do the following:
>> 1. undef ?the ?ARCH_NEEDS_KMAP_HIGH_GET
>> 2. use page_address instead of kmap_high_get()
>> do you think it will work?
>
> Definitely not. ?We use kmap_high_get() so that we can ensure that we've
> flushed data out of the PIPT cache for highmem pages. ?highmem pages
> which are unmapped do not have a valid page_address() but may have PIPT
> cache lines associated with them.
>
> So no, I don't think it'll be safe.
ok, what about the following patch, the idea is to use only the
kmap_high_l1_vipt when doing cache maintenance.

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index feb988a..457998c 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -19,7 +19,9 @@

 extern pte_t *pkmap_page_table;

+#ifndef CONFIG_SMP
 #define ARCH_NEEDS_KMAP_HIGH_GET
+#endif

 extern void *kmap_high(struct page *page);
 extern void *kmap_high_get(struct page *page);
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9e7742f..d22366b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -459,12 +459,15 @@ static void dma_cache_maint_page(struct page
*page, unsigned long offset,
 				}
 				len = PAGE_SIZE - offset;
 			}
+#ifdef ARCH_NEEDS_KMAP_HIGH_GET
 			vaddr = kmap_high_get(page);
 			if (vaddr) {
 				vaddr += offset;
 				op(vaddr, len, dir);
 				kunmap_high(page);
-			} else if (cache_is_vipt()) {
+			} else if (cache_is_vipt())
+#endif
+			{
 				pte_t saved_pte;
 				vaddr = kmap_high_l1_vipt(page, &saved_pte);
 				op(vaddr + offset, len, dir);
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index c6844cb..7f96b2c 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -161,11 +161,15 @@ void __flush_dcache_page(struct address_space
*mapping, struct page *page)
 	if (!PageHighMem(page)) {
 		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
 	} else {
-		void *addr = kmap_high_get(page);
+		void *addr;
+#ifdef ARCH_NEEDS_KMAP_HIGH_GET
+	        addr = kmap_high_get(page);
 		if (addr) {
 			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
 			kunmap_high(page);
-		} else if (cache_is_vipt()) {
+		} else if (cache_is_vipt())
+#endif
+		{
 			pte_t saved_pte;
 			addr = kmap_high_l1_vipt(page, &saved_pte);
 			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 6ab2440..7493a79 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -57,7 +57,11 @@ void *kmap_atomic(struct page *page, enum km_type type)
 		kmap = NULL;
 	else
 #endif
+#ifdef ARCH_NEEDS_KMAP_HIGH_GET
 		kmap = kmap_high_get(page);
+#else
+	kmap = NULL;
+#endif
 	if (kmap)
 		return kmap;
