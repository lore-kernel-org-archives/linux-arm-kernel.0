From: olof@lixom.net (Olof Johansson)
Date: Mon, 15 Jul 2013 13:59:24 -0700
Subject: [PATCH] ARM: Add check for Cortex-A15 errata 798181 ECO
In-Reply-To: <1373920943-18308-1-git-send-email-robherring2@gmail.com>
References: <1373920943-18308-1-git-send-email-robherring2@gmail.com>
Message-ID: <CAOesGMjATn9MCzazUGmbD44XR8HyJZU4cCvmOEoUZsmCgutPUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 1:42 PM, Rob Herring <robherring2@gmail.com> wrote:
> diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
> index 9a52a07..7fd64b7 100644
> --- a/arch/arm/kernel/smp_tlb.c
> +++ b/arch/arm/kernel/smp_tlb.c
> @@ -74,10 +74,21 @@ static inline void ipi_flush_bp_all(void *ignored)
>  static int erratum_a15_798181(void)
>  {
>         unsigned int midr = read_cpuid_id();
> +       unsigned int revidr;
>
>         /* Cortex-A15 r0p0..r3p2 affected */
>         if ((midr & 0xff0ffff0) != 0x410fc0f0 || midr > 0x413fc0f2)
>                 return 0;
> +
> +       /* Check for Cortex A15 <= r3p2 with ECO fix */
> +       revidr = read_cpuid(CPUID_REVIDR);
> +       if ((revidr & 0x210) == 0x210)
> +               return 0;

Reading and evaluating all this on every invalidate seems suboptimal.
It should be possible to read just once and cache the result.

I would have had the same comment about the original patch, but ARM
pushes those to Russell in secret so it wasn't on the list. :-)


-Olof
