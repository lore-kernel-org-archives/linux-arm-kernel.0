From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 10:52:07 +0000
Subject: build error on 3.14-rc4 with SPLIT_PTLOCK_CPUS <= NR_CPUS and !MMU
In-Reply-To: <20140226101204.GD6865@pengutronix.de>
References: <20140226101204.GD6865@pengutronix.de>
Message-ID: <20140226105207.GV21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 11:12:04AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> with the attached config building on v3.14-rc4 fails with 
> 
> In file included from arch/arm/kernel/asm-offsets.c:14:0:
> include/linux/mm.h: In function 'pte_lockptr':
> include/linux/mm.h:1392:2: error: implicit declaration of function 'pmd_page' [-Werror=implicit-function-declaration]
> include/linux/mm.h:1392:2: warning: passing argument 1 of 'ptlock_ptr' makes pointer from integer without a cast [enabled by default]
> include/linux/mm.h:1384:27: note: expected 'struct page *' but argument is of type 'int'
> 
> I don't know how to fix that.

This looks like it was caused by:

commit 49076ec2ccaf68610aa03d96bced9a6694b93ca1
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Thu Nov 14 14:31:51 2013 -0800

    mm: dynamically allocate page->ptl if it cannot be embedded to struct page

    If split page table lock is in use, we embed the lock into struct page
    of table's page.  We have to disable split lock, if spinlock_t is too
    big be to be embedded, like when DEBUG_SPINLOCK or DEBUG_LOCK_ALLOC
    enabled.

    This patch add support for dynamic allocation of split page table lock
    if we can't embed it to struct page.

    page->ptl is unsigned long now and we use it as spinlock_t if
    sizeof(spinlock_t) <= sizeof(long), otherwise it's pointer to spinlock_t.

    The spinlock_t allocated in pgtable_page_ctor() for PTE table and in
    pgtable_pmd_page_ctor() for PMD table.  All other helpers converted to
    support dynamically allocated page->ptl.

    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Reviewed-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

which decided to turn macros into inline functions but without /first/
making sure that the requirements of those inline functions are
included - that being asm/pgtable.h.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
