From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 2 Mar 2016 16:46:35 +0100
Subject: [PATCH] ARM: at91: avoid defining CONFIG_* symbols in source code
In-Reply-To: <1456238384-882646-1-git-send-email-arnd@arndb.de>
References: <1456238384-882646-1-git-send-email-arnd@arndb.de>
Message-ID: <56D70ADB.2050008@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/02/2016 15:39, Arnd Bergmann a ?crit :
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

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Arnd,

Can you please add this patch on top of the arm-soc branches "soc" or
"cleanup" for 4.6.
I don't think that we will have more material for these branches to send
to you before the opening of the merge window.

Thanks for your patch, bye.


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
> 


-- 
Nicolas Ferre
