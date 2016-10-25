From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 25 Oct 2016 23:25:04 +0800
Subject: [PATCH 1/2] iommu/arm-smmu: Don't inadvertently reject multiple
 SMMUv3s
In-Reply-To: <5cf1acbf9c42cc99e5cc0dacb50b7a92c3bd0feb.1476702234.git.robin.murphy@arm.com>
References: <5cf1acbf9c42cc99e5cc0dacb50b7a92c3bd0feb.1476702234.git.robin.murphy@arm.com>
Message-ID: <61bd096a-cc82-43d3-a99b-5b09252b9e7d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/10/17 19:06, Robin Murphy wrote:
> We now delay installing our per-bus iommu_ops until we know an SMMU has
> successfully probed, as they don't serve much purpose beforehand, and
> doing so also avoids fights between multiple IOMMU drivers in a single
> kernel. However, the upshot of passing the return value of bus_set_iommu()
> back from our probe function is that if there happens to be more than
> one SMMUv3 device in a system, the second and subsequent probes will
> wind up returning -EBUSY to the driver core and getting torn down again.
>
> There are essentially 3 cases in which bus_set_iommu() returns nonzero:
> 1. The bus already has iommu_ops installed
> 2. One of the add_device callbacks from the initial notifier failed
> 3. Allocating or installing the notifier itself failed
>
> The first two are down to devices other than the SMMU in question, so
> shouldn't abort an otherwise-successful SMMU probe, whilst the third is
> indicative of the kind of catastrophic system failure which isn't going
> to get much further anyway. Consequently, there is little harm in
> ignoring the return value either way.
>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
