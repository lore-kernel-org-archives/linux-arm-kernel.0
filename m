From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 03 Mar 2010 10:26:56 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100302211049V.fujita.tomonori@lab.ntt.co.jp>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <1267572416.2173.22.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-02 at 21:11 +0900, FUJITA Tomonori wrote:
> 
> > Sorry to be a bit late to the party (on holiday), but I/D coherency
> is
> > supposed to be taken care of using flush_cache_page in the memory
> > mapping routines.
> 
> powerpc does that? To be exact, powerpc doesn't need
> flush_cache_page() and handles I/D coherency in the pte modification
> code. powerpc uses PG_arch_1 to avoid unnecessarily handling I/D
> coherency. Seems that IA64 does the same trick with PG_arch_1.

Right. We set PG_arch_1 to avoid doing it again of a given physical
page. We assume that it's always cleared when a page is recycled by the
page cache and we also clear it in flush_dcache_page() though the need
for that later thing is dubious...

Cheers,
Ben.
