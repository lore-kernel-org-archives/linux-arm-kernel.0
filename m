From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 18 Nov 2014 13:20:29 -0800
Subject: [PATCHv5 3/7] arm64: Move cpu_resume into the text section
In-Reply-To: <20141118104935.GA14323@leverpostej>
References: <1416272105-14787-1-git-send-email-lauraa@codeaurora.org>
 <1416272105-14787-4-git-send-email-lauraa@codeaurora.org>
 <20141118104935.GA14323@leverpostej>
Message-ID: <546BB81D.1000606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2014 2:49 AM, Mark Rutland wrote:
> Hi Laura,
>
> On Tue, Nov 18, 2014 at 12:55:01AM +0000, Laura Abbott wrote:
>> The function cpu_resume currently lives in the .data section.
>> There's no reason for it to be there since we can use relative
>> instructions without a problem. Move a few cpu_resume data
>> structures out of the assembly file so the .data annotation
>> can be dropped completely and cpu_resume ends up in the read
>> only text section.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> Tested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>> v5: Dropped the .data annoation completely per suggestion of
>> Lorenzo. Dropped mpidr_hash_ptr per suggestion of Ard.
>> Moved sleep_save_sp and sleep_idmap_phys from assembly per
>> suggestion of Mark.
>>
>> Please let me know if your Tested-by/Reviewed-by/Acked-by
>> still stands.
>> ---
>>   arch/arm64/kernel/sleep.S   | 29 ++++++-----------------------
>>   arch/arm64/kernel/suspend.c |  4 ++--
>>   2 files changed, 8 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
>> index a564b44..3f836b2 100644
>> --- a/arch/arm64/kernel/sleep.S
>> +++ b/arch/arm64/kernel/sleep.S
>> @@ -147,14 +147,12 @@ cpu_resume_after_mmu:
>>   	ret
>>   ENDPROC(cpu_resume_after_mmu)
>>
>> -	.data
>>   ENTRY(cpu_resume)
>>   	bl	el2_setup		// if in EL2 drop to EL1 cleanly
>>   #ifdef CONFIG_SMP
>>   	mrs	x1, mpidr_el1
>> -	adr	x4, mpidr_hash_ptr
>> -	ldr	x5, [x4]
>> -	add	x8, x4, x5		// x8 = struct mpidr_hash phys address
>> +	adrp	x8, mpidr_hash
>> +	add x8, x8, #:lo12:mpidr_hash // x8 = struct mpidr_hash phys address
>>           /* retrieve mpidr_hash members to compute the hash */
>>   	ldr	x2, [x8, #MPIDR_HASH_MASK]
>>   	ldp	w3, w4, [x8, #MPIDR_HASH_SHIFTS]
>> @@ -164,14 +162,15 @@ ENTRY(cpu_resume)
>>   #else
>>   	mov	x7, xzr
>>   #endif
>> -	adr	x0, sleep_save_sp
>> +	adrp	x0, sleep_save_sp
>> +	add	x0, x0, #:lo12:sleep_save_sp
>>   	ldr	x0, [x0, #SLEEP_SAVE_SP_PHYS]
>>   	ldr	x0, [x0, x7, lsl #3]
>>   	/* load sp from context */
>>   	ldr	x2, [x0, #CPU_CTX_SP]
>> -	adr	x1, sleep_idmap_phys
>> +	adrp	x1, sleep_idmap_phys
>>   	/* load physical address of identity map page table in x1 */
>> -	ldr	x1, [x1]
>> +	ldr	x1, [x1, #:lo12:sleep_idmap_phys]
>>   	mov	sp, x2
>>   	/*
>>   	 * cpu_do_resume expects x0 to contain context physical address
>> @@ -182,24 +181,8 @@ ENTRY(cpu_resume)
>>   ENDPROC(cpu_resume)
>>
>>   	.align 3
>> -mpidr_hash_ptr:
>>   	/*
>>   	 * offset of mpidr_hash symbol from current location
>>   	 * used to obtain run-time mpidr_hash address with MMU off
>>            */
>>   	.quad	mpidr_hash - .
>
> The .align, comment and the .quad should go too, now the value is
> unused.
>

Ah yes, I misread what was happening here and thought this was the
declaration for mpidr_hash. It can be removed just fine.

Thanks,
Laura



-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
