From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 08:47:17 +0100
Subject: [PATCH 1/3] arm64: merge __enable_mmu and __turn_mmu_on
In-Reply-To: <550866E6.5050901@codeaurora.org>
References: <1426587074-22390-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426587074-22390-2-git-send-email-ard.biesheuvel@linaro.org>
 <550866E6.5050901@codeaurora.org>
Message-ID: <CAKv+Gu8vCjLnyBAcEfucFAj7KqB3qmfKvjowNRoG1dWXoFjYsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2015 at 18:39, Christopher Covington <cov@codeaurora.org> wrote:
> On 03/17/2015 06:11 AM, Ard Biesheuvel wrote:
>> Enabling of the MMU is split into two functions, with an align and
>> a branch in the middle. On arm64, the entire kernel Image is ID mapped
>> so this is really not necessary, and we can just merge it into a
>> single function.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/head.S | 30 ++++++++----------------------
>>  1 file changed, 8 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 65c7de889c8c..fb912314d5e1 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -615,8 +615,13 @@ ENDPROC(__secondary_switched)
>>  #endif       /* CONFIG_SMP */
>>
>>  /*
>> - * Setup common bits before finally enabling the MMU. Essentially this is just
>> - * loading the page table pointer and vector base registers.
>> + * Enable the MMU. This completely changes the structure of the visible memory
>> + * space. You will not be able to trace execution through this.
>
> I don't understand the last sentence. I recall being able to read and
> eventually understand simulator instruction traces of this code. Is the
> sentence referring to the Embedded Trace Macrocell or something?
>

I guess the comment is a bit stale: it was inherited from the ARM
version, where older platforms only have a single TTBR register, and
switching address spaces is a bit more involved. On arm64, however,
there are always two TTBR registers at EL1, and the address spaced
they represent can never overlap, so there it isn't such a big deal.
