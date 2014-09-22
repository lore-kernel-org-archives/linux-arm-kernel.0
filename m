From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Sep 2014 18:43:37 +0100
Subject: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <20140922091934.GH1470@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-8-git-send-email-will.deacon@arm.com>
 <20140922091934.GH1470@ulmo>
Message-ID: <20140922174337.GI7936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Mon, Sep 22, 2014 at 10:19:35AM +0100, Thierry Reding wrote:
> On Fri, Sep 12, 2014 at 05:34:55PM +0100, Will Deacon wrote:
> [...]
> > +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size)
> > +{
> > +	struct dma_iommu_mapping *mapping;
> > +
> > +	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
> 
> If I understand correctly this will be called for each device that has
> an IOMMU master interface and will end up creating a new mapping for
> each of the devices. Each of these mappings will translate to a domain
> in the IOMMU API, which in turn is a separate address space.

Correct, although that's largely because I've bolted on the existing ARM
IOMMU code.

> How do you envision to support use-cases where a set of devices need to
> share a single domain? This is needed for example in DRM where SoCs
> often have a set of hardware blocks (each with its own master interface)
> that compose the display device. On Tegra for example there are two
> display controllers that need access to the same IOVA domain so that
> they can scan out framebuffers.

Yup. In this case, the iommu_dma_mapping passed to arch_setup_dma_ops
contains a domain and an allocator for each IOMMU instance in the system.
It would then be up to the architecture how it makes use of those, but
the most obvious thing to do would be to attach devices mastering through
an IOMMU instance to that per-instance domain.

The other use-case is isolation (one domain per device), which I guess
matches what the ARM code is doing at the moment.

Will
