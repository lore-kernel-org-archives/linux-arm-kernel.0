From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 Sep 2017 08:26:09 -0700
Subject: [PATCH] ARM: unaligned.h: Use an arch-specific version
In-Reply-To: <20170920151802.7609-1-romain.izard.pro@gmail.com>
References: <20170920151802.7609-1-romain.izard.pro@gmail.com>
Message-ID: <CAKv+Gu_ZMy-A-Du3ikVe47pcUR7hSBFHY+hQQ8APGGP1iRcigA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,

On 20 September 2017 at 08:18, Romain Izard <romain.izard.pro@gmail.com> wrote:
> For the 32-bit ARM architecture, unaligned access support is variable.
> On a chip without a MMU, an unaligned access returns a rotated data word
> and must be avoided.
>
> When a MMU is available, it can be trapped. On ARMv6 or ARMv7, it can also
> be handled by the hardware, depending on the type of access instruction.
> Unaligned access of 32 bits or less are corrected, while larger access
> provoke a trap.
>
> Unfortunately, the compiler is able to merge two 32-bit access that
> would generate a LDR instruction, that works on unaligned access, into a
> single LDM access that will not work. This is not a common situation,
> but it has been observed in the LZ4 decompression code.
>
> To prevent this type of optimization, it is necessary to change the
> explicit accessors for unaligned addresses from those defined in the
> access_ok.h header, to those defined in the packed_struct.h header.
>
> Add an arch-specific header to ARM, to retain other optimizations that
> rely on HAVE_EFFICIENT_UNALIGNED_ACCESS, while making sure that access
> that explicitly rely on the unaligned accessors are correctly handled by
> the compiler.
>
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>

If access_ok.h has been observed to produce different output from the
struct versions (using any compiler), I guess we cannot simply change
the asm-generic default and expect everybody to be ok with that. So I
agree this is the most appropriate course of action.

With the wart below removed:
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> This is a follow-up to this discussion:
> HAVE_EFFICIENT_UNALIGNED_ACCESS on ARM32
> https://lkml.org/lkml/2017/9/4/359
>
>  arch/arm/include/asm/Kbuild      |  1 -
>  arch/arm/include/asm/unaligned.h | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/include/asm/unaligned.h
>
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index 721ab5ecfb9b..0f2c8a2a8131 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -20,7 +20,6 @@ generic-y += simd.h
>  generic-y += sizes.h
>  generic-y += timex.h
>  generic-y += trace_clock.h
> -generic-y += unaligned.h
>
>  generated-y += mach-types.h
>  generated-y += unistd-nr.h
> diff --git a/arch/arm/include/asm/unaligned.h b/arch/arm/include/asm/unaligned.h
> new file mode 100644
> index 000000000000..394227f24b77
> --- /dev/null
> +++ b/arch/arm/include/asm/unaligned.h
> @@ -0,0 +1,22 @@
> +#ifndef __ASM_ARM_UNALIGNED_H
> +#define __ASM_ARM_UNALIGNED_H
> +
> +#include <asm/byteorder.h>
> +
> +#if defined(__LITTLE_ENDIAN)
> +#include <linux/unaligned/le_struct.h>
> +#include <linux/unaligned/be_byteshift.h>
> +#include <linux/unaligned/generic.h>
> +#define get_unaligned  __get_unaligned_le
> +#define put_unaligned  __put_unaligned_le
> +#elif defined(__BIG_ENDIAN)
> +#include <linux/unaligned/be_struct.h>
> :q

^^^

> +#include <linux/unaligned/le_byteshift.h>
> +#include <linux/unaligned/generic.h>
> +#define get_unaligned  __get_unaligned_be
> +#define put_unaligned  __put_unaligned_be
> +#else
> +#error need to define endianness
> +#endif
> +
> +#endif /* __ASM_ARM_UNALIGNED_H */
> --
> 2.11.0
