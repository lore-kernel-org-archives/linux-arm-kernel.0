From: dvyukov@google.com (Dmitry Vyukov)
Date: Wed, 12 Sep 2018 18:33:56 +0200
Subject: [PATCH v6 06/18] khwasan, arm64: untag virt address in
 __kimg_to_phys and _virt_addr_is_linear
In-Reply-To: <19d757c2cafc277f0143a8ac34e179061f3487f5.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <19d757c2cafc277f0143a8ac34e179061f3487f5.1535462971.git.andreyknvl@google.com>
Message-ID: <CACT4Y+aJ36LGLG=TVOGQoJ+fB4Xc9CjdxAs8KZpUm3AsNEoHFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> __kimg_to_phys (which is used by virt_to_phys) and _virt_addr_is_linear
> (which is used by virt_addr_valid) assume that the top byte of the address
> is 0xff, which isn't always the case with KHWASAN enabled.
>
> The solution is to reset the tag in those macros.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/include/asm/memory.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index f5e262ee76c1..f5e2953b7009 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -92,6 +92,13 @@
>  #define KASAN_THREAD_SHIFT     0
>  #endif
>
> +#ifdef CONFIG_KASAN_HW
> +#define KASAN_TAG_SHIFTED(tag)         ((unsigned long)(tag) << 56)
> +#define KASAN_SET_TAG(addr, tag)       (((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
> +                                               KASAN_TAG_SHIFTED(tag))
> +#define KASAN_RESET_TAG(addr)          KASAN_SET_TAG(addr, 0xff)
> +#endif
> +


Wouldn't it be better to
#define KASAN_RESET_TAG(addr) addr
when CONFIG_KASAN_HW is not enabled, and then not duplicate the macros
below? That's what we do in kasan.h for all hooks.
I see that a subsequent patch duplicates yet another macro in this
file. While we could use:

#define __kimg_to_phys(addr)   (KASAN_RESET_TAG(addr) - kimage_voffset)

with and without kasan. Duplicating them increases risk that somebody
will change only the non-kasan version but forget kasan version.



>  #define MIN_THREAD_SHIFT       (14 + KASAN_THREAD_SHIFT)
>
>  /*
> @@ -232,7 +239,12 @@ static inline unsigned long kaslr_offset(void)
>  #define __is_lm_address(addr)  (!!((addr) & BIT(VA_BITS - 1)))
>
>  #define __lm_to_phys(addr)     (((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
> +
> +#ifdef CONFIG_KASAN_HW
> +#define __kimg_to_phys(addr)   (KASAN_RESET_TAG(addr) - kimage_voffset)
> +#else
>  #define __kimg_to_phys(addr)   ((addr) - kimage_voffset)
> +#endif
>
>  #define __virt_to_phys_nodebug(x) ({                                   \
>         phys_addr_t __x = (phys_addr_t)(x);                             \
> @@ -308,7 +320,13 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #endif
>  #endif
>
> +#ifdef CONFIG_KASAN_HW
> +#define _virt_addr_is_linear(kaddr)    (KASAN_RESET_TAG((u64)(kaddr)) >= \
> +                                               PAGE_OFFSET)
> +#else
>  #define _virt_addr_is_linear(kaddr)    (((u64)(kaddr)) >= PAGE_OFFSET)
> +#endif
> +
>  #define virt_addr_valid(kaddr)         (_virt_addr_is_linear(kaddr) && \
>                                          _virt_addr_valid(kaddr))
>
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
