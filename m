From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jun 2010 13:59:52 +0100
Subject: [PATCH 2/2] arm: Make VFPv3 usable on ARMv6
In-Reply-To: <20100621135125.24299.91290.stgit@baageli.muru.com>
References: <20100621135125.24299.91290.stgit@baageli.muru.com>
Message-ID: <1277211592.29532.20.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-21 at 14:51 +0100, Tony Lindgren wrote:
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 315a540..19ba626 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -549,10 +549,14 @@ static int __init vfp_init(void)
>                 /*
>                  * Check for the presence of the Advanced SIMD
>                  * load/store instructions, integer and single
> -                * precision floating point operations.
> +                * precision floating point operations. Only check
> +                * for NEON if the hardware has TLS register as the
> +                * MVFR registers got added in ARM1136 r1p0 with TLS.
>                  */
> -               if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
> -                       elf_hwcap |= HWCAP_NEON;
> +               if (elf_hwcap & HWCAP_TLS) {
> +                       if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
> +                               elf_hwcap |= HWCAP_NEON;
> +               }

MVFR should be available with the new CPU id format:

	((read_cpuid_id() & 0x000f0000) == 0x000f0000)

I think that would be a cleaner test than relying on the TLS presence.

-- 
Catalin
