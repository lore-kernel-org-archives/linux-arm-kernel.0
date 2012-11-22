From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Nov 2012 12:08:57 +0000
Subject: [PATCH] ARM: perf: fix link error when CONFIG_HW_PERF_EVENTS
 is not selected
In-Reply-To: <20121122115812.GD3113@mudshark.cambridge.arm.com>
References: <1353584851-17842-1-git-send-email-marc.zyngier@arm.com>
 <20121122115812.GD3113@mudshark.cambridge.arm.com>
Message-ID: <50AE15D9.7070203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/12 11:58, Will Deacon wrote:
> On Thu, Nov 22, 2012 at 11:47:31AM +0000, Marc Zyngier wrote:
>> Commit e50c541 (ARM: perf: add guest vs host discrimination) broken the
>> link as perf_instruction_pointer and perf_misc_flags are not defined
>> when CONFIG_HW_PERF_EVENTS is not selected.
>>
>> As it make little sense to try and profile a guest without any HW event,
>> just fallback to the original code when this config option is not selected.
>>
>> Reported-by: Russell King <linux@arm.linux.org.uk>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/include/asm/perf_event.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
>> index 00416ed..7558775 100644
>> --- a/arch/arm/include/asm/perf_event.h
>> +++ b/arch/arm/include/asm/perf_event.h
>> @@ -21,9 +21,11 @@
>>  #define C(_x)				PERF_COUNT_HW_CACHE_##_x
>>  #define CACHE_OP_UNSUPPORTED		0xFFFF
>>  
>> +#ifdef CONFIG_HW_PERF_EVENTS
>>  struct pt_regs;
>>  extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
>>  extern unsigned long perf_misc_flags(struct pt_regs *regs);
>>  #define perf_misc_flags(regs)	perf_misc_flags(regs)
>> +#endif
>>  
>>  #endif /* __ARM_PERF_EVENT_H__ */
>> -- 
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks Marc for the fix and Russell for reporting the issue.
> 
> Please can you stick this in the patch system as I don't have any other
> perf patches pending for 3.8?

Queued as 7584/1.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
