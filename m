From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 27 Mar 2014 15:21:30 +0100
Subject: [PATCH 1/6] ARM: mvebu: introduce CPU reset code
In-Reply-To: <533431C0.2040402@gmail.com>
References: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1395927485-11842-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <533431C0.2040402@gmail.com>
Message-ID: <20140327152130.1fbcac9e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Thu, 27 Mar 2014 15:12:16 +0100, Sebastian Hesselbarth wrote:
> > +static struct of_device_id of_cpu_reset_table[] = {
> > +	{.compatible = "marvell,armada-370-cpu-reset", .data = (void*) ARMADA_370_MAX_CPUS },
> > +	{.compatible = "marvell,armada-xp-cpu-reset",  .data = (void*) ARMADA_XP_MAX_CPUS },
> > +	{ /* end of list */ },
> > +};
> > +
> > +static void __iomem *cpu_reset_base;
> > +static int ncpus;
> > +
> > +#define CPU_RESET_OFFSET(cpu) (cpu * 0x8)
> > +#define CPU_RESET_ASSERT      BIT(0)
> > +
> > +int mvebu_cpu_reset_deassert(int cpu)
> > +{
> > +	u32 reg;
> > +
> > +	if (cpu >= ncpus)
> > +		return -EINVAL;
> 
> Is this check required at all? I mean, the function is supposed to
> be called from sane environments, that determine cpu to reset from
> some ID register or so. Removing the check will allow you to remove
> ncpus and therefore the scratchy (void *)CONST in the of_device_ids
> above.

Just a safety check to ensure we're not writing outside of the CPU
reset registers that have been mapped. I more or less tend to believe
that it's nicer to have APIs that do some minimal amount of checking
and return an error, rather than having things completely blow up when
arguments are wrong.

But I certainly understand that this is a very subjective view, and I
wouldn't mind changing the code according to your suggestion if other
people agree with it.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
