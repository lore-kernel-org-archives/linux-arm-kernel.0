From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Jan 2018 13:00:36 +0000
Subject: [PATCH] iommu/arm-smmu-v3: Cope with duplicated Stream IDs
In-Reply-To: <13744c7ba2af61bc39b68e9ab05ab8482f928334.1514896042.git.robin.murphy@arm.com>
References: <13744c7ba2af61bc39b68e9ab05ab8482f928334.1514896042.git.robin.murphy@arm.com>
Message-ID: <20180102130036.GB6613@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 12:33:14PM +0000, Robin Murphy wrote:
> For PCI devices behind an aliasing PCIe-to-PCI/X bridge, the bridge
> alias to DevFn 0.0 on the subordinate bus may match the original RID of
> the device, resulting in the same SID being present in the device's
> fwspec twice. This causes trouble later in arm_smmu_write_strtab_ent()
> when we wind up visiting the STE a second time and find it already live.
> 
> Avoid the issue by giving arm_smmu_install_ste_for_dev() the cleverness
> to skip over duplicates. It seems mildly counterintuitive compared to
> preventing the duplicates from existing in the first place, but since
> the DT and ACPI probe paths build their fwspecs differently, this is
> actually the cleanest and most self-contained way to deal with it.
> 
> Fixes: 8f78515425da ("iommu/arm-smmu: Implement of_xlate() for SMMUv3")
> Reported-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
> Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
> Tested-by: Jayachandran C. <jnair@caviumnetworks.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Cheers, Robin. I'll pick this up and send to Alex later this week along with
a couple of other fixes I have kicking around.

Will
