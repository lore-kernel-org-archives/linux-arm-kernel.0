From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 13 Jun 2013 18:31:32 -0400 (EDT)
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <20130613203218.GA22310@quad.lixom.net>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
 <20130613203218.GA22310@quad.lixom.net>
Message-ID: <alpine.LFD.2.03.1306131817310.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Olof Johansson wrote:

> > +config ARCH_VEXPRESS_TC2
> > +	bool "Versatile Express TC2 power management"
> 
> Should there be a _PM in the config option, perhaps? Or maybe take out the
> power management one-line info if it's really just base support for the
> platform.

CONFIG_ARCH_VEXPRESS_TC2_PM it now is.

> > +static int tc2_pm_use_count[3][2];
> 
> A comment describing the purpose of this array would be much beneficial for
> someone reading the driver.

You are right.  It now looks like this:

#define TC2_CLUSTERS                    2
#define TC2_MAX_CPUS_PER_CLUSTER        3

/* Keep per-cpu usage count to cope with unordered up/down requests */
static int tc2_pm_use_count[TC2_MAX_CPUS_PER_CLUSTER][TC2_CLUSTERS];

#define tc2_cluster_unused(cluster) \
        (!tc2_pm_use_count[0][cluster] && \
         !tc2_pm_use_count[1][cluster] && \
         !tc2_pm_use_count[2][cluster])

> > +	if (!tc2_pm_use_count[0][cluster] &&
> > +	    !tc2_pm_use_count[1][cluster] &&
> > +	    !tc2_pm_use_count[2][cluster])
> 
> I see this construct used three times open-coded like this in the file. Adding
> a smaller helper with a descriptive name would be a good idea.

Good observation.  Being too close to this code makes those issues 
invisible.  Hence the tc2_cluster_unused() above.

> Same goes for other direct accesses to the array -- maybe a tiny helper to
> set/get state? It might end up overabstracted that way though.

I would think so.

> > +static void __init tc2_pm_usage_count_init(void)
> > +{
> > +	unsigned int mpidr, cpu, cluster;
> > +
> > +	mpidr = read_cpuid_mpidr();
> > +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > +
> > +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> > +	BUG_ON(cpu >= 3 || cluster >= 2);
> 
> A warning saying that this hardware configuration is not supported would maybe
> be more informal for an user trying to boot some mythical future hardware with
> a too-old kernel.

Hmmm... OK.


Nicolas
