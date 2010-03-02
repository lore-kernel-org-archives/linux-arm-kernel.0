From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 03 Mar 2010 10:33:54 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267552072.15401.83.camel@e102109-lin.cambridge.arm.com>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<1267552072.15401.83.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1267572834.2173.28.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-02 at 17:47 +0000, Catalin Marinas wrote:
> 
> Actually, option 2 still has an issue - does not easily work on SMP
> systems where cache maintenance operations aren't broadcast in hardware.
> In this case (ARM11MPCore), flush_dcache_page() is implemented
> non-lazily so that the flushing happens on the same processor that
> dirtied the cache. But since with some drivers there is no call to this
> function, it wouldn't make any difference.

Also, option 1 would not solve the icache issue which has the same
problem related to IPIs. You -really- need to spank some HW folks
here :-)

> A solution is to do something like read-for-ownership before flushing
> the D-cache in update_mmu_cache() (or set_pte_at()). 

You might also want to experiment with not clearing PG_arch_1 in
flush_dcache_page(). I'm not 100% convinced it is necessary and that may
reduce the amount of flushing needed.

Another thing is, on powerpc, we only do the cleaning when we try to
execute from the pages. IE. We basically "filter out" exec permission
when pages are not clean. At least on processors that support per-page
exec permission. You may want to consider something like that as well.

Cheers,
Ben.
