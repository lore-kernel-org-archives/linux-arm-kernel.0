From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 14 Aug 2015 17:53:00 -0400
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <55CE05EC.4040909@oracle.com>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com> <20150814140934.GX7557@n2100.arm.linux.org.uk>
 <55CE05EC.4040909@oracle.com>
Message-ID: <55CE633C.10402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2015 11:14 AM, santosh shilimkar wrote:
> On 8/14/2015 7:09 AM, Russell King - ARM Linux wrote:
>> On Fri, Aug 14, 2015 at 10:04:41AM -0400, Murali Karicheri wrote:
>>> On 08/11/2015 03:13 PM, Murali Karicheri wrote:
>>>> Currently on some devices, an asynchronous external abort exception
>>>> happens during boot up when exception handlers are enabled in kernel
>>>> before switching to user space. This patch adds a workaround to handle
>>>> this once during boot. Many customers are already using this
>>>> with out any issues and is required to workaround the above issue.
>>>>
>>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>>> ---
>>>>   arch/arm/mach-keystone/keystone.c | 26 ++++++++++++++++++++++++++
>>>>   1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-keystone/keystone.c
>>>> b/arch/arm/mach-keystone/keystone.c
>>>> index e2880105..c1d0fe5 100644
>>>> --- a/arch/arm/mach-keystone/keystone.c
>>>> +++ b/arch/arm/mach-keystone/keystone.c
>>>> @@ -15,6 +15,7 @@
>>>>   #include <linux/of_platform.h>
>>>>   #include <linux/of_address.h>
>>>>   #include <linux/memblock.h>
>>>> +#include <linux/signal.h>
>>>>
>>>>   #include <asm/setup.h>
>>>>   #include <asm/mach/map.h>
>>>> @@ -52,6 +53,24 @@ static struct notifier_block platform_nb = {
>>>>       .notifier_call = keystone_platform_notifier,
>>>>   };
>>>>
>>>> +static bool ignore_first = true;
>>>> +static int keystone_async_ext_abort_fault(unsigned long addr,
>>>> unsigned int fsr,
>>>> +                      struct pt_regs *regs)
>>>> +{
>>>> +    /*
>>>> +     * if first time, ignore this as this is a asynchronous
>>>> external abort
>>>> +     * happening only some devices that couldn't be root caused and
>>>> we add
>>>> +     * this work around to handle this first time.
>>>> +     */
>>>> +    if (ignore_first) {
>>>> +        ignore_first = false;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    /* Subsequent ones should be handled as fault */
>>>> +    return 1;
>>>> +}
>>>> +
>>>>   static void __init keystone_init(void)
>>>>   {
>>>>       if (PHYS_OFFSET >= KEYSTONE_HIGH_PHYS_START) {
>>>> @@ -61,6 +80,13 @@ static void __init keystone_init(void)
>>>>       }
>>>>       keystone_pm_runtime_init();
>>>>       of_platform_populate(NULL, of_default_bus_match_table, NULL,
>>>> NULL);
>>>> +
>>>> +    /*
>>>> +     * Add a one time exception handler to catch asynchronous external
>>>> +     * abort
>>>> +     */
>>>> +    hook_fault_code(17, keystone_async_ext_abort_fault, SIGBUS, 0,
>>>> +            "async external abort handler");
>>>>   }
>>>>
>>>>   static phys_addr_t keystone_virt_to_idmap(unsigned long x)
>>>>
>>> Can this be applied if it looks good?
>>
>> What causes the abort?  We shouldn't be adding hacks like this to the
>> kernel without having the full picture...
>>
> Indeed. These external aborts are notorious and often hides dangerous
> bugs. On OMAP as well many folks burn their had with it till the
> interconnect handlers were added to detect those and hunt those
> bugs.
>
> In my experience such aborts happen outside ARM subsystem, either in
> the interconnect or at the salve targets which are reported over
> the ARM bus as async external aborts. And often these errors are
> due to bad accesses/wrong accesses/un-clocked accesses at slaves.
>
We have spend some time already to debug the root cause. Do you have 
idea on how this was hunted down on OMAP that we can learn from? The bad 
address is NULL and it seems to happen very rarely and is not easily 
reproducible. Don't want to put this workaround, but we couldn't track 
it down either. So any help to debug this will be appreciated.

Murali

> Regards,
> Santosh
>
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone
