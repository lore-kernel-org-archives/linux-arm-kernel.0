From: nbowler@elliptictech.com (Nick Bowler)
Date: Wed, 24 Oct 2012 09:32:32 -0400
Subject: [PATCH v3 3/5] zynq: remove use of CLKDEV_LOOKUP
In-Reply-To: <20121024003442.GD31625@beefymiracle.amer.corp.natinst.com>
References: <20121024003218.GA31625@beefymiracle.amer.corp.natinst.com>
 <20121024003442.GD31625@beefymiracle.amer.corp.natinst.com>
Message-ID: <20121024133231.GA28661@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-10-23 19:34 -0500, Josh Cartwright wrote:
> The Zynq support in mainline does not (yet) make use of any of the
> generic clk or clk lookup functionality.  Remove what is upstream for
> now, until the out-of-tree implementation is in suitable form for
> merging.
> 
> An important side effect of this patch is that it allows the building of
> a Zynq kernel without running into unresolved symbol problems:
> 
>    drivers/built-in.o: In function `amba_get_enable_pclk':
>    clkdev.c:(.text+0x444): undefined reference to `clk_enable'

For the record, I think this was introduced by commit 56a34b03ff427
("ARM: versatile: Make plat-versatile clock optional") which forgot to
select PLAT_VERSATILE_CLOCK on Zynq.  This is not all that surprising,
because the fact that Zynq "uses" PLAT_VERSATILE is secretly hidden in
the Makefile.

Nevertheless, the only feature from versatile that Zynq needed was the
clock support, so this patch should *also* delete the secret use of
plat-versatile by removing this line from arch/arm/Makefile:

  plat-$(CONFIG_ARCH_ZYNQ)	+= versatile

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cce4f8d..de70d99 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -946,7 +946,6 @@ config ARCH_ZYNQ
>  	bool "Xilinx Zynq ARM Cortex A9 Platform"
>  	select ARM_AMBA
>  	select ARM_GIC
> -	select CLKDEV_LOOKUP
>  	select CPU_V7
>  	select GENERIC_CLOCKEVENTS
>  	select ICST

I'd prefer if we just added "select COMMON_CLK" instead of removing this
so we don't have to re-add this later, but I guess it doesn't really
matter either way.

Cheers,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
