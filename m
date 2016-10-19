From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Oct 2016 16:01:58 +0100
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <CAKv+Gu_ts83bKc4mYujf7NnzGVHoxP7TXgHbFxSgb9LkxH=wXQ@mail.gmail.com>
References: <20161017183806.GG5601@arm.com>
 <CAKv+Gu869PXA_cXaL6+uokRCS4EZ8-q6x2xnj4e5DWO28B5jCw@mail.gmail.com>
 <20161019133500.GQ9193@arm.com>
 <CAKv+Gu_ts83bKc4mYujf7NnzGVHoxP7TXgHbFxSgb9LkxH=wXQ@mail.gmail.com>
Message-ID: <CAKv+Gu_wJWCtQGfQv2V_tNq+zygMzbassEa92c5sx90w0TW4vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 October 2016 at 15:59, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 19 October 2016 at 14:35, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Ard,
>>
>> On Mon, Oct 17, 2016 at 08:43:19PM +0100, Ard Biesheuvel wrote:
>>> On 17 October 2016 at 19:38, Will Deacon <will.deacon@arm.com> wrote:
>>> > I'm seeing an arm64 build failure with -rc1 and GCC trunk, although I
>>> > believe that the new compiler behaviour at the heart of the problem
>>> > has the potential to affect other architectures and other pieces of
>>> > kernel code relying on dead-code elimination to remove deliberately
>>> > undefined functions.
>>> >
>>> > The failure looks like:
>>> >
>>> >   | drivers/built-in.o: In function `armada_3700_add_composite_clk':
>>> >   |
>>> >   | linux/drivers/clk/mvebu/armada-37xx-periph.c:351:
>>> >   | undefined reference to `____ilog2_NaN'
>>> >   |
>>> >   | linux/drivers/clk/mvebu/armada-37xx-periph.c:351:(.text+0xc72e0):
>>> >   | relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
>>> >   | `____ilog2_NaN'
>>> >   |
>>> >   | make: *** [vmlinux] Error 1
>>> >
>>> > and if we look at the source for armada_3700_add_composite_clk, we see
>>> > that this is caused by:
>>> >
>>> >   int table_size = 0;
>>> >
>>> >   rate->reg = reg + (u64)rate->reg;
>>> >   for (clkt = rate->table; clkt->div; clkt++)
>>> >          table_size++;
>>> >   rate->width = order_base_2(table_size);
>>> >
>>> > order_base_2 calls ilog2, which has the ____ilog2_NaN call:
>>> >
>>> > #define ilog2(n)                                \
>>> > (                                               \
>>> >         __builtin_constant_p(n) ? (             \
>>> >                 (n) < 1 ? ____ilog2_NaN() :     \
>>> >
>>> > This is because we're in a curious case where GCC has emitted a
>>> > special-cased version of armada_3700_add_composite_clk, with table_size
>>> > effectively constant-folded as 0. Whilst we shouldn't see this in a
>>> > non-buggy kernel (hence the deliberate call to the undefined function
>>> > ____ilog2_NaN), it means that the final link fails because we have a
>>> > ____ilog2_NaN in the code, with a runtime check on table_size.
>>> >
>>>
>>> This is indeed an unintended side effect, but I would not call it
>>> weird behaviour at all. The code in its current form does not handle
>>> the case where it could end up passing 0 into order_base_2(), and we
>>> simply need to handle that case.
>>
>> The reasons I think it's weird are:
>>
>>   (1) The optimisation doesn't generate better code in this case --
>>       optimising for the table_size == 0 case is uninformed, particularly
>>       as that *cannot* happen at runtime (GCC probably can't tell, due
>>       to things like container_of, but all the clock data is static).
>>
>
> AFAICT, the references to the static clock data are indirected via
> of_device_get_match_data(), which means there is no way the compiler
> can prove that table_size is always non-zero.
>
>>   (2) __builtin_constant_p(n) could be interpreted by a developer as
>>      "this code will execute with a constant n at runtime". With this
>>      issue, GCC could (in theory) generate a specialisation for every
>>      possible value of a variable, and return __builtin_constant_p as
>>      true for all of them, which somewhat undermines the point of the
>>      builtin.
>>
>
> Yes, and that would be perfectly legal from a correctness point of
> view, and would likely help performance as well. By using
> __builtin_constant_p(), you are choosing to perform a build time
> evaluation of an expression that would ordinarily be evaluated only at
> runtime. This implies that you have to address undefined behavior at
> build time rather than at runtime as well.
>
>>> If order_base_2() is not defined for input 0, it should BUG() in that
>>> case, and the associated __builtin_unreachable() should prevent the
>>> special version from being emitted. If order_base_2() is defined for input
>>> 0, it should not invoke ilog2() with that argument, and the problem should
>>> go away as well.
>>
>> I don't necessarily think it should BUG() if it's not defined for input
>> 0; things like __ffs don't do that and we'd be introducing conditional
>> checks for cases that should not happen. The comment above order_base_2
>> does suggest that ob2(0) should return 0, but it can actually end up
>> invoking ilog2(-1), which is obviously wrong.
>>
>> I could update the comment, but that doesn't fix the build issue.
>>
>
> Fixing roundup_pow_of_two() [which is arguably incorrect]

I just spotted the comment that says it is undefined. But that means
it could legally return 1 for input 0, i suppose

> would
> probably fix the build issue as well, no?
>
> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index fd7ff3d91e6a..8a4be5e4223b 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h
> @@ -168,7 +168,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>  #define roundup_pow_of_two(n)                  \
>  (                                              \
>         __builtin_constant_p(n) ? (             \
> -               (n == 1) ? 1 :                  \
> +               (n <= 1) ? 1 :                  \
>                 (1UL << (ilog2((n) - 1) + 1))   \
>                                    ) :          \
>         __roundup_pow_of_two(n)                 \
