From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2011 18:23:01 +0200
Subject: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent
	method to more generic alloc/free_attrs
In-Reply-To: <1308932147.5929.0.camel@mulgrave>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<201106241751.35655.arnd@arndb.de>
	<1308932147.5929.0.camel@mulgrave>
Message-ID: <201106241823.01273.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 June 2011, James Bottomley wrote:
> On Fri, 2011-06-24 at 17:51 +0200, Arnd Bergmann wrote:
> > Yes, I think that is good, but the change needs to be done atomically
> > across all architectures. This should be easy enough as I believe
> > all other architectures that use dma_map_ops don't even require
> > dma_alloc_noncoherent
> 
> This statement is definitely not true of parisc, and also, I believe,
> not true of sh, so that would have to figure in the conversion work too.

As far as I can tell, parisc uses its own hppa_dma_ops, not
dma_map_ops, and arch/sh/include/asm/dma-mapping.h contains an
unconditional

#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)

If you want to change parisc to use dma_map_ops then I would suggest
adding another attribute for alloc_noncoherent.

	Arnd
