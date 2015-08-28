From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 28 Aug 2015 08:27:45 +0200
Subject: [PATCH 1/4] x86, efi, kasan: #undef memset/memcpy/memmove per
 arch.
In-Reply-To: <1440605707-8325-2-git-send-email-ryabinin.a.a@gmail.com>
References: <1440605707-8325-1-git-send-email-ryabinin.a.a@gmail.com>
 <1440605707-8325-2-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <20150828062745.GB1928@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:

> In not-instrumented code KASAN replaces instrumented
> memset/memcpy/memmove with not-instrumented analogues
> __memset/__memcpy/__memove.
> However, on x86 EFI stub is not linked with kernel.

s/with the kernel

> It uses not-instrumented mem*() functions from
> arch/x86/boot/compressed/string.c
> So we don't replace them with __mem*() variants in EFI stub.
> 
> In ARM64 EFI stub is linked with the kernel, so we should

s/In ARM64 EFI stub/On ARM64 the EFI stub/.

> replace mem*() functions with __mem*(), because EFI stub

s/the EFI stub

> runs before KASAN setup early shadow.

s/before KASAN sets up the early shadow

?

> So let's move these #undef mem* into arch's asm/efi.h which is

s/lets

> also included by EFI stub.

s/by the EFI stub

> 
> Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> ---
>  arch/x86/include/asm/efi.h             | 8 ++++++++
>  drivers/firmware/efi/libstub/efistub.h | 4 ----
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 155162e..d821ce2 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -25,6 +25,14 @@
>  #define EFI32_LOADER_SIGNATURE	"EL32"
>  #define EFI64_LOADER_SIGNATURE	"EL64"
>  
> +/*
> + * Use memcpy/memset from arch/x86/boot/compressed/string.c
> + * for EFI stub.
> + */
> +#undef memcpy
> +#undef memset
> +#undef memmove

This comment should also mention why it's done, not what is done.

Also:

    s/for EFI stub/for the EFI stub

Thanks,

	Ingo
