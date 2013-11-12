From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 16:34:20 -0700
Subject: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
In-Reply-To: <1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
 <1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <5282BAFC.8070405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> An "IOMMU device" on the bus is poplulated first, "IOMMU'able devices"
> are done later.
> 
> With CONFIG_OF_IOMMU, "#stream-id-cells" DT binding would be used to
> identify whether a device is IOMMU'able or not. If a device is
> IOMMU'able, we'll defer to populate that device till an iommu device
> is populated. Once an iommu device is populated, "dev->bus->iommu_ops"
> is set in the bus. Then, those defered IOMMU'able devices are
> populated and configured as IOMMU'abled with help of the already
> populated iommu device via iommu_ops->add_device().

This looks fairly neat and clean.

I'm still worried about using #stream-id-cells in DT nodes though. While
I do understand that the *Linux* device model currently only allows each
struct device to be affected by a single IOMMU, I worry that encoding
that same restriction into DT is a mistake. I'd far rather see a
property like:

SMMU:
    smmu: smmu at xxxxxx {
        #smmu-cells = <1>;
    }

Affected device:
    smmus = <&smmu 1>;
    (perhaps with smmu-names too)

That would allow the DT to represent basically arbitrary HW configurations.

The implementation of this patch would then be almost as trivial; you'd
just need to walk the smmus property to find each phandle in turn, just
like any other phandle+specifier property, and validate that the SMMU
driver was already probe()d for each.
