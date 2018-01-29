From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jan 2018 23:57:11 +0000
Subject: [PATCH] arch/arm/Kconfig: enable ARM_MODULE_PLTS when LOCKDEP=y
In-Reply-To: <20180129234900.11121-1-anders.roxell@linaro.org>
References: <20180129234900.11121-1-anders.roxell@linaro.org>
Message-ID: <20180129235710.GA9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 12:49:00AM +0100, Anders Roxell wrote:
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

This really doesn't follow IMHO - enabling various features can cause
this, and we're not going to end up stuffing the Kconfig full of these
select statements each time we find a combination of Kconfig symbols
that cause it.

lockdep isn't that special - I can (and do) build kernels with lockdep
enabled, with modules, and I do not run into this problem.  So it's
not as simple as you make out in this commit description.

It's likely that you have either a fairly full kernel configuration (it
must be to place memset() more than 16MB) or you are not placing the
kernel at 0xc0008000 due to memory reservations in the low memory.

> Suggested-by: Arnd Bergmann <arnd@arndb.de>

I guess this was discussed privately with Arnd, since there's no record
of the discussion on the lists - which is even more reason why the
commit message needs to describe better why you need this change.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 51c8df561077..a339157497c6 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -20,6 +20,7 @@ config ARM
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select ARCH_WANT_IPC_PARSE_VERSION
> +	select ARM_MODULE_PLTS if LOCKDEP
>  	select BUILDTIME_EXTABLE_SORT if MMU
>  	select CLONE_BACKWARDS
>  	select CPU_PM if (SUSPEND || CPU_IDLE)
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
