From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 13 Nov 2012 10:06:59 +0000
Subject: [PATCH v2 2/5] ARM: kernel: add device tree init map function
In-Reply-To: <20121112172753.GB2111@linaro.org>
References: <1352471654-20207-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1352471654-20207-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20121112172753.GB2111@linaro.org>
Message-ID: <20121113100659.GF12287@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 05:27:53PM +0000, Dave Martin wrote:
> On Fri, Nov 09, 2012 at 02:34:11PM +0000, Lorenzo Pieralisi wrote:

[...]

> > +Every cpu node is required to set its device_type to "cpu".
> > +
> > +Example:
> > +
> > +	cpus {
> > +		#size-cells = <0>;
> > +		#address-cells = <1>;
> > +
> > +		CPU0: cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = <arm, cortex-a15>;
> > +			reg = <0x0>;
> > +		};
> > +
> > +		CPU1: cpu at 1 {
> > +			device_type = "cpu";
> > +			compatible = <arm, cortex-a15>;
> > +			reg = <0x1>;
> > +		};
> > +
> > +		CPU2: cpu at 100 {
> > +			device_type = "cpu";
> > +			compatible = <arm, cortex-a7>;
> > +			reg = <0x100>;
> > +		};
> > +
> > +		CPU3: cpu at 101 {
> 
> Should we document the unit address convention as part of the binding
> documentation?
> 
> Using the MPIDR value here is a bit cumbersome, but I'm not sure if
> there's a better alternative, unless we make a multi-element vector
> out of the MPIDR to use as the address -- sounds like overkill.

I just followed the booting-without-of.txt convention for /cpu nodes,
where the unit-address is just the reg property stripped of its leading
zeros. I think it is the default way of defining the unit-address I do not
know if I need to add to this, I certainly can.

> > +			device_type = "cpu";
> > +			compatible = <arm, cortex-a7>;
> > +			reg = <0x101>;
> > +		};
> > +	};
> > diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
> > index aeae9c6..8dd51dc 100644
> > --- a/arch/arm/include/asm/prom.h
> > +++ b/arch/arm/include/asm/prom.h
> > @@ -15,6 +15,7 @@
> >  
> >  extern struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
> >  extern void arm_dt_memblock_reserve(void);
> > +extern void __init arm_dt_init_cpu_maps(void);
> >  
> >  #else /* CONFIG_OF */
> >  
> > @@ -24,6 +25,7 @@ static inline struct machine_desc *setup_machine_fdt(unsigned int dt_phys)
> >  }
> >  
> >  static inline void arm_dt_memblock_reserve(void) { }
> > +static inline void arm_dt_init_cpu_maps(void) { }
> >  
> >  #endif /* CONFIG_OF */
> >  #endif /* ASMARM_PROM_H */
> > diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> > index bee7f9d..d64d222 100644
> > --- a/arch/arm/kernel/devtree.c
> > +++ b/arch/arm/kernel/devtree.c
> > @@ -19,8 +19,10 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  
> > +#include <asm/cputype.h>
> >  #include <asm/setup.h>
> >  #include <asm/page.h>
> > +#include <asm/smp_plat.h>
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach-types.h>
> >  
> > @@ -61,6 +63,80 @@ void __init arm_dt_memblock_reserve(void)
> >  	}
> >  }
> >  
> > +/*
> > + * arm_dt_init_cpu_maps - Function retrieves cpu nodes from the device tree
> > + * and builds the cpu logical map array containing MPIDR values related to
> > + * logical cpus
> > + *
> > + * Updates the cpu possible mask with the number of parsed cpu nodes
> > + */
> 
> Can this function sanity-check that we do not assign the same MPIDR
> value for multiple logical CPUs?
> 
> It turns out to be surprisingly easy to write a DT with duplicate reg
> properties in the CPUs node due to careless cut-and-paste.  (i.e., I
> did it, but have been getting away with it up to now).

Check added. Waiting for some comments on the compatible list of ids to
post v3.

Thanks a lot,
Lorenzo
