From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 27 Jan 2016 10:34:14 +0100
Subject: [PATCH 1/4] ARM: fix demoting HWCAP_SWP
In-Reply-To: <1453800223-18590-2-git-send-email-vladimir.murzin@arm.com>
References: <1453800223-18590-1-git-send-email-vladimir.murzin@arm.com>
 <1453800223-18590-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <CAKv+Gu-oPmMd8rLK7p8FMnaO4FPEyN=xctYxCvmBk4a18vinXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 January 2016 at 10:23, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> Commit b8c9592 "ARM: 8318/1: treat CPU feature register fields as signed
> quantities" accidentally altered cpuid register used to demote
> HWCAP_SWP.
> ARM ARM says that SyncPrim_instrs bits in ID_ISAR3 should be used with
> SynchPrim_instrs_frac from ID_ISAR4. So, follow this rule.
>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Apologies for breaking that ...

> ---
>  arch/arm/kernel/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 7d0cba6f..fde041b 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -510,7 +510,7 @@ static void __init elf_hwcap_fixup(void)
>          */
>         if (cpuid_feature_extract(CPUID_EXT_ISAR3, 12) > 1 ||
>             (cpuid_feature_extract(CPUID_EXT_ISAR3, 12) == 1 &&
> -            cpuid_feature_extract(CPUID_EXT_ISAR3, 20) >= 3))
> +            cpuid_feature_extract(CPUID_EXT_ISAR4, 20) >= 3))
>                 elf_hwcap &= ~HWCAP_SWP;
>  }
>
> --
> 1.7.9.5
>
