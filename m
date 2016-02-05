From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 5 Feb 2016 09:02:39 +0000
Subject: [PATCH v3 20/23] arm64: perf: Count EL2 events if the kernel is
 running in HYP
In-Reply-To: <20160204192301.GG13974@cbox>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
 <1454522416-6874-21-git-send-email-marc.zyngier@arm.com>
 <20160204192301.GG13974@cbox>
Message-ID: <56B4652F.4030407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/16 19:23, Christoffer Dall wrote:
> On Wed, Feb 03, 2016 at 06:00:13PM +0000, Marc Zyngier wrote:
>> When the kernel is running in HYP (with VHE), it is necessary to
>> include EL2 events if the user requests counting kernel or
>> hypervisor events.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kernel/perf_event.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index f7ab14c..6013a38 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -20,6 +20,7 @@
>>   */
>>  
>>  #include <asm/irq_regs.h>
>> +#include <asm/virt.h>
>>  
>>  #include <linux/of.h>
>>  #include <linux/perf/arm_pmu.h>
>> @@ -693,10 +694,15 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>>  		return -EPERM;
>>  	if (attr->exclude_user)
>>  		config_base |= ARMV8_EXCLUDE_EL0;
>> -	if (attr->exclude_kernel)
>> -		config_base |= ARMV8_EXCLUDE_EL1;
>> -	if (!attr->exclude_hv)
>> -		config_base |= ARMV8_INCLUDE_EL2;
>> +	if (is_kernel_in_hyp_mode()) {
>> +		if (!attr->exclude_kernel || !attr->exclude_hv)
>> +			config_base |= ARMV8_INCLUDE_EL2;
> 
> is exclude_hv a perf generic construct?

Yes. It seems to be universally used on all architectures.

> is it really correct to count everything the host kernel does (even
> unrelated to running VMs) when counting hypervisor events?

With VHE, the roles are blurred, and the PMU can only count events
occurring when at a given exception level. It has no notion of context.

> Other than my ignorance in this area, this patch looks fine to me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
