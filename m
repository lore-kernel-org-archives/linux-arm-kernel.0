From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2016 10:07:37 +0100
Subject: [PATCH] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <20160610170220.GC23223@arm.com>
References: <1465571984-18776-1-git-send-email-suzuki.poulose@arm.com>
 <20160610170220.GC23223@arm.com>
Message-ID: <20160613090736.GA18097@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 06:02:21PM +0100, Will Deacon wrote:
> On Fri, Jun 10, 2016 at 04:19:44PM +0100, Suzuki K Poulose wrote:
> > From: Steve Capper <steve.capper@linaro.org>
> > 
> > It can be useful for JIT software to be aware of MIDR_EL1 and
> > REVIDR_EL1 to ascertain the presence of any core errata that could
> > affect codegen.
> > 
> > This patch exposes these registers through sysfs:
> > 
> > /sys/devices/system/cpu/cpu$ID/identification/midr
> > /sys/devices/system/cpu/cpu$ID/identification/revidr
> > 
> > where $ID is the cpu number. For big.LITTLE systems, one can have a
> > mixture of cores (e.g. Cortex A53 and Cortex A57), thus all CPUs need
> > to be enumerated.
> > 
> > If the kernel does not have valid information to populate these entries
> > with, an empty string is returned to userspace.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > [ Return error for access to !present CPU registers ]
> > Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> > ---
> > Changes since V2:
> >   - Fix errno for failures (Spotted-by: Russell King)
> >   - Roll back, if we encounter a missing cpu device
> >   - Return error for access to registers of CPUs not present.
> > ---
> >  arch/arm64/include/asm/cpu.h |  1 +
> >  arch/arm64/kernel/cpuinfo.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> > index 13a6103..116a382 100644
> > --- a/arch/arm64/include/asm/cpu.h
> > +++ b/arch/arm64/include/asm/cpu.h
> > @@ -29,6 +29,7 @@ struct cpuinfo_arm64 {
> >  	u32		reg_cntfrq;
> >  	u32		reg_dczid;
> >  	u32		reg_midr;
> > +	u32		reg_revidr;
> >  
> >  	u64		reg_id_aa64dfr0;
> >  	u64		reg_id_aa64dfr1;
> > diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> > index c173d32..c2d0c42 100644
> > --- a/arch/arm64/kernel/cpuinfo.c
> > +++ b/arch/arm64/kernel/cpuinfo.c
> > @@ -212,6 +212,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
> >  	info->reg_ctr = read_cpuid_cachetype();
> >  	info->reg_dczid = read_cpuid(DCZID_EL0);
> >  	info->reg_midr = read_cpuid_id();
> > +	info->reg_revidr = read_cpuid(REVIDR_EL1);
> >  
> >  	info->reg_id_aa64dfr0 = read_cpuid(ID_AA64DFR0_EL1);
> >  	info->reg_id_aa64dfr1 = read_cpuid(ID_AA64DFR1_EL1);
> > @@ -264,3 +265,71 @@ void __init cpuinfo_store_boot_cpu(void)
> >  	boot_cpu_data = *info;
> >  	init_cpu_features(&boot_cpu_data);
> >  }
> > +
> > +#define CPUINFO_ATTR_RO(_name)							\
> > +	static ssize_t show_##_name (struct device *dev,			\
> > +			struct device_attribute *attr, char *buf)		\
> > +	{									\
> > +		struct cpuinfo_arm64 *info = &per_cpu(cpu_data, dev->id);	\
> > +		if (!cpu_present(dev->id))					\
> > +			return -ENODEV;						\
> > +										\
> > +		if (info->reg_midr)						\
> > +			return sprintf(buf, "0x%016x\n", info->reg_##_name);	\
> 
> Should this be 0x%08x, as these are 32-bit registers?

That's a difficult question to answer. Per C5.1.1, "Principles of the
System instruction class encoding" in ARM DDI 0487A.i, when a system
register is escribed as 32-bit, this only means that the upper 32 bits
are RES0, not that they will never be made use of.

CLIDR_EL1 (previously described as a 32-bit register) is now a 64-bit
register, so clearly extension is possible.

I imagine that otehr registers (e.g. MIDR_EL1) may also get extended in
future, and I think we need to treat "32-bit registers" as 64-bit, to
account for future allocation of the RES0 bits.

On that note, we should probably rework the sanity checks code to read
all registers as 64 bit.

Thanks,
Mark.
