From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 May 2015 15:01:45 +0200
Subject: [PATCH] ARM: fix BE8 module loading
In-Reply-To: <2205892.6d8Sa1bONm@wuerfel>
References: <2205892.6d8Sa1bONm@wuerfel>
Message-ID: <CAKv+Gu_kD2GsFDk_gQDttOK5qwWML_3C+kfYisAwF0KXoNow6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2015 at 14:36, Arnd Bergmann <arnd@arndb.de> wrote:
> The new veneer support for loadable modules on ARM uses the
> __opcode_to_mem_thumb32() function to count R_ARM_THM_CALL
> and R_ARM_THM_JUMP24 relocations.
>
> However, this function is not defined for big-endian kernels
> on ARMv5 or before, causing a compile-time error:
>
> arch/arm/kernel/module-plts.c: In function 'count_plts':
> arch/arm/kernel/module-plts.c:124:9: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]
>          __opcode_to_mem_thumb32(0x07ff2fff)))
>          ^
>
> As we know that this part of the function is only needed for
> Thumb2 kernels, and that those can never happen with BE8,
> we can avoid the error by enclosing the code in an #ifdef.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7d485f647c1 ("ARM: 8220/1: allow modules outside of bl range")
> ---
> Found with the randconfig builder on linux-next.
>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
> index 71a65c49871d..097e2e201b9f 100644
> --- a/arch/arm/kernel/module-plts.c
> +++ b/arch/arm/kernel/module-plts.c
> @@ -118,11 +118,13 @@ static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
>                                            __opcode_to_mem_arm(0x00ffffff)))
>                                 ret++;
>                         break;
> +#ifdef CONFIG_THUMB2_KERNEL
>                 case R_ARM_THM_CALL:
>                 case R_ARM_THM_JUMP24:
>                         if (!duplicate_rel(base, rel, i,
>                                            __opcode_to_mem_thumb32(0x07ff2fff)))
>                                 ret++;
> +#endif
>                 }
>         return ret;
>  }
>
