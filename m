From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Dec 2015 11:26:13 +0000
Subject: [RFC PATCH v3 2/8] arm64: Move cpu_die_early to smp.c
In-Reply-To: <20151215112338.GD9452@arm.com>
References: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
 <1449655039-22022-3-git-send-email-suzuki.poulose@arm.com>
 <20151215112338.GD9452@arm.com>
Message-ID: <20151215112612.GG31299@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 11:23:39AM +0000, Will Deacon wrote:
> > +/*
> > + * Kill the calling secondary CPU, early in bringup before it is turned
> > + * online.
> > + */
> > +void cpu_die_early(void)
> > +{
> > +	int cpu = smp_processor_id();
> > +
> > +	pr_crit("CPU%d: will not boot\n", cpu);
> > +
> > +	/* Mark this CPU absent */
> > +	set_cpu_present(cpu, 0);
> > +
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +	/* Check if we can park ourselves */
> > +	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
> 
> IS_ENABLED?

The definition of struct cpu_ops has cpu_die in an #ifdef
CONFIG_HOTPLUG_CPU.

Mark.
