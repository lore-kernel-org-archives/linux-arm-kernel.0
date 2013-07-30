From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 30 Jul 2013 15:15:02 -0400 (EDT)
Subject: [PATCH 12/13] ARM: bL_switcher: remove assumptions between
 logical and physical CPUs
In-Reply-To: <20130730163010.GA8921@e102568-lin.cambridge.arm.com>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-13-git-send-email-nicolas.pitre@linaro.org>
 <20130730163010.GA8921@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1307301502120.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Jul 2013, Lorenzo Pieralisi wrote:

> On Tue, Jul 23, 2013 at 04:31:28AM +0100, Nicolas Pitre wrote:
> > Up to now, the logical CPU was somehow tied to the physical CPU number
> > within a cluster.  This causes problems when forcing the boot CPU to be
> > different from the first enumerated CPU in the device tree creating a
> > discrepancy between logical and physical CPU numbers.
> > 
> > Let's make the pairing completely independent from physical CPU numbers.
> > 
> > Let's keep only those logical CPUs with same initial CPU cluster to create
> > a uniform scheduler profile without having to modify any of the probed
> > topology and compute capacity data.  This has the potential to create
> > a non contiguous CPU numbering space when the switcher is active with
> > potential impact on buggy user space tools.  It is however better to fix
> > those tools rather than making the switcher code more intrusive.
> 
> Nico, I am not following you here. Is this not the same problem we
> have in a system where we hotplug out some of the CPUs in the logical map ?

Yes, it is.  Although with the switcher, user space does initialize with 
holes in the logical CPU map since some CPUs have been hotplugged out 
before the boot completed which is something some tools are not 
expecting.  And it did cause problems with Android for example, although 
that has been fixed now.

> [...]
> 
> >  static void bL_switcher_restore_cpus(void)
> > @@ -319,52 +322,86 @@ static void bL_switcher_restore_cpus(void)
> >  
> >  static int bL_switcher_halve_cpus(void)
> >  {
> > -	int cpu, cluster, i, ret;
> > -	cpumask_t cluster_mask[2], common_mask;
> > -
> > -	cpumask_clear(&bL_switcher_removed_logical_cpus);
> > -	cpumask_clear(&cluster_mask[0]);
> > -	cpumask_clear(&cluster_mask[1]);
> > +	int i, j, cluster_0, gic_id, ret;
> > +	unsigned int cpu, cluster, mask;
> > +	cpumask_t available_cpus;
> >  
> > +	/* First pass to validate what we have */
> > +	mask = 0;
> >  	for_each_online_cpu(i) {
> > -		cpu = cpu_logical_map(i) & 0xff;
> > -		cluster = (cpu_logical_map(i) >> 8) & 0xff;
> > +		cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 0);
> > +		cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 1);
> >  		if (cluster >= 2) {
> >  			pr_err("%s: only dual cluster systems are supported\n", __func__);
> >  			return -EINVAL;
> >  		}
> > -		cpumask_set_cpu(cpu, &cluster_mask[cluster]);
> > +		if (WARN_ON(cpu >= MAX_CPUS_PER_CLUSTER))
> 
> pr_warn ?

I dunno.  What's the policy for choosing between those two?
Obviously this is a "shouldn't happen" case.

> 
> > +			return -EINVAL;
> > +		mask |= (1 << cluster);
> >  	}
> > -
> > -	if (!cpumask_and(&common_mask, &cluster_mask[0], &cluster_mask[1])) {
> > -		pr_err("%s: no common set of CPUs\n", __func__);
> > +	if (mask != 3) {
> 
> Technically, you might have two clusters with eg MPIDR[15:8] = {0,2}
> this would break this code. Just saying, I know for now we can live with that.
> Given that's the only usage of mask you might use a counter, just as well.

Well, there are assumptions about the cluster encoding all over the 
place, so this is a stop gap to trap anything which is not following the 
0,1 enumeration.

This assumption could be fixed eventually if it turns to e false on some 
hardware.

> > +		pr_err("%s: no CPU pairing possible\n", __func__);
> >  		return -EINVAL;
> >  	}
> >  
> > -	for_each_online_cpu(i) {
> > -		cpu = cpu_logical_map(i) & 0xff;
> > -		cluster = (cpu_logical_map(i) >> 8) & 0xff;
> > -
> > -		if (cpumask_test_cpu(cpu, &common_mask)) {
> > -			/* Let's take note of the GIC ID for this CPU */
> > -			int gic_id = gic_get_cpu_id(i);
> > -			if (gic_id < 0) {
> > -				pr_err("%s: bad GIC ID for CPU %d\n", __func__, i);
> > -				return -EINVAL;
> > -			}
> > -			bL_gic_id[cpu][cluster] = gic_id;
> > -			pr_info("GIC ID for CPU %u cluster %u is %u\n",
> > -				cpu, cluster, gic_id);
> > -
> > +	/*
> > +	 * Now let's do the pairing.  We match each CPU with another CPU
> > +	 * from a different cluster.  To get a uniform scheduling behavior
> > +	 * without fiddling with CPU topology and compute capacity data,
> > +	 * we'll use logical CPUs initially belonging to the same cluster.
> > +	 */
> > +	memset(bL_switcher_cpu_pairing, -1, sizeof(bL_switcher_cpu_pairing));
> > +	cpumask_copy(&available_cpus, cpu_online_mask);
> > +	cluster_0 = -1;
> > +	for_each_cpu(i, &available_cpus) {
> > +		int match = -1;
> > +		cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 1);
> > +		if (cluster_0 == -1)
> > +			cluster_0 = cluster;
> > +		if (cluster != cluster_0)
> > +			continue;
> > +		cpumask_clear_cpu(i, &available_cpus);
> > +		for_each_cpu(j, &available_cpus) {
> > +			cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(j), 1);
> >  			/*
> > -			 * We keep only those logical CPUs which number
> > -			 * is equal to their physical CPU number. This is
> > -			 * not perfect but good enough for now.
> > +			 * Let's remember the last match to create "odd"
> > +			 * pairings on purpose in order for other code not
> > +			 * to assume any relation between physical and
> > +			 * logical CPU numbers.
> >  			 */
> > -			if (cpu == i) {
> > -				bL_switcher_cpu_original_cluster[cpu] = cluster;
> > -				continue;
> > -			}
> > +			if (cluster != cluster_0)
> > +				match = j;
> > +		}
> > +		if (match != -1) {
> > +			bL_switcher_cpu_pairing[i] = match;
> > +			cpumask_clear_cpu(match, &available_cpus);
> > +			pr_info("CPU%d paired with CPU%d\n", i, match);
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Now we disable the unwanted CPUs i.e. everything that has no
> > +	 * pairing information (that includes the pairing counterparts).
> > +	 */
> > +	cpumask_clear(&bL_switcher_removed_logical_cpus);
> > +	for_each_online_cpu(i) {
> > +		cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 0);
> > +		cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 1);
> > +
> > +		/* Let's take note of the GIC ID for this CPU */
> > +		gic_id = gic_get_cpu_id(i);
> > +		if (gic_id < 0) {
> > +			pr_err("%s: bad GIC ID for CPU %d\n", __func__, i);
> > +			bL_switcher_restore_cpus();
> > +			return -EINVAL;
> > +		}
> > +		bL_gic_id[cpu][cluster] = gic_id;
> > +		pr_info("GIC ID for CPU %u cluster %u is %u\n",
> > +			cpu, cluster, gic_id);
> > +
> > +		if (bL_switcher_cpu_pairing[i] != -1) {
> > +			bL_switcher_cpu_original_cluster[i] = cluster;
> > +			continue;
> >  		}
> >  
> >  		ret = cpu_down(i);
> > @@ -415,7 +452,7 @@ static int bL_switcher_enable(void)
> >  
> >  static void bL_switcher_disable(void)
> >  {
> > -	unsigned int cpu, cluster, i;
> > +	unsigned int cpu, cluster;
> >  	struct bL_thread *t;
> >  	struct task_struct *task;
> >  
> > @@ -435,7 +472,6 @@ static void bL_switcher_disable(void)
> >  	 * possibility for interference from external requests.
> >  	 */
> >  	for_each_online_cpu(cpu) {
> > -		BUG_ON(cpu != (cpu_logical_map(cpu) & 0xff));
> >  		t = &bL_threads[cpu];
> >  		task = t->task;
> >  		t->task = NULL;
> > @@ -459,14 +495,10 @@ static void bL_switcher_disable(void)
> >  		/* If execution gets here, we're in trouble. */
> >  		pr_crit("%s: unable to restore original cluster for CPU %d\n",
> >  			__func__, cpu);
> > -		for_each_cpu(i, &bL_switcher_removed_logical_cpus) {
> > -			if ((cpu_logical_map(i) & 0xff) != cpu)
> > -				continue;
> > -			pr_crit("%s: CPU %d can't be restored\n",
> > -				__func__, i);
> > -			cpumask_clear_cpu(i, &bL_switcher_removed_logical_cpus);
> > -			break;
> > -		}
> > +		pr_crit("%s: CPU %d can't be restored\n",
> > +			__func__, bL_switcher_cpu_pairing[cpu]);
> > +		cpumask_clear_cpu(bL_switcher_cpu_pairing[cpu],
> > +				  &bL_switcher_removed_logical_cpus);
> >  	}
> >  
> >  	bL_switcher_restore_cpus();
> > -- 
> 
> Other than that:
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks.


Nicolas


> 
