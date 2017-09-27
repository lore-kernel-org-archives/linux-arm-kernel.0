From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Sep 2017 12:26:01 +0100
Subject: [PATCH 2/3] arm64: cpuinfo: add human readable CPU names to
 /proc/cpuinfo
In-Reply-To: <20170926222324.17409-3-ahs3@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170926222324.17409-3-ahs3@redhat.com>
Message-ID: <20170927112600.GD32150@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On Tue, Sep 26, 2017 at 04:23:23PM -0600, Al Stone wrote:
> In the interest of making things easier for humans to use, add a
> "CPU name" line to /proc/cpuinfo for each CPU that uses plain old
> words instead of hex values.  For example, instead of printing only
> CPU implementer 0x43 and CPU part 0x0A1, print also "CPU name :
> Cavium ThunderX".
> 
> Note that this is not meant to be an exhaustive list of all possible
> implementers or CPUs (I'm not even sure that is knowable); this patch
> is intentionally limited to only those willing to provide info in
> arch/arm64/include/asm/cputype.h

As mentioned in the cover letter, and as with previous patches
attempting to do the same thing:

NAK to this patch.

In general, modifying /proc/cpuinfo comes with the risk of breaking
applications that (for better or worse) try to parse it mechanically.
Further, such modifications add to the problem by introducing yet more
ABI state applications may or may not end up depending on to function
(even if they don't require or use the information at all).

Specifically regarding mapping MIDRs to strings in the kernel, there are
a number of problems that make this undesirable, including (but not
limited to):

* As mentioned in the commit message, this cannot be complete, and is
  thus unreliable. We cannot know the set of CPUs that will exist in the
  future, and thus this practically mandates a kernel upgrade to use new
  CPUs, solely for a nicety.

* The names of CPUs can change, so there's not necessarily a single
  correct name to expose. As seen with Cortex-A12 and Cortex-A17 [1],
  where some users were upset if their CPU was considered to be a
  Cortex-A12 rather than a Cortex-A17.

  This embeds a political problem into kernel ABI.

* No matter how many times we tell them not to, applications *will* try
  to parse this. Any change (e.g. typo fixing or naming updates) will
  break some applications. An unexpectedly long CPU name may break
  parses using a small buffer.

  Worse, this could change over a kernel update, as a cpu goes from
  being:
  
    CPU name: unknown
  
  ... to being:

    CPU name: awesome super CPU 2000xx-super-mega-long-name-edition

  ... which could break applications, and some could argue that this is
  a kernel-side regression breaking userspace.

* This information can be derived from the MIDR and REVIDR. The decoded
  MIDR has always been exposed under /proc/cpuinfo, and both are exposed
  in a structured way under:

  /sys/devices/system/cpu/cpu${N}/regs/identification

  This duplicates information that way already expose, but in an
  unreliable fashion.

* This requires us to maintain an ever growing mapping of CPU IDs to
  strings.

* For similar reasons, this information is not exposed by 32-bit ARM,
  and further bifurcates our /proc/cpuinfo formats.

These problems cannot be solved kernel-side, and given this, I will
continue to NAK patches which attempt to decode the MIDR to human
readable strings.

Thanks,
Mark.

[1] https://community.arm.com/processors/b/blog/posts/arm-cortex-a17-cortex-a12-processor-update?CommentId=85c9dea4-1c9a-460c-a7b6-dcf59caab43d&pi10955=99

> 
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/cpuinfo.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index e505007138eb..0b4261884862 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -75,6 +75,61 @@ static const char *const hwcap_str[] = {
>  	NULL
>  };
>  
> +struct hw_part {
> +	u16	id;
> +	char	*name;
> +};
> +
> +static const struct hw_part arm_hw_part[] = {
> +	{ ARM_CPU_PART_AEM_V8,		"AEMv8 Model" },
> +	{ ARM_CPU_PART_FOUNDATION,	"Foundation Model" },
> +	{ ARM_CPU_PART_CORTEX_A57,	"Cortex A57" },
> +	{ ARM_CPU_PART_CORTEX_A53,	"Cortex A53" },
> +	{ ARM_CPU_PART_CORTEX_A73,	"Cortex A73" },
> +	{ (-1), "unknown" }		/* Potenza == 0, unfortunately */
> +};
> +
> +static const struct hw_part apm_hw_part[] = {
> +	{ APM_CPU_PART_POTENZA,		"Potenza" },
> +	{ (-1), "unknown" }		/* Potenza == 0, unfortunately */
> +};
> +
> +static const struct hw_part brcm_hw_part[] = {
> +	{ BRCM_CPU_PART_VULCAN,		"Vulcan" },
> +	{ (-1), "unknown" }		/* Potenza == 0, unfortunately */
> +};
> +
> +static const struct hw_part cavium_hw_part[] = {
> +	{ CAVIUM_CPU_PART_THUNDERX,	 "ThunderX" },
> +	{ CAVIUM_CPU_PART_THUNDERX_81XX, "ThunderX 81XX" },
> +	{ CAVIUM_CPU_PART_THUNDERX_83XX, "ThunderX 83XX" },
> +	{ (-1), "unknown" }		/* Potenza == 0, unfortunately */
> +};
> +
> +static const struct hw_part qcom_hw_part[] = {
> +	{ QCOM_CPU_PART_FALKOR_V1,	"Falkor v1" },
> +	{ (-1), "unknown" }		/* Potenza == 0, unfortunately */
> +};
> +
> +static const struct hw_part unknown_hw_part[] = {
> +	{ (-1), "unknown" }		/* Potenza == 0, unfortunately */
> +};
> +
> +struct hw_impl {
> +	u8			id;
> +	const struct hw_part	*parts;
> +	char			*name;
> +};
> +
> +static const struct hw_impl hw_implementer[] = {
> +	{ ARM_CPU_IMP_ARM,	arm_hw_part,	"ARM Ltd." },
> +	{ ARM_CPU_IMP_APM,	apm_hw_part,	"Applied Micro" },
> +	{ ARM_CPU_IMP_CAVIUM,	cavium_hw_part,	"Cavium" },
> +	{ ARM_CPU_IMP_BRCM,	brcm_hw_part,	"Broadcom" },
> +	{ ARM_CPU_IMP_QCOM,	qcom_hw_part,	"Qualcomm" },
> +	{ 0, unknown_hw_part, "unknown" }
> +};
> +
>  #ifdef CONFIG_COMPAT
>  static const char *const compat_hwcap_str[] = {
>  	"swp",
> @@ -116,6 +171,9 @@ static int c_show(struct seq_file *m, void *v)
>  {
>  	int i, j;
>  	bool compat = personality(current->personality) == PER_LINUX32;
> +	u8 impl;
> +	u16 part;
> +	const struct hw_part *parts;
>  
>  	for_each_online_cpu(i) {
>  		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
> @@ -132,6 +190,32 @@ static int c_show(struct seq_file *m, void *v)
>  			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
>  				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
>  
> +		impl = (u8) MIDR_IMPLEMENTOR(midr);
> +		for (j = 0; hw_implementer[j].id != 0; j++) {
> +			if (hw_implementer[j].id == impl) {
> +				seq_printf(m, "CPU name\t: %s ",
> +					   hw_implementer[j].name);
> +				parts = hw_implementer[j].parts;
> +				break;
> +			}
> +		}
> +		if (hw_implementer[j].id == 0) {
> +			seq_printf(m, "CPU name\t: %s ",
> +				   hw_implementer[j].name);
> +			parts = hw_implementer[j].parts;
> +		}
> +
> +		part = (u16) MIDR_PARTNUM(midr);
> +		for (j = 0; parts[j].id != (-1); j++) {
> +			if (parts[j].id == part) {
> +				seq_printf(m, "%s\n", parts[j].name);
> +				break;
> +			}
> +		}
> +		if (parts[j].id == (-1))
> +			seq_printf(m, "%s", parts[j].name);
> +		seq_puts(m, "\n");
> +
>  		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
>  			   loops_per_jiffy / (500000UL/HZ),
>  			   loops_per_jiffy / (5000UL/HZ) % 100);
> -- 
> 2.13.5
> 
