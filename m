From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 07 Oct 2011 22:46:42 +0200
Subject: [PATCH v3 RE-SEND 2/2] iommu/exynos: Add iommu driver for Exynos
	Platforms
In-Reply-To: <01e601cc84d9$4530d6a0$cf9283e0$%kim@samsung.com>
References: <01e601cc84d9$4530d6a0$cf9283e0$%kim@samsung.com>
Message-ID: <4E8F6532.9060609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2011 12:09 PM, Kukjin Kim wrote:
> From: KyongHo Cho<pullip.cho@samsung.com>
> 
> This is the System MMU driver and IOMMU API implementation for
> Exynos SOC platforms. Exynos platforms has more than 10 System
> MMUs dedicated for each multimedia accellerators.
> 
> The System MMU driver is already in arc/arm/plat-s5p but it is
> moved to drivers/iommu due to Ohad Ben-Cohen gathered IOMMU drivers
> there
> 
> This patch also includes fault handling feature in IOMMU driver
> suggested by Ohad.
> Users of IOMMU API can register its own fault handler with
> iommu_set_fault_handler() and the handler is called by IRQ handler
> of System MMU.
> If no user installs fault handler, IOMMU driver prints debugging
> message and generates kernel oops.
> 
> This IOMMU driver calls bus_set_iommu() instead of register_iommu()
> since Joerg suggested that installing iommu_ops in bus_type.
> 
> Cc: Joerg Roedel<joerg.roedel@amd.com>
> Cc: Ohad Ben-Cohen<ohad@wizery.com>
> Signed-off-by: KyongHo Cho<pullip.cho@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> ---
> NOTE: Since previous sending has problem, I'm re-sending.
> Sorry, please kindly ignore previous one.
> 
>   arch/arm/plat-s5p/Kconfig                   |   14 -
>   arch/arm/plat-s5p/Makefile                  |    1 -
>   arch/arm/plat-s5p/sysmmu.c                  |  312 ---------
>   arch/arm/plat-samsung/include/plat/sysmmu.h |   95 ---
>   drivers/iommu/Kconfig                       |   14 +
>   drivers/iommu/Makefile                      |    1 +
>   drivers/iommu/exynos_iommu.c                |  963 +++++++++++++++++++++++++++
>   7 files changed, 978 insertions(+), 422 deletions(-)
>   delete mode 100644 arch/arm/plat-s5p/sysmmu.c
>   delete mode 100644 arch/arm/plat-samsung/include/plat/sysmmu.h
>   create mode 100644 drivers/iommu/exynos_iommu.c
> 
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index 7b9dada..fa374cc 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -46,20 +46,6 @@ config S5P_PM
>   	  Common code for power management support on S5P and newer SoCs
>   	  Note: Do not select this for S5P6440 and S5P6450.
> 
> -comment "System MMU"
> -
> -config S5P_SYSTEM_MMU
> -	bool "S5P SYSTEM MMU"
> -	depends on ARCH_EXYNOS4
> -	help
> -	  Say Y here if you want to enable System MMU
> -
> -config S5P_SLEEP
> -	bool
> -	help
> -	  Internal config node to apply common S5P sleep management code.
> -	  Can be selected by S5P and newer SoCs with similar sleep procedure.
> -

Is S5P_SLEEP being removed intentionally ? It doesn't seem to belong here.
