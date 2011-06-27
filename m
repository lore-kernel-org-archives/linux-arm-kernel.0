From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Jun 2011 05:37:55 -0700
Subject: [PATCH] Use MMIO clocksource for 32kHz counter
In-Reply-To: <20110627123315.GB1777@n2100.arm.linux.org.uk>
References: <20110627123315.GB1777@n2100.arm.linux.org.uk>
Message-ID: <20110627123754.GQ23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110627 05:28]:
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> +#ifdef CONFIG_ARCH_OMAP16XX
> +		else if (cpu_is_omap16xx())
> +			base = OMAP2_L4_IO_ADDRESS(OMAP16XX_TIMER_32K_SYNCHRONIZED);
> +#endif
> +#ifdef CONFIG_SOC_OMAP2420
>  		else if (cpu_is_omap2420())
> -			clocksource_32k.read = omap2420_32k_read;
> +			base = OMAP2_L4_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x10);
> +#endif
> +#ifdef CONFIG_SOC_OMAP2430
>  		else if (cpu_is_omap2430())
> -			clocksource_32k.read = omap2430_32k_read;
> +			base = OMAP2_L4_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x10);
> +#endif
> +#ifdef CONFIG_ARCH_OMAP3
>  		else if (cpu_is_omap34xx())
> -			clocksource_32k.read = omap34xx_32k_read;
> +			base = OMAP2_L4_IO_ADDRESS(OMAP3430_32KSYNCT_BASE + 0x10);
> +#endif
> +#ifdef CONFIG_ARCH_OMAP4
>  		else if (cpu_is_omap44xx())
> -			clocksource_32k.read = omap44xx_32k_read;
> +			base = OMAP2_L4_IO_ADDRESS(OMAP4430_32KSYNCT_BASE + 0x10);
> +#endif
>  		else
>  			return -ENODEV;
>  

You should be able to replace the above with just ioremap as we now
have the static mappings.

Tony
