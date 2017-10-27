From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Oct 2017 17:19:55 +0200
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <20171020200231.1355569-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Fri, 20 Oct 2017 22:01:56 +0200")
References: <20171020200231.1355569-1-arnd@arndb.de>
Message-ID: <87wp3g39es.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On ven., oct. 20 2017, Arnd Bergmann <arnd@arndb.de> wrote:

> The asm-generic/unaligned.h header provides two different implementations
> for accessing unaligned variables: the access_ok.h version used when
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set pretends that all pointers
> are in fact aligned, while the le_struct.h version convinces gcc that the
> alignment of a pointer is '1', to make it issue the correct load/store
> instructions depending on the architecture flags.
>
> On ARMv5 and older, we always use the second version, to let the compiler
> use byte accesses. On ARMv6 and newer, we currently use the access_ok.h
> version, so the compiler can use any instruction including stm/ldm and
> ldrd/strd that will cause an alignment trap. This trap can significantly
> impact performance when we have to do a lot of fixups and, worse, has
> led to crashes in the LZ4 decompressor code that does not have a trap
> handler.
>
> This adds an ARM specific version of asm/unaligned.h that uses the
> le_struct.h/be_struct.h implementation unconditionally. This should lead
> to essentially the same code on ARMv6+ as before, with the exception of
> using regular load/store instructions instead of the trapping instructions
> multi-register variants.
>
> The crash in the LZ4 decompressor code was probably introduced by the
> patch replacing the LZ4 implementation, commit 4e1a33b105dd ("lib: update
> LZ4 compressor module"), so linux-4.11 and higher would be affected most.
> However, we probably want to have this backported to all older stable
> kernels as well, to help with the performance issues.
>
> There are two follow-ups that I think we should also work on, but not
> backport to stable kernels, first to change the asm-generic version of
> the header to remove the ARM special case, and second to review all
> other uses of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS to see if they
> might be affected by the same problem on ARM.
>
> Cc: stable at vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Untested so far, please verify that this fixes all the known problems
> with the alignment traps.

I think Russell already find this conclusion but this patch didn't solve
my boot issue with dtb append.

I tested this patch onto a v4.14-rc6.

Then at least with the patch from Ard: "efi/libstub: arm: omit sorting
of the UEFI memory map", it didn't prevent booting.

Gregory


> ---
>  arch/arm/include/asm/Kbuild      |  1 -
>  arch/arm/include/asm/unaligned.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
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
> index 000000000000..ab905ffcf193
> --- /dev/null
> +++ b/arch/arm/include/asm/unaligned.h
> @@ -0,0 +1,27 @@
> +#ifndef __ASM_ARM_UNALIGNED_H
> +#define __ASM_ARM_UNALIGNED_H
> +
> +/*
> + * We generally want to set CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on ARMv6+,
> + * but we don't want to use linux/unaligned/access_ok.h since that can lead
> + * to traps on unaligned stm/ldm or strd/ldrd.
> + */
> +#include <asm/byteorder.h>
> +
> +#if defined(__LITTLE_ENDIAN)
> +# include <linux/unaligned/le_struct.h>
> +# include <linux/unaligned/be_byteshift.h>
> +# include <linux/unaligned/generic.h>
> +# define get_unaligned	__get_unaligned_le
> +# define put_unaligned	__put_unaligned_le
> +#elif defined(__BIG_ENDIAN)
> +# include <linux/unaligned/be_struct.h>
> +# include <linux/unaligned/le_byteshift.h>
> +# include <linux/unaligned/generic.h>
> +# define get_unaligned	__get_unaligned_be
> +# define put_unaligned	__put_unaligned_be
> +#else
> +# error need to define endianess
> +#endif
> +
> +#endif /* __ASM_ARM_UNALIGNED_H */
> -- 
> 2.9.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
