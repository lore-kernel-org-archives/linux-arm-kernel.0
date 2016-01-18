From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 18 Jan 2016 09:41:17 -0800
Subject: [PATCH] ARM: debug-ll: fix BCM63xx entry for multiplatform
In-Reply-To: <5641204.G6RtGs3Kji@wuerfel>
References: <5641204.G6RtGs3Kji@wuerfel>
Message-ID: <569D23BD.9050506@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/16 01:51, Arnd Bergmann wrote:
> During my randconfig build testing, I found that a kernel with
> DEBUG_AT91_UART and ARCH_BCM_63XX fails to build:
> 
> arch/arm/include/debug/at91.S:18:0: error: "CONFIG_DEBUG_UART_VIRT" redefined [-Werror]
> 
> It turns out that the DEBUG_UART_BCM63XX option is enabled whenever
> the ARCH_BCM_63XX is, and that breaks multiplatform kernels because
> we then end up using the UART address from BCM63XX rather than the
> one we actually configured (if any).
> 
> This changes the BCM63XX options to only have one Kconfig option,
> and only enable that if the user explicitly turns it on.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b51312bebfa4 ("ARM: BCM63XX: add low-level UART debug support")
> Cc: stable at vger.kernel.org
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index c57cbb7e8179..4a2c6a3bc90a 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -153,10 +153,10 @@ choice
>  		  mobile SoCs in the Kona family of chips (e.g. bcm28155,
>  		  bcm11351, etc...)
>  
> -	config DEBUG_BCM63XX
> +	config DEBUG_BCM63XX_UART
>  		bool "Kernel low-level debugging on BCM63XX UART"
>  		depends on ARCH_BCM_63XX
> -		select DEBUG_UART_BCM63XX
> +		help		  

What's with the empty help message (and lots of trailing whitespace)?

>  
>  	config DEBUG_BERLIN_UART
>  		bool "Marvell Berlin SoC Debug UART"


-- 
~Randy
