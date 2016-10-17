From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 17 Oct 2016 20:43:19 +0100
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <20161017183806.GG5601@arm.com>
References: <20161017183806.GG5601@arm.com>
Message-ID: <CAKv+Gu869PXA_cXaL6+uokRCS4EZ8-q6x2xnj4e5DWO28B5jCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 October 2016 at 19:38, Will Deacon <will.deacon@arm.com> wrote:
> Hi all,
>
> I'm seeing an arm64 build failure with -rc1 and GCC trunk, although I
> believe that the new compiler behaviour at the heart of the problem
> has the potential to affect other architectures and other pieces of
> kernel code relying on dead-code elimination to remove deliberately
> undefined functions.
>
> The failure looks like:
>
>   | drivers/built-in.o: In function `armada_3700_add_composite_clk':
>   |
>   | linux/drivers/clk/mvebu/armada-37xx-periph.c:351:
>   | undefined reference to `____ilog2_NaN'
>   |
>   | linux/drivers/clk/mvebu/armada-37xx-periph.c:351:(.text+0xc72e0):
>   | relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
>   | `____ilog2_NaN'
>   |
>   | make: *** [vmlinux] Error 1
>
> and if we look at the source for armada_3700_add_composite_clk, we see
> that this is caused by:
>
>   int table_size = 0;
>
>   rate->reg = reg + (u64)rate->reg;
>   for (clkt = rate->table; clkt->div; clkt++)
>          table_size++;
>   rate->width = order_base_2(table_size);
>
> order_base_2 calls ilog2, which has the ____ilog2_NaN call:
>
> #define ilog2(n)                                \
> (                                               \
>         __builtin_constant_p(n) ? (             \
>                 (n) < 1 ? ____ilog2_NaN() :     \
>
> This is because we're in a curious case where GCC has emitted a
> special-cased version of armada_3700_add_composite_clk, with table_size
> effectively constant-folded as 0. Whilst we shouldn't see this in a
> non-buggy kernel (hence the deliberate call to the undefined function
> ____ilog2_NaN), it means that the final link fails because we have a
> ____ilog2_NaN in the code, with a runtime check on table_size.
>

This is indeed an unintended side effect, but I would not call it
weird behaviour at all. The code in its current form does not handle
the case where it could end up passing 0 into order_base_2(), and we
simply need to handle that case. If order_base_2() is not defined for
input 0, it should BUG() in that case, and the associated
__builtin_unreachable() should prevent the special version from being
emitted. If order_base_2() is defined for input 0, it should not
invoke ilog2() with that argument, and the problem should go away as
well.

-- 
Ard.


> In other words, __builtin_constant_p appears to be weaker than we've
> been assuming. Talking to the compiler guys here, this is due to the
> "jump-threading" optimisation pass, so the patch below disables that.
>
> A simpler example is:
>
> int foo();
> int bar();
>
> int count(int *argc)
> {
>         int table_size = 0;
>
>         for (; *argc; argc++)
>                 table_size++;
>
>         if (__builtin_constant_p(table_size))
>                 return table_size == 0 ? foo() : bar();
>
>         return bar();
> }
>
> which compiles to:
>
> count:
>         ldr     w0, [x0]
>         cbz     w0, .L4
>         b       bar
>         .p2align 3
> .L4:
>         b       foo
>
> and, with the "optimisation" disabled:
>
> count:
>         b       bar
>
> Thoughts? It feels awfully fragile disabling passes like this, but with
> GCC transforming the code like this, I can't immediately think of a way
> to preserve the intended behaviour of the code.
>
> Will
>
> --->8
>
> diff --git a/Makefile b/Makefile
> index 512e47a53e9a..750873d6d11e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -641,6 +641,11 @@ endif
>  # Tell gcc to never replace conditional load with a non-conditional one
>  KBUILD_CFLAGS  += $(call cc-option,--param=allow-store-data-races=0)
>
> +# Stop gcc from converting switches into a form that defeats dead code
> +# elimination and can subsequently lead to calls to intentionally
> +# undefined functions appearing in the final link.
> +KBUILD_CFLAGS  += $(call cc-option,--param=max-fsm-thread-path-insns=1)
> +
>  include scripts/Makefile.gcc-plugins
>
>  ifdef CONFIG_READABLE_ASM
