From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Aug 2015 10:08:11 +0100
Subject: [PATCH] thermal: cpu_cooling: fix lockdep problems in cpu_cooling
In-Reply-To: <20150812081142.GB16445@linux>
References: <20150812073530.GA16445@linux>
 <E1ZPQfV-0005nb-DN@rmk-PC.arm.linux.org.uk>
 <20150812081142.GB16445@linux>
Message-ID: <20150812090811.GI7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 01:41:43PM +0530, Viresh Kumar wrote:
> On 12-08-15, 08:41, Russell King wrote:
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> >  /**
> > @@ -221,7 +224,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
> >  	switch (event) {
> >  
> >  	case CPUFREQ_ADJUST:
> > -		mutex_lock(&cooling_cpufreq_lock);
> > +		mutex_lock(&cooling_list_lock);
> 
> There is one more place where the list's locking needs update:
> cpufreq_cooling_get_level().
> 
> >  		list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
> >  			if (!cpumask_test_cpu(policy->cpu,
> >  					      &cpufreq_dev->allowed_cpus))
> > @@ -233,7 +236,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
> >  				cpufreq_verify_within_limits(policy, 0,
> >  							     max_freq);
> >  		}
> > -		mutex_unlock(&cooling_cpufreq_lock);
> > +		mutex_unlock(&cooling_list_lock);
> >  		break;
> >  	default:
> >  		return NOTIFY_DONE;
> > @@ -865,12 +868,15 @@ __cpufreq_cooling_register(struct device_node *np,
> >  	cpufreq_dev->cool_dev = cool_dev;
> >  
> >  	mutex_lock(&cooling_cpufreq_lock);
> > +	mutex_lock(&cooling_list_lock);
> 
> Why is the list lock taken from within the existing lock here? and ...

To preserve the behaviour of the code, which is to atomically add to
the list and register the notifier.

> > +	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> > +	mutex_unlock(&cooling_list_lock);
> >  
> >  	/* Register the notifier for first cpufreq cooling device */
> > -	if (list_empty(&cpufreq_dev_list))
> > +	if (cpufreq_dev_count == 0)
> >  		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> >  					  CPUFREQ_POLICY_NOTIFIER);
> > -	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> > +	cpufreq_dev_count++;
> 
> Maybe:
>         if (!cpufreq_dev_count++)
>                 cpufreq_register_notifier();

Possibly, had the code previously been like that.  See:

commit 2479bb6443d6a793f896219a34bfab0cc410f0b4
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu Dec 4 09:42:04 2014 +0530

which post-dates this patch, and removes this "style" in favour of using
the broken list mechanism.  Frankly... you don't have a leg to stand on
because _you_ knew about this problem, and you saw my patch.  So removing
something that my patch to fix a serious bug relied upon...

You know what?  At this point, I'm just not going to bother.  You fix
this lockdep problem, I'm obviously useless at kernel stuff.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
