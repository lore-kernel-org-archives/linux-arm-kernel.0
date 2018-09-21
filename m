From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 12:05:48 +0200
Subject: [PATCH v5] ARM: mvebu: use dt_fixup to provide fallback for
 enable-method
In-Reply-To: <20180726034856.20743-1-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Thu, 26 Jul 2018 15:48:56 +1200")
References: <20180726034856.20743-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <8736u3jhc3.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On jeu., juil. 26 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> We need to maintain backwards compatibility with device trees that don't
> define an enable method. At the same time we want the device tree to be
> able to specify an enable-method and have it stick.
>
> Previously by having smp assigned in the DT_MACHINE definition this
> would be picked up by setup_arch() and override whatever
> arm_dt_init_cpu_maps() had configured. Now we move the initial
> assignment of default smp_ops to a dt_fixup and let
> arm_dt_init_cpu_maps() override that if the device tree defines an
> enable-method.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

I made several tests on an Armada XP based board: OpenBlock AX3: I
modify the enable-method in the decvice tree, and I confirm that without
your patch it is not taken into account whereas with this patch the
enable-method is applied form the device tree. I also didn't see any
regression with the original dtb.

So I added my:
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

and applied on mvebu/soc

Thanks,

Gregory

> ---
> Pervious versions
>
> v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300182.html
> v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300480.html
> v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302945.html
> v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303899.html
>
> Changes since v4:
> - drop "RFC"
>
>  arch/arm/mach-mvebu/board-v7.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index ccca95173e17..5bbde5e5258e 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -145,6 +145,11 @@ static void __init mvebu_dt_init(void)
>  		i2c_quirk();
>  }
>  
> +static void __init armada_370_xp_dt_fixup(void)
> +{
> +	smp_set_ops(smp_ops(armada_xp_smp_ops));
> +}
> +
>  static const char * const armada_370_xp_dt_compat[] __initconst = {
>  	"marvell,armada-370-xp",
>  	NULL,
> @@ -153,17 +158,12 @@ static const char * const armada_370_xp_dt_compat[] __initconst = {
>  DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
>  	.l2c_aux_val	= 0,
>  	.l2c_aux_mask	= ~0,
> -/*
> - * The following field (.smp) is still needed to ensure backward
> - * compatibility with old Device Trees that were not specifying the
> - * cpus enable-method property.
> - */
> -	.smp		= smp_ops(armada_xp_smp_ops),
>  	.init_machine	= mvebu_dt_init,
>  	.init_irq       = mvebu_init_irq,
>  	.restart	= mvebu_restart,
>  	.reserve        = mvebu_memblock_reserve,
>  	.dt_compat	= armada_370_xp_dt_compat,
> +	.dt_fixup	= armada_370_xp_dt_fixup,
>  MACHINE_END
>  
>  static const char * const armada_375_dt_compat[] __initconst = {
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
