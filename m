From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 25 Jun 2015 12:01:36 -0400
Subject: [PATCH] keystone: psci: adds cpu_die implementation
In-Reply-To: <558C174F.80108@oracle.com>
References: <1435240970-30869-1-git-send-email-vitalya@ti.com>
 <20150625144511.GA6844@leverpostej> <558C174F.80108@oracle.com>
Message-ID: <558C25E0.3010102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/25/2015 10:59 AM, santosh shilimkar wrote:
> On 6/25/2015 7:45 AM, Mark Rutland wrote:
>> Hi,
>>
>> On Thu, Jun 25, 2015 at 03:02:50PM +0100, Vitaly Andrianov wrote:
>>> This commit add cpu_die implementation using psci api
>>
>> I don't understand. If you have a PSCI implementation, it should be
>> sufficient to have a PSCI node (and enable-method) in your DT, and the
>> generic code will be used. Nothing should be required in your board
>> code.
>>
>> You should also use CPU_ON to bring secondaries online rather than
>> mixing up PSCI and platform-specific mechanisms.
>>
> Good point about CPU_ON. We need that as well.
>
Does it mean that keystone_defconfig must always have CONFIG_HOTPLUG_CPU 
and CONFIG_ARM_PSCI enabled?

What is if someone doesn't want to have HOTPLUG_CPU?
How he can boot secondary CPU w/o platform-specific mechanizm?


>>>
>>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>>> ---
>>>   arch/arm/mach-keystone/platsmp.c | 32 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-keystone/platsmp.c
>>> b/arch/arm/mach-keystone/platsmp.c
>>> index 5f46a7c..2c40cc0 100644
>>> --- a/arch/arm/mach-keystone/platsmp.c
>>> +++ b/arch/arm/mach-keystone/platsmp.c
>>> @@ -20,6 +20,7 @@
>>>   #include <asm/prom.h>
>>>   #include <asm/tlbflush.h>
>>>   #include <asm/pgtable.h>
>>> +#include <asm/psci.h>
>>>
>>>   #include "keystone.h"
>>>
>>> @@ -51,7 +52,38 @@ static inline void __cpuinit
>>> keystone_smp_secondary_initmem(unsigned int cpu)
>>>   {}
>>>   #endif
>>>
>>> +
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +static void keystone_cpu_die(unsigned int cpu)
>>> +{
>>> +#ifdef CONFIG_ARM_PSCI
>>> +    struct psci_power_state pwr_state = {0, 0, 0};
>>> +
>>> +    pr_info("keystone_cpu_die(%d) from %d using PSCI\n", cpu,
>>> +           smp_processor_id());
>>> +
>>> +    if (psci_ops.cpu_off)
>>> +        psci_ops.cpu_off(pwr_state);
>>> +#else
>>> +    /*
>>> +     * We may want to add here a direct smc call to monitor
>>> +     * if the kernel doesn't support PSCI API
>>> +     */
>>> +#endif
>>
>> You should determine this from your DT. Your FW/bootloader can patch in
>> the relevant nodes and properties when support is present, so the
>> presence of such nodes should guarantee that PSCI is available.
>>
> That will be a nice trick. FW already does some tweaks of dts for
> LPAE/non_LPAE tweaks.
>
> Regards,
> Santosh

Thanks,
-Vitaly
