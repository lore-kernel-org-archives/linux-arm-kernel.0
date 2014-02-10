From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 10 Feb 2014 09:50:16 +0100
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <20140207170903.GT5976@mudshark.cambridge.arm.com>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140207170903.GT5976@mudshark.cambridge.arm.com>
Message-ID: <52F892C8.80508@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2014 06:09 PM, Will Deacon wrote:
> On Fri, Feb 07, 2014 at 04:19:15PM +0000, Fabrice GASNIER wrote:
>> This patch adds imprecise abort enable/disable macros.
>> It also enables imprecise aborts when starting kernel.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>   arch/arm/include/asm/irqflags.h |   33 +++++++++++++++++++++++++++++++++
>>   arch/arm/kernel/smp.c           |    1 +
>>   arch/arm/kernel/traps.c         |    4 ++++
>>   3 files changed, 38 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/irqflags.h b/arch/arm/include/asm/irqflags.h
>> index 3b763d6..82e3834 100644
>> --- a/arch/arm/include/asm/irqflags.h
>> +++ b/arch/arm/include/asm/irqflags.h
>> @@ -51,6 +51,9 @@ static inline void arch_local_irq_disable(void)
>>   
>>   #define local_fiq_enable()  __asm__("cpsie f	@ __stf" : : : "memory", "cc")
>>   #define local_fiq_disable() __asm__("cpsid f	@ __clf" : : : "memory", "cc")
>> +
>> +#define local_abt_enable()  __asm__("cpsie a	@ __sta" : : : "memory", "cc")
>> +#define local_abt_disable() __asm__("cpsid a	@ __cla" : : : "memory", "cc")
>>   #else
>>   
>>   /*
>> @@ -130,6 +133,36 @@ static inline void arch_local_irq_disable(void)
>>   	: "memory", "cc");					\
>>   	})
>>   
>> +/*
>> + * Enable Aborts
>> + */
>> +#define local_abt_enable()					\
>> +	({							\
>> +		unsigned long temp;				\
>> +	__asm__ __volatile__(					\
>> +	"mrs	%0, cpsr		@ sta\n"		\
>> +"	bic	%0, %0, %1\n"					\
>> +"	msr	cpsr_c, %0"					\
>> +	: "=r" (temp)						\
>> +	: "r" (PSR_A_BIT)					\
> Can you use "i" instead of a register for this constant?
Hi,

Sure, I will change it in a future patch.
>
>> +	: "memory", "cc");					\
> You don't need the "cc" clobber.
That surprises me: I think "orr" and "bic" instruction might change N 
and Z bits, depending on the result.
So shouldn't "cc" be placed here ?
I also see that it is used in local_fiq_enable/disable macros just 
above, that are similar:
#define local_fiq_enable()                    \
     ({                            \
         unsigned long temp;                \
     __asm__ __volatile__(                    \
     "mrs    %0, cpsr        @ stf\n"        \
"    bic    %0, %0, #64\n"                    \
"    msr    cpsr_c, %0"                    \
     : "=r" (temp)                        \
     :                            \
     : "memory", "cc");                    \
     })
>>   #endif
>>   
>>   /*
>> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
>> index dc894ab..c2093cb 100644
>> --- a/arch/arm/kernel/smp.c
>> +++ b/arch/arm/kernel/smp.c
>> @@ -377,6 +377,7 @@ asmlinkage void secondary_start_kernel(void)
>>   
>>   	local_irq_enable();
>>   	local_fiq_enable();
>> +	local_abt_enable();
>>   
>>   	/*
>>   	 * OK, it's off to the idle thread for us
>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>> index 4636d56..ef15709 100644
>> --- a/arch/arm/kernel/traps.c
>> +++ b/arch/arm/kernel/traps.c
>> @@ -900,6 +900,10 @@ void __init early_trap_init(void *vectors_base)
>>   
>>   	flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
>>   	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
>> +
>> +	/* Enable imprecise aborts */
>> +	local_abt_enable();
> Surely we want to enable this as early as possible? Now, putting this into
> head.S is ugly, as it duplicating it across all the proc*.S files, so why
> not setup_arch?
Sorry, I'm not sure to understand your last comment.
At least, I need it enabled before probing drivers (PCIe bus)
I've added imprecise abort enable code in traps.c, following Russel 
King's advice, please see:
http://archive.arm.linux.org.uk/lurker/message/20140131.170827.d752a1cc.en.html
As abort bit is local to a cpu, i've also added it in smp.c, but this 
may not be the right place ?

Please elaborate,

Thanks,
Fabrice
>
> Will
