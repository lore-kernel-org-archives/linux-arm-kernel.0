From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 9 Feb 2017 14:38:05 +0000
Subject: [QUESTION] Early Write Acknowledge for PCIe configuration space
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1FA25E1C@lhreml507-mbx>
References: <df407f39-ee05-d74d-6e5e-c5e502372032@huawei.com>
 <6092525.UgRCY3dpzP@wuerfel> <20170106114231.GC15333@arm.com>
 <20170208183530.GA27720@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1FA25E1C@lhreml507-mbx>
Message-ID: <20170209143805.GA31693@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 11:42:18AM +0000, Gabriele Paoloni wrote:

[...]

> > > The ARMv8 ARM also says that the E attribute is a hint, so there's no
> > > guarantee that it's actually honoured by the implementation. However,
> > > now that it explicitly mentions PCI config space, the intention is
> > clearly
> > > that nE *is* honoured for systems using PCIe, so I agree that we
> > should make
> > > this change. I don't want to use the nE type for all ioremap
> > invocations,
> > > though.
> > 
> > I suspect this is a potential issue on ARM 32-bit systems too(?).
> > Fixing
> > IO space should be reasonably simple, we just have to change the
> > pgprot_device() in pci_remap_iospace() to pgprot_noncached() (they are
> > the same attributes on ARM 32-bit already if I am not mistaken).
> 
> Agreed on this. Actually I noticed that pci_remap_iospace() is __weak
> but no other definitions are present...

Yes I will remove it.

> > What do we want to do for config space ? Implement ioremap_uc() for
> > ARM/ARM64 (and add a devm_ioremap_uc() call to use it in basically all
> > drivers/pci/host implementations to map config space - or we just patch
> > the ioremap calls in drivers/pci/ecam.c and we assume the other hosts
> > controllers have purportedly called devm_ioremap() because on those
> > platforms it just works ok till further notice ?)
> 
> Well if my understanding is correct we are 100% positive that this issue
> affects controllers mounted on ARM and ARM64, right?
> If this is correct I would look at drivers/pci/host/Kconfig and see which
> controllers depend on ARM or ARM64; for these controllers I would replace
> devm_ioremap() with devm_ioremap_uc().
> Obviously I would also replace the calls in drivers/pci/ecam.c...
> 
> What do you think?

I share Will's concern on the _uc API, I will probably add a
pci_remap_cfgspace() API that would fall back to ioremap_nocache()
by default (ie if the arch does not override it).

Adding a devm_ioremap_* version seems overkill to me.

I will send a patch series, we will take it from there.

Cheers,
Lorenzo
