From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 11:51:54 +0200
Subject: [PATCH v2 3/4] ARM: OMAP2+: Add machine entry for dra72x devices
In-Reply-To: <1398243775-4145-4-git-send-email-rnayak@ti.com>
References: <1398243775-4145-1-git-send-email-rnayak@ti.com>
 <1398243775-4145-4-git-send-email-rnayak@ti.com>
Message-ID: <66310471.kybX1mlztt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014 14:32:54 Rajendra Nayak wrote:
> 
>  #ifdef CONFIG_SOC_DRA7XX
> -static const char *dra7xx_boards_compat[] __initdata = {
> +static const char *dra74x_boards_compat[] __initconst = {
> +       "ti,dra74x",
>         "ti,dra7xx",
>         "ti,dra7",
>         NULL,
>  };
>  
> -DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
> +DT_MACHINE_START(DRA74X_DT, "Generic DRA74X (Flattened Device Tree)")
>         .reserve        = omap_reserve,
>         .smp            = smp_ops(omap4_smp_ops),
>         .map_io         = omap5_map_io,
> @@ -255,7 +256,26 @@ DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
>         .init_irq       = omap_gic_of_init,
>         .init_machine   = omap_generic_init,
>         .init_time      = omap5_realtime_timer_init,
> -       .dt_compat      = dra7xx_boards_compat,
> +       .dt_compat      = dra74x_boards_compat,
> +       .restart        = omap44xx_restart,
> +MACHINE_END
> +
> +static const char *dra72x_boards_compat[] __initconst = {
> +       "ti,dra72x",
> +       "ti,dra7xx",
> +       "ti,dra7",
> +       NULL,
> +};

Now you have two lists that both match "ti,dra7xx" and "ti,dra7", which will
cause problems if you have a new machine that doesn't match the more specific
strings.

Note that we intentionally don't allow wildcards in compatible strings
to avoid this situation.

Please remove all strings with an "x" in them from the dts files and from
the source, and make sure you have no duplication between the lists.

	Arnd
