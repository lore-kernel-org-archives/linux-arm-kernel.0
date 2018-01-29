From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 29 Jan 2018 17:06:28 +0000
Subject: [PATCH 07/16] arm64: capabilities: Filter the entries based on a
 given type
In-Reply-To: <bea651c0-9184-79ea-5613-c59fa6c64a79@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-8-suzuki.poulose@arm.com>
 <20180126112217.GO5862@e103592.cambridge.arm.com>
 <bea651c0-9184-79ea-5613-c59fa6c64a79@arm.com>
Message-ID: <20180129170627.GA5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 12:21:43PM +0000, Suzuki K Poulose wrote:
> On 26/01/18 11:22, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:28:00PM +0000, Suzuki K Poulose wrote:
> >>While processing the list of capabilities, it is useful to
> >>filter out some of the entries based on the given type to
> >>allow better control. This can be used later for handling
> >>LOCAL vs SYSTEM wide capabilities and more.
> >>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  arch/arm64/include/asm/cpufeature.h |  5 +++++
> >>  arch/arm64/kernel/cpufeature.c      | 30 ++++++++++++++++++++----------
> >>  2 files changed, 25 insertions(+), 10 deletions(-)
> >>
> >>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >>index 27d037bb0451..a621d2184227 100644
> >>--- a/arch/arm64/include/asm/cpufeature.h
> >>+++ b/arch/arm64/include/asm/cpufeature.h
> >>@@ -99,6 +99,11 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
> >>  /* Is it safe for a late CPU to miss this capability when system has it */
> >>  #define ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS	BIT(3)
> >>+#define ARM64_CPUCAP_TYPE_ALL			 \
> >>+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|\
> >>+	 ARM64_CPUCAP_SCOPE_SYSTEM		|\
> >>+	 ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE	|\
> >>+	 ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS)
> >
> >Nit: can we have another tab between | and \?
> >
> >This will help to make missing |s stand out more if/when more entries
> >are added to this list in future.
> >
> 
> Sure, will do.
> 
> >>  /*
> >>   * CPU errata detected at boot time based on feature of one or more CPUs.
> >>   * It is not safe for a late CPU to have this feature when the system doesn't
> >>diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c

[...]

> >>@@ -1204,12 +1206,13 @@ static int __enable_cpu_capability(void *arg)
> >>   * Run through the enabled capabilities and enable() it on all active
> >>   * CPUs
> >>   */
> >>-static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
> >>+static void __init
> >>+enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 caps_type)
> >
> >The "caps_type" argument should be named consistently with the
> >corresponding argument to update_cpu_capabilities().

[...]

> >>  static void verify_local_cpu_errata_workarounds(void)
> >>  {
> >>-	if (__verify_local_cpu_caps(arm64_errata))
> >>+	if (!__verify_local_cpu_caps(arm64_errata, ARM64_CPUCAP_TYPE_ALL))
> >>  		cpu_die_early();
> >
> >Did you mean to insert the ! here?
> 
> Thanks for spotting. I think it should have been there in the first place,
> as we get "false" when there is a conflict. I will fix the previous patch which
> adds the call.

Oh, right.  Yes, I think that probably makes sense.

Cheers
---Dave
