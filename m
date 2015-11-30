From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 30 Nov 2015 15:00:42 +0530
Subject: [PATCH v4 3/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
In-Reply-To: <1448875581.29031.14.camel@mtksdaap41>
References: <1448616727-29367-1-git-send-email-dawei.chien@mediatek.com>
 <1448616727-29367-4-git-send-email-dawei.chien@mediatek.com>
 <20151130053845.GM3373@ubuntu>
 <1448875581.29031.14.camel@mtksdaap41>
Message-ID: <20151130093042.GA8556@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-11-15, 17:26, dawei chien wrote:
> On Mon, 2015-11-30 at 11:08 +0530, Viresh Kumar wrote:
> > On 27-11-15, 17:32, Dawei Chien wrote:
> > > MT8173 cpufreq driver use of_cpufreq_power_cooling_register registering
> > > cooling devices with dynamic power coefficient.
> > > 
> > > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > > ---
> > > This patch is base on patchset:
> > > https://lkml.org/lkml/2015/11/17/251
> > > ---
> > >  drivers/cpufreq/mt8173-cpufreq.c |   28 ++++++++++++++++++++--------
> > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> > > index 83001dc..4d39468 100644
> > > --- a/drivers/cpufreq/mt8173-cpufreq.c
> > > +++ b/drivers/cpufreq/mt8173-cpufreq.c
> > > @@ -263,24 +263,34 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
> > >  	return 0;
> > >  }
> > >  
> > > +#define DYNAMIC_POWER "dynamic-power-coefficient"
> > > +
> > >  static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
> > >  {
> > >  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
> > >  	struct device_node *np = of_node_get(info->cpu_dev->of_node);
> > > +	u32 capacitance;
> > >  
> > >  	if (WARN_ON(!np))
> > >  		return;
> > >  
> > >  	if (of_find_property(np, "#cooling-cells", NULL)) {
> > > -		info->cdev = of_cpufreq_cooling_register(np,
> > > -							 policy->related_cpus);
> > > +		if (!info->cdev) {
> > 
> > Why will info->cdev be non-NULL here ?
> 
> This is a error-checking to avoid user or any script by command line hotplug CPU
> more than two times, we don't need to register cooling device on this case.

Why?

> I will remove it if you don't agree it.

No, my agreeing or not doesn't matter. If what you are doing is useful
(and I am not able to understand it), then you should make me
understand that and don't change your code.

But, I really do not get the reasoning behind the logic. Please
elaborate that step by step.

> > > @@ -460,7 +470,9 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
> > >  {
> > >  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
> > >  
> > > -	cpufreq_cooling_unregister(info->cdev);
> > > +	if (info->cdev)
> > > +		cpufreq_cooling_unregister(info->cdev);
> > > +
> > 
> > Why do you need to update this?
> 
> This is a error-checking to avoid user or any script by command line
> unplug CPU more than two times, we don't need to unregister cooling
> device on this case.
> 
> I will remove it if you don't agree it.

Same here.

-- 
viresh
