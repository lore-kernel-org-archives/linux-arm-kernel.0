From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 05 Jan 2012 17:30:27 +0100
Subject: [PATCH] ARM: tegra: select required CPU and L2 errata options
In-Reply-To: <1325719752-818-1-git-send-email-olof@lixom.net>
References: <1325719752-818-1-git-send-email-olof@lixom.net>
Message-ID: <6121078.4q2inFFXlB@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 4. Januar 2012, 15:29:12 schrieb Olof Johansson:
> Only one of the L2 erratas are needed on T30, but T20/25
> needs a few more.

can we have a word from someone from NVIDIA about which Tegra versions/revisions need 
which erratum applied? 

Currently the kernel has selections for the following errata (on ARM):

	T2x		T30
					ERRATA_430973			Stale prediction on replaced interworking branch
					ERRATA_458693			Processor deadlock when a false hazard is created
					ERRATA_460075			Data written to the L2 cache can be overwritten
											with stale data
	x				ERRATA_742230			DMB operation may be faulty
					ERRATA_742231			Incorrect hazard handling in the SCU may lead to
											data corruption
					PL310_ERRATA_588369	Clean & Invalidate maintenance operations do not
											invalidate clean lines
					ERRATA_720789			TLBIASIDIS and TLBIMVAIS operations can broadcast
											a faulty ASID
					PL310_ERRATA_727915	Background Clean & Invalidate by Way operation
											can cause data corruption
					ERRATA_743622			Faulty hazard checking in the Store Buffer may
											lead to data corruption
					ERRATA_751472			Interrupted ICIALLUIS may prevent completion of
											broadcasted operation
	x				PL310_ERRATA_753970	cache sync operation may be faulty
					ERRATA_754322			possible faulty MMU translations following an ASID
											switch
					ERRATA_754327			no automatic Store Buffer drain
					ERRATA_764369			Data cache line maintenance operation by MVA may
											not succeed
	x		x		PL310_ERRATA_769419	no automatic Store Buffer drain

With Olofs patch, the following errata are enabled by tegra_defconfig:

742230(T2x), 753970(T2x), 769419(T2x + T30)

I have the feeling that at least 764369 also needs to be enabled. From the 
description: ... affecting Cortex-A9 MPCore with two or more processors (all                                                                         
current revisions). I wonder if this includes multi *cores*.

The TRM is not very detailed about this topic. Having this info will likely remove 
some headache for non OEM custumers.

Marc


> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/mach-tegra/Kconfig |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 373652d..a2c76ee 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -10,6 +10,9 @@ config ARCH_TEGRA_2x_SOC
>  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select USB_ULPI if USB_SUPPORT
>  	select USB_ULPI_VIEWPORT if USB_SUPPORT
> +	select ARM_ERRATA_742230
> +	select PL310_ERRATA_753970 if CACHE_PL310
> +	select PL310_ERRATA_769419 if CACHE_L2X0
>  	help
>  	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
>  	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
> @@ -23,6 +26,7 @@ config ARCH_TEGRA_3x_SOC
>  	select USB_ULPI if USB_SUPPORT
>  	select USB_ULPI_VIEWPORT if USB_SUPPORT
>  	select USE_OF
> +	select PL310_ERRATA_769419 if CACHE_L2X0
>  	help
>  	  Support for NVIDIA Tegra T30 processor family, based on the
>  	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
