From: fkan@apm.com (Feng Kan)
Date: Mon, 14 Aug 2017 11:41:58 -0700
Subject: [PATCH v3 0/5] ACPI: DMA ranges management
In-Reply-To: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
References: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
Message-ID: <CAL85gmAd4aA7M7sEJC4yfb7UVghmb4ZE-XVdb8y0D=P_Ut2MOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 3, 2017 at 5:32 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> This patch series is v3 of a previous posting:
>
> v2->v3:
>         - Fixed DMA masks computation
>         - Fixed size computation overflow in acpi_dma_get_range()
>
> v1->v2:
>         - Reworked acpi_dma_get_range() flow and logs
>         - Added IORT named component address limits
>         - Renamed acpi_dev_get_resources() helper function
>         - Rebased against v4.13-rc3
>
> v2: http://lkml.kernel.org/r/20170731152323.32488-1-lorenzo.pieralisi at arm.com
> v1: http://lkml.kernel.org/r/20170720144517.32529-1-lorenzo.pieralisi at arm.com
>
> -- Original cover letter --
>
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
> Lorenzo Pieralisi (5):
>   ACPICA: resource_mgr: Allow _DMA method in walk resources
>   ACPI: Make acpi_dev_get_resources() method agnostic
>   ACPI: Introduce DMA ranges parsing
>   ACPI: Make acpi_dma_configure() DMA regions aware
>   ACPI/IORT: Add IORT named component memory address limits
>
>  drivers/acpi/acpica/rsxface.c |  7 ++--
>  drivers/acpi/arm64/iort.c     | 57 ++++++++++++++++++++++++++-
>  drivers/acpi/resource.c       | 82 +++++++++++++++++++++++++++++---------
>  drivers/acpi/scan.c           | 91 +++++++++++++++++++++++++++++++++++++++----
>  include/acpi/acnames.h        |  1 +
>  include/acpi/acpi_bus.h       |  2 +
>  include/linux/acpi.h          |  8 ++++
>  include/linux/acpi_iort.h     |  5 ++-
>  8 files changed, 219 insertions(+), 34 deletions(-)
>
> --
> 2.10.0
>
Works on XGene.
Tested-by: Feng Kan <fkan@apm.com>
