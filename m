From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 18 May 2015 15:22:44 +0100
Subject: [PATCH] ARM: fix BE8 module loading
In-Reply-To: <2205892.6d8Sa1bONm@wuerfel>
References: <2205892.6d8Sa1bONm@wuerfel>
Message-ID: <5559F5B4.9060401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 18/05/15 13:36, Arnd Bergmann wrote:
> The new veneer support for loadable modules on ARM uses the
> __opcode_to_mem_thumb32() function to count R_ARM_THM_CALL
> and R_ARM_THM_JUMP24 relocations.
>
> However, this function is not defined for big-endian kernels
> on ARMv5 or before, causing a compile-time error:
>
> arch/arm/kernel/module-plts.c: In function 'count_plts':
> arch/arm/kernel/module-plts.c:124:9: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]
>           __opcode_to_mem_thumb32(0x07ff2fff)))
>           ^
>
> As we know that this part of the function is only needed for
> Thumb2 kernels, and that those can never happen with BE8,

Do you mean BE-32 here (and in the title)? That's the obsolete wacky 
word-invariant one, BE-8 is the sensible* one that modern CPUs support.

Robin.

*as sensible as big-endian could ever be, at any rate :P

> we can avoid the error by enclosing the code in an #ifdef.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7d485f647c1 ("ARM: 8220/1: allow modules outside of bl range")
> ---
> Found with the randconfig builder on linux-next.
>
> diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
> index 71a65c49871d..097e2e201b9f 100644
> --- a/arch/arm/kernel/module-plts.c
> +++ b/arch/arm/kernel/module-plts.c
> @@ -118,11 +118,13 @@ static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
>   					   __opcode_to_mem_arm(0x00ffffff)))
>   				ret++;
>   			break;
> +#ifdef CONFIG_THUMB2_KERNEL
>   		case R_ARM_THM_CALL:
>   		case R_ARM_THM_JUMP24:
>   			if (!duplicate_rel(base, rel, i,
>   					   __opcode_to_mem_thumb32(0x07ff2fff)))
>   				ret++;
> +#endif
>   		}
>   	return ret;
>   }
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
