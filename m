From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 10 Aug 2012 16:14:05 +0100
Subject: Why the region area don't decrease 1 in function
 sanity_check_meminfo?
In-Reply-To: <CAKvkGKeqzAiqRAj+H+E-eoN9SOOMP-aMhUJYmUb0UK4ei=jouA@mail.gmail.com>
References: <CAKvkGKeqzAiqRAj+H+E-eoN9SOOMP-aMhUJYmUb0UK4ei=jouA@mail.gmail.com>
Message-ID: <5025253D.3010007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/12 11:54, ??? wrote:

> I don't known why the memory region have not decrease 1, i think it
> should be decreased(like this , (__va(bank->start + bank->size
> -1))because in sparse memory system,  this address bank->start +
> bank->size is belong to another bank, so this method is not correctly.

I think you're right - we should have the '- 1' in there, although I 
don't think there currently exist any situations where this will cause
us grief. Here's a patch for correctness anyway...

> Please indicate whether my understanding is correct.
 

As far as I can see in all existing situations, the worst effect of this
will be truncating by a single byte a bank that doesn't actually need
truncating.

As you said in your following email, we would get trouble with this if
using SPARSEMEM in a situation where the physical to virtual address
conversion is not monotonic increasing.

Jonny

---8<---
From: Jonathan Austin <jonathan.austin@arm.com>
Date: Thu, 9 Aug 2012 15:59:16 +0100
Subject: [PATCH] arm: mm: Fix vmalloc overlap check for !HIGHMEM

With !HIGHMEM, sanity_check_meminfo checks for banks that completely or
partially overlap the vmalloc region. The check for partial overlap checks
__va(bank->start + bank->size) > vmalloc_min, but the last address of the
bank is (bank->start + bank->size -1).

This doesn't cause serious issues for existing platforms, except to
truncate by a single byte a bank that doesn't actually need truncating if
it happens to finish at vmalloc_min -1.

However, theoretically, if using using SPARSEMEM in a situation where the
physical to virtual address conversion is not monotonic increasing, the
incorrect test could result in a bank not being truncated when it should be.

Reported-by: ??? (Steve) <zhanzhenbo@gmail.com>
Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
---
 arch/arm/mm/mmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4c2d045..29f7084 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -961,8 +961,8 @@ void __init sanity_check_meminfo(void)
                 * Check whether this memory bank would partially overlap
                 * the vmalloc area.
                 */
-               if (__va(bank->start + bank->size) > vmalloc_min ||
-                   __va(bank->start + bank->size) < __va(bank->start)) {
+               if (__va(bank->start + bank->size - 1) > vmalloc_min ||
+                   __va(bank->start + bank->size - 1) < __va(bank->start)) {
                        unsigned long newsize = vmalloc_min - __va(bank->start);
                        printk(KERN_NOTICE "Truncating RAM at %.8llx-%.8llx "
                               "to -%.8llx (vmalloc region overlap).\n",
