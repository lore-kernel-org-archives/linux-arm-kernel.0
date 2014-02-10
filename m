From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 10 Feb 2014 14:32:51 +0100
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <52F89522.6030302@codethink.co.uk>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140207170903.GT5976@mudshark.cambridge.arm.com> <52F892C8.80508@st.com>
 <52F89522.6030302@codethink.co.uk>
Message-ID: <52F8D503.1080600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2014 10:00 AM, Ben Dooks wrote:
> On 10/02/14 08:50, Fabrice Gasnier wrote:
>> On 02/07/2014 06:09 PM, Will Deacon wrote:
>>> On Fri, Feb 07, 2014 at 04:19:15PM +0000, Fabrice GASNIER wrote:
>>>> This patch adds imprecise abort enable/disable macros.
>>>> It also enables imprecise aborts when starting kernel.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> ---
>>>>   arch/arm/include/asm/irqflags.h |   33
>>>> +++++++++++++++++++++++++++++++++
>>>>   arch/arm/kernel/smp.c           |    1 +
>>>>   arch/arm/kernel/traps.c         |    4 ++++
>>>>   3 files changed, 38 insertions(+)
>>>>
>>>> diff --git a/arch/arm/include/asm/irqflags.h
>>>> b/arch/arm/include/asm/irqflags.h
>>>> index 3b763d6..82e3834 100644
>>>> --- a/arch/arm/include/asm/irqflags.h
>>>> +++ b/arch/arm/include/asm/irqflags.h
>>>> @@ -51,6 +51,9 @@ static inline void arch_local_irq_disable(void)
>>>>   #define local_fiq_enable()  __asm__("cpsie f    @ __stf" : : :
>>>> "memory", "cc")
>>>>   #define local_fiq_disable() __asm__("cpsid f    @ __clf" : : :
>>>> "memory", "cc")
>>>> +
>>>> +#define local_abt_enable()  __asm__("cpsie a    @ __sta" : : :
>>>> "memory", "cc")
>>>> +#define local_abt_disable() __asm__("cpsid a    @ __cla" : : :
>>>> "memory", "cc")
>>>>   #else
>>>>   /*
>>>> @@ -130,6 +133,36 @@ static inline void arch_local_irq_disable(void)
>>>>       : "memory", "cc");                    \
>>>>       })
>>>> +/*
>>>> + * Enable Aborts
>>>> + */
>>>> +#define local_abt_enable()                    \
>>>> +    ({                            \
>>>> +        unsigned long temp;                \
>>>> +    __asm__ __volatile__(                    \
>>>> +    "mrs    %0, cpsr        @ sta\n"        \
>>>> +"    bic    %0, %0, %1\n"                    \
>>>> +"    msr    cpsr_c, %0"                    \
>>>> +    : "=r" (temp)                        \
>>>> +    : "r" (PSR_A_BIT)                    \
>>> Can you use "i" instead of a register for this constant?
>> Hi,
>>
>> Sure, I will change it in a future patch.
>>>
>>>> +    : "memory", "cc");                    \
>>> You don't need the "cc" clobber.
>> That surprises me: I think "orr" and "bic" instruction might change N
>> and Z bits, depending on the result.
>> So shouldn't "cc" be placed here ?
>> I also see that it is used in local_fiq_enable/disable macros just
>> above, that are similar:
>
> No, only if they have the S flag set on the instruction (ORRS,BICS)
>
>
Thank you for pointing that out!
