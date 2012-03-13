From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 10:10:42 +0000
Subject: [PATCH 4/7 v4] ARM: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <0032addd7e94c5d4d1a3a0be77fe79bcffee53db.1331601448.git.jason@lakedaemon.net>
References: <cover.1331601448.git.jason@lakedaemon.net>
 <0032addd7e94c5d4d1a3a0be77fe79bcffee53db.1331601448.git.jason@lakedaemon.net>
Message-ID: <201203131010.43095.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Jason Cooper wrote:
> Initially, copied guruplug-setup.c and did s/guruplug/dreamplug/g.
> Then, switched to SPI based NOR flash.
> 
> After talking to Arnd Bergman, chose an incremental approach to adding
> devicetree support.  First, we use the dtb to tell us we are on the
> dreamplug, then we gradually port over drivers.
> 
> Driver porting will start with the uart (see next patch), and progress
> from there.  Next, all drivers not needing common clock (kirkwood_tclk)
> or pinmux.  Then, remain drivers as that support hits the tree.
> 
> We need to absorb kirkwood_init() into kirkwood_dt_init() so that as we
> convert drivers, we can remove the platform call, eg
> kirkwood_rtc_init().  This maintains compatibility with non-fdt
> configurations because they still call kirkwood_init() in common.c.
> 
> As drivers are converted, we will reinstate the 'static' qualifier in
> common.c.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

Patches 4 and 5 both look ok, but since I merged the earlier versions
of these into the stable next/board branch of arm-soc.git, you will have
to generate these as incremental patches now, and adapt the changeset
comments accordingly.

One small issue:

> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -44,6 +44,20 @@ config MACH_GURUPLUG
>  	  Say 'Y' here if you want your kernel to support the
>  	  Marvell GuruPlug Reference Board.
>  
> +config ARCH_KIRKWOOD_DT
> +	bool "Marvell Kirkwood Flattened Device Tree"
> +	select USE_OF
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Marvell Kirkwood using flattened device tree.
> +
> +config MACH_DREAMPLUG_DT
> +	bool "Marvell DreamPlug (Flattened Device Tree)"
> +	select ARCH_KIRKWOOD_DT
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Marvell DreamPlug (Flattened Device Tree).
> +

You allow ARCH_KIRKWOOD_DT to be enabled without also enabling
dreamplug. That is ok, but

> +
> +	if (of_machine_is_compatible("globalscale,dreamplug"))
> +		dreamplug_init();
> +

you call a function from dreamplug.o in board-dt.o and

> +/* board init functions for drivers not converted to fdt */
> +void dreamplug_init(void);

you have an unconditional forward declaration in the header.

The idiomatic way to deal with this is to replace turn the
declaration into

#ifdef CONFIG_DREAMPLUG_DT
void dreamplug_init(void);
#else
static inline void dreamplug_init(void) {}
#endif

	Arnd
