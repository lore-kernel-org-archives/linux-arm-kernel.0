From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 Aug 2016 16:06:35 +0100
Subject: [RFC PATCH v3 6/7] arm64: irqflags: Use ICC sysregs to implement
 IRQ masking
In-Reply-To: <5eb08d32-1223-55f9-24ac-c1909f62aea9@linaro.org>
References: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
 <1471623195-7829-7-git-send-email-daniel.thompson@linaro.org>
 <57BACFF6.6060807@arm.com> <5eb08d32-1223-55f9-24ac-c1909f62aea9@linaro.org>
Message-ID: <57BB14FB.3090903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/16 15:24, Daniel Thompson wrote:
> On 22/08/16 11:12, Marc Zyngier wrote:
>> Hi Daniel,
>>
>> On 19/08/16 17:13, Daniel Thompson wrote:
>>> Currently irqflags is implemented using the PSR's I bit. It is possible
>>> to implement irqflags by using the co-processor interface to the GIC.
>>> Using the co-processor interface makes it feasible to simulate NMIs
>>> using GIC interrupt prioritization.
>>>
>>> This patch changes the irqflags macros to modify, save and restore
>>> ICC_PMR_EL1. This has a substantial knock on effect for the rest of
>>> the kernel. There are four reasons for this:
>>>
>>> 1. The state of the ICC_PMR_EL1_G_BIT becomes part of the CPU context
>>
>> What is this G bit? I can't spot anything like this in the GICv3 spec.
> 
> Good point. This is jargon that hasn't get been defined. Its just an 
> arbitrary bit in the PMR (we don't need to save whole PMR, just the bit 
> we toggle to jump between high and low priority).
> 
> I'll fix the description (and perhaps also add deeper comments to 
> asm/ptrace.h ).
> 
> 
>>>    and must be saved and restored during traps. To simplify the
>>>    additional context management the ICC_PMR_EL1_G_BIT is converted
>>>    into a fake (reserved) bit within the PSR (PSR_G_BIT). Naturally
>>>    this approach will need to be changed if future ARM architecture
>>>    extensions make use of this bit.
>>>
>>> 2. The hardware automatically masks the I bit (at boot, during traps, etc).
>>>    When the I bit is set by hardware we must add code to switch from I
>>>    bit masking and PMR masking.
>>>
>>> 3. Some instructions, noteably wfi, require that the PMR not be used
>>>    for interrupt masking. Before calling these instructions we must
>>>    switch from PMR masking to I bit masking.
>>>
>>> 4. We use the alternatives system to all a single kernel to boot and
>>>    switch between the different masking approaches.
>>>
>>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>>> ---
>>>  arch/arm64/Kconfig                  |  15 +++++
>>>  arch/arm64/include/asm/arch_gicv3.h |  51 +++++++++++++++++
>>>  arch/arm64/include/asm/assembler.h  |  32 ++++++++++-
>>>  arch/arm64/include/asm/irqflags.h   | 106 ++++++++++++++++++++++++++++++++++++
>>>  arch/arm64/include/asm/ptrace.h     |  23 ++++++++
>>>  arch/arm64/kernel/entry.S           |  77 ++++++++++++++++++++++----
>>>  arch/arm64/kernel/head.S            |  35 ++++++++++++
>>>  arch/arm64/kernel/smp.c             |   6 ++
>>>  arch/arm64/mm/proc.S                |  23 ++++++++
>>>  drivers/irqchip/irq-gic-v3.c        |   2 +
>>>  include/linux/irqchip/arm-gic.h     |   2 +-
>>>  11 files changed, 356 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index bc3f00f586f1..56846724d2af 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -718,6 +718,21 @@ config FORCE_MAX_ZONEORDER
>>>  	  However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
>>>  	  4M allocations matching the default size used by generic code.
>>>
>>> +config USE_ICC_SYSREGS_FOR_IRQFLAGS
>>> +	bool "Use ICC system registers for IRQ masking"
>>> +	select CONFIG_ARM_GIC_V3
>>> +	help
>>> +	  Using the ICC system registers for IRQ masking makes it possible
>>> +	  to simulate NMI on ARM64 systems. This allows several interesting
>>> +	  features (especially debug features) to be used on these systems.
>>> +
>>> +	  Say Y here to implement IRQ masking using ICC system
>>> +	  registers. This will result in an unbootable kernel if these
>>
>> Is that a true statement? If so, this is not acceptable. We want a
>> kernel that has this feature enabled to boot on anything, whether it has
>> GICv3 or not. It should disable itself on a GICv2 system.
> 
> It *was* a true statement in v2 but now its completely wrong. The code 
> works just fine on Hikey (where the feature does not deploy).
> 
> Will fix.
> 
> 
> 
>>> +	  registers are not implemented or made inaccessible by the
>>> +	  EL3 firmare or EL2 hypervisor (if present).
>>> +
>>> +	  If unsure, say N
>>> +
>>>  menuconfig ARMV8_DEPRECATED
>>>  	bool "Emulate deprecated/obsolete ARMv8 instructions"
>>>  	depends on COMPAT
>>> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
>>> index fc2a0cb47b2c..a4ad69e2831b 100644
>>> --- a/arch/arm64/include/asm/arch_gicv3.h
>>> +++ b/arch/arm64/include/asm/arch_gicv3.h
>>> @@ -80,6 +80,9 @@
>>>  #include <linux/stringify.h>
>>>  #include <asm/barrier.h>
>>>
>>> +/* Our default, arbitrary priority value. Linux only uses one anyway. */
>>> +#define DEFAULT_PMR_VALUE	0xf0
>>> +
>>>  /*
>>>   * Low-level accessors
>>>   *
>>> @@ -102,9 +105,35 @@ static inline void gic_write_dir(u32 irq)
>>>  static inline u64 gic_read_iar_common(void)
>>>  {
>>>  	u64 irqstat;
>>> +	u64 __maybe_unused daif;
>>> +	u64 __maybe_unused pmr;
>>> +	u64 __maybe_unused default_pmr_value = DEFAULT_PMR_VALUE;
>>>
>>> +#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
>>>  	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
>>>  	dsb(sy);
>>> +#else
>>> +	/*
>>> +	 * The PMR may be configured to mask interrupts when this code is
>>> +	 * called, thus in order to acknowledge interrupts we must set the
>>> +	 * PMR to its default value before reading from the IAR.
>>> +	 *
>>> +	 * To do this without taking an interrupt we also ensure the I bit
>>> +	 * is set whilst we are interfering with the value of the PMR.
>>> +	 */
>>> +	asm volatile(
>>> +		"mrs	%1, daif\n\t"			     /* save I bit  */
>>> +		"msr	daifset, #2\n\t"		     /* set I bit   */
>>> +		"mrs_s  %2, " __stringify(ICC_PMR_EL1) "\n\t"/* save PMR    */
>>> +		"msr_s	" __stringify(ICC_PMR_EL1) ",%3\n\t" /* set PMR     */
>>> +		"mrs_s	%0, " __stringify(ICC_IAR1_EL1) "\n\t" /* ack int   */
>>> +		"msr_s  " __stringify(ICC_PMR_EL1) ",%2\n\t" /* restore PMR */
>>> +		"isb\n\t"
>>> +		"msr	daif, %1"			     /* restore I   */
>>> +		: "=r" (irqstat), "=&r" (daif), "=&r" (pmr)
>>> +		: "r" (default_pmr_value));
>>
>> I'm a bit puzzled by this. Why would you have to mess with PMR or DAIF
>> at this stage? Why can't we just let the GIC priority mechanism do its
>> thing? I'd expect the initial setting of PMR (indicating whether or not
>> we have normal interrupts enabled or not) to be enough to perform the
>> filtering.
>>
>> You may get an NMI while you're already handling an interrupt, but
>> that's fair game, and that's not something we should prevent.
>>
>> What am I missing?
> 
> This code *always* executes with interrupts masked at the PMR and, when 
> interrupts are masked in this way, they cannot be acknowledged.
> 
> So to acknowledge the interrupt we must first modify the PMR to unmask 
> it. If we did that without first ensuring the I-bit is masked we would 
> end up constantly re-trapping.

Right, I see your problem now. I guess that I had a slightly different
view of how to implement it. My own take is that we'd be better off
leaving the I bit alone until we reach the point where we've accessed
the IAR register (hence making the interrupt active and this particular
priority unable to fire:

	irqstat = read_iar();
	clear_i_bit();

At that stage, the only interrupt that can fire is an NMI (or nothing at
all if we're already handling one). The I bit must also be set again on
priority drop (before writing to the EOI register).

This will save you most, if not all, of the faffing with PMR (which
requires an ISB/DSB pair on each update to be guaranteed to have an
effect, and is a good way to kill your performance).

Of course, the drawback is that we still cover a large section of code
using the I bit, but that'd be a good start.

> Note, we could probably avoid saving the DAIF bits and PMR since they 
> both have a known state at this stage in gic_handle_irq(). However it 
> would be such a nasty potential side-effect I think I'd have to refactor 
> things a bit so the mask/unmask dance doesn't happen in the register 
> access functions.

Yeah, there is clearly some redundancy here. And to be completely
honest, I think you should try to split this series in two parts:
- one that implements interrupt masking using PMR
- one that takes care of NMIs and possibly backtracing

At the moment, things are a bit mixed and it is hard to pinpoint what is
really required for what.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
