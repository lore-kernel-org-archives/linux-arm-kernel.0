From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 May 2013 16:28:19 +0100
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130505222645.GA1433@schnuecks.de>
References: <20130418135104.GA18616@arm.com>
 <20130421220629.GA25571@schnuecks.de>
 <20130430112225.GD29766@arm.com>
 <20130430210403.GA18076@schnuecks.de>
 <20130501142206.GB17387@arm.com>
 <20130501190441.GA22227@schnuecks.de>
 <20130502095431.GA20730@arm.com>
 <20130502193835.GA29144@schnuecks.de>
 <20130503100242.GB29962@arm.com>
 <20130505222645.GA1433@schnuecks.de>
Message-ID: <20130508152819.GJ2703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 05, 2013 at 11:26:47PM +0100, Simon Baatz wrote:
> On Fri, May 03, 2013 at 11:02:42AM +0100, Catalin Marinas wrote:
> > On Thu, May 02, 2013 at 08:38:36PM +0100, Simon Baatz wrote:
> ...
> > I haven't run the tests but I can see  why it fails without
> > flush_kernel_dcache_page(). So I think this function needs to be
> > implemented for aliasing VIPT or VIVT caches.
> > 
> > > It is even needed in flush_dcache_page() as long as everybody
> > > continues to use flush_dcache_page() instead of
> > > flush_kernel_dcache_page() when appropriate...
> > > (This is probably the main reason why the problem I reported is so
> > > uncommon: Everybody seems to use flush_dcache_page() and since it
> > > flushes the kernel mapping in these cases, everything is fine.)
> > 
> > That's why for non-aliasing VIPT we could make it just a clear_bit() and
> > let the callers fix their API usage.
> 
> Do you mean the unnecessary flush for anon pages or also the D/I
> flush for user space mapped page cache pages?

flush_dcache_page() should just ignore anonymous pages. The D/I
coherency would be handled in __sync_icache_dcache() later. Do we have
cases where a page is already mapped in user space (pte valid) and the
kernel writes any code to it? I don't think we have. PowerPC have a
simplified flush_dcache_page() and they haven't seen any issues.

> For anon pages, that was the content of the patch you acked ([1])
> once.  However, Russel did not like the idea to use the
> PG_dcache_clean bit also for anon pages.

I think Russell was right, the kernel does not have any guarantees about
the PG_arch_1 bit on anonymous pages. Do we could remove the !mapping
code path in flush_dcache_page().

> I have a newer version that does the following: Do nothing for
> mapping == NULL on non-aliasing VIPT in flush_dcache_page().  

Can this mapping == NULL be generalised for aliasing caches?

> In __sync_icache_dcache() flush if mapping == NULL (always on aliasing
> VIPT, only if pte_exec() on non-aliasing VIPT).

If the page is anonymous, do we expect user code to execute from a
clear page? When the page is first allocated, clear_user_highpage should
take care of the aliases already.

-- 
Catalin
