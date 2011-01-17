From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 17 Jan 2011 18:39:49 -0500 (EST)
Subject: [PATCH 06/14] ARM: v6k: Dove platforms use V6K architecture CPUs
In-Reply-To: <E1PeufN-0003Sd-W2@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeufN-0003Sd-W2@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101171835530.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:

> Make Dove platforms select the new V6K CPU option.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Nicolas Pitre <nicolas.pitre@linaro.org>

I'd suggest doing the following instead of attaching the selection to 
each individual board target , as the whole Dove architecture is V6K:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba304a3..d3f5674 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -457,6 +457,7 @@ config ARCH_IXP4XX
 
 config ARCH_DOVE
 	bool "Marvell Dove"
+	select CPU_V6K
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index 822439a..dd937c5 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -5,14 +5,12 @@ menu "Marvell Dove Implementations"
 config MACH_DOVE_DB
 	bool "Marvell DB-MV88AP510 Development Board"
 	select I2C_BOARDINFO
-	select CPU_V6K
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DB-MV88AP510 Development Board.
 
 config MACH_CM_A510
 	bool "CompuLab CM-A510 Board"
-	select CPU_V6K
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  CompuLab CM-A510 Board.




> ---
>  arch/arm/mach-dove/Kconfig |    4 +++-
>  arch/arm/mm/Kconfig        |    4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
> index a4ed390..822439a 100644
> --- a/arch/arm/mach-dove/Kconfig
> +++ b/arch/arm/mach-dove/Kconfig
> @@ -5,12 +5,14 @@ menu "Marvell Dove Implementations"
>  config MACH_DOVE_DB
>  	bool "Marvell DB-MV88AP510 Development Board"
>  	select I2C_BOARDINFO
> +	select CPU_V6K
>  	help
>  	  Say 'Y' here if you want your kernel to support the
>  	  Marvell DB-MV88AP510 Development Board.
>  
> - config MACH_CM_A510
> +config MACH_CM_A510
>  	bool "CompuLab CM-A510 Board"
> +	select CPU_V6K
>  	help
>  	  Say 'Y' here if you want your kernel to support the
>  	  CompuLab CM-A510 Board.
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 559e933..22a3f4a 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -390,7 +390,7 @@ config CPU_PJ4
>  
>  # ARMv6
>  config CPU_V6
> -	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
> +	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
>  	select CPU_32v6
>  	select CPU_ABRT_EV6
>  	select CPU_PABRT_V6
> @@ -403,7 +403,7 @@ config CPU_V6
>  
>  # ARMv6k
>  config CPU_V6K
> -	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
> +	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
>  	select CPU_32v6
>  	select CPU_32v6K if !ARCH_OMAP2
>  	select CPU_ABRT_EV6
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
