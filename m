From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 11:56:29 +0100
Subject: [PATCH 10/12] ARM: vf610m4: add new machine and SoC for Vybrid on
 Cortex-M4
In-Reply-To: <1417565531-4507-11-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-11-git-send-email-stefan@agner.ch>
Message-ID: <2188062.Vg1qCai6yo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 01:12:09 Stefan Agner wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 89c4b5c..fdebe18 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -459,6 +459,18 @@ config ARCH_FOOTBRIDGE
>  	  Support for systems based on the DC21285 companion chip
>  	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
>  
> +menuconfig ARCH_MXCM4
> +	bool "Freescale Vybrid/i.MX family on Cortex-M4" if !MMU
> +	select ARCH_REQUIRE_GPIOLIB
> +	select ARM_CPU_SUSPEND if PM
> +	select CLKSRC_MMIO
> +	select GENERIC_IRQ_CHIP
> +	select PINCTRL
> +	select PM_OPP if PM
> +	select SOC_BUS
> +	help
> +	  Support for Freescale Vybrid/iMX-based family of processors on Cortex-M4
> +
>  config ARCH_NETX
>  	bool "Hilscher NetX based"
>  	select ARM_VIC

I would really prefer not to see any more standalone machine types,
but rather have ARMv7-M as one of the options for the
multiplatform configuration. In particular, that would let us
do *build* testing on a combined mxcm4/efm32/vexpress kernel,
although that kernel would clearly not be usable anywhere
because of the restrictions of nommu machines.

> +static void __init vf610m4_init_irq(void)
> +{
> +	vf610_mscm_init();
> +	irqchip_init();
> +}

Can you make vf610_mscm_init get called from irqchip and remove this
function?

	Arnd
