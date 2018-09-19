From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 19 Sep 2018 14:25:38 +0100
Subject: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
In-Reply-To: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
Message-ID: <7d7646dc-9d0b-013d-75d7-a6cb4453f41f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurentiu,

On 19/09/18 13:35, laurentiu.tudor at nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> This patch series adds SMMU support for NXP LS1043A and LS1046A chips
> and consists mostly in important driver fixes and the required device
> tree updates. It touches several subsystems and consists of three main
> parts:
>   - changes in soc/drivers/fsl/qbman drivers adding iommu mapping of
>     reserved memory areas, fixes and defered probe support
>   - changes in drivers/net/ethernet/freescale/dpaa_eth drivers
>     consisting in misc dma mapping related fixes and probe ordering
>   - addition of the actual arm smmu device tree node together with
>     various adjustments to the device trees
> 
> Performance impact
> 
>      Running iperf benchmarks in a back-to-back setup (both sides
>      having smmu enabled) on a 10GBps port show an important
>      networking performance degradation of around %40 (9.48Gbps
>      linerate vs 5.45Gbps). If you need performance but without
>      SMMU support you can use "iommu.passthrough=1" to disable
>      SMMU.
> 
> USB issue and workaround
> 
>      There's a problem with the usb controllers in these chips
>      generating smaller, 40-bit wide dma addresses instead of the 48-bit
>      supported at the smmu input. So you end up in a situation where the
>      smmu is mapped with 48-bit address translations, but the device
>      generates transactions with clipped 40-bit addresses, thus smmu
>      context faults are triggered. I encountered a similar situation for
>      mmc that I  managed to fix in software [1] however for USB I did not
>      find a proper place in the code to add a similar fix. The only
>      workaround I found was to add this kernel parameter which limits the
>      usb dma to 32-bit size: "xhci-hcd.quirks=0x800000".
>      This workaround if far from ideal, so any suggestions for a code
>      based workaround in this area would be greatly appreciated.

If you have a nominally-64-bit device with a 
narrower-than-the-main-interconnect link in front of it, that should 
already be fixed in 4.19-rc by bus_dma_mask picking up DT dma-ranges, 
provided the interconnect hierarchy can be described appropriately (or 
at least massaged sufficiently to satisfy the binding), e.g.:

/ {
	...

	soc {
		ranges;
		dma-ranges = <0 0 10000 0>;

		dev_48bit { ... };

		periph_bus {
			ranges;
			dma-ranges = <0 0 100 0>;

			dev_40bit { ... };
		};
	};
};

and if that fails to work as expected (except for PCI hosts where 
handling dma-ranges properly still needs sorting out), please do let us 
know ;)

Robin.

> The patch set is based on net-next so, if generally agreed, I'd suggest
> to get the patches through the netdev tree after getting all the Acks.
> 
> [1] https://patchwork.kernel.org/patch/10506627/
> 
> Laurentiu Tudor (21):
>    soc/fsl/qman: fixup liodns only on ppc targets
>    soc/fsl/bman: map FBPR area in the iommu
>    soc/fsl/qman: map FQD and PFDR areas in the iommu
>    soc/fsl/qman-portal: map CENA area in the iommu
>    soc/fsl/qbman: add APIs to retrieve the probing status
>    soc/fsl/qman_portals: defer probe after qman's probe
>    soc/fsl/bman_portals: defer probe after bman's probe
>    soc/fsl/qbman_portals: add APIs to retrieve the probing status
>    fsl/fman: backup and restore ICID registers
>    fsl/fman: add API to get the device behind a fman port
>    dpaa_eth: defer probing after qbman
>    dpaa_eth: base dma mappings on the fman rx port
>    dpaa_eth: fix iova handling for contiguous frames
>    dpaa_eth: fix iova handling for sg frames
>    dpaa_eth: fix SG frame cleanup
>    arm64: dts: ls1046a: add smmu node
>    arm64: dts: ls1043a: add smmu node
>    arm64: dts: ls104xa: set mask to drop TBU ID from StreamID
>    arm64: dts: ls104x: add missing dma ranges property
>    arm64: dts: ls104x: add iommu-map to pci controllers
>    arm64: dts: ls104x: make dma-coherent global to the SoC
> 
>   .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  52 ++++++-
>   .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  48 +++++++
>   .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 136 ++++++++++++------
>   drivers/net/ethernet/freescale/fman/fman.c    |  35 ++++-
>   drivers/net/ethernet/freescale/fman/fman.h    |   4 +
>   .../net/ethernet/freescale/fman/fman_port.c   |  14 ++
>   .../net/ethernet/freescale/fman/fman_port.h   |   2 +
>   drivers/soc/fsl/qbman/bman_ccsr.c             |  23 +++
>   drivers/soc/fsl/qbman/bman_portal.c           |  20 ++-
>   drivers/soc/fsl/qbman/qman_ccsr.c             |  30 ++++
>   drivers/soc/fsl/qbman/qman_portal.c           |  35 +++++
>   include/soc/fsl/bman.h                        |  16 +++
>   include/soc/fsl/qman.h                        |  17 +++
>   13 files changed, 379 insertions(+), 53 deletions(-)
> 
