From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 29 May 2013 14:57:10 +0200
Subject: [PATCH 3/3] ARM PJ4B: Add support for errata 4611
In-Reply-To: <20130529112207.GG13095@mudshark.cambridge.arm.com>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
 <1369822618-26797-4-git-send-email-gregory.clement@free-electrons.com>
 <20130529112207.GG13095@mudshark.cambridge.arm.com>
Message-ID: <51A5FB26.4090000@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 05/29/2013 01:22 PM, Will Deacon wrote:
> On Wed, May 29, 2013 at 11:16:58AM +0100, Gregory CLEMENT wrote:
>> From: Lior Amsalem <alior@marvell.com>
>>
>> A CP15 clean operation can result in a dead lock state if it is hit by
>> an incoming snoop event. the fiw to this issue is the following:
> 
> s/fiw/fix/
> 
>> before any CP15 clean type operation in Cache Coherency mode, issue a
>> Data Memory Barrier (DMB) or a Data Synchronization Barrier (DSB)
>> instruction.
> 
> Could you combine this with #6124, so we don't have back-to-back ifdefs all
> over the place? Also, there are more clean operations than you have
> described here, so why haven't you have to touch them all?

For the first point, unfortunately it is not possible as they are
errata for different CPUs. If finally the 2 last patches won't be
merged in 3.10, then I will add a new patch before them, to introduce
the PJ4B-MP which is the CPU used by the Armada XP whereas the
Armada 370 uses the PJ4B.

For the second point and the other CPU specific questions you raised
in the other emails, I am waiting for answer from Marvell engineers.

Thanks for your review

> 
>> [gregory.clement at free-electrons.com:add errata description in changelog]
>> [gregory.clement at free-electrons.com:make this errata depend on Aramda
>> 370]
>> Signed-off-by: Lior Amsalem <alior@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  arch/arm/Kconfig                | 11 +++++++++++
>>  arch/arm/include/asm/tlbflush.h | 22 ++++++++++++++++++++++
>>  arch/arm/mm/copypage-v6.c       | 11 +++++++++++
>>  arch/arm/mm/proc-macros.S       | 13 +++++++++++++
>>  4 files changed, 57 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 48cdbea..05c13f9 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1087,6 +1087,17 @@ if !MMU
>>  source "arch/arm/Kconfig-nommu"
>>  endif
>>  
>> +config PJ4B_ERRATA_4611
>> +        bool "PJ4B Errata 4611: A Deadlock can Occur if a CP15 Clean/Clean and Invalidate Operation is Hit By a Snoop Event"
>> +        depends on CPU_PJ4B && MACH_ARMADA_370
>> +        help
>> +          A CP15 clean operation can result in a dead lock state if it is hit by
>> +          an incoming snoop event.
>> +          Workaround:
>> +	  Before any CP15 clean type operation in Cache Coherency mode, issue
>> +          a Data Memory Barrier (DMB) or a Data Synchronization Barrier (DSB)
>> +          instruction.
>> +
>>  config PJ4B_ERRATA_4742
>>          bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the CPU Core to Cease Operation"
>>          depends on CPU_PJ4B && MACH_ARMADA_370
>> diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
>> index e3a8064..112f778 100644
>> --- a/arch/arm/include/asm/tlbflush.h
>> +++ b/arch/arm/include/asm/tlbflush.h
>> @@ -475,11 +475,22 @@ static inline void flush_pmd_entry(void *pmd)
>>  {
>>  	const unsigned int __tlb_flag = __cpu_tlb_flags;
>>  
>> +#ifdef CONFIG_PJ4B_ERRATA_4611
>> +	unsigned long flags;
>> +	raw_local_irq_save(flags);
>> +	dmb();
>> +#endif
>> +
>>  #ifdef CONFIG_PJ4B_ERRATA_6124
>>  	tlb_op(TLB_DCLEAN, "c7, c14, 1	@ flush_pmd", pmd);
>>  #else
>>  	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
>>  #endif
>> +
>> +#ifdef CONFIG_PJ4B_ERRATA_4611
>> +	raw_local_irq_restore(flags);
>> +#endif
> 
> Eeek. Why do you have to disable interrupts during this? Again, are there no
> chicken bits to save you?
> 
>>  	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
>>  
>>  	if (tlb_flag(TLB_WB))
>> @@ -490,11 +501,22 @@ static inline void clean_pmd_entry(void *pmd)
>>  {
>>  	const unsigned int __tlb_flag = __cpu_tlb_flags;
>>  
>> +#ifdef CONFIG_PJ4B_ERRATA_4611
>> +	unsigned long flags;
>> +	raw_local_irq_save(flags);
>> +	dmb();
>> +#endif
>> +
>>  #ifdef CONFIG_PJ4B_ERRATA_6124
>>  	tlb_op(TLB_DCLEAN, "c7, c14, 1	@ flush_pmd", pmd);
>>  #else
>>  	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
>>  #endif
>> +
>> +#ifdef CONFIG_PJ4B_ERRATA_4611
>> +	raw_local_irq_restore(flags);
>> +#endif
>> +
>>  	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
>>  }
>>  
>> diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
>> index b9bcc9d..20b69ad 100644
>> --- a/arch/arm/mm/copypage-v6.c
>> +++ b/arch/arm/mm/copypage-v6.c
>> @@ -59,11 +59,22 @@ static void v6_clear_user_highpage_nonaliasing(struct page *page, unsigned long
>>   */
>>  static void discard_old_kernel_data(void *kto)
>>  {
>> +#ifdef CONFIG_PJ4B_ERRATA_4611
>> +        unsigned long flags;
>> +
>> +        raw_local_irq_save(flags);
>> +        dmb();
>> +#endif
>> +
>>  	__asm__("mcrr	p15, 0, %1, %0, c6	@ 0xec401f06"
>>  	   :
>>  	   : "r" (kto),
>>  	     "r" ((unsigned long)kto + PAGE_SIZE - L1_CACHE_BYTES)
>>  	   : "cc");
>> +
>> +#ifdef CONFIG_PJ4B_ERRATA_4611
>> +        raw_local_irq_restore(flags);
>> +#endif
> 
> Do you actually have an aliasing vipt cache? If not, you don't care about
> this function.
> 
>> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
>> index f9a0aa7..ca81291 100644
>> --- a/arch/arm/mm/proc-macros.S
>> +++ b/arch/arm/mm/proc-macros.S
>> @@ -178,7 +178,20 @@
>>  #endif
>>  
>>  	str	r3, [r0]
>> +
>> +#ifdef CONFIG_PJ4B_ERRATA_4611
>> +	mrs     r2, cpsr
>> +	orr     r3, r2, #PSR_F_BIT | PSR_I_BIT
>> +	msr     cpsr_c, r3                      @ Disable interrupts
>> +	dmb                                     @ ensure ordering with previous memory accesses
>> +#endif
>> +
>>  	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
>> +
>> +#ifdef CONFIG_PJ4B_ERRATA_4611
>> +	msr     cpsr_c, r2                      @ Restore interrupts
>> +	mcr     p15, 0, r0, c7, c10, 4          @ drain write buffer
>> +#endif
> 
> This could be a dsb.
> 
> Will
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
