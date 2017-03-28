From: keescook@chromium.org (Kees Cook)
Date: Tue, 28 Mar 2017 15:34:19 -0700
Subject: [PATCH v4 0/3] arm64: usercopy: Implement stack frame object
 validation
In-Reply-To: <CAGXu5jJ9xis_X9qd-GxCM=oDDoynMrW=GZbfeOKKt_FpAuK83Q@mail.gmail.com>
References: <20170216182917.19637-1-james.morse@arm.com>
 <CAGXu5jJ9xis_X9qd-GxCM=oDDoynMrW=GZbfeOKKt_FpAuK83Q@mail.gmail.com>
Message-ID: <CAGXu5jKhVzH9OB6QgGb1u0sbnFGn5J72FnzNeGo076f52Scn+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 4:54 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 16, 2017 at 10:29 AM, James Morse <james.morse@arm.com> wrote:
>> Hi all,
>>
>> This version of Sahara's arch_within_stack_frames() series replaces the
>> open-coded stack walker with a call to arm64's existing walker.
>>
>> Patch 2 can be tested independently with this change[0].
>>
>> lkdtm's use of unallocated stack regions is a separate problem, patch 3
>> tries to address this.
>>
>> Sahara, it would be good to get your review of this!
>> I'm afraid I omitted your patch-3 as it stopped the lkdtm test from working,
>> I suspect its not tricking the compiler, but I haven't investigated.
>>
>>
>> Thanks,
>>
>> James
>>
>> [0] Change to lkdtm to generate accesses that overlap stack frames.
>> --------------%<--------------
>> diff --git a/drivers/misc/lkdtm_usercopy.c b/drivers/misc/lkdtm_usercopy.c
>> index 1dd611423d8b..fcbba3a14387 100644
>> --- a/drivers/misc/lkdtm_usercopy.c
>> +++ b/drivers/misc/lkdtm_usercopy.c
>> @@ -57,7 +57,8 @@ static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
>>
>>         /* This is a pointer to outside our current stack frame. */
>>         if (bad_frame) {
>> -               bad_stack = do_usercopy_stack_callee((uintptr_t)&bad_stack);
>> +               bad_stack = __builtin_frame_address(0);
>> +               bad_stack -= sizeof(good_stack)/2;
>
> Ah, sneaky, yeah, that'll work nicely.
>
> (Though it should likely get wrapped in a CONFIG_STACK_GROWSUP/DOWN test...)

Is this still in progress? Seemed like it was very close?

-Kees

-- 
Kees Cook
Pixel Security
