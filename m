From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Apr 2016 17:40:22 +0200
Subject: [PATCH 3/8] arm64/kernel: use a proper stack frame in
 __mmap_switched()
In-Reply-To: <57028941.6050805@arm.com>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
 <1459781544-14310-4-git-send-email-ard.biesheuvel@linaro.org>
 <57028941.6050805@arm.com>
Message-ID: <CAKv+Gu_CM61_RmCgoSPcZCJ2m4GCR7txkh6+fp_LqBqXYypZjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2016 at 17:33, James Morse <james.morse@arm.com> wrote:
> Hi Ard,
>
> On 04/04/16 15:52, Ard Biesheuvel wrote:
>> Considering that we can expect stack accesses from the moment we assign
>> VBAR_EL1, let's initialize the stack pointer first in __mmap_switched(),
>> and set up a proper stack frame while we're at it.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/head.S | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 9d8f928c355c..f441fc73a7a2 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -421,9 +421,14 @@ kernel_img_size:
>>  /*
>>   * The following fragment of code is executed with the MMU enabled.
>>   */
>> -     .set    initial_sp, init_thread_union + THREAD_START_SP
>>  __mmap_switched:
>> -     mov     x28, lr                         // preserve LR
>> +     adrp    x4, init_thread_union
>> +     add     sp, x4, #THREAD_SIZE
>> +     msr     sp_el0, x4                      // Save thread_info
>
> (Terms describing the stack are confusing, here goes!)
>
> The address you have in x4 is the 'highest' address on the stack, (the first
> that gets used), thread_info is at the other end, the 'lowest' address.
>
> You used THREAD_SIZE instead of THREAD_START_SP, so the x4 value points to the
> 'bottom' of the page after the stack, this isn't a problem because the pre-index
> addressing decrements sp before it writes, but it does break the 'and   x4, x4,
> #~(THREAD_SIZE - 1)' trick to find thread_info, which I think is what the '-16'
> in THREAD_START_SP is for...
>

True. But since the sp is decremented by the same 16 bytes in the next
instruction, the net value of sp when entering start_kernel() is
identical.

> 6cdf9c7ca687 ("arm64: Store struct thread_info in sp_el0") got rid of most of
> the users of this masking trick, maybe we can get rid of THREAD_START_SP too?
> (unless it is there for some other clever reason!)
>

I agree that the whole point of the -16 is to make the masking work.
So if we can get rid of the masking, we can get rid of
THREAD_START_SP, and also of the natural alignment of the stacks.
