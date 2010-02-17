From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Feb 2010 20:44:04 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266439020.16346.285.camel@pasglop>
References: <20100208065519.GE1290@ucw.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
	<201002160922.47072.oliver@neukum.org>
	<1266397543.16346.264.camel@pasglop>
	<1266420475.16707.31.camel@e102109-lin.cambridge.arm.com>
	<1266439020.16346.285.camel@pasglop>
Message-ID: <20100217204404.GD30033@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 07:37:00AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2010-02-17 at 15:27 +0000, Catalin Marinas wrote:
> > We do the same on ARM. The problem with most (all) HCD drivers that do
> > PIO is that they copy the data to the transfer buffer but there is no
> > call in this driver to flush_dcache_page(). The upper mass storage or
> > filesystem layers don't call this function either, so there isn't
> > anything that would set the PG_arch1 bit. 
> 
> Actually, clear it :-)
> 
> I suppose that's one thing that needs to be fixed in the drivers.

No, because that'd probably bugger up the Sparc64 method of delaying
flush_dcache_page.

This method works as follows:

- a page cache page is allocated - this has PG_arch_1 clear.

- IO happens on it and it's placed into the page cache.  PG_arch_1 is
  still clear.

- someone calls read()/write() which accesses the page.  The generic
  file IO layers call flush_dcache_page() in response to read()/write()
  fs calls.  flush_dcache_page() spots that the page is not yet mapped
  into userspace, and sets PG_arch_1 to mark the fact that the kernel
  mapping is dirty.

- when someone maps the page, we check PG_arch_1 in update_mmu_cache.
  If PG_arch_1 is set, we flush the kernel mapping.

Clearly, if we go around having drivers clearing PG_arch_1, this is going
to break horribly.
