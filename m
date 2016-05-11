From: keescook@chromium.org (Kees Cook)
Date: Wed, 11 May 2016 08:27:14 -0700
Subject: [PATCH] arm64: kernel: Fix incorrect brk randomization
In-Reply-To: <1462959868.2834.17.camel@linaro.org>
References: <20160510175549.GA20496@www.outflux.net>
 <1462959868.2834.17.camel@linaro.org>
Message-ID: <CAGXu5jLy4e1d8oQMAm8JTgCjyCPb_i3QvMw+gT3_H6WeAatO1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 2:44 AM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> On Tue, 2016-05-10 at 10:55 -0700, Kees Cook wrote:
>> This fixes two issues with the arm64 brk randomziation. First, the
>> STACK_RND_MASK was being used incorrectly. The original code was:
>>
>>       unsigned long range_end = base + (STACK_RND_MASK << PAGE_SHIFT) + 1;
>>
>> STACK_RND_MASK is 0x7ff (32-bit) or 0x3ffff (64-bit), with 4K pages where
>> PAGE_SHIFT is 12:
>>
>>       #define STACK_RND_MASK  (test_thread_flag(TIF_32BIT) ? \
>>                                               0x7ff >> (PAGE_SHIFT - 12) : \
>>                                               0x3ffff >> (PAGE_SHIFT - 12))
>>
>> This means the resulting offset from base would be 0x7ff0001 or 0x3ffff0001,
>> which is wrong since it creates an unaligned end address. It was likely
>> intended to be:
>>
>>       unsigned long range_end = base + ((STACK_RND_MASK + 1) << PAGE_SHIFT)
>>
>> Which would result in offsets of 0x800000 (32-bit) and 0x40000000 (64-bit).
>>
>> However, even this corrected 32-bit compat offset (0x00800000) is much
>> smaller than native ARM's brk randomization value (0x02000000):
>>
>>       unsigned long arch_randomize_brk(struct mm_struct *mm)
>>       {
>>               unsigned long range_end = mm->brk + 0x02000000;
>>               return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
>>       }
>>
>> So, instead of basing arm64's brk randomization on mistaken STACK_RND_MASK
>> calculations, just use specific corrected values for compat (0x2000000)
>> and native arm64 (0x40000000).
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> There seems to be a helper 'is_compat_task()' that does
> 'test_thread_flag(TIF_32BIT)' so could perhaps be used instead, but
> that's too nit-picky. This change makes things more consistent with

Oh, good call. Yeah, none of the other .c code does direct tests for
the TIF_32BIT flag, so I'll use the helper and send a v2. Thanks!

-Kees

> arch/arm and other arches, and stops use of STACK_RND_MASK for things
> that aren't stack related so seems good all round to me.
>
> Reviewed-by: Jon Medhurst <tixy@linaro.org>
>
>> ---
>>  arch/arm64/kernel/process.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 80624829db61..0d0969bcd76d 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -382,13 +382,14 @@ unsigned long arch_align_stack(unsigned long sp)
>>       return sp & ~0xf;
>>  }
>>
>> -static unsigned long randomize_base(unsigned long base)
>> -{
>> -     unsigned long range_end = base + (STACK_RND_MASK << PAGE_SHIFT) + 1;
>> -     return randomize_range(base, range_end, 0) ? : base;
>> -}
>> -
>>  unsigned long arch_randomize_brk(struct mm_struct *mm)
>>  {
>> -     return randomize_base(mm->brk);
>> +     unsigned long range_end = mm->brk;
>> +
>> +     if (test_thread_flag(TIF_32BIT))
>> +             range_end += 0x02000000;
>> +     else
>> +             range_end += 0x40000000;
>> +
>> +     return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
>>  }
>> --
>> 2.6.3
>>
>>
>
>



-- 
Kees Cook
Chrome OS & Brillo Security
