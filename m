From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 30 Jun 2015 12:01:02 +0200
Subject: [PATCH] ARM: mm: handle non-pmd-aligned end of RAM
In-Reply-To: <20150511103130.GA3490@leverpostej>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
 <20150511103130.GA3490@leverpostej>
Message-ID: <CABxcv=noPD1vdY5V-G+M16S0y20VO2_s6XbQJG_qM+=dOKtZxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Krzysztof, Doug, Kukjin and Sjoerd to cc since they are also
familiar with this platform]

Hello Mark,

On Mon, May 11, 2015 at 12:31 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> At boot time we round the memblock limit down to section size in an
> attempt to ensure that we will have mapped this RAM with section
> mappings prior to allocating from it. When mapping RAM we iterate over
> PMD-sized chunks, creating these section mappings.
>
> Section mappings are only created when the end of a chunk is aligned to
> section size. Unfortunately, with classic page tables (where PMD_SIZE is
> 2 * SECTION_SIZE) this means that if a chunk is between 1M and 2M in
> size the first 1M will not be mapped despite having been accounted for
> in the memblock limit. This has been observed to result in page tables
> being allocated from unmapped memory, causing boot-time hangs.
>
> This patch modifies the memblock limit rounding to always round down to
> PMD_SIZE instead of SECTION_SIZE. For classic MMU this means that we
> will round the memblock limit down to a 2M boundary, matching the limits
> on section mappings, and preventing allocations from unmapped memory.
> For LPAE there should be no change as PMD_SIZE == SECTION_SIZE.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Stefan Agner <stefan@agner.ch>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Steve Capper <steve.capper@linaro.org>
> ---
>  arch/arm/mm/mmu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4e6ef89..7186382 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1112,22 +1112,22 @@ void __init sanity_check_meminfo(void)
>                         }
>
>                         /*
> -                        * Find the first non-section-aligned page, and point
> +                        * Find the first non-pmd-aligned page, and point
>                          * memblock_limit at it. This relies on rounding the
> -                        * limit down to be section-aligned, which happens at
> -                        * the end of this function.
> +                        * limit down to be pmd-aligned, which happens at the
> +                        * end of this function.
>                          *
>                          * With this algorithm, the start or end of almost any
> -                        * bank can be non-section-aligned. The only exception
> -                        * is that the start of the bank 0 must be section-
> +                        * bank can be non-pmd-aligned. The only exception is
> +                        * that the start of the bank 0 must be section-
>                          * aligned, since otherwise memory would need to be
>                          * allocated when mapping the start of bank 0, which
>                          * occurs before any free memory is mapped.
>                          */
>                         if (!memblock_limit) {
> -                               if (!IS_ALIGNED(block_start, SECTION_SIZE))
> +                               if (!IS_ALIGNED(block_start, PMD_SIZE))
>                                         memblock_limit = block_start;
> -                               else if (!IS_ALIGNED(block_end, SECTION_SIZE))
> +                               else if (!IS_ALIGNED(block_end, PMD_SIZE))
>                                         memblock_limit = arm_lowmem_limit;
>                         }
>
> @@ -1137,12 +1137,12 @@ void __init sanity_check_meminfo(void)
>         high_memory = __va(arm_lowmem_limit - 1) + 1;
>
>         /*
> -        * Round the memblock limit down to a section size.  This
> +        * Round the memblock limit down to a pmd size.  This
>          * helps to ensure that we will allocate memory from the
> -        * last full section, which should be mapped.
> +        * last full pmd, which should be mapped.
>          */
>         if (memblock_limit)
> -               memblock_limit = round_down(memblock_limit, SECTION_SIZE);
> +               memblock_limit = round_down(memblock_limit, PMD_SIZE);
>         if (!memblock_limit)
>                 memblock_limit = arm_lowmem_limit;
>
> --

There were reports of 4.1 not booting on the Exynos Chromebooks. I did
a bisect on an Exynos5420 Peach Pit Chromebook and tracked it down to
$subject as the cause. Reverting this commit makes it to boot again.

In case someone is not familiar with the Exynos Chromebooks, they have
a read-only u-boot that can only boot signed images so there are two
ways to boot a kernel:

1) Booting a signed FIT image that contains the zImage + FDT
2) Chain loading a signed u-boot image (i.e: mainline u-boot) that can
in turn boot a non signed kernel image

4.1 is failing to boot only for 1), doing 2) leads to the kernel
booting successfully.

Adding some printouts I found that the memory layout and total amount
of RAM is different when booting a FIT image directly and when chain
loading a mainline u-boot.

when chain loading a mainline u-boot:
------------------------------------------------------

memory block: block_start 0x40000000 size 0x60000000

This 1.5 GiB block is both PMD_SIZE and SECTION_SIZE aligned

when booting using the vendor u-boot and a FIT:
---------------------------------------------------------------------

memory block: block_start 0x20000000 size 0x1e00000
memory block: block_start 0x21f00000 size 0x7e100000

The first 30MiB block is both PMD_SIZE and SECTION_SIZE aligned but
the second (~2GiB) block start is SECTION_SIZE aligned but no PMD_SIZE
aligned.

The Device Tree memory node in arch/arm/boot/dts/exynos5420-peach-pit.dts is:

memory {
      reg = <0x20000000 0x80000000>;
};

So besides wondering which memory layout is the correct one, I wonder
if this patch is not just exposing another latent bug on this
platform.

Since before this patch, memblock_limit was always set to
arm_lowmem_limit in both cases because the memory blocks were always
aligned to SECTION_SIZE regardless if booting a FIT directly or chain
loading mainline u-boot.

But this is not true anymore when rounding memblock_limit down to
PMD_SIZE since when booting using a FIT, the second memory area start
is only SECTION_SIZE aligned but no PMD_SIZE aligned.

Best regards,
Javier
