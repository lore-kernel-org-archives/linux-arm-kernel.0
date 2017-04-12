From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 13 Apr 2017 08:30:40 +1000
Subject: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
In-Reply-To: <20170412144109.GB6842@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
 <20170412144109.GB6842@red-moon>
Message-ID: <1492036240.7236.80.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-04-12 at 15:41 +0100, Lorenzo Pieralisi wrote:
> > > At least we make the failure explicit, and the driver can take
> > > alternate (possibly sub-optimal) action if it chooses to do so.
> > 
> > The same points apply to things like pgprot_writecombine(),
> > pgprot_noncached(), pgprot_device().? Then there's also pgprot_nonposted()
> > that this series also introduces.

No. pgprot_writecombine() silently falling back to simply non-cached is
ok as we aren't "weakening" the ordering rules silently here. Something
that is correct with writecombine will also work without. It's just an
optimisation. Not correctness.

Things like noncached() must of course be honored, and I don't think
we have a case anywhere where it isn't.

My point with nopost() is that it's never ok to silently downgrade it.
Code written with the assumption that there is no posting will be
*incorrect* if posting happens. We do live with that "bug" today indeed
but once we have that accessors we might start growing more code that
relies on the specific attribute that things aren't posted and will be
wrong on all the archs providing the default implementation.

This is why I insist that pgprot_nopost() if it exists globally, should
return NULL when the semantic cannot be provided. That way there is a
clear line in the sand. If the driver choses to operate with posted
non-cached anyway, then make it an explicit driver choice.

> > If ioremap_nopost() is not possible on an architecture, then
> > pgprot_nonposted() won't be possible either - but you've made no
> > mention of that so far.

Right. It's not on most in fact.

> > Just like the proposed ioremap_nopost(), pgprot_nonposted() is given a
> > default implementation that uses pgprot_noncached().? Maybe we should
> > also make pci_remap_iospace() fail if pgprot_nonposted() is not defined
> > by the architecture?

Or we *document* that mmap of IO space can result in something that is
partially non-posted.

> Yes, I was about to mention that and you are right, I should deal with
> that too unfortunately. BTW, I have not posted the drivers to make the
> review easier (ie it would add 20 more patches to an already massive
> patch series - that will be trimmed when the asm-generic include is
> removed from arches according to this discussion).
> 
> Thanks,
> Lorenzo
