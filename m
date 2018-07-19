From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 19 Jul 2018 15:20:16 +0100
Subject: [PATCH v2] drivers/firmware: psci_checker: stash and use
 topology_core_cpumask for hotplug tests
In-Reply-To: <1532007349-9498-1-git-send-email-sudeep.holla@arm.com>
References: <1531913132-21022-1-git-send-email-sudeep.holla@arm.com>
 <1532007349-9498-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180719142016.GD9213@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 02:35:49PM +0100, Sudeep Holla wrote:
> Commit 7f9545aa1a91 ("arm64: smp: remove cpu and numa topology
> information when hotplugging out CPU") updates the cpu topology when
> the CPU is hotplugged out. However the PSCI checker code uses the
> topology_core_cpumask pointers for some of the cpu hotplug testing.
> Since the pointer to the core_cpumask of the first CPU in the group
> is used, which when that CPU itself is hotpugged out is just set to
> itself, the testing terminates after that particular CPU is tested out.
> But the intention of this tests is to cover all the CPU in the group.
> 
> In order to support that, we need to stash the topology_core_cpumask
> before the start of the test and use that value instead of pointer to
> a cpumask which will be updated on CPU hotplug.
> 
> Fixes: 7f9545aa1a91a9a4 ("arm64: smp: remove cpu and numa topology
> 	information when hotplugging out CPU")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/psci_checker.c | 53 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> v1->v2:
> 	- Move allocation and freeing of the cpumasks to separate
> 	  routines as suggested by Lorenzo
> 	- Reduced the allocation to number of groups instead of number
> 	  of cpus in the system by making 2 pass
> 
> diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci_checker.c
> index bb1c068bff19..7e6f66b588fd 100644
> --- a/drivers/firmware/psci_checker.c
> +++ b/drivers/firmware/psci_checker.c
> @@ -77,21 +77,23 @@ static int psci_ops_check(void)
>  	return 0;
>  }
> 
> -static int find_cpu_groups(const struct cpumask *cpus,
> -			   const struct cpumask **cpu_groups)
> +static int find_cpu_groups(cpumask_var_t *cpu_groups)
>  {
>  	unsigned int nb = 0;
>  	cpumask_var_t tmp;
> 
>  	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
>  		return -ENOMEM;
> -	cpumask_copy(tmp, cpus);
> +	cpumask_copy(tmp, cpu_online_mask);
> 
>  	while (!cpumask_empty(tmp)) {
>  		const struct cpumask *cpu_group =
>  			topology_core_cpumask(cpumask_any(tmp));
> 
> -		cpu_groups[nb++] = cpu_group;
> +		if (cpu_groups && cpu_groups[nb])
> +			cpumask_copy(cpu_groups[nb], cpu_group);
> +
> +		nb++;
>  		cpumask_andnot(tmp, tmp, cpu_group);
>  	}
> 
> @@ -166,20 +168,48 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
>  	return err;
>  }
> 
> +static void free_cpu_groups(int num, cpumask_var_t *cpu_groups)
> +{
> +	int i;
> +
> +	for (i = 0; i < num; ++i)
> +		free_cpumask_var(cpu_groups[i]);
> +	kfree(cpu_groups);
> +}
> +
> +static cpumask_var_t *alloc_cpu_groups(int num)
> +{
> +	int i;
> +	cpumask_var_t *cpu_groups;
> +
> +	cpu_groups = kcalloc(num, sizeof(cpu_groups), GFP_KERNEL);
> +	if (!cpu_groups)
> +		return NULL;
> +
> +	for (i = 0; i < num; ++i)
> +		if (!alloc_cpumask_var(&cpu_groups[i], GFP_KERNEL)) {
> +			free_cpu_groups(num, cpu_groups);
> +			return NULL;
> +		}
> +
> +	return cpu_groups;
> +}

Sorry for being a PITA - I meant we could remove find_cpu_groups()
entirely and embed it in alloc_cpu_groups(), that takes a cpumask_t
pointer and return the number of groups, again, to make it more
readable but that's just my opinion.

Regardless:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  static int hotplug_tests(void)
>  {
>  	int err;
> -	cpumask_var_t offlined_cpus;
> +	cpumask_var_t offlined_cpus, *cpu_groups;
>  	int i, nb_cpu_group;
> -	const struct cpumask **cpu_groups;
>  	char *page_buf;
> 
> +	/* first run to just get the number of cpu groups */
> +	nb_cpu_group = find_cpu_groups(NULL);
> +
>  	err = -ENOMEM;
>  	if (!alloc_cpumask_var(&offlined_cpus, GFP_KERNEL))
>  		return err;
> -	/* We may have up to nb_available_cpus cpu_groups. */
> -	cpu_groups = kmalloc_array(nb_available_cpus, sizeof(*cpu_groups),
> -				   GFP_KERNEL);
> +
> +	cpu_groups = alloc_cpu_groups(nb_cpu_group);
>  	if (!cpu_groups)
>  		goto out_free_cpus;
>  	page_buf = (char *)__get_free_page(GFP_KERNEL);
> @@ -187,7 +217,8 @@ static int hotplug_tests(void)
>  		goto out_free_cpu_groups;
> 
>  	err = 0;
> -	nb_cpu_group = find_cpu_groups(cpu_online_mask, cpu_groups);
> +	/* second run to populate/copy the cpumask */
> +	nb_cpu_group = find_cpu_groups(cpu_groups);
> 
>  	/*
>  	 * Of course the last CPU cannot be powered down and cpu_down() should
> @@ -212,7 +243,7 @@ static int hotplug_tests(void)
> 
>  	free_page((unsigned long)page_buf);
>  out_free_cpu_groups:
> -	kfree(cpu_groups);
> +	free_cpu_groups(nb_cpu_group, cpu_groups);
>  out_free_cpus:
>  	free_cpumask_var(offlined_cpus);
>  	return err;
> --
> 2.7.4
> 
