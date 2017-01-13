From: tn@semihalf.com (Tomasz Nowicki)
Date: Fri, 13 Jan 2017 14:59:16 +0100
Subject: [PATCH v8 00/18] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
In-Reply-To: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
Message-ID: <e1e6d9cf-5fb8-e118-3a47-4c6be77c21a3@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On 11.01.2017 10:41, Eric Auger wrote:
> Following LPC discussions, we now report reserved regions through
> the iommu-group sysfs reserved_regions attribute file.
>
> Reserved regions are populated through the IOMMU get_resv_region
> callback (former get_dm_regions), now implemented by amd-iommu,
> intel-iommu and arm-smmu:
> - the intel-iommu reports the [0xfee00000 - 0xfeefffff] MSI window
>   as a reserved region and RMRR regions as direct-mapped regions.
> - the amd-iommu reports device direct mapped regions, the MSI region
>   and HT regions.
> - the arm-smmu reports the MSI window (arbitrarily located at
>   0x8000000 and 1MB large).
>
> Unsafe interrupt assignment is tested by enumerating all MSI irq
> domains and checking MSI remapping is supported in the above hierarchy.
> This check is done in case we detect the iommu translates MSI
> (an IOMMU_RESV_MSI window exists). Otherwise the IRQ remapping
> capability is checked at IOMMU level. Obviously this is a defensive
> IRQ safety assessment: Assuming there are several MSI controllers
> in the system and at least one does not implement IRQ remapping,
> the assignment will be considered as unsafe (even if this controller
> is not acessible from the assigned devices).
>
> The series first patch stems from Robin's branch:
> http://linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/misc
>
> Best Regards
>
> Eric
>
> Git: complete series available at
> https://github.com/eauger/linux/tree/v4.10-rc3-reserved-v8

I tested the series on ThunderX with internal 10G VNIC and Intel IXGBE 
NIC. Please feel free to add my:
Tested-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>

Thanks,
Tomasz
