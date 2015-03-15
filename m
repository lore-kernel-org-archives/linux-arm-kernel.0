From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 15 Mar 2015 23:44:49 +0100
Subject: [PATCH 02/10] ARM: zx: add low level debug support
In-Reply-To: <1426333785-3952-3-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-3-git-send-email-jun.nie@linaro.org>
Message-ID: <55060B61.5010500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/03/15 12:49, Jun Nie wrote:
> Use the UART0 peripheral for low level debug. Only the UART port 0 is
> currently supported.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  arch/arm/Kconfig.debug      | 12 ++++++++++++
>  arch/arm/include/debug/zx.S | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 arch/arm/include/debug/zx.S
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 970de75..b2a0e9a 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1169,6 +1169,17 @@ choice
>  		  For more details about semihosting, please see
>  		  chapter 8 of DUI0203I_rvct_developer_guide.pdf from ARM Ltd.
>  
> +	config DEBUG_ZTE_ZX
> +		bool "Use ZTE ZX UART"
> +		depends on ARCH_ZX
> +		help
> +		  Say Y here if you are enabling ZTE ZX296702 SOC and need
> +		  debug uart support.
> +
> +		  This option is preferred over the platform specific
> +		  options; the platform specific options are deprecated
> +		  and will be soon removed.
> +
>  	config DEBUG_LL_UART_8250
>  		bool "Kernel low-level debugging via 8250 UART"
>  		help
> @@ -1315,6 +1326,7 @@ config DEBUG_LL_INCLUDE
>  	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT
>  	default "debug/vf.S" if DEBUG_VF_UART
>  	default "debug/vt8500.S" if DEBUG_VT8500_UART0
> +	default "debug/zx.S" if DEBUG_ZTE_ZX
>  	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
>  	default "debug/bcm63xx.S" if DEBUG_UART_BCM63XX
>  	default "debug/digicolor.S" if DEBUG_DIGICOLOR_UA0
> diff --git a/arch/arm/include/debug/zx.S b/arch/arm/include/debug/zx.S
> new file mode 100644
> index 0000000..aa745ac
> --- /dev/null
> +++ b/arch/arm/include/debug/zx.S
> @@ -0,0 +1,35 @@
> +/*
> + * Debugging macro include header
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#define UART01x_DR              0x04    /* Data read or write */
> +#define UART01x_FR              0x14    /* Flag register (Read only) */
> +
> +#define UART01x_FR_TXFF         0x020
> +
> +
> +#define UART0_PADDR		0x09405000
> +#define UART0_VADDR		0xfc705000

Why don't you use CONFIG_DEBUG_UART_VIRT and CONFIG_DEBUG_UART_PHYS?

> +
> +		.macro	addruart, rp, rv, tmp
> +		ldr	\rp, =UART0_PADDR	@ physical
> +		ldr	\rv, =UART0_VADDR	@ virtual
> +		.endm
> +
> +		.macro	senduart,rd,rx
> +		strb	\rd, [\rx, #UART01x_DR]
> +		.endm
> +
> +		.macro	waituart,rd,rx
> +		.endm
> +
> +		.macro  busyuart,rd,rx
> +1001:		ldr	\rd, [\rx, #UART01x_FR]
> +		tst	\rd, #UART01x_FR_TXFF
> +		bne	1001b
> +		.endm
> 
