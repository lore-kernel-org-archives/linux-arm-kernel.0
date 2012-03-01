From: khilman@ti.com (Kevin Hilman)
Date: Thu, 01 Mar 2012 14:37:09 -0800
Subject: [PATCHv3 4/6] ARM: OMAP3 PM: Enable IO Wake up
In-Reply-To: <4F4F1CBA.7040502@ti.com> (Rajendra Nayak's message of "Thu, 01
 Mar 2012 12:22:42 +0530")
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
 <1330525621-29836-5-git-send-email-t-kristo@ti.com>
 <4F4F1CBA.7040502@ti.com>
Message-ID: <87sjhsdk2y.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> On Wednesday 29 February 2012 07:56 PM, Tero Kristo wrote:
>> From: Vishwanath BS<vishwanath.bs@ti.com>
>>
>> Enable IO Wake up for OMAP3 as part of PM Init. Currently this has been
>> managed in cpuidle path which is not the right place. Subsequent patch
>> will remove IO Daisy chain handling in cpuidle path once daisy chain is
>> handled as part of hwmod mux.
>>
>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>> Tested-by: Govindraj.R<govindraj.raja@ti.com>
>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>> ---
>>   arch/arm/mach-omap2/pm34xx.c |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index e97ec3f..e6c2d39 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -793,6 +793,10 @@ static int __init omap3_pm_init(void)
>>   		goto err1;
>>   	}
>>
>> +	if (omap3_has_io_wakeup())
>> +		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
>> +					   PM_WKEN);
>
> On OMAP4 this GLOBAL IO chain enable happens as part of the trigger
> function itself, it might make sense to do that for OMAP3 too to avoid
> similar issues as seen on OMAP4 when the GLOBAL switch is enabled too
> late in boot. The best however would be to get rid of it in the trigger
> function and enable this early during PM init, but I am not sure whats
> a good place to do this 'early' enough.

What about the subsys_initcall() that's already in the prm*.c files?

IMO, the global one-time init doesn't belong in the trigger function
because there's no need to do the extra PRM read/write when it should be
a one-shot init.

Kevin
