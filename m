From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 28 May 2015 15:02:25 +0200
Subject: [PATCH v3 4/5] arm64: alternative: Introduce feature for GICv3
 CPU interface
In-Reply-To: <5566DF72.4050507@arm.com>
References: <1427461765-14462-1-git-send-email-marc.zyngier@arm.com>
 <1427461765-14462-5-git-send-email-marc.zyngier@arm.com>
 <20150514112523.GQ32765@cbox> <5566DF72.4050507@arm.com>
Message-ID: <20150528130225.GD18009@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 10:27:14AM +0100, Marc Zyngier wrote:
> On 14/05/15 12:25, Christoffer Dall wrote:
> > On Fri, Mar 27, 2015 at 01:09:24PM +0000, Marc Zyngier wrote:
> >> Add a new item to the feature set (ARM64_HAS_SYSREG_GIC_CPUIF)
> >> to indicate that we have a system register GIC CPU interface
> >>
> >> This will help KVM switching to alternative instruction patching.
> >>
> >> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> >> Acked-by: Will Deacon <will.deacon@arm.com>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  arch/arm64/include/asm/cpufeature.h |  8 +++++++-
> >>  arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++++++
> >>  2 files changed, 23 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >> index 6ae35d1..d9e57b5 100644
> >> --- a/arch/arm64/include/asm/cpufeature.h
> >> +++ b/arch/arm64/include/asm/cpufeature.h
> >> @@ -23,8 +23,9 @@
> >>  
> >>  #define ARM64_WORKAROUND_CLEAN_CACHE		0
> >>  #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
> >> +#define ARM64_HAS_SYSREG_GIC_CPUIF		2
> >>  
> >> -#define ARM64_NCAPS				2
> >> +#define ARM64_NCAPS				3
> >>  
> >>  #ifndef __ASSEMBLY__
> >>  
> >> @@ -37,6 +38,11 @@ struct arm64_cpu_capabilities {
> >>  			u32 midr_model;
> >>  			u32 midr_range_min, midr_range_max;
> >>  		};
> >> +
> >> +		struct {	/* Feature register checking */
> >> +			u64 register_mask;
> >> +			u64 register_value;
> >> +		};
> >>  	};
> >>  };
> >>  
> >> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >> index 3d9967e..b0bea2b3 100644
> >> --- a/arch/arm64/kernel/cpufeature.c
> >> +++ b/arch/arm64/kernel/cpufeature.c
> >> @@ -22,7 +22,23 @@
> >>  #include <asm/cpu.h>
> >>  #include <asm/cpufeature.h>
> >>  
> >> +static bool
> >> +has_id_aa64pfr0_feature(const struct arm64_cpu_capabilities *entry)
> >> +{
> >> +	u64 val;
> >> +
> >> +	val = read_cpuid(id_aa64pfr0_el1);
> > 
> > is this preferred compared to fishing it out of cpuinfo ?
> 
> Probably for the moment, yes. At some point, we should be able to have a
> consolidated set of features, consistent across all CPUs in the system.
> Once we have that, we should revisit this detection mecanism.
> 
> >> +	return (val & entry->register_mask) == entry->register_value;
> >> +}
> >> +
> >>  static const struct arm64_cpu_capabilities arm64_features[] = {
> >> +	{
> >> +		.desc = "system register GIC CPU interface",
> >> +		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
> >> +		.matches = has_id_aa64pfr0_feature,
> >> +		.register_mask = (0xf << 24),
> >> +		.register_value = (1 << 24),
> > 
> > I don't know if it's worth defining these masks in some header file.
> > The only other place I could see them used was in head.S.
> 
> Mark was looking at this a while ago. Maybe a task for a sleepless
> night? ;-)
> 

yeah, you can add this to the patch if it helps:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

-Christoffer
