From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jul 2015 14:48:46 +0100
Subject: [PATCH 03/18] arm64: elf: advertise 8.1 atomic instructions as
 new hwcap
In-Reply-To: <1436779519-2232-4-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-4-git-send-email-will.deacon@arm.com>
Message-ID: <20150717134845.GA15035@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 10:25:04AM +0100, Will Deacon wrote:
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

At some point, we should move the elf_hwcap setting to the cpu features
infrastructure. The PAN patch series introduces an "enable" method for
detected CPU features (can be cleaned up for 4.4).

-- 
Catalin
