From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 06 Dec 2015 13:33:20 +0200
Subject: [PATCH 07/10] ARM: debug-ll: rework lpc32xx handling
In-Reply-To: <1449268242-808553-8-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
 <1449268242-808553-8-git-send-email-arnd@arndb.de>
Message-ID: <56641D00.40309@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.12.2015 00:30, Arnd Bergmann wrote:
> LPC32xx can not yet be configured in a multiplatform kernel, but
> if we ever get there, enabling one of the LPC32xx platforms
> while trying to use DEBUG_LL for another platform can default to
> the wrong UART address, as the options are purely based on the
> architecture being enabled or not.
> 
> This changes the logic to use the LPC32xx default addresses only
> if we have also picked the respective Kconfig symbols introduced
> here.
> 
> While we're at it, this also reorders the virtual address as
> it should be.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig.debug | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index b35392417378..9836d428a65d 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -480,6 +480,14 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on NXP LPC18xx/43xx UART0.
>  
> +	config DEBUG_LPC32XX
> +		bool "Kernel low-level debugging messages via NXP LPC32xx UART"
> +		depends on ARCH_LPC32XX
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on NXP LPC32xx based platforms.
> +
>  	config DEBUG_MESON_UARTAO
>  		bool "Kernel low-level debugging via Meson6 UARTAO"
>  		depends on ARCH_MESON
> @@ -1425,7 +1433,7 @@ config DEBUG_UART_PL01X
>  config DEBUG_UART_8250
>  	def_bool ARCH_EBSA110 || (FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
>  		ARCH_IOP13XX || ARCH_IOP32X || ARCH_IOP33X || ARCH_IXP4XX || \
> -		ARCH_LPC32XX || ARCH_RPC
> +		ARCH_RPC
>  
>  # Compatibility options for BCM63xx
>  config DEBUG_UART_BCM63XX
> @@ -1468,7 +1476,7 @@ config DEBUG_UART_PHYS
>  	default 0x3e000000 if DEBUG_BCM_KONA_UART
>  	default 0x4000e400 if DEBUG_LL_UART_EFM32
>  	default 0x40081000 if DEBUG_LPC18XX_UART0
> -	default 0x40090000 if ARCH_LPC32XX
> +	default 0x40090000 if DEBUG_LPC32XX
>  	default 0x40100000 if DEBUG_PXA_UART1
>  	default 0x42000000 if DEBUG_GEMINI
>  	default 0x50000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
> @@ -1562,9 +1570,9 @@ config DEBUG_UART_VIRT
>  	default 0xf1c28000 if DEBUG_SUNXI_UART0
>  	default 0xf1c28400 if DEBUG_SUNXI_UART1
>  	default 0xf1f02800 if DEBUG_SUNXI_R_UART
> +	default 0xf4090000 if DEBUG_LPC32XX
>  	default 0xf4200000 if DEBUG_GEMINI
>  	default 0xf6200000 if DEBUG_PXA_UART1
> -	default 0xf4090000 if ARCH_LPC32XX
>  	default 0xf7000000 if DEBUG_SUN9I_UART0
>  	default 0xf7000000 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART0
>  	default 0xf7000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
> 

For LPC32xx change:

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
