From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 7 Apr 2017 17:30:42 +0100
Subject: [PATCHv2 15/16] arm64: pmuv3: handle !PMUv3 when probing
In-Reply-To: <20170407142908.GO19342@arm.com>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
 <1491503363-17731-16-git-send-email-mark.rutland@arm.com>
 <20170407142908.GO19342@arm.com>
Message-ID: <20170407163042.GE858@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 03:29:09PM +0100, Will Deacon wrote:
> >  static void __armv8pmu_probe_pmu(void *info)
> >  {
> > -	struct arm_pmu *cpu_pmu = info;
> > +	struct armv8pmu_probe_info *probe = info;
> > +	struct arm_pmu *cpu_pmu = probe->pmu;
> > +	u64 dfr0;
> >  	u32 pmceid[2];
> >  
> > +	dfr0 = read_sysreg(id_aa64dfr0_el1);
> > +	if (((dfr0 >> ID_AA64DFR0_PMUVER_SHIFT) & 0xf) != 1)
> > +		return;
> 
> Shouldn't we be using one of those fancy cpuid_feature_extract_*_field helpers?

Sure. I can make this:

	u64 dfr0, pmuver;

	...

	dfr0 = read_sysreg(id_aa64dfr0_el1);
	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
			ID_AA64DFR0_PMUVER_SHIFT);
	if (pmuver != 1)
		return;

> It would also be worth spinning this up on qemu, if you get a chance, as
> I don't think that implements the PMU.

I will try to give that a go shortly.

Thanks,
Mark.
