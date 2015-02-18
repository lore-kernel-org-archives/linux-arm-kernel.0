From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Feb 2015 12:23:40 -0500 (EST)
Subject: [PATCH] ARM: bL_switcher: add GIC dependency
In-Reply-To: <13974795.LDi5KKMcsa@wuerfel>
References: <13974795.LDi5KKMcsa@wuerfel>
Message-ID: <alpine.LFD.2.11.1502181222290.22104@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Feb 2015, Arnd Bergmann wrote:

> It is not possible to build the bL_switcher code if the GIC
> driver is disabled, because it relies on calling into some
> gic specific interfaces, and that would result in this build
> error:
> 
> arch/arm/common/built-in.o: In function `bL_switch_to':
> :(.text+0x1230): undefined reference to `gic_get_sgir_physaddr'
> :(.text+0x1244): undefined reference to `gic_send_sgi'
> :(.text+0x1268): undefined reference to `gic_migrate_target'
> arch/arm/common/built-in.o: In function `bL_switcher_enable.part.4':
> :(.text.unlikely+0x2f8): undefined reference to `gic_get_cpu_id'
> 
> This adds a Kconfig dependency to ensure we only build the big-little
> switcher if the GIC driver is present as well.
> 
> Almost all ARMv7 platforms come with a GIC anyway, but it is possible
> to build a kernel that disables all platforms.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <nico@linaro.org>

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4b68867641f9..6aa2a766be66 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1420,7 +1420,7 @@ config BIG_LITTLE
>  
>  config BL_SWITCHER
>  	bool "big.LITTLE switcher support"
> -	depends on BIG_LITTLE && MCPM && HOTPLUG_CPU
> +	depends on BIG_LITTLE && MCPM && HOTPLUG_CPU && ARM_GIC
>  	select ARM_CPU_SUSPEND
>  	select CPU_PM
>  	help
> 
> 
