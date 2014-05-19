From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 12:26:35 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <4391809.OTRCiJQXS4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 May 2014 14:23:18 Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This commit introduces a generic device tree binding for IOMMU devices.
> Only a very minimal subset is described here, but it is enough to cover
> the requirements of both the Exynos System MMU and Tegra SMMU as
> discussed here:
> 
>     https://lkml.org/lkml/2014/4/27/346
> 
> More advanced functionality such as the dma-ranges property can easily
> be added in a backwards-compatible way. In the absence of a dma-ranges
> property it should be safe to default to the whole address space.
> 

The basic binding looks fine, but I'd like it to be more explicit
about dma-ranges. Most importantly, what does "the whole address space"
mean? A lot of IOMMUs have only 32-bit bus addresses when targetted
by a bus master, it would also be normal for some to be smaller and
some might even support 64-bit.

For the upstream side, I'd hope we always have access to the full
physical memory, but since this is a brand-new binding, it should
be straightforward to just ask for upstream dma-ranges properties
to be set all the way up to the root to confirm that.

For downstream, we don't actually have a good place to put the
dma-ranges property. We can't put it into the iommu node, because
that would imply translating to the iommu's parent bus, not the
iommu's own bus space. We also can't put it into the master, because
dma-ranges is supposed to be in the parent bus. Finally, it makes
no sense to use the dma-ranges property of the master's parent bus,
because that bus isn't actually involved in the translation.

My preferred option would be to always put the address range into
the iommu descriptor, using the iommu's #address-cells.

	Arnd
