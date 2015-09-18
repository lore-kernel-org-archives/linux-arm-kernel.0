From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Sep 2015 16:48:43 +0200
Subject: [PATCH] ARM: at91: debug: use DEBUG_UART_PHYS
In-Reply-To: <1439028671-22131-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439028671-22131-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55FC244B.106@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/08/2015 12:11, Alexandre Belloni a ?crit :
> Instead of having to add a new configuration option each time support for
> new SoC is added, use CONFIG_DEBUG_UART_PHYS. For now,
> CONFIG_DEBUG_UART_VIRT is automatically computed.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/Kconfig.debug        | 41 ++++++++++++++++-------------------------
>  arch/arm/include/debug/at91.S | 18 ++++--------------
>  2 files changed, 20 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 946c8c0fa1fb..3ba23d0f5c55 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -123,29 +123,23 @@ choice
>  		    0x80020000      | 0xf0020000     | UART8
>  		    0x80024000      | 0xf0024000     | UART9
>  
> -	config AT91_DEBUG_LL_DBGU0
> -		bool "Kernel low-level debugging on rm9200, 9260/9g20, 9261/9g10, 9rl, 9x5, 9n12"
> -		select DEBUG_AT91_UART
> +	config DEBUG_AT91_UART
> +		bool "Kernel low-level debugging on Atmel SoCs"
>  		depends on ARCH_AT91
> -		depends on SOC_AT91RM9200 || SOC_AT91SAM9
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to the serial port on atmel devices.
>  
> -	config AT91_DEBUG_LL_DBGU1
> -		bool "Kernel low-level debugging on 9263, 9g45 and sama5d3"
> -		select DEBUG_AT91_UART
> -		depends on ARCH_AT91
> -		depends on SOC_AT91SAM9 || SOC_SAMA5
> +		  SOC                  DEBUG_UART_PHYS   DEBUG_UART_VIRT  PORT
> +		  rm9200, 9260/9g20,   0xfffff200        0xfefff200       DBGU
> +		  9261/9g10, 9rl
> +		  9263, 9g45, sama5d3  0xffffee00        0xfeffee00       DBGU
> +		  sama5d4              0xfc00c000        0xfb00c000       USART3
> +		  sama5d4              0xfc069000        0xfb069000       DBGU

This last one must be sama5d3, mustn't it?

Otherwise I'm okay:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> +		  sama5d2              0xf8020000        0xf7020000       UART1
>  
> -	config AT91_DEBUG_LL_DBGU2
> -		bool "Kernel low-level debugging on sama5d4"
> -		select DEBUG_AT91_UART
> -		depends on ARCH_AT91
> -		depends on SOC_SAMA5
> -
> -	config AT91_DEBUG_LL_DBGU3
> -		bool "Kernel low-level debugging on sama5d2"
> -		select DEBUG_AT91_UART
> -		depends on ARCH_AT91
> -		depends on SOC_SAMA5
> +		  Please adjust DEBUG_UART_PHYS configuration options based on
> +		  your needs.
>  
>  	config DEBUG_BCM2835
>  		bool "Kernel low-level debugging on BCM2835 PL011 UART"
> @@ -1242,10 +1236,6 @@ choice
>  
>  endchoice
>  
> -config DEBUG_AT91_UART
> -	bool
> -	depends on ARCH_AT91
> -
>  config DEBUG_EXYNOS_UART
>  	bool
>  
> @@ -1476,7 +1466,8 @@ config DEBUG_UART_PHYS
>  		DEBUG_RMOBILE_SCIFA0 || DEBUG_RMOBILE_SCIFA1 || \
>  		DEBUG_RMOBILE_SCIFA4 || DEBUG_S3C24XX_UART || \
>  		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART || \
> -		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0
> +		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
> +		DEBUG_AT91_UART
>  
>  config DEBUG_UART_VIRT
>  	hex "Virtual base address of debug UART"
> diff --git a/arch/arm/include/debug/at91.S b/arch/arm/include/debug/at91.S
> index 2556a8801c8c..43243be94cfc 100644
> --- a/arch/arm/include/debug/at91.S
> +++ b/arch/arm/include/debug/at91.S
> @@ -9,32 +9,22 @@
>   *
>  */
>  
> -#if defined(CONFIG_AT91_DEBUG_LL_DBGU0)
> -#define AT91_DBGU 0xfffff200 /* AT91_BASE_DBGU0 */
> -#elif defined(CONFIG_AT91_DEBUG_LL_DBGU1)
> -#define AT91_DBGU 0xffffee00 /* AT91_BASE_DBGU1 */
> -#elif defined(CONFIG_AT91_DEBUG_LL_DBGU2)
> -/* On sama5d4, use USART3 as low level serial console */
> -#define AT91_DBGU 0xfc00c000 /* SAMA5D4_BASE_USART3 */
> -#else
> -/* On sama5d2, use UART1 as low level serial console */
> -#define AT91_DBGU 0xf8020000
> -#endif
> -
>  #ifdef CONFIG_MMU
>  #define AT91_IO_P2V(x) ((x) - 0x01000000)
>  #else
>  #define AT91_IO_P2V(x) (x)
>  #endif
>  
> +#define CONFIG_DEBUG_UART_VIRT AT91_IO_P2V(CONFIG_DEBUG_UART_PHYS)
> +
>  #define AT91_DBGU_SR		(0x14)	/* Status Register */
>  #define AT91_DBGU_THR		(0x1c)	/* Transmitter Holding Register */
>  #define AT91_DBGU_TXRDY		(1 << 1)	/* Transmitter Ready */
>  #define AT91_DBGU_TXEMPTY	(1 << 9)	/* Transmitter Empty */
>  
>  	.macro	addruart, rp, rv, tmp
> -	ldr	\rp, =AT91_DBGU				@ System peripherals (phys address)
> -	ldr	\rv, =AT91_IO_P2V(AT91_DBGU)		@ System peripherals (virt address)
> +	ldr	\rp, =CONFIG_DEBUG_UART_PHYS		@ System peripherals (phys address)
> +	ldr	\rv, =CONFIG_DEBUG_UART_VIRT		@ System peripherals (virt address)
>  	.endm
>  
>  	.macro	senduart,rd,rx
> 


-- 
Nicolas Ferre
