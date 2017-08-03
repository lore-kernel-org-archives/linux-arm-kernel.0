From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 3 Aug 2017 18:20:32 +0100
Subject: [PATCH] arm64: avoid overflow in VA_START and PAGE_OFFSET
In-Reply-To: <20170803171117.107992-1-ndesaulniers@google.com>
References: <20170803132035.gixd7m7oxtehpquu@yury-thinkpad>
 <20170803171117.107992-1-ndesaulniers@google.com>
Message-ID: <CAKv+Gu-sKku1R6RQHoRsoskk+n5ns+4BfChH7gvR-JCmksdVsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 August 2017 at 18:11, Nick Desaulniers <ndesaulniers@google.com> wrote:
> The bitmask used to define these values produces overflow, as seen by
> this compiler warning:
>
> arch/arm64/kernel/head.S:47:8: warning:
>       integer overflow in preprocessor expression
>   #elif (PAGE_OFFSET & 0x1fffff) != 0
>          ^~~~~~~~~~~
> arch/arm64/include/asm/memory.h:52:46: note:
>       expanded from macro 'PAGE_OFFSET'
>   #define PAGE_OFFSET             (UL(0xffffffffffffffff) << (VA_BITS -
> 1))
>                                       ~~~~~~~~~~~~~~~~~~  ^
>
> It would be preferrable to use GENMASK_ULL() instead, but it's not set
> up to be used from assembly (the UL() macro token pastes UL suffixes
> when not included in assembly sources).
>
> Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
> Suggested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm64/include/asm/memory.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 32f82723338a..dde717a31dee 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -64,8 +64,9 @@
>   * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
>   */
>  #define VA_BITS                        (CONFIG_ARM64_VA_BITS)
> -#define VA_START               (UL(0xffffffffffffffff) << VA_BITS)
> -#define PAGE_OFFSET            (UL(0xffffffffffffffff) << (VA_BITS - 1))
> +#define VA_START               ((UL(0xffffffffffffffff) >> VA_BITS) << VA_BITS)
> +#define PAGE_OFFSET            ((UL(0xffffffffffffffff) >> (VA_BITS - 1)) \
> +       << (VA_BITS - 1))
>  #define KIMAGE_VADDR           (MODULES_END)
>  #define MODULES_END            (MODULES_VADDR + MODULES_VSIZE)
>  #define MODULES_VADDR          (VA_START + KASAN_SHADOW_SIZE)
> --
> 2.14.0.rc1.383.gd1ce394fe2-goog
>

Would

#define VA_START (UL(0xffffffffffffffff) - (1 << VA_BITS) + 1)

also work?
