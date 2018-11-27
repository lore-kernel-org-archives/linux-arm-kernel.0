From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 27 Nov 2018 13:44:51 +0100
Subject: [PATCH v4 1/1] arm64/neon: add workaround for ambiguous C99
 stdint.h types
In-Reply-To: <20181127123813.7523-1-liuyun01@kylinos.cn>
References: <20181127123813.7523-1-liuyun01@kylinos.cn>
Message-ID: <CAKv+Gu8KB91XmacyS5rBK+_5pKdS_i+z2Wi+J0fGXweL9Q_hqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(add maintainers back to cc)

On Tue, 27 Nov 2018 at 13:38, Jackie Liu <liuyun01@kylinos.cn> wrote:
>
> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
> for ambiguous C99 stdint.h types"), this patch redefines the macros that
> are used in stdint.h so its definitions of uint64_t and int64_t are
> compatible with those of the kernel.
>
> This patch comes from: https://patchwork.kernel.org/patch/3540001/
> Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> We mark this file as a private file and don't have to override asm/types.h
>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

(Nit below)

> ---
>  arch/arm64/include/asm/neon-intrinsics.h | 35 ++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 arch/arm64/include/asm/neon-intrinsics.h
>
> diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
> new file mode 100644
> index 0000000..145d8ea
> --- /dev/null
> +++ b/arch/arm64/include/asm/neon-intrinsics.h
> @@ -0,0 +1,35 @@
> +#ifndef _NEON_INTRINSICS_H
> +#define _NEON_INTRINSICS_H
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
> +/*
> + * genksyms chokes on the ARM NEON instrinsics system header, but we
> + * don't export anything
> + * it defines anyway, so just disregard when genksyms execute.

Can we fix up the spurious newline and the grammar here when applying? [my bad]

> + */
> +#ifndef __GENKSYMS__
> +#include <arm_neon.h>
> +#endif
> +
> +#endif /* ! _NEON_INTRINSICS_H */
> --
> 2.7.4
>
>
>
