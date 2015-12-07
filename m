From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 7 Dec 2015 13:13:27 +0000
Subject: [PATCH 02/10] ARM: debug-ll: reorganize mvebu debug uart config
In-Reply-To: <1449268242-808553-3-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
 <1449268242-808553-3-git-send-email-arnd@arndb.de>
Message-ID: <566585F7.4020606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/15 22:30, Arnd Bergmann wrote:
> As we are moving dove/mv78xx0/orion into multiplatform, the debug-ll
> configuration options for these platforms are conflicting with the
> multiplatform configuration: enabling one of those platforms sometimes
> changes the default addresses to the ones used on one of them, rather
> than the one that was selected in Kconfig.
>
> This changes the configuration so we share the physical address
> configuration with mach-mvebu.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/Kconfig.debug | 32 +++++++++++++++++++-------------
>   1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 50ae573e6cba..8258f9dd1f77 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -499,6 +499,7 @@ choice
>   	config DEBUG_MVEBU_UART0
>   		bool "Kernel low-level debugging messages via MVEBU UART0 (old bootloaders)"
>   		depends on ARCH_MVEBU
> +		depends on ARCH_MVEBU && CPU_V7
>   		select DEBUG_UART_8250
>   		help
>   		  Say Y here if you want kernel low-level debugging support
> @@ -511,17 +512,23 @@ choice
>   		  Plathome OpenBlocks AX3, when using the original
>   		  bootloader.
>
> +		  This option will not work on older Marvell platforms
> +		  (Kirkwood, Dove, MV78xx0, Orion5x), which should  piock
> +		  the "new bootloader" variant.
> +

s/piock/pick/
