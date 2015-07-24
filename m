From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 12:24:48 +0100
Subject: [PATCH v2 05/20] arm64: elf: advertise 8.1 atomic instructions
 as new hwcap
In-Reply-To: <1437734531-10698-6-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-6-git-send-email-will.deacon@arm.com>
Message-ID: <20150724112447.GF3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:41:56AM +0100, Will Deacon wrote:
> The ARM v8.1 architecture introduces new atomic instructions to the A64
> instruction set for things like cmpxchg, so advertise their availability
> to userspace using a hwcap.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> index 73cf0f54d57c..361c8a8ef55f 100644
> --- a/arch/arm64/include/uapi/asm/hwcap.h
> +++ b/arch/arm64/include/uapi/asm/hwcap.h
> @@ -27,5 +27,6 @@
>  #define HWCAP_SHA1		(1 << 5)
>  #define HWCAP_SHA2		(1 << 6)
>  #define HWCAP_CRC32		(1 << 7)
> +#define HWCAP_ATOMICS		(1 << 8)
>  
>  #endif /* _UAPI__ASM_HWCAP_H */
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f3067d4d4e35..c7fd2c946374 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -280,6 +280,19 @@ static void __init setup_processor(void)
>  	if (block && !(block & 0x8))
>  		elf_hwcap |= HWCAP_CRC32;
>  
> +	block = (features >> 20) & 0xf;
> +	if (!(block & 0x8)) {
> +		switch (block) {
> +		default:
> +		case 2:
> +			elf_hwcap |= HWCAP_ATOMICS;
> +		case 1:
> +			/* RESERVED */
> +		case 0:
> +			break;
> +		}
> +	}

After we merge Robin's patch for cpuid_feature_extract_field(), we can
change this function (subsequent patch though).

-- 
Catalin
