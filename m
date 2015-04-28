From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 28 Apr 2015 09:08:43 -0500
Subject: [PATCH 1/2] clocksource: arm_arch_timer: add
 arch_timer_okay_for_vdso
In-Reply-To: <20150427105509.GC1544@arm.com>
References: <1429911801-6069-1-git-send-email-nathan_lynch@mentor.com>
 <20150427105509.GC1544@arm.com>
Message-ID: <553F946B.7030306@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2015 05:55 AM, Will Deacon wrote:
> On Fri, Apr 24, 2015 at 10:43:20PM +0100, Nathan Lynch wrote:
>> The 32-bit ARM VDSO needs to know whether a generic timer is present
>> and whether it is suitable for use by user space.  The VDSO
>> initialization code currently duplicates some of the logic from the
>> driver to make this determination, but unfortunately it is incomplete;
>> it will incorrectly enable the VDSO if HYP mode is available or if no
>> interrupt is provided for the virtual timer (see arch_timer_init).  In
>> these cases the driver will switch to memory-backed access while the
>> VDSO will attempt to access the counter using cp15 reads.
>>
>> Add an arch_timer_okay_for_vdso API which can reliably inform the VDSO
>> init code whether the arch timer is present and usable.
>>
>> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 12 ++++++++++++
>>  include/clocksource/arm_arch_timer.h |  6 ++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 0aa135ddbf80..b75215523d2f 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -462,6 +462,18 @@ struct timecounter *arch_timer_get_timecounter(void)
>>  	return &timecounter;
>>  }
>>  
>> +/* The ARM VDSO init code needs to know:
>> + * - whether a cp15-based arch timer is present; and if so
>> + * - whether the physical or virtual counter is being used.
>> + */
>> +bool arch_timer_okay_for_vdso(void)
>> +{
>> +	if (!(arch_timers_present & ARCH_CP15_TIMER))
>> +		return false;
>> +
>> +	return arch_timer_use_virtual;
>> +}
> 
> If we're adding this, then it wouldn't hurt to use the same check in
> arch/arm64 when we update_vsyscall(...). Could we also encapsulate the
> `current clocksource' knowledge in there too, to remove the hardcoded
> "arch_sys_counter" check from the arch code?

While I think it makes sense to consolidate the current clocksource check,
I view that as distinct from this (which needs to run at boot, before
anything uses the vdso).

I'm actually now unsure about whether the implementation I have here
is correct.  Take arch_timer_init:

static void __init arch_timer_init(void)
{
	/*
	 * If HYP mode is available, we know that the physical timer
	 * has been configured to be accessible from PL1. Use it, so
	 * that a guest can use the virtual timer instead.
	 *
	 * If no interrupt provided for virtual timer, we'll have to
	 * stick to the physical timer. It'd better be accessible...
	 */
	if (is_hyp_mode_available() || !arch_timer_ppi[VIRT_PPI]) {
		arch_timer_use_virtual = false;

		if (!arch_timer_ppi[PHYS_SECURE_PPI] ||
		    !arch_timer_ppi[PHYS_NONSECURE_PPI]) {
			pr_warn("arch_timer: No interrupt available, giving up\n");
			return;
		}
	}

	arch_timer_register();
	arch_timer_common_init();
}

I assume this has been working fine for arm64 up to this point --
i.e. arch_timer_use_virtual is false, but the VDSO continues to use
the virtual counter and gets correct results?  If so, I don't see any
reason this wouldn't be true for ARM.  So I'm thinking
arch_timer_use_virtual isn't the right proxy for determining
whether the VDSO can work correctly.

The reason I initially turned to arch_timer_use_virtual is in
arch_timer_of_init:

	/*
	 * If we cannot rely on firmware initializing the timer registers then
	 * we should use the physical timers instead.
	 */
	if (IS_ENABLED(CONFIG_ARM) &&
	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
			arch_timer_use_virtual = false;

I definitely need to catch that case, and this is currently duplicated in
arch/arm/kernel/vdso.c.  Maybe this should toggle an additional boolean,
say "arch_timer_cntvct_ok", which captures the information that is truly
of interest with respect to the VDSO using the virtual counter.
