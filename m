From: nwatters@codeaurora.org (Nate Watterson)
Date: Wed, 26 Jul 2017 10:46:00 -0400
Subject: [PATCH 0/4] ACPI: DMA ranges management
In-Reply-To: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
Message-ID: <7df11172-5a40-685f-5202-9a0bceb6e19b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 7/20/2017 10:45 AM, Lorenzo Pieralisi wrote:
> As reported in:
> 
> http://lkml.kernel.org/r/CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g at mail.gmail.com
> 
> the bus connecting devices to an IOMMU bus can be smaller in size than
> the IOMMU input address bits which results in devices DMA HW bugs in
> particular related to IOVA allocation (ie chopping of higher address
> bits owing to system bus HW capabilities mismatch with the IOMMU).
> 
> Fortunately this problem can be solved through an already present but never
> used ACPI 6.2 firmware bindings (ie _DMA object) allowing to define the DMA
> window for a specific bus in ACPI and therefore all upstream devices
> connected to it.
> 
> This small patch series enables _DMA parsing in ACPI core code and
> use it in ACPI IORT code in order to detect DMA ranges for devices and
> update their data structures to make them work with their related DMA
> addressing restrictions.

I tested the patches and unfortunately it seems like the DMA addressing
restrictions are not really enforced for devices that attempt to set
their own dma_mask based on controller capabilities. For instance,
consider the following from the ahci_platform driver:

	if (hpriv->cap & HOST_CAP_64) {
		rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
		[...]
	}

Prior to the check, I can see that the device dma_mask respects the
limits enumerated in the _DMA object, however it is then clobbered by
the call to dma_coerce_mask_and_coherent(). Interestingly, if
HOST_CAP_64 was not set and the _DMA object for the device (or its
parent) indicated support for > 32-bit addrs, the host controller
could end up getting programmed with addresses beyond what it actually
supports. That is more a bug with the ahci_platform driver assuming a
default 32-bit dma_mask, but I would not be surprised to find other
drivers that rely on the same assumption.

To ensure that dma_set_mask() and friends actually respect _DMA, would
you consider introducing a dma_supported() callback to check the input
dma_mask against the FW defined limits? This would end up aggressively
clipping the dma_mask to 32-bits for devices like the above if the _DMA
limit was less than 64-bits, but that is probably preferable to the
controller accessing unintended addresses.

Also, how would you feel about adding support for the IORT named_node
memory_address_limit field?

-Nate
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Feng Kan <fkan@apm.com>
> Cc: Jon Masters <jcm@redhat.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> Lorenzo Pieralisi (4):
>    ACPI: Allow _DMA method in walk resources
>    ACPI: Make acpi_dev_get_resources() method agnostic
>    ACPI: Introduce DMA ranges parsing
>    ACPI: Make acpi_dma_configure() DMA regions aware
> 
>   drivers/acpi/acpica/rsxface.c |  7 ++--
>   drivers/acpi/arm64/iort.c     | 27 +++++++++++-
>   drivers/acpi/resource.c       | 83 ++++++++++++++++++++++++++++---------
>   drivers/acpi/scan.c           | 95 +++++++++++++++++++++++++++++++++++++++----
>   include/acpi/acnames.h        |  1 +
>   include/acpi/acpi_bus.h       |  2 +
>   include/linux/acpi.h          |  8 ++++
>   include/linux/acpi_iort.h     |  5 ++-
>   8 files changed, 194 insertions(+), 34 deletions(-)
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
