From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 16 Jul 2014 15:25:50 +0200
Subject: [PATCH v3] ARM: exynos4: hotplug: Fix CPU idle clock down after
 CPU off
In-Reply-To: <53C678B5.7080304@samsung.com>
References: <1405512467-27269-1-git-send-email-k.kozlowski@samsung.com>
 <53C678B5.7080304@samsung.com>
Message-ID: <1405517150.15590.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-07-16 at 15:05 +0200, Tomasz Figa wrote:
> Hi Krzysztof,
> 
> On 16.07.2014 14:07, Krzysztof Kozlowski wrote:
> 
> [snip]
> 
> > +#ifdef CONFIG_SMP
> > +extern void exynos_clear_delayed_reset_assertion(u32 core_id);
> > +#endif
> 
> Is the ifdef really needed? The only difference it makes if the function
> is used but not compiled in is that with it the compilation will fail,
> while without it the kernel won't link.

Hmmm... I'll take another approach - just merge hotplug.c into
platsmp.c.

> 
> > +
> >  extern void exynos_cpu_resume(void);
> >  
> >  extern struct smp_operations exynos_smp_ops;
> 
> [snip]
> 
> > +/*
> > + * Clear the USE_DELAYED_RESET_ASSERTION option, set on Exynos4 SoCs
> > + * during hot-unplugging CPUx.
> > + *
> > + * It won't harm if this is called during first boot of secondary CPU.
> > + *
> > + * Exynos4 SoCs require setting USE_DELAYED_RESET_ASSERTION so the CPU idle
> > + * clock down feature could properly detect global idle state when
> > + * CPUx is off.
> > + */
> > +void exynos_clear_delayed_reset_assertion(u32 core_id)
> > +{
> > +	if (soc_is_exynos4()) {
> > +		unsigned int tmp;
> > +
> > +		tmp = __raw_readl(EXYNOS_ARM_CORE_OPTION(core_id));
> > +		tmp &= ~(S5P_USE_DELAYED_RESET_ASSERTION);
> > +		__raw_writel(tmp, EXYNOS_ARM_CORE_OPTION(core_id));
> > +	}
> > +}
> 
> The idea to make this a helper function is quite nice, but maybe it
> could be extended into exynos_set_delayed_reset_assertion() and disable
> or enable delayed assertion depending on another argument?

Sure, I'll change it.

Best regards,
Krzysztof

> 
> Best regards,
> Tomasz
