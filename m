From: khiem.nguyen.xt@renesas.com (Khiem Nguyen)
Date: Fri, 03 Oct 2014 09:04:29 +0900
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
Message-ID: <542DE80D.2000600@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 10/3/2014 4:02 AM, Geert Uytterhoeven wrote:
> Add serial port debug macros for the SCIF(A) serial ports.
> This includes all shmobile SoCs, except for EMEV2.
> 
> On SoCs using the legacy machine_desc.map_io(), an identity mapping of
> the SCIF(A) registers must be set up in .map_io(). On all but r8a7779
> this was already done.
> 
> On other SoCs, debug_ll_io_init() maps the SCIF(A) registers to a fixed
> virtual address. 0xfdxxxxxx was chosen, as it should lie below
> VMALLOC_END = 0xff000000, and must not conflict with the 2 MiB reserved
> region at PCI_IO_VIRT_BASE = 0xfee00000.
> 
> This was derived from the r8a7790 version by Laurent Pinchart.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on r8a7791/koelsch and r8a7740/armadillo.
> Testing on other platforms would be highly appreciated.

Uhm..., I have tried to test your patch with devel branch/renesas repo.
1. CONFIG_DEBUG_SCIF is enabled in shmobile_defconfig.
2. *Need to configure* CONFIG_DEBUG_UART_PHYS for lager/koelsch
since 0xe6c50000 (for ARCH_R8A7740) will be selected by default.

Diff of config changed:
-# CONFIG_DEBUG_LL is not set
-CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
+CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_SCIF=y
+# CONFIG_DEBUG_ICEDCC is not set
+# CONFIG_DEBUG_SEMIHOSTING is not set
+# CONFIG_DEBUG_LL_UART_8250 is not set
+# CONFIG_DEBUG_LL_UART_PL01X is not set
+CONFIG_DEBUG_LL_INCLUDE="debug/scif.S"
 # CONFIG_DEBUG_UART_PL01X is not set
 # CONFIG_DEBUG_UART_8250 is not set
+CONFIG_DEBUG_UART_PHYS=0xe6e60000
+CONFIG_DEBUG_UNCOMPRESS=y
 CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
+# CONFIG_EARLY_PRINTK is not set
 # CONFIG_PID_IN_CONTEXTIDR is not set

3. Boot up in lager/koelsch, kernel log output
to "booting the kernel" then ... nothing else.

Starting kernel ...

Uncompressing Linux... done, booting the kernel.


Could you let me know your test procedure ?

> 
> Notes:
>   - On armadillo-multiplatform there may be a period while garbage data
>     is output.
>     This happens because sh_mobile_i2c_init() enables and disables its
>     clock during probing. As iic0 and scifa1 share the same parent
>     clock, this causes the scifa1 clock to no longer receive clock
>     ticks.
>     On armadillo-legacy, this is mitigated by the pre-CCF clock driver,
>     which never really disables clocks during boot-up for exactly this
>     reason. Cfr. "One example of this is the handling of the Mackerel
>     serial console output that shares clock with the I2C controller.",
>     in commit 794d78fea51504ba ("drivers: sh: late disabling of clocks
>     V2").
>     I'm wondering whether this can be fixed in the i2c driver? Does it
>     really have to enable and disable the clock?
> 
>   - While the serial console on r8a7790 was switched from SCIF0 to
>     SCIFA0 recently, I believe r8a7990 still needs to use SCIF0 instead
>     of SCIFA0, as that's what the bootloader has configured.
> ---
>  arch/arm/Kconfig.debug                 | 20 +++++++++++-
>  arch/arm/include/debug/scif.S          | 60 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/setup-r8a7779.c |  7 ++++
>  3 files changed, 86 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/include/debug/scif.S
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index b11ad54f8d17fa6b..58ace40b30938e58 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -699,6 +699,14 @@ choice
>  		  their output to UART 2. The port must have been initialised
>  		  by the boot-loader before use.
>  
> +	config DEBUG_SCIF
> +		bool "Kernel low-level debugging messages via SCIF(A) on Renesas ARM SoCs"
> +		depends on ARCH_R7S72100 || ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || ARCH_RMOBILE
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on Renesas ARM based platforms using SCIF(A) serial ports
> +		  (SH-Mobile, R-Mobile, RZ/A1H, R-Car Gen1, R-Car Gen2).
> +
>  	config DEBUG_SOCFPGA_UART
>  		depends on ARCH_SOCFPGA
>  		bool "Use SOCFPGA UART for low-level debug"
> @@ -1028,6 +1036,7 @@ config DEBUG_LL_INCLUDE
>  				 DEBUG_IMX6SX_UART
>  	default "debug/msm.S" if DEBUG_MSM_UART || DEBUG_QCOM_UARTDM
>  	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
> +	default "debug/scif.S" if DEBUG_SCIF
>  	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART
>  	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
>  	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
> @@ -1109,6 +1118,12 @@ config DEBUG_UART_PHYS
>  	default 0xd4017000 if DEBUG_MMP_UART2
>  	default 0xd4018000 if DEBUG_MMP_UART3
>  	default 0xe0000000 if ARCH_SPEAR13XX
> +	default 0xe6c40000 if DEBUG_SCIF && (ARCH_R8A73A4 || ARCH_SH7372)
> +	default 0xe6c50000 if DEBUG_SCIF && ARCH_R8A7740
> +	default 0xe6c80000 if DEBUG_SCIF && ARCH_SH73A0
> +	default 0xe6e58000 if DEBUG_SCIF && ARCH_R8A7794
> +	default 0xe6e60000 if DEBUG_SCIF && (ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7793)
> +	default 0xe8008000 if DEBUG_SCIF && ARCH_R7S72100
>  	default 0xf0000be0 if ARCH_EBSA110
>  	default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
>  	default 0xf1012000 if ARCH_DOVE || ARCH_MV78XX0 || \
> @@ -1121,12 +1136,15 @@ config DEBUG_UART_PHYS
>  	default 0xff690000 if DEBUG_RK32_UART2
>  	default 0xffc02000 if DEBUG_SOCFPGA_UART
>  	default 0xffd82340 if ARCH_IOP13XX
> +	default 0xffe40000 if DEBUG_SCIF && ARCH_R8A7778
> +	default 0xffe42000 if DEBUG_SCIF && ARCH_R8A7779
>  	default 0xfff36000 if DEBUG_HIGHBANK_UART
>  	default 0xfffff700 if ARCH_IOP33X
>  	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>  		DEBUG_LL_UART_EFM32 || \
>  		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
> -		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART
> +		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
> +		DEBUG_SCIF
>  
>  config DEBUG_UART_VIRT
>  	hex "Virtual base address of debug UART"
> diff --git a/arch/arm/include/debug/scif.S b/arch/arm/include/debug/scif.S
> new file mode 100644
> index 0000000000000000..9c9b9b2c17f97b4a
> --- /dev/null
> +++ b/arch/arm/include/debug/scif.S
> @@ -0,0 +1,60 @@
> +/*
> + * Renesas SCIF(A) debugging macro include header
> + *
> + * Based on r8a7790.S
> + *
> + * Copyright (C) 2012-2013 Renesas Electronics Corporation
> + * Copyright (C) 1994-1999 Russell King
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#if CONFIG_DEBUG_UART_PHYS < 0xe6e00000
> +/* SCIFA */
> +#define FTDR		0x20
> +#define FSR		0x14
> +#else
> +/* SCIF */
> +#define FTDR		0x0c
> +#define FSR		0x10
> +#endif
> +
> +#define SCIF_PHYS	CONFIG_DEBUG_UART_PHYS
> +
> +#if defined(CONFIG_ARCH_R8A7740) || defined(CONFIG_ARCH_R8A7779) || \
> +    defined(CONFIG_ARCH_SH7372) || defined(CONFIG_ARCH_SH73A0)
> +/* Legacy machine_desc.map_io() sets up an identity mapping for us */
> +#define SCIF_VIRT	SCIF_PHYS
> +#else
> +/* Relying on debug_ll_io_init(), so we have to select a free gap ourselves */
> +#define SCIF_VIRT	((SCIF_PHYS & 0x00ffffff) | 0xfd000000)
> +#endif
> +
> +#define TDFE	(1 << 5)
> +#define TEND	(1 << 6)
> +
> +	.macro	addruart, rp, rv, tmp
> +	ldr	\rp, =SCIF_PHYS
> +	ldr	\rv, =SCIF_VIRT
> +	.endm
> +
> +	.macro	waituart, rd, rx
> +1001:	ldrh	\rd, [\rx, #FSR]
> +	tst	\rd, #TDFE
> +	beq	1001b
> +	.endm
> +
> +	.macro	senduart, rd, rx
> +	strb	\rd, [\rx, #FTDR]
> +	ldrh	\rd, [\rx, #FSR]
> +	bic	\rd, \rd, #TEND
> +	strh	\rd, [\rx, #FSR]
> +	.endm
> +
> +	.macro	busyuart, rd, rx
> +1001:	ldrh	\rd, [\rx, #FSR]
> +	tst	\rd, #TEND
> +	beq	1001b
> +	.endm
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index 136078ab9407cc2d..24c49f7121d69d28 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -66,6 +66,13 @@ static struct map_desc r8a7779_io_desc[] __initdata = {
>  		.length		= SZ_16M,
>  		.type		= MT_DEVICE_NONSHARED
>  	},
> +	/* 64K entity map for 0xffe40000 (SCIF0/1) */
> +	{
> +		.virtual	= 0xffe40000,
> +		.pfn		= __phys_to_pfn(0xffe40000),
> +		.length		= SZ_64K,
> +		.type		= MT_DEVICE_NONSHARED
> +	},
>  };
>  
>  void __init r8a7779_map_io(void)
> 

-- 
Best regards,
KHIEM Nguyen
