From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Tue, 29 Sep 2015 18:34:51 +0300
Subject: [PATCH v6 3/6] x86, efi,
 kasan: #undef memset/memcpy/memmove per arch.
In-Reply-To: <20150929083814.GA32127@gmail.com>
References: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
 <1442482692-6416-4-git-send-email-ryabinin.a.a@gmail.com>
 <20150929083814.GA32127@gmail.com>
Message-ID: <CAPAsAGwKh2sWMwEqhrtfV_YGWcFRWDqj6_vfgBMFW-Eqh+Dtjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-29 11:38 GMT+03:00 Ingo Molnar <mingo@kernel.org>:
>
> * Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>
>> In not-instrumented code KASAN replaces instrumented
>> memset/memcpy/memmove with not-instrumented analogues
>> __memset/__memcpy/__memove.
>> However, on x86 the EFI stub is not linked with the kernel.
>> It uses not-instrumented mem*() functions from
>> arch/x86/boot/compressed/string.c
>> So we don't replace them with __mem*() variants in EFI stub.
>>
>> On ARM64 the EFI stub is linked with the kernel, so we should
>> replace mem*() functions with __mem*(), because the EFI stub
>> runs before KASAN sets up early shadow.
>>
>> So let's move these #undef mem* into arch's asm/efi.h which is
>> also included by the EFI stub.
>>
>> Also, this will fix the warning in 32-bit build reported by
>> kbuild test robot <fengguang.wu@intel.com>:
>>       efi-stub-helper.c:599:2: warning: implicit declaration of function 'memcpy'
>>
>> Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
>> ---
>>  arch/x86/include/asm/efi.h             | 12 ++++++++++++
>>  drivers/firmware/efi/libstub/efistub.h |  4 ----
>>  2 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
>> index 155162e..6db2742 100644
>> --- a/arch/x86/include/asm/efi.h
>> +++ b/arch/x86/include/asm/efi.h
>> @@ -86,6 +86,18 @@ extern u64 asmlinkage efi_call(void *fp, ...);
>>  extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
>>                                       u32 type, u64 attribute);
>>
>> +/*
>> + * CONFIG_KASAN may redefine memset to __memset.
>> + * __memset function is present only in kernel binary.
>> + * Since the EFI stub linked into a separate binary it
>> + * doesn't have __memset(). So we should use standard
>> + * memset from arch/x86/boot/compressed/string.c
>> + * The same applies to memcpy and memmove.
>> + */
>> +#undef memcpy
>> +#undef memset
>> +#undef memmove
>
> Hm, so this hack got upstream via -mm, and it breaks the 64-bit x86 build with
> some configs:
>
>  arch/x86/platform/efi/efi.c:673:3: error: implicit declaration of function ?memcpy? [-Werror=implicit-function-declaration]
>  arch/x86/platform/efi/efi_64.c:139:2: error: implicit declaration of function ?memcpy? [-Werror=implicit-function-declaration]
>  ./arch/x86/include/asm/desc.h:121:2: error: implicit declaration of function ?memcpy? [-Werror=implicit-function-declaration]
>
> I guess it's about EFI=y but KASAN=n. Config attached.

It's actually, it's about KMEMCHECK=y and KASAN=n, because declaration
of memcpy() is hidden under ifndef.

arch/x86/include/asm/string_64.h:
    #ifndef CONFIG_KMEMCHECK
    #if (__GNUC__ == 4 && __GNUC_MINOR__ >= 3) || __GNUC__ > 4
    extern void *memcpy(void *to, const void *from, size_t len);
    #else
    #define memcpy(dst, src, len)                                   \
    .......
    #endif
    #else
    /*
     * kmemcheck becomes very happy if we use the REP instructions
unconditionally,
     * because it means that we know both memory operands in advance.
     */
    #define memcpy(dst, src, len) __inline_memcpy((dst), (src), (len))
    #endif

So it also broke build with GCCs 4.0 - 4.3.
And it also breaks clang build, because AFAIK clang defines GNUC,
GNUC_MINOR as 4.2.

>
> beyond fixing the build bug ... could we also engineer this in a better fashion
> than spreading random #undefs across various KASAN unrelated headers?

I think we can add something like -DNOT_KERNEL (anyone has a better name ?)
to the CFLAGS for everything that is not linked with the kernel binary
(efistub, arch/x86/boot)

So, if NOT_KERNEL is defined we will not #define memcpy(), so we won't
need these undefs.


> Thanks,
>
>         Ingo
