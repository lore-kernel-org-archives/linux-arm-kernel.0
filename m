From: toshi.kani@hpe.com (Kani, Toshi)
Date: Thu, 26 Apr 2018 17:49:58 +0000
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <20180426172327.GQ15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
Message-ID: <1524764948.2693.478.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-04-26 at 19:23 +0200, joro at 8bytes.org wrote:
> On Thu, Apr 26, 2018 at 04:21:19PM +0000, Kani, Toshi wrote:
> > All pages under the pmd had been unmapped and then lazy TLB purged with
> > INVLPG before coming to this code path.  Speculation is not allowed to
> > pages without mapping.
> 
> CPUs have not only TLBs, but also page-walk caches which cache
> intermediary results of page-table walks and which is flushed together
> with the TLB.
> 
> So the PMD entry you clear can still be in a page-walk cache and this
> needs to be flushed too before you can free the PTE page. Otherwise
> page-walks might still go to the page you just freed. That is especially
> bad when the page is already reallocated and filled with other data.

I do not understand why we need to flush processor caches here. x86
processor caches are coherent with MESI.  So, clearing an PMD entry
modifies a cache entry on the processor associated with the address,
which in turn invalidates all stale cache entries on other processors.

> > > Further this needs synchronization with other page-tables in the system
> > > when the kernel PMDs are not shared between processes. In x86-32 with
> > > PAE this causes a BUG_ON() being triggered at arch/x86/mm/fault.c:268
> > > because the page-tables are not correctly synchronized.
> > 
> > I think this is an issue with pmd mapping support on x86-32-PAE, not
> > with this patch.  I think the code needed to be updated to sync at the
> > pud level.
> 
> It is an issue with this patch, because this patch is for x86 and on x86
> every change to the kernel page-tables potentially needs to by
> synchronized to the other page-tables. And this patch doesn't implement
> it, which triggers a BUG_ON() under certain conditions.

The issue was introduced when pmd mapping support was added on x86/32,
which was made prior to this patch.

Thanks,
-Toshi
