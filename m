From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Thu, 31 Aug 2017 13:13:59 +0200
Subject: [RFC PATCH v9 5/7] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170831103119.GC15031@leverpostej>
References: <20170829131238.4988-1-jglauber@cavium.com>
 <20170829131238.4988-6-jglauber@cavium.com>
 <a89f597e-885d-a8bd-f6ce-452d7025cb20@hisilicon.com>
 <20170831095746.GB15906@hc> <20170831103119.GC15031@leverpostej>
Message-ID: <20170831111359.GC15906@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 11:31:20AM +0100, Mark Rutland wrote:
> On Thu, Aug 31, 2017 at 11:57:46AM +0200, Jan Glauber wrote:
> > On Wed, Aug 30, 2017 at 10:54:03AM +0800, Zhangshaokun wrote:
> > > On 2017/8/29 21:12, Jan Glauber wrote:
> > > > Add support for the PMU counters on Cavium SOC memory controllers.
> > > > 
> > > > This patch also adds generic functions to allow supporting more
> > > > devices with PMU counters.
> 
> > > > +/* generic struct to cover the different pmu types */
> > > > +struct cvm_pmu_dev {
> > > > +	struct pmu pmu;
> > > > +	const char *pmu_name;
> > > 
> > > It seems that pmu_name is redundant since struct pmu has a name field,
> > > Mark has mentioned it in HiSilicon uncore PMU driver, Link:
> > > https://patchwork.kernel.org/patch/9861821/
> > 
> > I don't get it. perf_pmu_register() just copies the char* from the
> > argument into pmu->name. Somewhere the string must be allocated.
> > That's why I have cvm_pmu_dev->pmu_name.
> 
> I'm not sure I follow. cvm_pmu_dev->pmu_name is just a char *, so what
> does that have to do with allocation?

As you pointed out here:
https://lkml.org/lkml/2017/6/2/530
perf_pmu_register does not copy the string, so _somewhere_ the name must
be allocated and freed afterwards. Are you suggesting to use pmu.name
directly to allocate the name there and pass
perf_register_pmu(..., tlk->pmu.name, ...)?

--Jan

> ... unless you mean you want to allocate this in some variant-specific
> code prior to passing it to code which calls perf_pmu_register(), and
> you just need a place to stash it in the mean time?



[...]

> THanks,
> Mark.
