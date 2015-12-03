From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Dec 2015 11:31:58 +0000
Subject: [PATCH v6 05/19] arm64:uapi: set __BITS_PER_LONG correctly for
 ILP32 and LP64
In-Reply-To: <1447795019-30176-6-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-6-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151203113157.GI10747@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 12:16:45AM +0300, Yury Norov wrote:
> diff --git a/arch/arm64/include/uapi/asm/bitsperlong.h b/arch/arm64/include/uapi/asm/bitsperlong.h
> index fce9c29..4265243 100644
> --- a/arch/arm64/include/uapi/asm/bitsperlong.h
> +++ b/arch/arm64/include/uapi/asm/bitsperlong.h
> @@ -16,7 +16,14 @@
>  #ifndef __ASM_BITSPERLONG_H
>  #define __ASM_BITSPERLONG_H
>  
> -#define __BITS_PER_LONG 64
> +#if defined(__LP64__)
> +/* Assuming __LP64__ will be defined for native ELF64's and not for ILP32. */
> +#  define __BITS_PER_LONG 64
> +#elif defined(__ILP32__)
> +#  define __BITS_PER_LONG 32
> +#else
> +#  error "Neither LP64 nor ILP32: unsupported ABI in asm/bitsperlong.h"
> +#endif

Quick question: IIRC, earlier aarch64 gcc versions did not generate
__ILP32__ when -mabi=ilp32, they only removed __LP64__. When did the
change happen? Could we assume that all compiler versions used to
generate ILP32 would define this?

-- 
Catalin
