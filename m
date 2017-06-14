From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jun 2017 22:47:27 -0700
Subject: [PATCHv2] ARM: OMAP: PM: stop early on systems without twl
In-Reply-To: <20170613094617.29166-1-sre@kernel.org>
References: <20170612102527.GX3730@atomide.com>
 <20170613094617.29166-1-sre@kernel.org>
Message-ID: <20170614054727.GE3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [170613 02:50]:
> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 63027e60cc20..92e335decc61 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -240,6 +240,10 @@ omap_postcore_initcall(omap2_common_pm_init);
>  
>  int __init omap2_common_pm_late_init(void)
>  {
> +#if IS_BUILTIN(CONFIG_TWL6040_CORE) || IS_BUILTIN(CONFIG_TWL4030_CORE)
> +	if (!twl_rev())
> +		goto no_twl;
> +
>  	/* Init the voltage layer */
>  	omap3_twl_init();
>  	omap4_twl_init();
> @@ -253,4 +257,9 @@ int __init omap2_common_pm_late_init(void)
>  	omap_devinit_smartreflex();
>  
>  	return 0;
> +
> +no_twl:
> +#endif
> +	pr_err("OMAP4 PM not supported!\n");
> +	return -ENODEV;

This should probably just say "OMAP4 SmartReflex not supported".
We already have omap4 CPUs hit off mode during idle. What's
missing is save and restore of registers for various domains.

SmartReflex is also doable without twl PMICs, at least ti81xx
are doing SmartReflex over a group of GPIO pins without twl.

So maybe just put the twl specific parts into IS_BUILTIN so
we can optionally add other PM init here if needed?

Regards,

Tony
