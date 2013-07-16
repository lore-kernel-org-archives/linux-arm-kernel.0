From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Jul 2013 17:20:23 +0200
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
Message-ID: <20130716172023.64337690@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Hauke Mehrtens,

On Tue, 16 Jul 2013 15:52:07 +0200, Hauke Mehrtens wrote:
> +/include/ "bcm5301x.dtsi"
> +
> +/ {
> +	model = "Netgear R6250 V1 (BCM4708)";
> +	compatible = "netgear,r6250v1", "brcm,bcm5301x";

I don't think using "brcm,bcm5301x" has a compatible string is very
appropriate. It should really reflect which particular SoC this board
is using.

> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> new file mode 100644
> index 0000000..638350d
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -0,0 +1,72 @@
> +/*
> + * Broadcom BCM47XX / BCM53XX ARM platform code.
> + *
> + * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "brcm,bcm5301x";
> +	model = "BCM5301X/BCM4707/BCM4708/BCM4709 SoC";

Same here. Most likely, there will be difference between those SoCs, so
a compatible string of bcm5301x doesn't seem right, and also the model
that says this will handle all those platforms.

> diff --git a/arch/arm/mach-bcm53xx/Kconfig b/arch/arm/mach-bcm53xx/Kconfig
> new file mode 100644
> index 0000000..1e16e87
> --- /dev/null
> +++ b/arch/arm/mach-bcm53xx/Kconfig
> @@ -0,0 +1,10 @@
> +config ARCH_BCM53XX
> +	bool "Broadcom BCM47XX / BCM53XX ARM SoC"

So the directory is named mach-bcm53xx, but you also handle BCM47xx
SoCs. This doesn't sound really easy to follow.

> +static int bcm53xx_abort_handler(unsigned long addr, unsigned int fsr,
> +				 struct pt_regs *regs)
> +{
> +	/*
> +	 * These happen for no good reason
> +	 * possibly left over from CFE

CFE ?

> +	 */
> +	pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
> +		addr, fsr);
> +
> +	/* Returning non-zero causes fault display and panic */
> +	return 0;
> +}
> +
> +static void bcm53xx_aborts_enable(void)
> +{
> +	/* Install our hook */
> +	hook_fault_code(16 + 6, bcm53xx_abort_handler, SIGBUS, 0,
> +			"imprecise external abort");
> +}
> +
> +static void __init bcm53xx_timer_init(void)
> +{
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +}
> +
> +void __init bcm53xx_map_io(void)
> +{
> +	debug_ll_io_init();
> +	bcm53xx_aborts_enable();
> +}

That's a nitpick, but I personally tend to like when callbacks are
ordered as they are called, i.e ->map_io() first, and then
->init_time().

> +static void __init bcm53xx_dt_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

Not needed, this is the default. When ->init_machine() is NULL, the ARM
core already calls automatically of_platform_populate().

> +
> +static const char const *bcm53xx_dt_compat[] = {
> +	"brcm,bcm5301x",
> +	"netgear,r6250v1",
> +	NULL,

Don't list the boards here, only the SoCs. Otherwise, this place is
going to become a nightmare of conflicts.

> +DT_MACHINE_START(BCM53XX, "BCM53XX")
> +	.init_machine = bcm53xx_dt_init,
> +	.map_io = bcm53xx_map_io,
> +	.init_irq = irqchip_init,
> +	.init_time = bcm53xx_timer_init,
> +	.dt_compat = bcm53xx_dt_compat,
> +MACHINE_END

You also probably want to add this new platform to the
multi_v7_defconfig.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
