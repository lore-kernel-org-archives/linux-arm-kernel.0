From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 12:25:39 +0000
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support
In-Reply-To: <20130312045609.19701.39029.sendpatchset@w520>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <20130312045609.19701.39029.sendpatchset@w520>
Message-ID: <201303121225.40230.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Magnus Damm wrote:
> +static struct platform_device *r8a73a4_devices[] __initdata = {
> +};
> +
> +void __init r8a73a4_add_standard_devices(void)
> +{
> +       r8a73a4_clock_init();
> +
> +       platform_add_devices(r8a73a4_devices, ARRAY_SIZE(r8a73a4_devices));
> +}

I would suggest doing the platform_add_devices() only when you actually
add devices to the array, unless you have a number of conflicting patches
that each want to add their own devices.

> +#ifdef CONFIG_USE_OF
> +void __init r8a73a4_add_standard_devices_dt(void)
> +{
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

I have a patch that will make this function definition the default, so you
no longer have to provide an init_machine callback if you don't do anything
special. It's ok to leave it in for now, but we might want to do a follow
up patch to remove it once both patches are merged.

> +static const char *r8a73a4_boards_compat_dt[] __initdata = {
> +       "renesas,r8a73a4",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
> +       .init_irq       = irqchip_init,

Same thing for the default irqchip_init.

> +       .init_machine   = r8a73a4_add_standard_devices_dt,
> +       .init_time      = shmobile_timer_init,
> +       .dt_compat      = r8a73a4_boards_compat_dt,

Have you looked into using clocksource_of_init() here? Since you are using
the ARM architected timers, I would expect that they soon will get probed
using that function, which means we have to be careful crossing patches
if someone wants to convert over all the existing users and you add a new one
here.

	Arnd
