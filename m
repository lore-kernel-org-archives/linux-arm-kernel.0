From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Sep 2012 15:46:42 +0100
Subject: [PATCH v3 1/2] ARM: arch_timers: enable the use of the virtual
 timer
In-Reply-To: <503FB0C1.5040309@ti.com>
References: <1345819976-6339-1-git-send-email-marc.zyngier@arm.com>
 <1345819976-6339-2-git-send-email-marc.zyngier@arm.com>
 <503FB0C1.5040309@ti.com>
Message-ID: <50461452.6000308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyril,

On 30/08/12 19:28, Cyril Chemparathy wrote:
> On 8/24/2012 10:52 AM, Marc Zyngier wrote:
>> At the moment, the arch_timer driver only uses the physical timer,
>> which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
>> which is likely in a virtualized environment. Instead, the virtual
>> timer is always available.
>>
>> This patch enables the use of the virtual timer, unless no
>> interrupt is provided in the DT for it, in which case it falls
>> back to the physical timer.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Looks very nice...  Minor comments below.
> 

[...]

>>
>> -static irqreturn_t arch_timer_handler(int irq, void *dev_id)
>> +static inline cycle_t arch_counter_get_cntpct(void)
>>   {
>> -     struct clock_event_device *evt = *(struct clock_event_device **)dev_id;
>> -     unsigned long ctrl;
>> +     u32 cvall, cvalh;
>> +
>> +     asm volatile("mrrc p15, 0, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
>> +
>> +     return ((cycle_t) cvalh << 32) | cvall;
>> +}
>> +
>> +static inline cycle_t arch_counter_get_cntvct(void)
>> +{
>> +     u32 cvall, cvalh;
>> +
>> +     asm volatile("mrrc p15, 1, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
>> +
>> +     return ((cycle_t) cvalh << 32) | cvall;
>> +}
> 
> We should use the Q and R qualifiers to avoid compiler misbehavior:
>         u64 cval;
>         asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (cvall));
> 
> The compiler generates sad looking code when constructing 64-bit
> quantities with shifts and ORs.  We found this while implementing the
> phys-virt patching for 64-bit phys_addr_t.

Very good point. Looks a lot nicer.

> Is there value in unifying the physical and virtual counter read
> functions using the access specifier as you've done for the register
> read and write functions?

Not a bad idea. At least it makes the access look almost uniform.

>>
>> -static inline cycle_t arch_counter_get_cntpct(void)
>> +static u32 notrace arch_counter_get_cntpct32(void)
>>   {
>> -     u32 cvall, cvalh;
>> +     cycle_t cnt = arch_counter_get_cntpct();
>>
>> -     asm volatile("mrrc p15, 0, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
>> -
>> -     return ((cycle_t) cvalh << 32) | cvall;
>> -}
>> -
>> -static inline cycle_t arch_counter_get_cntvct(void)
>> -{
>> -     u32 cvall, cvalh;
>> -
>> -     asm volatile("mrrc p15, 1, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
>> -
>> -     return ((cycle_t) cvalh << 32) | cvall;
>> +     /*
>> +      * The sched_clock infrastructure only knows about counters
>> +      * with at most 32bits. Forget about the upper 24 bits for the
>> +      * time being...
>> +      */
>> +     return (u32)(cnt & (u32)~0);
> 
> Wouldn't a return (u32)cnt be sufficient here?

Yup, fixed.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
