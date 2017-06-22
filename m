From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 22 Jun 2017 19:59:25 +0530
Subject: [PATCH V2 1/5] arch_topology: Get rid of "cap_parsing_done"
In-Reply-To: <20170622094408.puyfkjglvqtlkq3f@e106622-lin>
References: <cover.1498019799.git.viresh.kumar@linaro.org>
 <3cb2fa07035f9333eeaaee3eab37d090777abb99.1498019799.git.viresh.kumar@linaro.org>
 <20170622094408.puyfkjglvqtlkq3f@e106622-lin>
Message-ID: <20170622142925.GD6314@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-06-17, 10:44, Juri Lelli wrote:
> Hi,
> 
> On 21/06/17 10:16, Viresh Kumar wrote:
> > We can reuse "cap_parsing_failed" instead of keeping an additional
> > variable here.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/base/arch_topology.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index d1c33a85059e..8239a6232808 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -161,7 +161,6 @@ int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> >  
> >  #ifdef CONFIG_CPU_FREQ
> >  static cpumask_var_t cpus_to_visit;
> > -static bool cap_parsing_done;
> >  static void parsing_done_workfn(struct work_struct *work);
> >  static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
> >  
> > @@ -173,7 +172,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> >  	struct cpufreq_policy *policy = data;
> >  	int cpu;
> >  
> > -	if (cap_parsing_failed || cap_parsing_done)
> > +	if (cap_parsing_failed)
> >  		return 0;
> >  
> >  	switch (val) {
> > @@ -193,7 +192,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> >  			topology_normalize_cpu_scale();
> >  			kfree(raw_capacity);
> >  			pr_debug("cpu_capacity: parsing done\n");
> > -			cap_parsing_done = true;
> > +			cap_parsing_failed = true;
> 
> But we didn't actually failed here, right?

Yeah. So I can actually move this patch to the end of the series and
cap_parsing_done can be dropped then as we will end up using
!raw_capacity instead. And the end result will stay the same.

-- 
viresh
