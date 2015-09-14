From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Sep 2015 14:32:47 +0100
Subject: [PATCH v2 3/3] drivers: firmware: psci: add system suspend support
In-Reply-To: <20150914132346.GB25469@red-moon>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-4-git-send-email-sudeep.holla@arm.com>
 <20150914132346.GB25469@red-moon>
Message-ID: <55F6CC7F.6080308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/09/15 14:23, Lorenzo Pieralisi wrote:
> On Thu, Jun 18, 2015 at 03:41:34PM +0100, Sudeep Holla wrote:
>> PSCI v1.0 introduces a new API called PSCI_SYSTEM_SUSPEND. This API
>> provides the mechanism by which the calling OS can request entry into
>> the deepest possible system sleep state.
>>
>> It meets all the necessary preconditions for entering suspend to RAM
>> state in Linux. This patch adds support for PSCI_SYSTEM_SUSPEND in psci
>> firmware and registers a psci system suspend operation to implement the
>> suspend-to-RAM(s2r) in a generic way on all the platforms implementing
>> PSCI.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/firmware/psci.c   | 31 +++++++++++++++++++++++++++++++
>>   include/uapi/linux/psci.h |  3 +++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index 752ca7c9eb97..f2b2b3e1c6e4 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -20,11 +20,13 @@
>>   #include <linux/printk.h>
>>   #include <linux/psci.h>
>>   #include <linux/reboot.h>
>> +#include <linux/suspend.h>
>>
>>   #include <uapi/linux/psci.h>
>>
>>   #include <asm/system_misc.h>
>>   #include <asm/smp_plat.h>
>> +#include <asm/suspend.h>
>>
>>   /*
>>    * While a 64-bit OS can make calls with SMC32 calling conventions, for some
>> @@ -222,6 +224,33 @@ static int __init psci_features(u32 psci_func_id)
>>   			      psci_func_id, 0, 0);
>>   }
>>
>> +static int psci_system_suspend(unsigned long unused)
>> +{
>> +	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
>> +			      virt_to_phys(cpu_resume), 0, 0);
>> +}
>> +
>> +static int psci_system_suspend_enter(suspend_state_t state)
>> +{
>> +	return cpu_suspend(0, psci_system_suspend);
>> +}
>> +
>> +static const struct platform_suspend_ops psci_suspend_ops = {
>> +	.valid          = suspend_valid_only_mem,
>> +	.enter          = psci_system_suspend_enter,
>> +};
>> +
>> +static void __init psci_init_system_suspend(void)
>> +{
>> +	if (!IS_ENABLED(CONFIG_SUSPEND))
>> +		return;
>> +
>> +	if (psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND)))
>> +		return;
>> +
>> +	suspend_set_ops(&psci_suspend_ops);
>
> For consistency with psci_init_cpu_suspend I rewrote it like this:
>
> static void __init psci_init_system_suspend(void)
> {
> 	int ret;
>
> 	if (!IS_ENABLED(CONFIG_SUSPEND))
> 		return;
>
> 	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
>
> 	if (ret != PSCI_RET_NOT_SUPPORTED)
> 		suspend_set_ops(&psci_suspend_ops);
> }
>
> Let me know if it is ok with you. Other than that:
>

Looks fine to me. Thanks for the fixup.

> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>

Thanks.

Regards,
Sudeep
