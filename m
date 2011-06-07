From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 07 Jun 2011 10:44:15 +0200
Subject: [PATCH] ARM: fix ioremap to allow mapping some specific RAM areas
In-Reply-To: <20110607080541.GA20929@n2100.arm.linux.org.uk>
References: <1307430745-17329-1-git-send-email-m.szyprowski@samsung.com>
	<20110607080541.GA20929@n2100.arm.linux.org.uk>
Message-ID: <003c01cc24ef$151827b0$3f487710$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, June 07, 2011 10:06 AM Russell King - ARM Linux wrote:

> On Tue, Jun 07, 2011 at 09:12:25AM +0200, Marek Szyprowski wrote:
> > Creating more than one mapping on ARMv6+ might cause unspecified behavior,
> > so ioremap() should fail if it was called with area that matches low
> memory.
> > However if the board code removes the specific area from low memory
> > mapping on boot (for example by calling memblock_remove()), then creating
> > a mapping with ioremap might be desired.
> >
> > This patch enables creating mapping for RAM by ioremap call, but only if
> > the target area has no low memory mapping yet. This enables board code to
> > reserve particular memory areas with memblock_remove() and provide them
> to
> > device drivers with a declare_coherent_memory() call.
> 
> NAK.  pfn_valid is already defined like this:
> 
> int pfn_valid(unsigned long pfn)
> {
>         return memblock_is_memory(pfn << PAGE_SHIFT);
> }
> 
> provided you enable ARCH_HAS_HOLES_MEMORYMODEL, which you must do if
> you're punching holes in the memory map.

Ok, I see the point in ARCH_HAS_HOLES_MEMORYMODEL, but it doesn't solve my
problem. In case of Samsung Exynos4 and S5PV210 platforms we use SPARSEMEM,
but the above definition of pfn_valid() function is correct only if SPARSEMEM
is not enabled.

How do you suggest to solve this issue in case of SPARSEMEM platforms?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
