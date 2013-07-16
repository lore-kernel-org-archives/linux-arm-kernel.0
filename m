From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 16 Jul 2013 14:38:48 -0400
Subject: [PATCH RFC v2 04/14] ARM: debug: provide 8250 debug uart register
 shift configuration option
In-Reply-To: <E1Uz8FU-00047a-AB@rmk-PC.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <E1Uz8FU-00047a-AB@rmk-PC.arm.linux.org.uk>
Message-ID: <51E59338.6020102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 July 2013 12:37 PM, Russell King wrote:
> Move the definition of the UART register shift out of the platform
> specific header file into the Kconfig files.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
[..]

> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 07ff149..5b44881 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -275,6 +275,7 @@ choice

[..]
> @@ -857,8 +872,17 @@ config DEBUG_LL_INCLUDE
>  	default "mach/debug-macro.S"
>  
>  config DEBUG_UART_8250
> -	def_bool ARCH_EBSA110 || (FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
> -		ARCH_GEMINI || ARCH_RPC
> +	def_bool ARCH_DOVE || ARCH_EBSA110 || \
> +		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
> +		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
> +		ARCH_IOP33X || ARCH_IXP4XX || ARCH_KIRKWOOD || \
> +		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
> +
> +config DEBUG_UART_8250_SHIFT
> +	int "Register offset shift for the 8250 debug UART"
> +	depends on DEBUG_UART_8250
> +	default 0 if FOOTBRIDGE || ARCH_IOP32X
> +	default 2
>  
Just a question. Exposing selection choice for UART port
and probably flow control is just fine, but do we need to
really need config entries for SHIFT, PA, VA etc ?

Regards,
Santosh
