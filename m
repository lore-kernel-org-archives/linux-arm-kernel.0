From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 1 Mar 2016 09:56:24 +0100
Subject: [PATCH] ARM: at91: avoid defining CONFIG_* symbols in source code
In-Reply-To: <1456238384-882646-1-git-send-email-arnd@arndb.de>
References: <1456238384-882646-1-git-send-email-arnd@arndb.de>
Message-ID: <20160301085624.GD2627@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/02/2016 at 15:39:38 +0100, Arnd Bergmann wrote :
> In an invalid randconfig build (fixed by another patch),
> I ran across this warning:
> 
> arch/arm/include/debug/at91.S:18:0: error: "CONFIG_DEBUG_UART_VIRT" redefined [-Werror]
>  #define CONFIG_DEBUG_UART_VIRT AT91_IO_P2V(CONFIG_DEBUG_UART_PHYS)
> 
> As Russell pointed out, we should never #define a macro starting
> with CONFIG_ in a source file, as that is rather confusing.
> 
> This renames the macro to avoid the symbol clash.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Russell King <linux@arm.linux.org.uk>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/include/debug/at91.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/debug/at91.S b/arch/arm/include/debug/at91.S
> index 43243be94cfc..d4ae3b8e2426 100644
> --- a/arch/arm/include/debug/at91.S
> +++ b/arch/arm/include/debug/at91.S
> @@ -15,7 +15,7 @@
>  #define AT91_IO_P2V(x) (x)
>  #endif
>  
> -#define CONFIG_DEBUG_UART_VIRT AT91_IO_P2V(CONFIG_DEBUG_UART_PHYS)
> +#define AT91_DEBUG_UART_VIRT AT91_IO_P2V(CONFIG_DEBUG_UART_PHYS)
>  
>  #define AT91_DBGU_SR		(0x14)	/* Status Register */
>  #define AT91_DBGU_THR		(0x1c)	/* Transmitter Holding Register */
> @@ -24,7 +24,7 @@
>  
>  	.macro	addruart, rp, rv, tmp
>  	ldr	\rp, =CONFIG_DEBUG_UART_PHYS		@ System peripherals (phys address)
> -	ldr	\rv, =CONFIG_DEBUG_UART_VIRT		@ System peripherals (virt address)
> +	ldr	\rv, =AT91_DEBUG_UART_VIRT		@ System peripherals (virt address)
>  	.endm
>  
>  	.macro	senduart,rd,rx
> -- 
> 2.7.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
