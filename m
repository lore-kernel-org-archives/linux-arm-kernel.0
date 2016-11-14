From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Nov 2016 18:07:34 +0000
Subject: [PATCH RFC 3/2] ARM: improve arch_irq_work_has_interrupt()
In-Reply-To: <2e14b943-e3a5-6993-48c7-68200c8b08a2@arm.com>
References: <E1c6GpW-0008DO-BD@rmk-PC.armlinux.org.uk>
 <20161114153630.GN1041@n2100.armlinux.org.uk>
 <2e14b943-e3a5-6993-48c7-68200c8b08a2@arm.com>
Message-ID: <20161114180734.GQ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 04:30:57PM +0000, Marc Zyngier wrote:
> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index 3d6dc8b..45612d2 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -48,6 +48,16 @@ extern void smp_init_cpus(void);
>   */
>  extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
>  
> +#ifdef CONFIG_SMP
> +#define setup_smp_ipi(f,i)			\
> +	do {					\
> +		set_smp_cross_call(f);		\
> +		irq_controller_can_ipi = (i);	\
> +	} while(0)
> +#else
> +#define setup_smp_ipi(f,i)	do { } while (0)
> +#endif
> +
>  /*
>   * Called from platform specific assembly code, this is the
>   * secondary CPU entry point.
> 
> with the similar entry point for arm64?

Note that asm/smp.h is not included if CONFIG_SMP is not set, so it's
not that easy.

Both ARM64 and ARM have asm/smp_plat.h which contains the platform
specifics of SMP, which is where set_smp_cross_call() really should
be anyway, and the GIC code already includes this.  So I'm moving
set_smp_cross_call() there for both arches.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
