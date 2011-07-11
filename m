From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 11 Jul 2011 16:36:15 +0100
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <20110709084508.GF4812@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709083815.GE4812@n2100.arm.linux.org.uk>
	<20110709084508.GF4812@n2100.arm.linux.org.uk>
Message-ID: <20110711153615.GA1103@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 09, 2011 at 09:45:08AM +0100, Russell King - ARM Linux wrote:
> On Sat, Jul 09, 2011 at 09:38:15AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 07, 2011 at 04:50:18PM +0100, Lorenzo Pieralisi wrote:
> > > +static int late_init(void)
> > > +{
> > > +	int rc;
> > > +	struct sr_cluster *cluster;
> > > +	int cluster_index, cpu_index = sr_platform_get_cpu_index();
> > 
> > Stop this madness, and use the standard linux APIs like smp_processor_id
> > here.  It might actually help you find bugs, like the fact that you're
> > in a preemptible context here, and so could be rescheduled onto any other
> > CPU in the system _after_ you've read the MPIDR register.
> > 

You are right, wanted to make all code uniform and rushed in a change
which is bound to create issues.

> > > +
> > > +	cluster_index = sr_platform_get_cluster_index();
> > > +	cluster = main_table.cluster_table + cluster_index;
> > > +	main_table.os_mmu_context[cluster_index][cpu_index] =
> > > +				current->active_mm->pgd;
> > > +	cpu_switch_mm(main_table.fw_mmu_context, current->active_mm);
> > > +	rc = sr_platform_init();
> > > +	cpu_switch_mm(main_table.os_mmu_context[cluster_index][cpu_index],
> > > +				current->active_mm);
> > 
> > CPU numbers are unique in the system, why do you need a 'cluster_index'
> > to save this?  In fact why do you even need to save it in a structure
> > at all?
> > 
> > Plus, "cluster" is not used, please get rid of it.
> 
> Oh, that's another thing.  This thread is about introducing idle support
> not cluster support.  Cluster support is surely something different (esp.
> as it seems from the above code that you're trying to support several
> clusters of MPCore CPUs, each with physical 0-N CPU numbers.)
> 
> Cluster support should be an entirely separate patch series.
> 

Yes it is cluster support, within idle though, that has to be said;
I will introduce it in a different patch as suggested and this patch 
will have to rely on it.

[...]

> In any case, smp_processor_id() will be (and must be) unique in any given
> running kernel across all CPUs, even if you have clusters of N CPUs all
> physically numbered 0-N.
> 

Indeed.
