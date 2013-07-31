From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 31 Jul 2013 10:41:28 +0100
Subject: [PATCH 12/13] ARM: bL_switcher: remove assumptions between
 logical and physical CPUs
In-Reply-To: <alpine.LFD.2.03.1307301502120.15022@syhkavp.arg>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-13-git-send-email-nicolas.pitre@linaro.org>
 <20130730163010.GA8921@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1307301502120.15022@syhkavp.arg>
Message-ID: <20130731094127.GB6583@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 08:15:02PM +0100, Nicolas Pitre wrote:
> On Tue, 30 Jul 2013, Lorenzo Pieralisi wrote:
> 
> > On Tue, Jul 23, 2013 at 04:31:28AM +0100, Nicolas Pitre wrote:
> > > Up to now, the logical CPU was somehow tied to the physical CPU number
> > > within a cluster.  This causes problems when forcing the boot CPU to be
> > > different from the first enumerated CPU in the device tree creating a
> > > discrepancy between logical and physical CPU numbers.
> > > 
> > > Let's make the pairing completely independent from physical CPU numbers.
> > > 
> > > Let's keep only those logical CPUs with same initial CPU cluster to create
> > > a uniform scheduler profile without having to modify any of the probed
> > > topology and compute capacity data.  This has the potential to create
> > > a non contiguous CPU numbering space when the switcher is active with
> > > potential impact on buggy user space tools.  It is however better to fix
> > > those tools rather than making the switcher code more intrusive.
> > 
> > Nico, I am not following you here. Is this not the same problem we
> > have in a system where we hotplug out some of the CPUs in the logical map ?
> 
> Yes, it is.  Although with the switcher, user space does initialize with 
> holes in the logical CPU map since some CPUs have been hotplugged out 
> before the boot completed which is something some tools are not 
> expecting.  And it did cause problems with Android for example, although 
> that has been fixed now.

Well, fixing them is a good thing to do, as you mentioned, so it is not
your problem.

> > [...]
> > 
> > >  static void bL_switcher_restore_cpus(void)
> > > @@ -319,52 +322,86 @@ static void bL_switcher_restore_cpus(void)
> > >  
> > >  static int bL_switcher_halve_cpus(void)
> > >  {
> > > -	int cpu, cluster, i, ret;
> > > -	cpumask_t cluster_mask[2], common_mask;
> > > -
> > > -	cpumask_clear(&bL_switcher_removed_logical_cpus);
> > > -	cpumask_clear(&cluster_mask[0]);
> > > -	cpumask_clear(&cluster_mask[1]);
> > > +	int i, j, cluster_0, gic_id, ret;
> > > +	unsigned int cpu, cluster, mask;
> > > +	cpumask_t available_cpus;
> > >  
> > > +	/* First pass to validate what we have */
> > > +	mask = 0;
> > >  	for_each_online_cpu(i) {
> > > -		cpu = cpu_logical_map(i) & 0xff;
> > > -		cluster = (cpu_logical_map(i) >> 8) & 0xff;
> > > +		cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 0);
> > > +		cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 1);
> > >  		if (cluster >= 2) {
> > >  			pr_err("%s: only dual cluster systems are supported\n", __func__);
> > >  			return -EINVAL;
> > >  		}
> > > -		cpumask_set_cpu(cpu, &cluster_mask[cluster]);
> > > +		if (WARN_ON(cpu >= MAX_CPUS_PER_CLUSTER))
> > 
> > pr_warn ?
> 
> I dunno.  What's the policy for choosing between those two?
> Obviously this is a "shouldn't happen" case.

For sure we have to bail out of there if that's hit, whether you need a
stack dump or not, I do not know, probably we don't, but that's arguable.

> > > +			return -EINVAL;
> > > +		mask |= (1 << cluster);
> > >  	}
> > > -
> > > -	if (!cpumask_and(&common_mask, &cluster_mask[0], &cluster_mask[1])) {
> > > -		pr_err("%s: no common set of CPUs\n", __func__);
> > > +	if (mask != 3) {
> > 
> > Technically, you might have two clusters with eg MPIDR[15:8] = {0,2}
> > this would break this code. Just saying, I know for now we can live with that.
> > Given that's the only usage of mask you might use a counter, just as well.
> 
> Well, there are assumptions about the cluster encoding all over the 
> place, so this is a stop gap to trap anything which is not following the 
> 0,1 enumeration.
> 
> This assumption could be fixed eventually if it turns to e false on some 
> hardware.

Yes, you are absolutely right, for now as I mentioned let's live with this
restriction.

Lorenzo
