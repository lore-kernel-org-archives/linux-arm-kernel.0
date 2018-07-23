From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Mon, 23 Jul 2018 16:27:34 +0100
Subject: [PATCH 1/4] sched/topology: SD_ASYM_CPUCAPACITY flag detection
In-Reply-To: <dbd8deec-a79d-5697-0c50-ea1a9ab7e5c9@arm.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
 <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
 <dbd8deec-a79d-5697-0c50-ea1a9ab7e5c9@arm.com>
Message-ID: <20180723152551.GA29978@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 02:25:34PM +0100, Qais Yousef wrote:
> Hi Morten
> 
> On 20/07/18 14:32, Morten Rasmussen wrote:
> >The SD_ASYM_CPUCAPACITY sched_domain flag is supposed to mark the
> >sched_domain in the hierarchy where all cpu capacities are visible for
> >any cpu's point of view on asymmetric cpu capacity systems. The
> >scheduler can then take to take capacity asymmetry into account when
> 
> Did you mean "s/take to take/try to take/"?

Yes.


[...]

> >+	/*
> >+	 * Examine topology from all cpu's point of views to detect the lowest
> >+	 * sched_domain_topology_level where a highest capacity cpu is visible
> >+	 * to everyone.
> >+	 */
> >+	for_each_cpu(i, cpu_map) {
> >+		unsigned long max_capacity = arch_scale_cpu_capacity(NULL, i);
> >+		int tl_id = 0;
> >+
> >+		for_each_sd_topology(tl) {
> >+			if (tl_id < asym_level)
> >+				goto next_level;
> >+
> 
> I think if you increment and then continue here you might save the extra
> branch. I didn't look at any disassembly though to verify the generated
> code.
> 
> I wonder if we can introduce for_each_sd_topology_from(tl, starting_level)
> so that you can start searching from a provided level - which will make this
> skipping logic unnecessary? So the code will look like
> 
> ??? ??? ??? for_each_sd_topology_from(tl, asymc_level) {
> ??? ??? ??? ??? ...
> ??? ??? ??? }

Both options would work. Increment+contrinue instead of goto would be
slightly less readable I think since we would still have the increment
at the end of the loop, but easy to do. Introducing
for_each_sd_topology_from() improve things too, but I wonder if it is
worth it.

> >@@ -1647,18 +1707,27 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >  	struct s_data d;
> >  	struct rq *rq = NULL;
> >  	int i, ret = -ENOMEM;
> >+	struct sched_domain_topology_level *tl_asym;
> >  	alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
> >  	if (alloc_state != sa_rootdomain)
> >  		goto error;
> >+	tl_asym = asym_cpu_capacity_level(cpu_map);
> >+
> 
> Or maybe this is not a hot path and we don't care that much about optimizing
> the search since you call it unconditionally here even for systems that
> don't care?

It does increase the cost of things like hotplug slightly and
repartitioning of root_domains a slightly but I don't see how we can
avoid it if we want generic code to set this flag. If the costs are not
acceptable I think the only option is to make the detection architecture
specific.

In any case, AFAIK rebuilding the sched_domain hierarchy shouldn't be a
normal and common thing to do. If checking for the flag is not
acceptable on SMP-only architectures, I can move it under arch/arm[,64]
although it is not as clean.

Morten
