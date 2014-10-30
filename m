From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 30 Oct 2014 09:49:30 -0700
Subject: [PATCHv4 3/7] arm64: Move cpu_resume into the text section
In-Reply-To: <20141028153118.GL9796@leverpostej>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
 <1414440752-9411-4-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu-UEE5YA8P5Rjh7vbDAQJxC2dTn2TaPBBosd_XVn-BeAg@mail.gmail.com>
 <CAKv+Gu_UWxdLvqnDWhF7YY0uWE=TYXf4P=5RyvTfPCpY7i25JQ@mail.gmail.com>
 <20141028124314.GD9796@leverpostej> <20141028152656.GB24445@red-moon>
 <20141028153118.GL9796@leverpostej>
Message-ID: <54526C1A.4050204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2014 8:31 AM, Mark Rutland wrote:
> On Tue, Oct 28, 2014 at 03:26:56PM +0000, Lorenzo Pieralisi wrote:
>> On Tue, Oct 28, 2014 at 12:43:15PM +0000, Mark Rutland wrote:
>>> On Tue, Oct 28, 2014 at 08:22:00AM +0000, Ard Biesheuvel wrote:
>>>> On 28 October 2014 09:10, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>>> On 27 October 2014 21:12, Laura Abbott <lauraa@codeaurora.org> wrote:
>>>>>> The function cpu_resume currently lives in the .data
>>>>>> section. There's no reason for it to be there since
>>>>>> we can use relative instructions without a problem.
>>>>>> Move it to the text section where it belongs.
>>>>>>
>>>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>>>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>>>>>> ---
>>>>>>   arch/arm64/kernel/sleep.S | 12 +++++++-----
>>>>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>>>>
>>>>>
>>>>> Hi Laura,
>>>>>
>>>>> Apologies for waiting until v4 to bring this up, but I have some minor comments.
>>>>>
>>>>>> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
>>>>>> index a564b44..5762b16 100644
>>>>>> --- a/arch/arm64/kernel/sleep.S
>>>>>> +++ b/arch/arm64/kernel/sleep.S
>>>>>> @@ -147,12 +147,12 @@ cpu_resume_after_mmu:
>>>>>>          ret
>>>>>>   ENDPROC(cpu_resume_after_mmu)
>>>>>>
>>>>>> -       .data
>>>>>>   ENTRY(cpu_resume)
>>>>>>          bl      el2_setup               // if in EL2 drop to EL1 cleanly
>>>>>>   #ifdef CONFIG_SMP
>>>>>>          mrs     x1, mpidr_el1
>>>>>> -       adr     x4, mpidr_hash_ptr
>>>>>> +       adrp    x4, mpidr_hash_ptr
>>>>>> +       add     x4, x4, #:lo12:mpidr_hash_ptr
>>>>>
>>>>> Instead of this change, you could put mpidr_hash_ptr itself in .text as well.
>>>>>
>>>>
>>>> Actually, looking more closely, it appears mpidr_hash_ptr can be
>>>> dropped completely:
>>>> the address obtained by adrp/add is PC relative, so the whole sequence
>>>> could just be
>>>>
>>>> adrp x8, mpidr_hash
>>>> add x8, x8, #:lo12:mpidr_hash // x8 = struct mpidr_hash phys address
>>>>
>>>> (and the ldr and add below can be dropped, and so can mpidr_hash_ptr at the end)
>>>
>>> Also, if you update arch/arm64/kernel/suspend.c to drop the extern from
>>> sleep_save_sp and sleep_idmap_phys, you can drop all of the .data from
>>> sleep.S
>>
>> If with that you also mean that all adr references to those data structures
>> in the resume path should become adrp I agree otherwise we might have an
>> offset issue.
>
> Yes. The original patch had those modifications already, so I assumed
> they would remain.
>

Thanks all. I'll incorporate the suggestions in the next version.

Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
