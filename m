From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Jan 2018 20:25:06 +0000
Subject: [PATCHv2] arch/arm/Kconfig: default ARM_MODULE_PLTS to 'y'
In-Reply-To: <20180131201911.19253-1-anders.roxell@linaro.org>
References: <20180129234900.11121-1-anders.roxell@linaro.org>
 <20180131201911.19253-1-anders.roxell@linaro.org>
Message-ID: <20180131202506.GI9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 09:19:11PM +0100, Anders Roxell wrote:
> While testing multi_v7_defconfig with LOCKDEP enabled, the kernel
> fails to load simple modules, as reported by kselftest:
> 
> [   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
> 28 out of range (0xbf046044 -> 0xc109f720)
> selftests: printf.sh [FAIL]
> 
> The problem that is seen when LOCKDEP is enabled without
> ARM_MODULE_PLTS, is that LOCKDEP eats so much memory that the top of the
> kernel gets out of reach from the bottom of the module area.

As I've said three times already (and clearly the message still hasn't
sunk in), it does _not_ follow that "enable lockdep" means "lots more
memory used".  We could say the same thing about several other kernel
options as well.  Please remove this from your commit message.

<exasperation@seemingly being ignored on this point>

Maybe you'd like to send your configuration file so we can see how much
is enabled in your kernel.  At that point I'll make a decision, but
until then, I'm not going to say that even what I suggested is an
acceptable way forward.

> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 51c8df561077..8014c8c322df 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1702,6 +1702,7 @@ config ARCH_WANT_GENERAL_HUGETLB
>  config ARM_MODULE_PLTS
>  	bool "Use PLTs to allow module memory to spill over into vmalloc area"
>  	depends on MODULES
> +	default y
>  	help
>  	  Allocate PLTs when loading modules so that jumps and calls whose
>  	  targets are too far away for their relative offsets to be encoded
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
