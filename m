From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jun 2016 13:45:32 +0100
Subject: [PATCH] iommu/arm-smmu: request pcie devices to enable ACS
In-Reply-To: <1465809617-13003-1-git-send-email-Wei.Chen@arm.com>
References: <1465809617-13003-1-git-send-email-Wei.Chen@arm.com>
Message-ID: <20160613124531.GE1605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 05:20:17PM +0800, Wei Chen wrote:
> The PCIe ACS capability will affect the layout of iommu groups.
> Generally speaking, if the path from root port to the PCIe device
> is ACS enabled, the iommu will create a single iommu group for this
> PCIe device. If all PCIe devices on the path are ACS enabled then
> Linux can determine this path is ACS enabled.
> 
> Linux use two PCIe configuration registers to determine the ACS
> status of PCIe devices:
> ACS Capability Register and ACS Control Register.
> 
> The first register is used to check the implementation of ACS function
> of a PCIe device, the second register is used to check the enable status
> of ACS function. If one PCIe device has implemented and enabled the ACS
> function then Linux will determine this PCIe device enabled ACS.
> 
> From the Chapter:6.12 of PCI Express Base Specification Revision 3.1a,
> we can find that when a PCIe device implements ACS function, the enable
> status is set to disabled by default and can be enabled by ACS-aware
> software.
> 
> ACS will affect the iommu groups topology, so, the iommu driver is
> ACS-aware software. This patch adds a call to pci_request_acs() to the
> arm-smmu driver to enable the ACS function in PCIe devices that support
> it.
> 
> Signed-off-by: Wei Chen <Wei.Chen@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 ++
>  drivers/iommu/arm-smmu.c    | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Thanks, queued for 4.8 w/ Robin and Eric's reviewed-by tags and the minor
commit wording change.

Will
