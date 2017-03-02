From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 2 Mar 2017 12:05:46 +0000
Subject: [PATCH 07/20] PCI: implement Devres interface to map PCI config
 space
In-Reply-To: <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
 <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
Message-ID: <20170302120546.GB17277@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Thu, Mar 02, 2017 at 01:54:42AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 27, 2017 at 5:14 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > The introduction of the pci_remap_cfgspace() interface allows
> > PCI host controller drivers to map PCI config space through a
> > dedicated kernel interface. Current PCI host controller drivers
> > use the devm_ioremap_* Devres interfaces to map PCI configuration
> > space regions so in order to update them to the new
> > pci_remap_cfgspace() mapping interface a new set of Devres interfaces
> > should be implemented so that PCI host controller drivers can make
> > use of them.
> >
> > Introduce two new functions in the PCI kernel layer and Devres
> > documentation:
> >
> > - devm_pci_remap_cfgspace()
> > - devm_pci_remap_cfg_resource()
> >
> > so that PCI host controller drivers can make use of them to map
> > PCI configuration space regions.
> 
> Wouldn't you like to be consistent with current PCI API, i.e.:
> 1. devm_*() functions called pcim_*() in PCI.

I thought about that and did not do it because here we are remapping
resources that are _not_ PCI bus resources (ie it is not PCI BARs we
are remapping), keeping the devm_* prefix would be more consistent
to the typical device drivers remapping functions pattern (ie a
typical PCI host controller driver would mix devm_ and pcim_ calls
which is a bit hard to parse), that was my rationale.

I am not too fussed about that either way, I am happy to update it to
pcim_* though, it is Bjorn/Arnd's decision.

> 2. If you may notice there is no separate pcim_*map*() stuff, they are
> dynamically adapting to the case.

I do not understand what you mean here I would ask you to elaborate
a bit more please so that I can do something about it.

Thanks !
Lorenzo
