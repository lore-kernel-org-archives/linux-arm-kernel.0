From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 Apr 2018 14:46:16 -0700
Subject: [RFC 3/3] arm: shmobile: Add the RZ/N1D SMP enabler driver.
In-Reply-To: <1523871304-48517-5-git-send-email-michel.pollet@bp.renesas.com>
References: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523871304-48517-5-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <9f33a1d2-3c55-2485-a1f2-909def69e5b0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On 04/16/2018 02:34 AM, Michel Pollet wrote:
> The Renesas RZ/N1D second CA7 is parked in a ROM pen at boot time, it
> requires a special enable method to get it started at boot time.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Some few comments below. This patch should probably be re-ordered in
your patch series, I would expect you to have this become patch 2 and
have patch 2 be patch 3 (first you add infrastructure for using
something, then you make use of it).

> +static int rzn1_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	if (!cpu_bootaddr)
> +		return -ENODEV;
> +
> +	spin_lock(&cpu_lock);
> +
> +	writel(virt_to_phys(secondary_startup), cpu_bootaddr);

Consider using __pa_symbol() instead of virt_to_phys() since
secondary_startup is part of the kernel's linear memory map.

> +	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +
> +	spin_unlock(&cpu_lock);
> +
> +	return 0;
> +}
> +
> +static void __init rzn1_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	struct device_node *dn;
> +	int ret;
> +	u32 bootaddr;
> +
> +	dn = of_get_cpu_node(1, NULL);
> +	if (!dn) {
> +		pr_err("CPU#1: missing device tree node\n");
> +		return;
> +	}
> +	/*
> +	 * Determine the address from which the CPU is polling.
> +	 */
> +	ret = of_property_read_u32(dn, "cpu-release-addr", &bootaddr);
> +	if (ret)
> +		pr_err("CPU#1: invalid cpu-release-addr property\n");
> +
> +	of_node_put(dn);
> +	/* The bootloader *does* change this property */

This comment should probably be moved above the function that fetches
"cpu-release-addr"

> +	pr_info("CPU#1: cpu-release-addr %08x\n", (u32)bootaddr);
> +
> +	if (!bootaddr)
> +		return;

Would not you want to show a message here to help catch such conditions

> +
> +	cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr));

Relying on ioremap() to reject values that might be outside of the
allowed range may be a little fragile, but I can't suggest any better
alternative.

> +	if (!cpu_bootaddr)
> +		pr_err("CPU#1: cpu-release-addr map failed\n");
> +}
> +
> +static const struct smp_operations rzn1_smp_ops __initconst = {
> +	.smp_prepare_cpus = rzn1_smp_prepare_cpus,
> +	.smp_boot_secondary = rzn1_smp_boot_secondary,
> +};
> +CPU_METHOD_OF_DECLARE(rzn1_smp, "renesas,r9a06g032-smp", &rzn1_smp_ops);
> 


-- 
Florian
