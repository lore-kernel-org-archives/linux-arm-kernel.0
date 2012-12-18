From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Dec 2012 10:49:27 +0000
Subject: [PATCH v2 6/6] ARM: mach-virt: add SMP support using PSCI
In-Reply-To: <alpine.LFD.2.02.1212171555570.1263@xanadu.home>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-7-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1212171555570.1263@xanadu.home>
Message-ID: <20121218104927.GA9632@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 09:45:52PM +0000, Nicolas Pitre wrote:
> On Mon, 17 Dec 2012, Will Deacon wrote:
> > This patch adds support for SMP to mach-virt using the PSCI
> > infrastructure.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>

[...]

> > +/*
> > + * Enumerate the possible CPU set from the device tree.
> > + */
> > +static void __init virt_smp_init_cpus(void)
> > +{
> > +	struct device_node *dn = NULL;
> > +	int cpu = 0;
> > +
> > +	while ((dn = of_find_node_by_type(dn, "cpu"))) {
> > +		if (cpu < NR_CPUS)
> > +			set_cpu_possible(cpu, true);
> > +		cpu++;
> > +	}
> > +
> > +	/* sanity check */
> > +	if (cpu > NR_CPUS)
> > +		pr_warning("no. of cores (%d) greater than configured maximum "
> > +			   "of %d - clipping\n",
> > +			   cpu, NR_CPUS);
> 
> Since commit 5587164eea you shouldn't need any of the above.

There's going to be nothing left at this rate! Thanks.

> > +#ifdef CONFIG_SMP
> > +extern struct smp_operations virt_smp_ops;
> > +#endif
> 
> You don't need to surround prototype declaration here, unless your goal 
> was to define a dummy virt_smp_ops when CONFIG_SMP is not selected?
> Otherwise the reference below would break compilation.

Right you are, the smp_ops macro does the magic for us. I'll put together a
v3.

Cheers,

Will

> > +
> >  DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
> >  	.init_irq	= gic_init_irq,
> >  	.handle_irq     = gic_handle_irq,
> >  	.timer		= &virt_timer,
> >  	.init_machine	= virt_init,
> > +	.smp		= smp_ops(virt_smp_ops),
> >  	.dt_compat	= virt_dt_match,
> >  MACHINE_END
> > -- 
> > 1.8.0
> > 
> 
