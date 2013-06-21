From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Jun 2013 10:57:29 +0100
Subject: [PATCH 7/9] documentation: iommu: add description of ARM System
 MMU binding
In-Reply-To: <20130620200845.GF11309@8bytes.org>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-8-git-send-email-will.deacon@arm.com>
 <20130620200845.GF11309@8bytes.org>
Message-ID: <20130621095729.GA7766@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Thu, Jun 20, 2013 at 09:08:45PM +0100, Joerg Roedel wrote:
> On Mon, Jun 10, 2013 at 07:34:43PM +0100, Will Deacon wrote:
> > This patch adds a description of the device tree binding for the ARM
> > System MMU architecture.
> 
> Interesting, will this be a common driver to replace existing ARM IOMMU
> drivers or is it a common driver for ARM IOMMUs found in future chips?

This is a common driver that will support any IOMMUs compatible with v1 or
v2 of the ARM SMMU architecture. Currently, that includes SMMUs known
informatively as MMU-400, MMU-401 and MMU-500. I had a look at the other
IOMMU drivers in the kernel and they seem to be driving incompatible IOMMUs,
so I don't see how this driver can replace those.

However, we'll hopefully see ARM SMMU-compatible devices turning up soon (I
know of many SoCs in development that are looking at them).

> > +- smmu-parent   : When multiple SMMUs are chained together, this
> > +                  property can be used to provide a phandle to the
> > +                  parent SMMU (that is the next SMMU on the path going
> > +                  from the mmu-masters towards memory) node for this
> > +                  SMMU.
> 
> What happens when SMMUs are chained? Will the second SMMU seeing the DMA
> just pass it through or is it translated again?

Chaining is really horrible and exists as a hack to support virtualisation
using two separate SMMUs, where neither of them can support nested
translation.

The current driver just programs the translation in the SMMU nearest the
device, then sets the other SMMU into `bypass' mode (it was simple enough to
generalise the chain to contain an arbitrary number of SMMUs, so the driver
can actually deal with any number of the things). In theory (and if we
extended the IOMMU API to distinguish between guest and host mappings --
something which I plan to look at in the future), KVM could install mappings
in the second SMMU, but I think we should draw a line in the sand and mandate
support for nested translation for KVM.

The only thing to take care of is that the SMMUs in the chain don't silently
truncate addresses.

Will
