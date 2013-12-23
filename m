From: s-anna@ti.com (Anna, Suman)
Date: Mon, 23 Dec 2013 12:52:29 -0600
Subject: [PATCH 0/7] Fix omap-iommu probe and convert to DT for 3.14
In-Reply-To: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <52B8866D.9060100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 12/17/2013 06:53 AM, Florian Vaussard wrote:
> OMAP2+ is heading towards a full device tree boot for 3.14. Currently,
> the iommu used by the OMAP3 camera subsystem is not yet converted. It
> cannot be probed as necessary data are only passed through device tree.
>
> Patches 1 and 2 are small fixes for problems encountered while developing
> this series.
>
> Patches 3 to 5 add the device tree logic to omap-iommu, and complete iommu
> data in omap3.dtsi. Patches 6 and 7 remove unused iommu hwmod data and
> platform code from OMAP2+.

This is a good starting patch series for the OMAP iommu DT conversion, 
but it only handles OMAP3 ISP MMU. The OMAP3 ISP MMU is not the only MMU 
handled by the OMAP iommu driver. There is also an OMAP3 IVA MMU and 
MMUs associated with DSP and IPU in OMAP4/OMAP5. The conversion is 
simpler just with the OMAP3 ISP MMU, as it doesn't have any reset lines 
associated with it. But all the other MMUs would require 
asserting/deasserting the resets (performed currently through the pdata 
function pointers). Your patch series removes that functionality 
completely, and if this were to go into 3.14, this has to be handled 
through some pdata quirks until all the resets in hwmod data are 
converted to a reset driver.

I have provided some more comments directly in the respective patches.

regards
Suman

>
> This was tested on Overo (OMAP36xx) with an MT9V032 sensor connected
> to the isp interface. The full testing tree can be found here [2] (not
> safe for merging).
>
> Patches are based on 3.13-rc3. OMAP-related patches are based on Tony's
> omap-for-v3.14/omap3-board-removal branch [1].
>
> Regards,
>
> Florian
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>        omap-for-v3.14/omap3-board-removal
> [2] git at github.com:vaussard/linux.git overo-for-3.14/iommu/dt
>
> Florian Vaussard (7):
>    iommu/omap: Do bus_set_iommu() only if probe() succeeds
>    iommu/omap: omap_iommu_attach() should return ENODEV, not NULL
>    iommu/omap: Convert to devicetree
>    iommu/omap: Allow enable/disable even without pdata
>    ARM: dts: Complete data for isp iommu
>    ARM: OMAP2+: Remove legacy data from hwmod for omap3 isp iommu
>    ARM: OMAP2+: Remove platform-specific omap-iommu
>
>   .../devicetree/bindings/iommu/ti,omap-iommu.txt    |  19 ++
>   arch/arm/boot/dts/omap3.dtsi                       |   4 +-
>   arch/arm/mach-omap2/Makefile                       |   3 -
>   arch/arm/mach-omap2/omap-iommu.c                   |  74 ------
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   8 -
>   drivers/iommu/omap-iommu.c                         | 247 +++++++++++----------
>   6 files changed, 156 insertions(+), 199 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>   delete mode 100644 arch/arm/mach-omap2/omap-iommu.c
>
