From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 Jun 2016 14:02:16 +0200
Subject: [PATCH] ARM: at91: debug: add default DEBUG_LL addresses
In-Reply-To: <1465386548-9757-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465386548-9757-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <575AAC48.30401@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/06/2016 13:49, Alexandre Belloni a ?crit :
> Add configuration options for the most commonly used UART physical and
> virtual addresses to ease the use of DEBUG_LL and earlyprintk.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks! It will certainly be easier with this.

Bye,

> ---
>  arch/arm/Kconfig.debug | 58 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 2609491f4ab1..ba4003e687ac 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -109,23 +109,41 @@ choice
>  		    0x80020000      | 0xf0020000     | UART8
>  		    0x80024000      | 0xf0024000     | UART9
>  
> -	config DEBUG_AT91_UART
> -		bool "Kernel low-level debugging on Atmel SoCs"
> -		depends on ARCH_AT91
> +	config DEBUG_AT91_RM9200_DBGU
> +		bool "Kernel low-level debugging on AT91RM9200, AT91SAM9 DBGU"
> +		select DEBUG_AT91_UART
> +		depends on SOC_AT91RM9200 || SOC_AT91SAM9
>  		help
> -		  Say Y here if you want the debug print routines to direct
> -		  their output to the serial port on atmel devices.
> +		  Say Y here if you want kernel low-level debugging support
> +		  on the DBGU port of:
> +		    at91rm9200, at91sam9260, at91sam9g20, at91sam9261,
> +		    at91sam9g10, at91sam9n12, at91sam9rl64, at91sam9x5
>  
> -		  SOC                  DEBUG_UART_PHYS   DEBUG_UART_VIRT  PORT
> -		  rm9200, 9260/9g20,   0xfffff200        0xf8fff200       DBGU
> -		  9261/9g10, 9rl
> -		  9263, 9g45, sama5d3  0xffffee00        0xf8ffee00       DBGU
> -		  sama5d4              0xfc00c000        0xfb00c000       USART3
> -		  sama5d4              0xfc069000        0xfb069000       DBGU
> -		  sama5d2              0xf8020000        0xf7020000       UART1
> +	config DEBUG_AT91_SAM9263_DBGU
> +		bool "Kernel low-level debugging on AT91SAM{9263,9G45,A5D3} DBGU"
> +		select DEBUG_AT91_UART
> +		depends on SOC_AT91SAM9 || SOC_SAMA5D3
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on the DBGU port of:
> +		    at91sam9263, at91sam9g45, at91sam9m10,
> +		    sama5d3
>  
> -		  Please adjust DEBUG_UART_PHYS and DEBUG_UART_VIRT
> -		  configuration options based on your needs.
> +	config DEBUG_AT91_SAMA5D2_UART1
> +		bool "Kernel low-level debugging on SAMA5D2 UART1"
> +		select DEBUG_AT91_UART
> +		depends on SOC_SAMA5D2
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on the UART1 port of sama5d2.
> +
> +	config DEBUG_AT91_SAMA5D4_USART3
> +		bool "Kernel low-level debugging on SAMA5D4 USART3"
> +		select DEBUG_AT91_UART
> +		depends on SOC_SAMA5D4
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on the USART3 port of sama5d4.
>  
>  	config DEBUG_BCM2835
>  		bool "Kernel low-level debugging on BCM2835 PL011 UART"
> @@ -1296,6 +1314,10 @@ choice
>  
>  endchoice
>  
> +config DEBUG_AT91_UART
> +	bool
> +	depends on ARCH_AT91
> +
>  config DEBUG_EXYNOS_UART
>  	bool
>  
> @@ -1502,8 +1524,10 @@ config DEBUG_UART_PHYS
>  	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
>  	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
>  	default 0xf7fc9000 if DEBUG_BERLIN_UART
> +	default 0xf8020000 if DEBUG_AT91_SAMA5D2_UART1
>  	default 0xf8b00000 if DEBUG_HIX5HD2_UART
>  	default 0xf991e000 if DEBUG_QCOM_UARTDM
> +	default 0xfc00c000 if DEBUG_AT91_SAMA5D4_USART3
>  	default 0xfcb00000 if DEBUG_HI3620_UART
>  	default 0xfd883000 if DEBUG_ALPINE_UART0
>  	default 0xfe800000 if ARCH_IOP32X
> @@ -1518,6 +1542,8 @@ config DEBUG_UART_PHYS
>  	default 0xfffb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
>  	default 0xfffb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
>  	default 0xfffe8600 if DEBUG_BCM63XX_UART
> +	default 0xffffee00 if DEBUG_AT91_SAM9263_DBGU
> +	default 0xfffff200 if DEBUG_AT91_RM9200_DBGU
>  	default 0xfffff700 if ARCH_IOP33X
>  	depends on ARCH_EP93XX || \
>  	        DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
> @@ -1566,13 +1592,17 @@ config DEBUG_UART_VIRT
>  				DEBUG_S3C2410_UART1)
>  	default 0xf7008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
>  				DEBUG_S3C2410_UART2)
> +	default 0xf7020000 if DEBUG_AT91_SAMA5D2_UART1
>  	default 0xf7fc9000 if DEBUG_BERLIN_UART
>  	default 0xf8007000 if DEBUG_HIP04_UART
>  	default 0xf8009000 if DEBUG_VEXPRESS_UART0_CA9
>  	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
> +	default 0xf8ffee00 if DEBUG_AT91_SAM9263_DBGU
> +	default 0xf8fff200 if DEBUG_AT91_RM9200_DBGU
>  	default 0xfa71e000 if DEBUG_QCOM_UARTDM
>  	default 0xfb002000 if DEBUG_CNS3XXX
>  	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
> +	default 0xfb00c000 if DEBUG_AT91_SAMA5D4_USART3
>  	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
>  	default 0xfc40ab00 if DEBUG_BRCMSTB_UART
>  	default 0xfc705000 if DEBUG_ZTE_ZX
> 


-- 
Nicolas Ferre
