From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 May 2015 10:10:57 +0100
Subject: [PATCHv2 02/12] arm64: smp_plat: add get_logical_index
In-Reply-To: <20150519083154.GU21251@e104818-lin.cambridge.arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-3-git-send-email-mark.rutland@arm.com>
 <20150518170912.GI21251@e104818-lin.cambridge.arm.com>
 <20150518175532.GC7064@leverpostej>
 <20150519083154.GU21251@e104818-lin.cambridge.arm.com>
Message-ID: <20150519091057.GA32656@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +/*
> > > > + * Retrieve logical cpu index corresponding to a given MPIDR.Aff*
> > > > + *  - mpidr: MPIDR.Aff* bits to be used for the look-up
> > > > + *
> > > > + * Returns the cpu logical index or -EINVAL on look-up error
> > > > + */
> > > > +static inline int get_logical_index(u64 mpidr)
> > > > +{
> > > > +	int cpu;
> > > > +	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> > > > +		if (cpu_logical_map(cpu) == mpidr)
> > > > +			return cpu;
> > > > +	return -EINVAL;
> > > > +}
> > > 
> > > Do we guarantee that mpidr here only contains the affinity bits (i.e. no
> > > masking)?
> > 
> > In the DT and ACPI probe paths we reject IDs with bits other than the
> > aff bits set.
> > 
> > I don't currently have a sanity check in the code handling
> > MIGRATE_INFO_UP_CPU, but I should add one.
> > 
> > Would you like a warning here too?
> 
> Or maybe just the warning if the code paths to this function already
> mask out the non-affinity bits.

Sure; that's what I meant about a sanity check in the code handling
MIGRATE_INFO_UP_CPU (where query a CPU ID from the PSCI implementation).
I'll see about adding a warning there.

In the DT and ACPI parsing cases we already warn if non-affinity bits
are set.

Thanks,
Mark.
