From: keescook@chromium.org (Kees Cook)
Date: Mon, 2 May 2016 12:34:05 -0700
Subject: [RFC PATCH] arm64: Make arch_randomize_brk avoid stack area
In-Reply-To: <1461853042.2848.24.camel@linaro.org>
References: <1461848638.2848.19.camel@linaro.org>
 <1461853042.2848.24.camel@linaro.org>
Message-ID: <CAGXu5jJKDE_pLCxy-FF7PN5+YC7wyvpQ_9DTDGqHuk+tb1mvJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 7:17 AM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> Sorry, the code patch has errors (I forgot to commit fixes before
> running git format-patch), the correct code, which was in the kernel I
> built and tested, is at the end of this email.

Please resend this as a v2 (with a changelog, etc). Conceptually, it
looks fine to me: it will limit the entropy of the brk base address
when close to the stack on old kernels and should be effectively a
no-op on modern kernels. However, I have some notes inline below.

Also, for v2, can you validate the text vs brk offset entropy on a 4.6
kernel before/after this patch?

This (aslr.c) may be helpful in running a few thousand iterations:

http://bazaar.launchpad.net/~ubuntu-bugcontrol/qa-regression-testing/master/files/head:/scripts/kernel-security/aslr/

$ for i in $(seq 10000); do ./aslr --report brk ; done | ...

>
> On Thu, 2016-04-28 at 14:03 +0100, Jon Medhurst (Tixy) wrote:
> Some incorrect code...
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 8062482..7126a5a 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -382,13 +382,24 @@ unsigned long arch_align_stack(unsigned long sp)
>>       return sp & ~0xf;
>>  }
>>
>> -static unsigned long randomize_base(unsigned long base)
>> +unsigned long arch_randomize_brk(struct mm_struct *mm)
>>  {
>>       unsigned long range_end = base + (STACK_RND_MASK << PAGE_SHIFT) + 1;
>> -     return randomize_range(base, range_end, 0) ? : base;
>> -}
>> +     unsigned long max_stack, range_limit;
>>
>> -unsigned long arch_randomize_brk(struct mm_struct *mm)
>> -{
>> -     return randomize_base(mm->brk);
>> +     /*
>> +      * Determine how much room do we need to leave available for the stack.
>> +      * We limit this to a reasonable value, because extremely large or
>> +      * unlimited stacks are always going to bump up against brk at some
>> +      * point and we don't want to fail to randomise brk in those cases.
>> +      */
>> +     max_stack = rlimit(RLIMIT_STACK);
>> +     if (max_stack > SZ_128M)
>> +             max_stack = SZ_128M;
>> +
>> +     range_limit = mm->start_stack - max_stack - 1;
>> +     if (range_end > range_limit)
>> +             range_end > range_limit
>> +
>> +     return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
>>  }
>
> Corrected code...
>
>  arch/arm64/kernel/process.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 07c4c53..7e0f404 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -434,13 +434,25 @@ unsigned long arch_align_stack(unsigned long sp)
>         return sp & ~0xf;
>  }
>
> -static unsigned long randomize_base(unsigned long base)
> +unsigned long arch_randomize_brk(struct mm_struct *mm)
>  {
> +       unsigned long base = mm->brk;
>         unsigned long range_end = base + (STACK_RND_MASK << PAGE_SHIFT) + 1;

This looks wrong. Shouldn't it be (STACK_RND_MASK + 1) << PAGE_SHIFT ?

STACK_RND_MASK is 0x7ff (32-bit) or 0x3ffff (64-bit):

#define STACK_RND_MASK                  (test_thread_flag(TIF_32BIT) ? \
                                                0x7ff >> (PAGE_SHIFT - 12) : \
                                                0x3ffff >> (PAGE_SHIFT - 12))

(4K paged PAGE_SHIFT is 12)

So the correct offset max would be 0x800000 (32-bit) and 0x40000000
(64-bit), instead of
0x7ff0001 and 0x3ffff0001.

Even with that correction, this looks wrong for 32-bit, which uses
0x2000000 natively:

unsigned long arch_randomize_brk(struct mm_struct *mm)
{
        unsigned long range_end = mm->brk + 0x02000000;
        return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
}

Seems like arm64 compat is using 4 times less entropy than native arm?
(Note that STACK_RND_MASK is correct for arm64 compat: this matches
the default in fs/binfmt_elf.c that arm uses. It just seems like the
brk randomization is accidentally too small on arm64 compat since arm
uses a fixed value unrelated to stack randomization.)

0x02000000 arm native
0x00800000 arm64 compat  <- bug?
0x40000000 arm64


> -       return randomize_range(base, range_end, 0) ? : base;
> -}
> +       unsigned long max_stack, range_limit;
>
> -unsigned long arch_randomize_brk(struct mm_struct *mm)
> -{
> -       return randomize_base(mm->brk);
> +       /*
> +        * Determine how much room do we need to leave available for the stack.
> +        * We limit this to a reasonable value, because extremely large or
> +        * unlimited stacks are always going to bump up against brk at some
> +        * point and we don't want to fail to randomise brk in those cases.
> +        */
> +       max_stack = rlimit(RLIMIT_STACK);
> +       if (max_stack > SZ_128M)
> +               max_stack = SZ_128M;
> +
> +       range_limit = mm->start_stack - max_stack - 1;
> +       if (range_end > range_limit)
> +               range_end = range_limit;
> +
> +       return randomize_range(base, range_end, 0) ? : base;
>  }
> --
> 2.1.4
>

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
