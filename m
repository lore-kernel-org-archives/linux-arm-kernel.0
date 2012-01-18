From: robherring2@gmail.com (Rob Herring)
Date: Wed, 18 Jan 2012 09:54:12 -0600
Subject: [RFC PATCH 4/5] ARM: gic: add cpuif topology description
In-Reply-To: <1326897408-11204-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1326897408-11204-5-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <4F16EB24.4000701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2012 08:36 AM, Lorenzo Pieralisi wrote:
> In order to set up a proper logical to per-cpu interrupt controller IF
> mapping, the GIC interrupt controller device tree bindings must be enhanced
> to define the CPU IF id for all present CPUs.
> GIC CPU IF ids are needed to send interprocessor IPIs and to set affinity
> levels. Since the way CPU IF ids are wired depends on the specific
> system design, they cannot be extrapolated or probed in HW by the boot
> CPU, so a binding to define them is needed to set-up the system properly.
> 
> This patch adds a logical map of per-cpu interrupt controller identifiers.
> The newly introduced per-cpu IF map has to be initialized by the GIC
> driver so that interprocessor interrupts and affinity levels can be set
> accordingly in an SMP system, with a proper 1:1 relation between per-cpu
> IF ids and logical cpu indexes.
> 
> This patch adds a function that parses the device tree properties and
> initializes the cpu interfaces ids properly according to the latest GIC
> device tree bindings.
> 
> If CONFIG_OF is not enabled, per-cpu CPU IF mappings are defined as
> cpu_logical_map(), leaving the current functionality unchanged.
> 

What if CONFIG_OF is enabled, but the DTB is not updated? That needs to
work.

I really don't get this. Furthermore, DT bindings are not supposed to
evolve. They need to be complete enough that they don't need frequent
updates for existing h/w. We discussed GIC bindings at length for 3+
months. The binding had sub nodes for cpu interfaces at one point, but
got rid of them. Then support for cpu interfaces at different addresses
was added. Those times were the time to bring-up issues like this. We
can't keep changing the binding.

Rob


> The GIC device tree bindings documentation is updated by the patch
> accordingly.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt |   69 ++++++++++++++++++
>  arch/arm/common/gic.c                         |   94 +++++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 9b4b82a..da2f6a8 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -57,3 +57,72 @@ Example:
>  		      <0xfff10100 0x100>;
>  	};
>  
> +* ARM Generic Interrupt Controller CPU Interfaces
> +
> +ARM GIC device tree nodes contain subnodes representing its CPU interfaces.
> +
> +The main properties required by CPU interface nodes are:
> +
> +- compatible	: "arm,gic-cpuif"
> +- cpuif-id	: specifies the CPU IF HW identifier
> +- cpu		: a phandle to the respective CPU node
> +
> +Example:
> +
> +	cpus {
> +		#size-cells = <0>;
> +		#address-cells = <1>;
> +
> +		CPU0: cpu at 0x0 {
> +			device_type = "cpu";
> +			reg = <0x0>;
> +		};
> +
> +		CPU1: cpu at 0x1 {
> +			device_type = "cpu";
> +			reg = <0x1>;
> +		};
> +
> +		CPU2: cpu at 0x100 {
> +			device_type = "cpu";
> +			reg = <0x100>;
> +		};
> +
> +		CPU3: cpu at 0x101 {
> +			device_type = "cpu";
> +			reg = <0x101>;
> +		};
> +	};
> +
> +	intc: interrupt-controller at fff11000 {
> +		compatible = "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		#address-cells = <1>;
> +		interrupt-controller;
> +		reg = <0xfff11000 0x1000>,
> +		      <0xfff10100 0x100>;
> +
> +			gic-cpuif at 0x0 {
> +				compatible = "arm,gic-cpuif";
> +				cpuif-id = <0x0>;
> +				cpu = <&CPU0>;
> +			};
> +
> +			gic-cpuif at 0x1 {
> +				compatible = "arm,gic-cpuif";
> +				cpuif-id = <0x1>;
> +				cpu = <&CPU1>;
> +			};
> +
> +			gic-cpuif at 0x2 {
> +				compatible = "arm,gic-cpuif";
> +				cpuif-id = <0x2>;
> +				cpu = <&CPU2>;
> +			};
> +
> +			gic-cpuif at 0x3 {
> +				compatible = "arm,gic-cpuif";
> +				cpuif-id = <0x3>;
> +				cpu = <&CPU3>;
> +			};
> +	};
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index c47d619..4be754d 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -140,6 +140,83 @@ static inline unsigned int gic_irq(struct irq_data *d)
>  	return d->hwirq;
>  }
>  
> +#ifdef CONFIG_OF
> +static u32 gic_cpuif_logical_map[NR_CPUS];
> +#define cpuif_logical_map(cpu)	gic_cpuif_logical_map[cpu]
> +
> +/*
> + * Create a mapping of GIC CPU IF numbers to logical cpus through the device
> + * tree. GIC CPU IF are linked to the respective cpu nodes through the "cpu"
> + * phandle.
> + */
> +static void __init gic_init_if_maps(struct gic_chip_data *gic)
> +{
> +	struct device_node *ncpu, *gic_cpuif;
> +	struct irq_domain *domain = &gic->domain;
> +	int i;
> +
> +	if (WARN_ON(!domain || !domain->of_node))
> +		return;
> +
> +	for_each_child_of_node(domain->of_node, gic_cpuif) {
> +		const u32 *cpuif_hwid, *mpidr;
> +		int len;
> +
> +		if (!of_device_is_compatible(gic_cpuif, "arm,gic-cpuif"))
> +			continue;
> +
> +		pr_debug("  * %s...\n", gic_cpuif->full_name);
> +
> +		ncpu = of_parse_phandle(gic_cpuif, "cpu", 0);
> +
> +		if (!ncpu) {
> +			pr_err("  * %s missing cpu phandle\n",
> +						gic_cpuif->full_name);
> +			continue;
> +		}
> +
> +		mpidr = of_get_property(ncpu, "reg", &len);
> +
> +		if (!mpidr || len != 4) {
> +			pr_err("  * %s missing reg property\n",
> +					ncpu->full_name);
> +			continue;
> +		}
> +
> +		cpuif_hwid = of_get_property(gic_cpuif, "cpuif-id", &len);
> +
> +		if (!cpuif_hwid || len != 4) {
> +			pr_err("  * %s missing cpuif-id property\n",
> +						gic_cpuif->full_name);
> +			continue;
> +		}
> +
> +		/*
> +		 * Do the logical enumeration once in arm_dt_init_cpu_maps and
> +		 * use it again here to avoid logical numbering mix-ups between
> +		 * cpu and interrupt controller ids
> +		 */
> +
> +		i = get_logical_index(be32_to_cpup(mpidr));
> +
> +		if (i < 0) {
> +			pr_err("  * %s mpidr mismatch\n",
> +						ncpu->full_name);
> +			continue;
> +		}
> +
> +		if (!i)
> +			printk(KERN_INFO "Booting Linux on GIC CPU IF 0x%x\n",
> +					be32_to_cpup(cpuif_hwid));
> +
> +		cpuif_logical_map(i) = be32_to_cpup(cpuif_hwid);
> +	}
> +}
> +#else
> +static inline void gic_init_if_maps(struct gic_chip_data *gic) {}
> +#define cpuif_logical_map(cpu)	cpu_logical_map(cpu)
> +#endif
> +
>  /*
>   * Routines to acknowledge, disable and enable interrupts
>   */
> @@ -245,7 +322,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  		return -EINVAL;
>  
>  	mask = 0xff << shift;
> -	bit = 1 << (cpu_logical_map(cpu) + shift);
> +	bit = 1 << (cpuif_logical_map(cpu) + shift);
>  
>  	raw_spin_lock(&irq_controller_lock);
>  	val = readl_relaxed(reg) & ~mask;
> @@ -353,7 +430,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>  	unsigned int gic_irqs = gic->gic_irqs;
>  	struct irq_domain *domain = &gic->domain;
>  	void __iomem *base = gic_data_dist_base(gic);
> -	u32 cpu = cpu_logical_map(smp_processor_id());
> +	u32 cpu = cpuif_logical_map(smp_processor_id());
>  
>  	cpumask = 1 << cpu;
>  	cpumask |= cpumask << 8;
> @@ -659,6 +736,14 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  
>  	gic = &gic_data[gic_nr];
>  	domain = &gic->domain;
> +
> +	/*
> +	 * create the logical/physical mapping just for the
> +	 * primary GIC
> +	 */
> +	if (gic_nr == 0)
> +		gic_init_if_maps(gic);
> +
>  #ifdef CONFIG_GIC_NON_BANKED
>  	if (percpu_offset) { /* Frankein-GIC without banked registers... */
>  		unsigned int cpu;
> @@ -673,7 +758,8 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  		}
>  
>  		for_each_possible_cpu(cpu) {
> -			unsigned long offset = percpu_offset * cpu_logical_map(cpu);
> +			unsigned long offset =
> +				percpu_offset * cpuif_logical_map(cpu);
>  			*per_cpu_ptr(gic->dist_base.percpu_base, cpu) = dist_base + offset;
>  			*per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = cpu_base + offset;
>  		}
> @@ -746,7 +832,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  
>  	/* Convert our logical CPU mask into a physical one. */
>  	for_each_cpu(cpu, mask)
> -		map |= 1 << cpu_logical_map(cpu);
> +		map |= 1 << cpuif_logical_map(cpu);
>  
>  	/*
>  	 * Ensure that stores to Normal memory are visible to the
