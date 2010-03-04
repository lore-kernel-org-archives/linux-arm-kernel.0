From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Mar 2010 21:44:35 +0000
Subject: [RFC PATCH] ARM: Assume new page cache pages have dirty D-cache
In-Reply-To: <1267727802.6526.545.camel@e102109-lin.cambridge.arm.com>
References: <20100302172947.27766.61539.stgit@e102109-lin.cambridge.arm.com>
	<20100304164416.GD13417@n2100.arm.linux.org.uk>
	<1267727802.6526.545.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100304214435.GJ13417@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 04, 2010 at 06:36:42PM +0000, Catalin Marinas wrote:
> ARM: Assume new page cache pages have dirty D-cache
> 
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> There are places in Linux where writes to newly allocated page cache
> pages happen without a subsequent call to flush_dcache_page() (several
> PIO drivers including USB HCD). This patch changes the meaning of
> PG_arch_1 to be PG_dcache_clean and always flush the D-cache for a newly
> mapped page in update_mmu_cache().
> 
> The patch also sets the PG_arch_1 bit in the DMA cache maintenance
> function to avoid additional cache flushing in update_mmu_cache().

As I just realised, this is going to subject all pages placed into
userspace with a D cache flush - even anonymous pages, and those
which we've been careful to deal with the cache issues already (eg,
via the COW page copying code.)

I think all the copypage functions need to set PG_dcache_clean on the
new pages once their copy has completed.

I wonder if there's any other anonymous page creating functions which
could do with a similar treatment...
