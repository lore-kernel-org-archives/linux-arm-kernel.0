From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Jun 2016 17:42:13 +0100
Subject: [PATCH 1/2] arm64: smp: Add function to determine if cpus are
 stuck in the kernel
In-Reply-To: <1466181432.7965.2.camel@infradead.org>
References: <1466156097-20028-1-git-send-email-james.morse@arm.com>
 <1466156097-20028-2-git-send-email-james.morse@arm.com>
 <1466181432.7965.2.camel@infradead.org>
Message-ID: <20160617164213.GE32754@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 09:37:12AM -0700, Geoff Levand wrote:
> On Fri, 2016-06-17 at 10:34 +0100, James Morse wrote:
> > +bool cpus_are_stuck_in_kernel(void)
> > +{
> > +> 	> bool ret = !!cpus_stuck_in_kernel;
> > +#ifdef CONFIG_HOTPLUG_CPU
> 
> How about using 'if (IS_ENABLED(CONFIG_HOTPLUG_CPU))' here?

I wanted to suggest that too, but ...

> > +	int any_cpu = raw_smp_processor_id();
> > +
> > +> 	> if (num_possible_cpus() > 1 && !cpu_ops[any_cpu]->cpu_die)
> > +> 	> 	> ret = true;

... here we'd blow up as cpu_ops::cpu_die is only defined when
CONFIG_HOTPLUG_CPU is selected.

So we'll have to use an ifdef, but we could instead ifdef a whole stub
function (e.g. have_cpu_die()), as Suzuki suggested.

Thanks,
Mark.
