From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Jun 2016 14:13:33 +0100
Subject: [PATCH v2 1/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1466559926.22191.203.camel@buserror.net>
References: <1463114260-8724-1-git-send-email-oss@buserror.net>
 <20160513112441.200f4349@arm.com> <1466559926.22191.203.camel@buserror.net>
Message-ID: <5771267D.7030102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/16 02:45, Scott Wood wrote:
> On Fri, 2016-05-13 at 11:24 +0100, Marc Zyngier wrote:
>> On Thu, 12 May 2016 23:37:39 -0500
>> Scott Wood <oss@buserror.net> wrote:
>>
>> Hi Scott,
>>
>>> Erratum A-008585 says that the ARM generic timer counter "has the
>>> potential to contain an erroneous value for a small number of core
>>> clock cycles every time the timer value changes".  Accesses to TVAL
>>> (both read and write) are also affected due to the implicit counter
>>> read.  Accesses to CVAL are not affected.
>>>
>>> The workaround is to reread TVAL and count registers until successive
>>> reads
>>> return the same value, and when writing TVAL to retry until counter
>>> reads before and after the write return the same value.
>>>
>>> This erratum can be found on LS1043A and LS2080A.
>>>
>>> Signed-off-by: Scott Wood <oss@buserror.net>
>>> ---
>>> v2:
>>> Significant rework based on feedback, including using static_key,
>>> disabling VDSO counter access rather than adding the workaround to the
>>> VDSO, and uninlining the loops.
>>>
>>> Dropped the separate property for indicating that writes to TVAL are
>>> affected, as I believe that's just a side effect of the implicit
>>> counter read being corrupted, and thus a chip that is affected by one
>>> will always be affected by the other.
>>>
>>> Dropped the arm32 portion as it seems there was confusion about whether
>>> LS1021A is affected.  Currently I am being told that it is not
>>> affected.
>>>
>>> I considered writing to CVAL rather than looping on TVAL writes, but
>>> that would still have required separate set_next_event() code for the
>>> erratum, and adding CVAL to the enum would have required a bunch of
>>> extra handlers in switch statements (even where unused, due to compiler
>>> warnings about unhandled enum values) including in an arm32 header.  It
>>> seemed better to avoid the arm32 interaction and new untested
>>> accessors.
>>> ---
>>>  .../devicetree/bindings/arm/arch_timer.txt         |   6 ++
>>>  arch/arm64/include/asm/arch_timer.h                |  37 +++++--
>>>  drivers/clocksource/arm_arch_timer.c               | 110
>>> +++++++++++++++++++++
>>>  3 files changed, 144 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt
>>> b/Documentation/devicetree/bindings/arm/arch_timer.txt
>>> index e774128..ef5fbe9 100644
>>> --- a/Documentation/devicetree/bindings/arm/arch_timer.txt
>>> +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
>>> @@ -25,6 +25,12 @@ to deliver its interrupts via SPIs.
>>>  - always-on : a boolean property. If present, the timer is powered
>>> through an
>>>    always-on power domain, therefore it never loses context.
>>>  
>>> +- fsl,erratum-a008585 : A boolean property. Indicates the presence of
>>> +  QorIQ erratum A-008585, which says that reading the counter is
>>> +  unreliable unless the same value is returned by back-to-back reads.
>>> +  This also affects writes to the tval register, due to the implicit
>>> +  counter read.
>>> +
>>>  ** Optional properties:
>>>  
>>>  - arm,cpu-registers-not-fw-configured : Firmware does not initialize
>>
>> This should be part of a separate patch. Also, errata should be
>> documented in Documentation/arm64/silicon-errata.txt.
> 
> Oh right, forgot.
> 
>>> +extern struct static_key_false arch_timer_read_ool_enabled;
>>> +
>>> +#define ARCH_TIMER_REG_READ(reg, func) \
>>> +extern u64 func##_ool(void); \
>>> +static inline u64 __##func(void) \
>>> +{ \
>>> +	u64 val; \
>>> +	asm volatile("mrs %0, " reg : "=r" (val)); \
>>> +	return val; \
>>> +} \
>>> +static inline u64 _##func(void) \
>>> +{ \
>>> +	if (static_branch_unlikely(&arch_timer_read_ool_enabled)) \
>>> +		return func##_ool(); \
>>> +	else \
>>> +		return __##func(); \
>>> +}
>>> +
>>> +ARCH_TIMER_REG_READ("cntp_tval_el0", arch_timer_get_ptval)
>>> +ARCH_TIMER_REG_READ("cntv_tval_el0", arch_timer_get_vtval)
>>> +ARCH_TIMER_REG_READ("cntvct_el0", arch_counter_get_cntvct)
>>> +
>>
>> Given that this will have a (small) impact on non-affected platforms,
>> it'd be good to have this guarded by a erratum-specific config option
>> (CONFIG_FSL_ERRATUM_008585?) and turn it into trivial accessors when not
>> defined.
> 
> OK.
> 
>>
>>>  /*
>>>   * These register accessors are marked inline so the compiler can
>>>   * nicely work out which register we want, and chuck away the rest of
>>> @@ -66,19 +89,19 @@ u32 arch_timer_reg_read_cp15(int access, enum
>>> arch_timer_reg reg)
>>>  	if (access == ARCH_TIMER_PHYS_ACCESS) {
>>>  		switch (reg) {
>>>  		case ARCH_TIMER_REG_CTRL:
>>> -			asm volatile("mrs %0,  cntp_ctl_el0" : "=r"
>>> (val));
>>> +			asm volatile("mrs %0, cntp_ctl_el0" : "=r"
>>> (val));
>>
>> Spurious change?
> 
> The extra spacing seemed to be an attempt to get things to line up between the
> CTRL and TVAL asm statements.  When the TVAL case was converted to a function
> call, there was nothing for the above to line up with, so I moved it back to
> normal spacing.
> 
>>> +{
>>> +	u64 cval_old, cval_new;
>>> +	int timeout = 200;
>>
>> Can we have a comment on how this value has been chosen? 
> 
> It's an arbitrary value well beyond the point at which we've seen it fail.

So can we please have a comment *in the code* that explains how this
value has been picked?

> 
>>> @@ -232,6 +274,50 @@ static __always_inline void set_next_event(const int
>>> access, unsigned long evt,
>>>  	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
>>>  }
>>>  
>>> +#ifdef CONFIG_ARM64
>>> +static __always_inline void rewrite_tval(const int access,
>>> +		unsigned long evt, struct clock_event_device *clk)
>>> +{
>>> +	u64 cval_old, cval_new;
>>> +	int timeout = 200;
>>> +
>>> +	do {
>>> +		cval_old = __arch_counter_get_cntvct();
>>> +		arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt,
>>> clk);
>>> +		cval_new = __arch_counter_get_cntvct();
>>
>> Don't you need to guarantee the order of accesses here?
> 
> I'm not 100% sure.  The erratum workaround sample code doesn't show any
> barriers, and adding more barriers could make it harder for the loop to
> successfully complete.  There's already a barrier after the write, so the only
> concern should be whether the timer read could be reordered after the timer
> write, which could cause the loop to exit even if the write was bad.  Do you
> know if A53 or A57 will reorder a counter read relative to a tval write?

I can't see any absolute guarantee that they wouldn't be reordered (but
I have no insight on the micro-architecture either). I'd rather err on
the side of caution here.

> 
>>> +#endif /* ARM64 */
>>> +
>>>  static int arch_timer_set_next_event_virt(unsigned long evt,
>>>  					  struct clock_event_device *clk)
>>>  {
>>> @@ -277,6 +363,13 @@ static void __arch_timer_setup(unsigned type,
>>>  			clk->set_state_shutdown =
>>> arch_timer_shutdown_virt;
>>>  			clk->set_state_oneshot_stopped =
>>> arch_timer_shutdown_virt;
>>>  			clk->set_next_event =
>>> arch_timer_set_next_event_virt;
>>> +
>>> +#ifdef CONFIG_ARM64
>>> +			if
>>> (static_branch_unlikely(&arch_timer_read_ool_enabled))
>>> +				clk->set_next_event =
>>> +					arch_timer_set_next_event_virt_er
>>> rata;
>>
>> On the same line, please.
> 
> I was trying to avoid going beyond 80 columns.

Please ignore what checkpatch says. Readability is more important (and
I've given up using a vintage vt100...).

> 
>>> @@ -485,6 +585,13 @@ static void __init arch_counter_register(unsigned
>>> type)
>>>  			arch_timer_read_counter =
>>> arch_counter_get_cntvct;
>>>  		else
>>>  			arch_timer_read_counter =
>>> arch_counter_get_cntpct;
>>> +
>>> +		/*
>>> +		 * Don't use the vdso fastpath if errata require using
>>> +		 * the out-of-line counter accessor.
>>> +		 */
>>> +		if (static_branch_unlikely(&arch_timer_read_ool_enabled))
>>> +			clocksource_counter.name =
>>> "arch_sys_counter_ool";
>>
>> This looks really ugly. How about telling the vdso subsystem directly?
>> Will, do you have a preference?
> 
> I was following the example set by "arch_mem_counter".

The right thing should probably be to use a flag in the clocksource
structure to mark it as "suitable for vdso", but I guess we can fix that
in a subsequent patch.

> 
>>>  	} else {
>>>  		arch_timer_read_counter = arch_counter_get_cntvct_mem;
>>>  
>>> @@ -763,6 +870,9 @@ static void __init arch_timer_of_init(struct
>>> device_node *np)
>>>  
>>>  	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>>>  
>>> +	if (of_property_read_bool(np, "fsl,erratum-a008585"))
>>> +		static_branch_enable(&arch_timer_read_ool_enabled);
>>> +
>>>  	/*
>>>  	 * If we cannot rely on firmware initializing the timer registers
>>> then
>>>  	 * we should use the physical timers instead.
>>
>> An outstanding question is how we're going to deal with this in KVM,
>> because a guest absolutely needs to know about it (I can definitely see
>> time jumping in guests running on a LS2080).
> 
> The property will need to be in the guest's device tree.  I'm not too familiar
> with how KVM handles device trees on arm...  From looking at the QEMU source
> it seems that the dtb is passed in by the user.  So either that dtb will need
> the erratum property in it, or QEMU (and KVM tool?) would need to patch it
>  into the guest dtb based on seeing the property in /proc/device-tree.

There is no guarantee that the host device tree is always accessible to
userspace. So we're probably looking at requiring a new KVM device API
that would expose the timer properties, one of them being this erratum.
That's certainly going to be fun to handle.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
