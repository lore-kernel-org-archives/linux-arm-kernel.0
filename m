From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Fri, 9 Oct 2015 11:12:24 +0300
Subject: [PATCH v4 3/3] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAPAsAGz7Tp6Z87tPq_NNh_mcwPF_DOaXzu0po5f6AQxPAcsALQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-08 22:02 GMT+03:00 Ard Biesheuvel <ard.biesheuvel@linaro.org>:
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -59,4 +59,31 @@
>         _kernel_offset_le       = DATA_LE64(TEXT_OFFSET);       \
>         _kernel_flags_le        = DATA_LE64(__HEAD_FLAGS);
>
> +#ifdef CONFIG_EFI
> +
> +/*
> + * The EFI stub has its own symbol namespace prefixed by __efistub_, to
> + * isolate it from the kernel proper. The following symbols are legally
> + * accessed by the stub, so provide some aliases to make them accessible.
> + * Only include data symbols here, or text symbols of functions that are
> + * guaranteed to be safe when executed at another offset than they were
> + * linked at. The routines below are all implemented in assembler in a
> + * position independent manner
> + */
> +__efistub_memcmp               = __pi_memcmp;
> +__efistub_memchr               = __pi_memchr;
> +__efistub_memcpy               = __pi_memcpy;
> +__efistub_memmove              = __pi_memmove;
> +__efistub_memset               = __pi_memset;
> +__efistub_strlen               = __pi_strlen;
> +__efistub_strcmp               = __pi_strcmp;
> +__efistub_strncmp              = __pi_strncmp;
> +__efistub___flush_dcache_area  = __pi___flush_dcache_area;

So why we need these __pi_* aliases?
We could just do __efistub_memcmp = memcmp; Right?


> +
> +__efistub__text                        = _text;
> +__efistub__end                 = _end;
> +__efistub__edata               = _edata;
> +
> +#endif
