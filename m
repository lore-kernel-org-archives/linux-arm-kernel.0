From: peter.chen@nxp.com (Peter Chen)
Date: Wed, 17 Aug 2016 07:58:55 +0000
Subject: [PATCH] ARM: irq_work: Do not attempt to IPI on non IPI-capable HW
In-Reply-To: <57B41523.6030202@arm.com>
References: <1471361210-29914-1-git-send-email-marc.zyngier@arm.com>
 <CAL411-pUUdxN_d76FaXYGtEd7Seewnrin=x2mFEbi1Z48zSRvg@mail.gmail.com>
 <57B41523.6030202@arm.com>
Message-ID: <VI1PR04MB1455E9F56D0EDA0558CC84508B140@VI1PR04MB1455.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>On 17/08/16 04:15, Peter Chen wrote:
>> On Tue, Aug 16, 2016 at 11:26 PM, Marc Zyngier <marc.zyngier@arm.com>
>wrote:
>>> Not all of the ARM HW is IPI capable (i.e. most of the non-SMP
>>> systems). Unfortunately, some systems do advertise being SMP capable,
>>> even if they have a single core and do not define a cross call
>>> method.
>>
>> Could you example it? I find all current set_smp_cross_call is defined
>> under CONFIG_SMP.
>
>This doesn't mean that the system will be SMP at runtime (SMP_ON_UP).
>
 
I am puzzled that how you would like to check IPI capable, at runtime
or according to kernel configuration?

>>>
>>>  static inline bool arch_irq_work_has_interrupt(void)  {
>>> -       return is_smp();
>>> +#ifdef CONFIG_SMP
>>
>> Why not using is_smp as condition, it is more strict.
>>
>> if (is_smp())
>>     return !!__smp_cross_call;
>> else
>>     return false;
>
>What's the gain? We're trying to check whether we can actually deliver
>an IPI. Why should we gate it by finding out whether we're smp_on_up or not?
>

If UP system with CONFIG_SMP enabled, the __smp_cross_call is not
NULL, but the IPI is not capable. Or am I missing something?

Peter
