From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Jan 2017 15:26:58 +0100
Subject: [PATCH v6 2/5] arm: mvebu: support for SMP on 98DX3336 SoC
In-Reply-To: <20170129232035.25189-3-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Mon, 30 Jan 2017 12:20:32 +1300")
References: <20170129232035.25189-1-chris.packham@alliedtelesis.co.nz>
 <20170129232035.25189-3-chris.packham@alliedtelesis.co.nz>
Message-ID: <87a8a8vd1p.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On lun., janv. 30 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Compared to the armada-xp the 98DX3336 uses different registers to set
> the boot address for the secondary CPU so a new enable-method is needed.
> This will only work if the machine definition doesn't define an overall
> smp_ops because there is not currently a way of overriding this from the
> device tree if it is set in the machine definition.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Rob Herring <robh@kernel.org>

Applied on mvebu/soc

Thanks,

Gregory


> ---
>
> Notes:
>     Changes in v2:
>     - Document new enable-method value
>     - Correct some references from 98DX4521 to 98DX3236
>     Changes in v3:
>     - Simplify mv98dx3236_resume_init by using of_io_request_and_map()
>     Changes in v4:
>     - integrate changes into platsmp.c instead of new init call
>     - avoid duplicated code.
>     - fix error return
>     - Collect ack from Rob
>     Changes in v5:
>     - Remove useless casts (thanks to Stephen Boyd)
>     Changes in v6:
>     - use a #define instead of a new structure for resume control registers.
>
>  Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>  .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  | 16 +++++
>  arch/arm/mach-mvebu/platsmp.c                      | 75 ++++++++++++++++++++++
>  3 files changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index a1bcfeed5f24..3c2fd72d0bf9 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -202,6 +202,7 @@ nodes to be present and contain the properties described below.
>  			    "marvell,armada-380-smp"
>  			    "marvell,armada-390-smp"
>  			    "marvell,armada-xp-smp"
> +			    "marvell,98dx3236-smp"
>  			    "mediatek,mt6589-smp"
>  			    "mediatek,mt81xx-tz-smp"
>  			    "qcom,gcc-msm8660"
> diff --git a/Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt b/Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
> new file mode 100644
> index 000000000000..26eb9d3aa630
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
> @@ -0,0 +1,16 @@
> +Resume Control
> +--------------
> +Available on Marvell SOCs: 98DX3336 and 98DX4251
> +
> +Required properties:
> +
> +- compatible: must be "marvell,98dx3336-resume-ctrl"
> +
> +- reg: Should contain resume control registers location and length
> +
> +Example:
> +
> +resume at 20980 {
> +	compatible = "marvell,98dx3336-resume-ctrl";
> +	reg = <0x20980 0x10>;
> +};
> diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> index 46c742d3bd41..e62273aacb43 100644
> --- a/arch/arm/mach-mvebu/platsmp.c
> +++ b/arch/arm/mach-mvebu/platsmp.c
> @@ -184,3 +184,78 @@ const struct smp_operations armada_xp_smp_ops __initconst = {
>  
>  CPU_METHOD_OF_DECLARE(armada_xp_smp, "marvell,armada-xp-smp",
>  		      &armada_xp_smp_ops);
> +
> +#define MV98DX3236_CPU_RESUME_CTRL_REG 0x08
> +#define MV98DX3236_CPU_RESUME_ADDR_REG 0x04
> +
> +static const struct of_device_id of_mv98dx3236_resume_table[] = {
> +	{
> +		.compatible = "marvell,98dx3336-resume-ctrl",
> +	},
> +	{ /* end of list */ },
> +};
> +
> +static int mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
> +{
> +	struct device_node *np;
> +	void __iomem *base;
> +	WARN_ON(hw_cpu != 1);
> +
> +	np = of_find_matching_node(NULL, of_mv98dx3236_resume_table);
> +	if (!np)
> +		return -ENODEV;
> +
> +	base = of_io_request_and_map(np, 0, of_node_full_name(np));
> +	of_node_put(np);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	writel(0, base + MV98DX3236_CPU_RESUME_CTRL_REG);
> +	writel(virt_to_phys(boot_addr), base + MV98DX3236_CPU_RESUME_ADDR_REG);
> +
> +	iounmap(base);
> +
> +	return 0;
> +}
> +
> +static int mv98dx3236_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	int ret, hw_cpu;
> +
> +	hw_cpu = cpu_logical_map(cpu);
> +	set_secondary_cpu_clock(hw_cpu);
> +	mv98dx3236_resume_set_cpu_boot_addr(hw_cpu,
> +					    armada_xp_secondary_startup);
> +
> +	/*
> +	 * This is needed to wake up CPUs in the offline state after
> +	 * using CPU hotplug.
> +	 */
> +	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +
> +	/*
> +	 * This is needed to take secondary CPUs out of reset on the
> +	 * initial boot.
> +	 */
> +	ret = mvebu_cpu_reset_deassert(hw_cpu);
> +	if (ret) {
> +		pr_warn("unable to boot CPU: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct smp_operations mv98dx3236_smp_ops __initconst = {
> +	.smp_init_cpus		= armada_xp_smp_init_cpus,
> +	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
> +	.smp_boot_secondary	= mv98dx3236_boot_secondary,
> +	.smp_secondary_init     = armada_xp_secondary_init,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_die		= armada_xp_cpu_die,
> +	.cpu_kill               = armada_xp_cpu_kill,
> +#endif
> +};
> +
> +CPU_METHOD_OF_DECLARE(mv98dx3236_smp, "marvell,98dx3236-smp",
> +		      &mv98dx3236_smp_ops);
> -- 
> 2.11.0.24.ge6920cf
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
