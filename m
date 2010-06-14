From: bahadir@l4dev.org (Bahadir Balban)
Date: Tue, 15 Jun 2010 00:52:02 +0300
Subject: map_vm_area() correct dcache cleaning on ARMv7?
In-Reply-To: <20100614193003.GA17539@n2100.arm.linux.org.uk>
References: <4C167C5B.9070605@l4dev.org>
	<20100614193003.GA17539@n2100.arm.linux.org.uk>
Message-ID: <4C16A482.4020106@l4dev.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Jun 14, 2010 at 10:00:43PM +0300, Bahadir Balban wrote:
>> 2. clean_dcache_area(): clean data cache for pages allocated in (1)
>> conditionally if tlb cannot fetch from 1st level dcache.
> 
> This is absolutely correct.  We allocate a new page.  This new page can
> contain any random garbage, from old PTE entries to invalid PTE entries.
> It could even be code.  We do not want the MMU to read that old data.
> 
> So, we zero the page, and then call clean_dcache_area() to ensure that
> the MMU will see an _initialized_ kernel, not the crappy data that was
> in the page before.
> 

You are correct. The zero-initialized page must be seen by MMU.

>> 4. flush_pmd_entry(): Clean the dcache for 1st to 2nd
>> level pointer set in (3), conditionally if TLB needs it.
> 
> This pushes the cache line for the L1 table out to memory so that the
> MMU can see it.  Without this, the MMU could still see 'zero', in
> which case the MMU will fault on the first access to any page covered
> by this L2 page table.
> 
>> 5. set_pte_ext(): Set each 2nd level entry to pages.
>>
>> 6. set_pte_ext(): Unconditionally clean the dcache for 2nd level to
>> page pointer set up in (5).
> 
> Again, this is to ensure that the MMU can see the data written to the
> page tables.
> 

In ARMv7 you might not need to clean the dcache if TLB supports L1
fetches. My point is it seems to be an unconditional clean here. (2) and
(4) in my example does check for this. How about a patch like this one:

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..6eef696 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -163,8 +163,10 @@ ENTRY(cpu_v7_set_pte_ext)
        moveq   r3, #0

        str     r3, [r0]
+#ifndef TLB_CAN_READ_FROM_L1_CACHE
        mcr     p15, 0, r0, c7, c10, 1          @ flush_pte
 #endif
+#endif
        mov     pc, lr
 ENDPROC(cpu_v7_set_pte_ext)
