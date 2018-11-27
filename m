From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 27 Nov 2018 09:17:55 +0100
Subject: [PATCH v2 1/2] arm64: add workaround for ambiguous C99 stdint.h
 types
In-Reply-To: <20181127052701.4144-1-liuyun01@kylinos.cn>
References: <20181127052701.4144-1-liuyun01@kylinos.cn>
Message-ID: <CAKv+Gu9TEZ9j3xB9dM_tP9tenzoH+p6Y7-1KCKGEL7AkiVdRdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Nov 2018 at 06:28, Jackie Liu <liuyun01@kylinos.cn> wrote:
>
> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
> for ambiguous C99 stdint.h types"), this patch redefines the macros that
> are used in stdint.h so its definitions of uint64_t and int64_t are
> compatible with those of the kernel.
>
> This patch comes from: https://patchwork.kernel.org/patch/3540001/
> Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>

OK, I remember now :-)

So this is the reason you had two separate source files in the
previous revision.

Could we maybe deal with this differently? Could we add a header

arch/arm64/include/asm/neon-intrinsics.h

that includes <arm_neon.h> after setting the preprocessor overrides
below? And reference that header from your code?

That way, we don't have to override asm/types.h for everyone.



> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  arch/arm64/include/uapi/asm/types.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 arch/arm64/include/uapi/asm/types.h
>
> diff --git a/arch/arm64/include/uapi/asm/types.h b/arch/arm64/include/uapi/asm/types.h
> new file mode 100644
> index 0000000..0016780
> --- /dev/null
> +++ b/arch/arm64/include/uapi/asm/types.h
> @@ -0,0 +1,26 @@
> +#ifndef _UAPI_ASM_TYPES_H
> +#define _UAPI_ASM_TYPES_H
> +
> +#include <asm-generic/int-ll64.h>
> +
> +/*
> + * For Aarch64, there is some ambiguity in the definition of the types below
> + * between the kernel and GCC itself. This is usually not a big deal, but it
> + * causes trouble when including GCC's version of 'stdint.h' (this is the file
> + * that gets included when you #include <stdint.h> on a -ffreestanding build).
> + * As this file also gets included implicitly when including 'arm_neon.h' (the
> + * NEON intrinsics support header), we need the following to work around the
> + * issue if we want to use NEON intrinsics in the kernel.
> + */
> +
> +#ifdef __INT64_TYPE__
> +#undef __INT64_TYPE__
> +#define __INT64_TYPE__         __signed__ long long
> +#endif
> +
> +#ifdef __UINT64_TYPE__
> +#undef __UINT64_TYPE__
> +#define __UINT64_TYPE__                unsigned long long
> +#endif
> +
> +#endif /* _UAPI_ASM_TYPES_H */
> --
> 2.7.4
>
>
>
>
