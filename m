From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 11 Dec 2017 10:28:15 +0100
Subject: [PATCH] ARM: debug: add stm32 low-level debug support
In-Reply-To: <1512394376-25962-1-git-send-email-ludovic.Barre@st.com>
References: <1512394376-25962-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <852f496f-b4eb-2a13-d234-bd86261d0e1a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2017 14:32, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This adds low-level debug support on USART1 for STM32F4
> and STM32F7. Compiled via 'CONFIG_DEBUG_LL' and 'CONFIG_EARLY_PRINTK'.
> Enabled via 'earlyprintk' in bootargs.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>

Hi Ludovic,

Please also add your sign-off here.

Neil

> ---
>  arch/arm/Kconfig.debug         | 25 +++++++++++++++++++++++++
>  arch/arm/include/debug/stm32.S | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 arch/arm/include/debug/stm32.S
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 17685e1..9469c58 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1140,6 +1140,26 @@ choice
>  
>  		  If unsure, say N.
>  
> +	config STM32F4_DEBUG_UART
> +		bool "Use STM32F4 UART for low-level debug"
> +		depends on ARCH_STM32
> +		select DEBUG_STM32_UART
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on STM32 based platforms.
> +
> +		  If unsure, say N.
> +
> +	config STM32F7_DEBUG_UART
> +		bool "Use STM32F7 UART for low-level debug"
> +		depends on ARCH_STM32
> +		select DEBUG_STM32_UART
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on STM32 based platforms.
> +
> +		  If unsure, say N.
> +
>  	config TEGRA_DEBUG_UART_AUTO_ODMDATA
>  		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
>  		depends on ARCH_TEGRA
> @@ -1424,6 +1444,10 @@ config DEBUG_STI_UART
>  	bool
>  	depends on ARCH_STI
>  
> +config DEBUG_STM32_UART
> +	bool
> +	depends on ARCH_STM32
> +
>  config DEBUG_SIRFSOC_UART
>  	bool
>  	depends on ARCH_SIRF
> @@ -1472,6 +1496,7 @@ config DEBUG_LL_INCLUDE
>  	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
>  	default "debug/sirf.S" if DEBUG_SIRFSOC_UART
>  	default "debug/sti.S" if DEBUG_STI_UART
> +	default "debug/stm32.S" if DEBUG_STM32_UART
>  	default "debug/tegra.S" if DEBUG_TEGRA_UART
>  	default "debug/ux500.S" if DEBUG_UX500_UART
>  	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT
> diff --git a/arch/arm/include/debug/stm32.S b/arch/arm/include/debug/stm32.S
> new file mode 100644
> index 0000000..4015257
> --- /dev/null
> +++ b/arch/arm/include/debug/stm32.S
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author: Gerald Baeza <gerald_baeza@st.com>
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#define STM32_UART_BASE			0x40011000	/* USART1 */
> +
> +#ifdef CONFIG_STM32F4_DEBUG_UART
> +#define STM32_USART_SR_OFF		0x00
> +#define STM32_USART_TDR_OFF		0x04
> +#endif
> +
> +#ifdef CONFIG_STM32F7_DEBUG_UART
> +#define STM32_USART_SR_OFF		0x1C
> +#define STM32_USART_TDR_OFF		0x28
> +#endif
> +
> +#define STM32_USART_TC			(1 << 6)	/* Tx complete       */
> +#define STM32_USART_TXE			(1 << 7)	/* Tx data reg empty */
> +
> +		.macro	addruart, rp, rv, tmp
> +		ldr	\rp,      =STM32_UART_BASE	@ physical base
> +		ldr	\rv,      =STM32_UART_BASE      @ virt base /* NoMMU */
> +		.endm
> +
> +                .macro  senduart,rd,rx
> +                strb    \rd, [\rx, #STM32_USART_TDR_OFF]
> +                .endm
> +
> +                .macro  waituart,rd,rx
> +1001:	ldr	\rd, [\rx, #(STM32_USART_SR_OFF)]	@ Read Status Register
> +	tst	\rd, #STM32_USART_TXE			@ TXE = 1 = tx empty
> +	beq	1001b
> +                .endm
> +
> +                .macro  busyuart,rd,rx
> +1001:	ldr	\rd, [\rx, #(STM32_USART_SR_OFF)]	@ Read Status Register
> +	tst	\rd, #STM32_USART_TC			@ TC = 1 = tx complete
> +	beq	1001b
> +                .endm
> 
