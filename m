From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 28 Aug 2015 15:43:58 +0100
Subject: [PATCH v2] x86, efi, kasan: #undef memset/memcpy/memmove per arch.
In-Reply-To: <1440760199-18111-1-git-send-email-ryabinin.a.a@gmail.com>
References: <20150828062745.GB1928@gmail.com>
 <1440760199-18111-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <20150828144358.GI2759@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Aug, at 02:09:59PM, Andrey Ryabinin wrote:
> In not-instrumented code KASAN replaces instrumented
> memset/memcpy/memmove with not-instrumented analogues
> __memset/__memcpy/__memove.
> However, on x86 the EFI stub is not linked with the kernel.
> It uses not-instrumented mem*() functions from
> arch/x86/boot/compressed/string.c
> So we don't replace them with __mem*() variants in EFI stub.
> 
> On ARM64 the EFI stub is linked with the kernel, so we should
> replace mem*() functions with __mem*(), because the EFI stub
> runs before KASAN sets up early shadow.
> 
> So let's move these #undef mem* into arch's asm/efi.h which is
> also included by the EFI stub.
> 
> Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> ---
>  arch/x86/include/asm/efi.h             | 11 +++++++++++
>  drivers/firmware/efi/libstub/efistub.h |  4 ----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 155162e..6862f11 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -25,6 +25,17 @@
>  #define EFI32_LOADER_SIGNATURE	"EL32"
>  #define EFI64_LOADER_SIGNATURE	"EL64"
>  
> +/*
> + * Sometimes we may redefine memset to __memset.
> + * The EFI stub doesn't have __memset() because it's not
> + * linked with the kernel. So we should use standard
> + * memset from arch/x86/boot/compressed/string.c
> + * The same applies to memcpy and memmove.
> + */
> +#undef memcpy
> +#undef memset
> +#undef memmove
> +

I think the key piece of information missing in this comment is that
it's redefined for KASAN, right?

>  #ifdef CONFIG_X86_32
>  
>  
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index e334a01..6b6548f 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -5,10 +5,6 @@
>  /* error code which can't be mistaken for valid address */
>  #define EFI_ERROR	(~0UL)
>  
> -#undef memcpy
> -#undef memset
> -#undef memmove
> -
>  void efi_char16_printk(efi_system_table_t *, efi_char16_t *);
>  
>  efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg, void *__image,

Does this patch have any negative consequences for arm64? Can we
safely remove these #undefs without breaking the arm64 EFI stub?

-- 
Matt Fleming, Intel Open Source Technology Center
