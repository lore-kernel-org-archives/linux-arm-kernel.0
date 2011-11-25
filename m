From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Nov 2011 10:17:46 +0000
Subject: [PATCH] ARM: Add TLB flushing for both entries in a PMD
In-Reply-To: <003401ccab4f$57882cd0$06988670$%youn@samsung.com>
References: <20111116103810.12733.23637.stgit@e102109-lin.cambridge.arm.com>
 <004d01cca9c9$aeeb0420$0cc10c60$%youn@samsung.com>
 <20111123104531.GC29609@arm.com>
 <003401ccab4f$57882cd0$06988670$%youn@samsung.com>
Message-ID: <20111125101746.GB30157@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 08:50:48AM +0000, Changhwan Youn wrote:
> On Wednesday, November 23, 2011 7:46 PM, Catalin Marinas wrote:
> > To: Changhwan Youn
> > Cc: linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH] ARM: Add TLB flushing for both entries in a PMD
> > 
> > On Wed, Nov 23, 2011 at 10:21:37AM +0000, Changhwan Youn wrote:
> > > I have tested this patch on several exynos machines which
> > > have a9 cores and it worked fine.
> > > Though I'm not sure that android boot and running simple applications
> > > are enough test for this patch.
> > 
> > Thanks for testing but the A9 would work fine without this patch. The
> > problem is on A15 where level 1 page table entries (pgd) are cached by
> > the TLB independently of level 2 entries (pte). The original code is
> > only flushing one entry in level 1 rather than 2.
> 
> Thank you for the answer.
> The one thing I don't understand is why A9 works fine without this
> patch. I know that A9 has worked fine without this patch.
> It seems that without this patch, invalid VA->PA mapping can remains in TLB
> and this can cause wrong PA access by user process.
> Can you explain why there's no wrong PA access in A9?

This patch only fixes a bug in the pte_free_tlb() function, used when
freeing the page tables and its goal is to make sure pmd level entries
to not point to an already freed pte. Unmapping user VA->PA mappings
happens at the pte level and page TLBs are flushed separately. If you
look at the original code, it only adds a TLB flush for a single address
while a pte table covers 2MB.

In theory, on A9 SMP there could also be an issue but given the timing
and memory ordering conditions that's impossible in practice. Basically,
the requirement is that clearing of the pmd entry on one CPU does not
become visible to another CPU before the corresponding pte page has been
re-used. The A9 only caches a page table walk in the TLB if there is a
complete VA->PA translation.

-- 
Catalin
