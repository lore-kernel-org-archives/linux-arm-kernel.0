From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Nov 2013 11:39:36 +0000
Subject: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
In-Reply-To: <1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
 <1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <20131111113936.GH28302@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 08:31:53AM +0000, Hiroshi Doyu wrote:
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
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
> Update:
> This is newly added, and the successor of the following RFC:
>   [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
>   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html

This generally looks like the right idea to me, but it would be good to have
the input from a DT maintainer on the use of "#stream-id-cells" as an indicator
that a device is behind an IOMMU. (aside: I think "iommuable" is a horrible
word!).

What happens if you do the deferring at the bus level? E.g. defer all device
probes on a bus, until the IOMMU is probed for that bus. That might fit
better with future work, where we will almost certainly need to expose more
of the bus topology to Linux. Of course, I can see that falling down for
monolithic virtual buses like the platform bus.

Will
