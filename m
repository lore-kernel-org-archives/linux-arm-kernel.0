From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 12 Apr 2017 11:00:28 +0100
Subject: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
In-Reply-To: <1491952447.7236.24.camel@kernel.crashing.org>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
 <1491917983.7236.9.camel@kernel.crashing.org>
 <20170411143138.GC6821@red-moon>
 <1491952447.7236.24.camel@kernel.crashing.org>
Message-ID: <20170412100028.GB31143@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 09:14:07AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-11 at 15:31 +0100, Lorenzo Pieralisi wrote:
> > > This is a semantic that simply *cannot* be generically provided accross
> > > architectures as a mapping attribute.
> > 
> > I agree that a default implementation does not make much sense. The
> > only solution to this, if we want the ioremap_nopost to be made available
> > to generic code (and drivers - ie DT PCI host bridge drivers on ARM/ARM64
> > are not arch code), is to make the ioremap_nopost() call return NULL
> > unless overriden by arch code that can provide its semantics.
> 
> That would be a better option.

I think that's what I will implement which basically means I will
replace the default:

static inline void __iomem *ioremap_nopost(phys_addr_t offset, size_t size)
{
	return ioremap_nocache(offset, size);
}

with

static inline void __iomem *ioremap_nopost(phys_addr_t offset, size_t size)
{
	return NULL;
}

If an arch can override ioremap_nopost() with sensible mapping
attributes (or whatever make it enforceable) it does, if it can't
any ioremap_nopost() usage will result in a mapping failure, if you
see any other viable solution please shout.

Thanks,
Lorenzo
