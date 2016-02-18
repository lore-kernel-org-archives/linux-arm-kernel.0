From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Feb 2016 11:06:08 -0500 (EST)
Subject: [PATCH 1/9] ARM: ARMv7-M uses BE-8, not BE-32
In-Reply-To: <1455804123-2526139-2-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-2-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1602181102570.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016, Arnd Bergmann wrote:

> When configuring the kernel for big-endian, we set either BE-8 or BE-32
> based on the CPU architecture level. Until linux-4.4, we did not have
> any ARMv7-M platform allowing big-endian builds, but now i.MX/Vybrid
> is in that category, adn we get a build error because of this:
> 
> arch/arm/kernel/module-plts.c: In function 'get_module_plt':
> arch/arm/kernel/module-plts.c:60:46: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]
> 
> This comes down to picking the wrong default, ARMv7-M uses BE8
> like ARMv7-A does. Changing the default gets the kernel to compile
> and presumably works.

Was it tested without BE8 when it was submitted upstream? I don't think 
you can switch this freely on a given hardware platform and expect it to 
still work.




> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 55347662e5ed..ff1637365494 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -723,7 +723,7 @@ config CPU_BIG_ENDIAN
>  config CPU_ENDIAN_BE8
>  	bool
>  	depends on CPU_BIG_ENDIAN
> -	default CPU_V6 || CPU_V6K || CPU_V7
> +	default CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
>  	help
>  	  Support for the BE-8 (big-endian) mode on ARMv6 and ARMv7 processors.
>  
> -- 
> 2.7.0
> 
> 
