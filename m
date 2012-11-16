From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 16 Nov 2012 12:29:44 -0500 (EST)
Subject: [RFC PATCH v2 2/2] ARM: kernel: update cpuinfo to print all
 online CPUs features
In-Reply-To: <1353066105-19486-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1353066105-19486-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1353066105-19486-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.02.1211161229190.1238@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2012, Lorenzo Pieralisi wrote:

> Currently, reading /proc/cpuinfo provides userspace with CPU ID of
> the CPU carrying out the read from the file. This is fine as long as all
> CPUs in the system are the same. With the advent of big.LITTLE and
> heterogenous ARM systems this approach provides user space with incorrect
> bits of information since CPU ids in the system might differ from the one
> provided by the CPU reading the file.
> 
> This patch updates the cpuinfo show function so that a read from
> /proc/cpuinfo prints HW information for all online CPUs at once, mirroring
>  x86 behaviour.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/kernel/setup.c | 66 ++++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 20c530b..948fff1 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -842,13 +842,15 @@ static const char *hwcap_str[] = {
>  
>  static int c_show(struct seq_file *m, void *v)
>  {
> -	int i;
> +	int i, j;
> +	u32 cpuid;
>  
> -	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
> -		   cpu_name, read_cpuid_id() & 15, elf_platform);
> +	for_each_online_cpu(i) {
> +		cpuid = is_smp() ? per_cpu(cpu_data, i).cpuid : read_cpuid_id();
> +		seq_printf(m, "Processor\t: %s rev %d (%s)\n",
> +			   cpu_name, cpuid & 15, elf_platform);
>  
>  #if defined(CONFIG_SMP)
> -	for_each_online_cpu(i) {
>  		/*
>  		 * glibc reads /proc/cpuinfo to determine the number of
>  		 * online processors, looking for lines beginning with
> @@ -858,42 +860,40 @@ static int c_show(struct seq_file *m, void *v)
>  		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n\n",
>  			   per_cpu(cpu_data, i).loops_per_jiffy / (500000UL/HZ),
>  			   (per_cpu(cpu_data, i).loops_per_jiffy / (5000UL/HZ)) % 100);
> -	}
> -#else /* CONFIG_SMP */
> -	seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
> -		   loops_per_jiffy / (500000/HZ),
> -		   (loops_per_jiffy / (5000/HZ)) % 100);
> +#else
> +		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
> +			   loops_per_jiffy / (500000/HZ),
> +			   (loops_per_jiffy / (5000/HZ)) % 100);
>  #endif
> +		/* dump out the processor features */
> +		seq_puts(m, "Features\t: ");
>  
> -	/* dump out the processor features */
> -	seq_puts(m, "Features\t: ");
> +		for (j = 0; hwcap_str[j]; j++)
> +			if (elf_hwcap & (1 << j))
> +				seq_printf(m, "%s ", hwcap_str[j]);
>  
> -	for (i = 0; hwcap_str[i]; i++)
> -		if (elf_hwcap & (1 << i))
> -			seq_printf(m, "%s ", hwcap_str[i]);
> +		seq_printf(m, "\nCPU implementer\t: 0x%02x\n", cpuid >> 24);
> +		seq_printf(m, "CPU architecture: %s\n",
> +			   proc_arch[cpu_architecture()]);
>  
> -	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
> -	seq_printf(m, "CPU architecture: %s\n", proc_arch[cpu_architecture()]);
> -
> -	if ((read_cpuid_id() & 0x0008f000) == 0x00000000) {
> -		/* pre-ARM7 */
> -		seq_printf(m, "CPU part\t: %07x\n", read_cpuid_id() >> 4);
> -	} else {
> -		if ((read_cpuid_id() & 0x0008f000) == 0x00007000) {
> -			/* ARM7 */
> -			seq_printf(m, "CPU variant\t: 0x%02x\n",
> -				   (read_cpuid_id() >> 16) & 127);
> +		if ((cpuid & 0x0008f000) == 0x00000000) {
> +			/* pre-ARM7 */
> +			seq_printf(m, "CPU part\t: %07x\n", cpuid >> 4);
>  		} else {
> -			/* post-ARM7 */
> -			seq_printf(m, "CPU variant\t: 0x%x\n",
> -				   (read_cpuid_id() >> 20) & 15);
> +			if ((cpuid & 0x0008f000) == 0x00007000) {
> +				/* ARM7 */
> +				seq_printf(m, "CPU variant\t: 0x%02x\n",
> +					   (cpuid >> 16) & 127);
> +			} else {
> +				/* post-ARM7 */
> +				seq_printf(m, "CPU variant\t: 0x%x\n",
> +					   (cpuid >> 20) & 15);
> +			}
> +			seq_printf(m, "CPU part\t: 0x%03x\n",
> +				   (cpuid >> 4) & 0xfff);
>  		}
> -		seq_printf(m, "CPU part\t: 0x%03x\n",
> -			   (read_cpuid_id() >> 4) & 0xfff);
> +		seq_printf(m, "CPU revision\t: %d\n\n", cpuid & 15);
>  	}
> -	seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
> -
> -	seq_puts(m, "\n");
>  
>  	seq_printf(m, "Hardware\t: %s\n", machine_name);
>  	seq_printf(m, "Revision\t: %04x\n", system_rev);
> -- 
> 1.7.12
> 
> 
