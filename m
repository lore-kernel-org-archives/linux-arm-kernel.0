From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Jun 2014 11:47:15 +0200
Subject: [PATCH 1/5] ARM: berlin: add SMP support
In-Reply-To: <1401700866-24804-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401700866-24804-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140602094715.GG28090@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 11:21:02AM +0200, Antoine T?nart wrote:
> +
> +static inline void berlin_reset_cpu(unsigned int cpu)
> +{
> +	u32 val;
> +
> +	val = readl(cpu_ctrl + CPU_RESET);
> +	val |= BIT(cpu_logical_map(cpu));
> +	writel(val, cpu_ctrl + CPU_RESET);
> +}

Hi Antoine

Is this performing a reset on the CPU, or is it taking it out of reset?

If you are going to implement CPU hotplug at some point, you are going
to want to be able to put the CPU into reset, i.e. power it off, and
take it out of reset, i.e. power it on and getting it running. So it
might help if we get these function names clear now.

      Andrew


> +
> +static int berlin_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	if (!cpu_ctrl)
> +		return -EFAULT;
> +
> +	/*
> +	 * Reset the CPU, making it to execute the instruction in the reset
> +	 * exception register.
> +	 */
> +	berlin_reset_cpu(cpu);
> +
> +	return 0;
> +}
> +
> +static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	struct device_node *np;
> +	void __iomem *scu_base;
> +	void __iomem *vectors_base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
> +	scu_base = of_iomap(np, 0);
> +	of_node_put(np);
> +	if (!scu_base)
> +		return;
> +
> +	np = of_find_compatible_node(NULL, NULL, "marvell,berlin-cpu-ctrl");
> +	cpu_ctrl = of_iomap(np, 0);
> +	of_node_put(np);
> +	if (!cpu_ctrl)
> +		goto unmap_scu;
> +
> +	vectors_base = ioremap(CONFIG_VECTORS_BASE, SZ_32K);
> +	if (!vectors_base)
> +		goto unmap_scu;
> +
> +	scu_enable(scu_base);
> +	flush_cache_all();
> +
> +	/*
> +	 * Write the first instruction the CPU will execute after being reseted
> +	 * in the reset exception register.
> +	 */
> +	writel(boot_inst, vectors_base + RESET_VECT);
> +
> +	/*
> +	 * Write the secondary startup address into the SW reset address
> +	 * register. This is used by boot_inst.

Maybe it would be better to call this the reset address vector instead
of address register. It is in the vector space after all.

   Andrew

> +	 */
> +	writel(virt_to_phys(berlin_secondary_startup), vectors_base + SW_RESET_ADDR);
> +
> +	iounmap(vectors_base);
> +unmap_scu:
> +	iounmap(scu_base);
> +}
> +
> +static struct smp_operations berlin_smp_ops __initdata = {
> +	.smp_prepare_cpus	= berlin_smp_prepare_cpus,
> +	.smp_boot_secondary	= berlin_boot_secondary,
> +};
> +CPU_METHOD_OF_DECLARE(berlin_smp, "marvell,berlin-smp", &berlin_smp_ops);
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
