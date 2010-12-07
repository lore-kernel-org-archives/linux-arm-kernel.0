From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Dec 2010 15:13:10 +0000
Subject: [PATCH v4] ARM: vexpress: add support for multiple core tiles
In-Reply-To: <1291732998-22789-1-git-send-email-will.deacon@arm.com>
References: <1291732998-22789-1-git-send-email-will.deacon@arm.com>
Message-ID: <20101207151310.GB23589@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 02:43:18PM +0000, Will Deacon wrote:
> @@ -115,36 +108,22 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>   */
>  void __init smp_init_cpus(void)
>  {
> -	void __iomem *scu_base = scu_base_addr();
> -	unsigned int i, ncores;
> -
> -	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> -
> -	/* sanity check */
> -	if (ncores > NR_CPUS) {
> +	ct_desc->init_cpu_map();
> +	if (!num_possible_cpus()) {
>  		printk(KERN_WARNING
> -		       "vexpress: no. of cores (%d) greater than configured "
> -		       "maximum of %d - clipping\n",
> -		       ncores, NR_CPUS);
> -		ncores = NR_CPUS;
> +		       "vexpress: no possible CPUs declared, forcing logical "
> +		       "CPU 0\n");
> +		set_cpu_possible(0, true);

Hmm. The right check is whether the current CPU number is set in the
possible map - if it's clear, then that's certainly a bug.

However, this will never happen, unless you do something really silly
in ->init_cpu_map() such as clearing all possible CPUs, or setting
them false.  See boot_cpu_init() in init/main.c.

So I don't think we need this check (and I think it should be in the
platform code.)

Alteratively, we could do this in the generic SMP code:

	if (num_possible_cpus() > NR_CPUS) {
		unsigned int nr = 0, cpu;

		pr_warning("SMP: number of CPUs greater than configured %u, disabling CPU",
			NR_CPUS);
		
		for_each_possible_cpu(cpu) {
			if (nr >= NR_CPUS) {
				cpu_set_possible(cpu, false);
				pr_cont(" %u", cpu);
			}
			nr++;
		}
		pr_cont("\n");
	}
