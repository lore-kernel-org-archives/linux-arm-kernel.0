From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 07 Nov 2014 16:07:51 +0000
Subject: [PATCHv3 4/5] arm64: Emulate CP15 Barrier instructions
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-6-git-send-email-punit.agrawal@arm.com>
 <20141105130513.GH32700@e104818-lin.cambridge.arm.com>
Message-ID: <9hhk3372duw.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Oct 27, 2014 at 06:40:06PM +0000, Punit Agrawal wrote:
>> diff --git a/Documentation/arm64/legacy_instructions.txt b/Documentation/arm64/legacy_instructions.txt
>> index 5ab5861..a3b3da2 100644
>> --- a/Documentation/arm64/legacy_instructions.txt
>> +++ b/Documentation/arm64/legacy_instructions.txt
>> @@ -38,3 +38,8 @@ Supported legacy instructions
>>  Node: /proc/sys/abi/swp
>>  Status: Obsolete
>>  Default: Undef (0)
>> +
>> +* CP15 Barriers
>> +Node: /proc/sys/abi/cp15_barrier
>> +Status: Deprecated
>> +Default: Emulate (1)
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6ae8079..2f7026e 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -199,6 +199,21 @@ config SWP_EMULATION
>>  
>>  	  If unsure, say N
>>  
>> +config CP15_BARRIER_EMULATION
>> +	bool "Emulate CP15 Barrier instructions"
>> +	help
>> +	  The CP15 barrier instructions - CP15ISB, CP15DSB, and
>> +	  CP15DMB - are deprecated in ARMv8 (and ARMv7). It is
>> +	  strongly recommended to use the ISB, DSB, and DMB
>> +	  instructions instead.
>> +
>> +	  Say Y here to enable software emulation of these
>> +	  instructions for AArch32 userspace code. When this option is
>> +	  enabled, CP15 barrier usage is traced which can help
>> +	  identify software that needs updating.
>> +
>> +	  If unsure, say N
>> +
>>  endif
>
> default y (I think we had a discussion in private whether deprecated
> should default to y and obsolete to y or n but I don't remember the
> conclusion; it's worth adding it to the Documentation/ file).

Based on the outcome of the discussion, I've documented the runtime
defaults ('undef' for obsolete and 'emulation' for deprecated instructions)
in the previous patch (3/5).

As for Kconfig, the conclusion was to keep them off by default. The
rationale was that they can be enabled quite easily and would form
another way to communicate that certain features are deprecated and
software might need updating.

>
>> +#define SCTLR_EL1_CP15BEN (1 << 5)
>> +
>> +static inline void config_sctlr_el1(u32 clear, u32 set)
>> +{
>> +	u32 val;
>> +
>> +	asm volatile("mrs %0, sctlr_el1" : "=r" (val));
>> +	val &= ~clear;
>> +	val |= set;
>> +	asm volatile("msr sctlr_el1, %0" : : "r" (val));
>> +}
>> +
>> +static void enable_cp15_ben(void *info)
>> +{
>> +	config_sctlr_el1(0, SCTLR_EL1_CP15BEN);
>> +}
>> +
>> +static void disable_cp15_ben(void *info)
>> +{
>> +	config_sctlr_el1(SCTLR_EL1_CP15BEN, 0);
>> +}
>> +
>> +static int cpu_hotplug_notify(struct notifier_block *b, unsigned long action,
>> +			  void *hcpu)
>> +{
>> +	switch (action) {
>> +	case CPU_STARTING:
>> +		enable_cp15_ben(NULL);
>> +		return NOTIFY_DONE;
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>
> Do we need CPU_STARTING_FROZEN as well?

Added this now.

Thinking about this, I think I want to disable this bit for CPUs being
hot-unplugged otherwise we might end up with an inconsistent state
across cores. I'll fix this up for the next version.

>
> This code always enables the CP15 barriers in hardware but it should
> take into account the actual state (emulation, undef).

The actual state is taken into account in the previous patch (3/5
function: update_insn_emulation_mode) and the hotplug notifier is only
installed to handle offlined CPUs when hardware execution is requested.
