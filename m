From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 12 Apr 2017 15:41:09 +0100
Subject: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
In-Reply-To: <20170412141654.GA17774@n2100.armlinux.org.uk>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
Message-ID: <20170412144109.GB6842@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 03:16:55PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 12, 2017 at 11:51:59PM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2017-04-12 at 12:31 +0100, Russell King - ARM Linux wrote:
> > > default implementation should fail if it's not supportable on all
> > > architectures.? However, when we have existing drivers using an
> > > interface that doesn't provide the semantics they already require,
> > > then it makes no sense to effectively break these drivers on a range
> > > of existing architectures.
> > > 
> > > The question really is - what's the best way to solve the problem
> > > with
> > > existing drivers without breaking them.? I suspect that, sadly, the
> > > only realistic way forward here is via the litter-drivers-with-ifdefs
> > > approach since you don't like providing a default implementation that
> > > is compatible with what these drivers are already doing.
> > 
> > Then make ioremap_nopost return NULL when the arch doesn't have 
> > the right semantic.
> > 
> > The driver than can *chose* to either silently fallback to ioremap,
> > which has served us well for a long time despite being theorically in
> > violation of the spec, or do funny things like read back some register
> > after every config write to ensure ordering etc...
> > 
> > I much prefer that approach than having some generic ioremap function
> > that exposes a semantic that silently provides a weaker one on some
> > architecture.
> > 
> > At least we make the failure explicit, and the driver can take
> > alternate (possibly sub-optimal) action if it chooses to do so.
> 
> The same points apply to things like pgprot_writecombine(),
> pgprot_noncached(), pgprot_device().  Then there's also pgprot_nonposted()
> that this series also introduces.
> 
> If ioremap_nopost() is not possible on an architecture, then
> pgprot_nonposted() won't be possible either - but you've made no
> mention of that so far.
> 
> Just like the proposed ioremap_nopost(), pgprot_nonposted() is given a
> default implementation that uses pgprot_noncached().  Maybe we should
> also make pci_remap_iospace() fail if pgprot_nonposted() is not defined
> by the architecture?

Yes, I was about to mention that and you are right, I should deal with
that too unfortunately. BTW, I have not posted the drivers to make the
review easier (ie it would add 20 more patches to an already massive
patch series - that will be trimmed when the asm-generic include is
removed from arches according to this discussion).

Thanks,
Lorenzo
