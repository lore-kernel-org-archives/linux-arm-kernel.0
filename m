From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Dec 2015 12:40:47 +0000
Subject: [PATCH] arm64: update linker script to increased L1_CACHE_BYTES
 value
In-Reply-To: <1448972440-32633-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1448972440-32633-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151201124046.GA6643@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 01:20:40PM +0100, Ard Biesheuvel wrote:
> Bring the linker script in line with the recent increase of
> L1_CACHE_BYTES to 128. Replace the hardcoded value of 64 with the
> symbolic constant.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I think we need to same substitution for RW_DATA_SECTION too, for
CACHELINE_ALIGNED_DATA(cacheline) and READ_MOSTLY_DATA(cacheline).

For 32-bit, Will made the same changes in f0d5375e3c7b5d7f ("ARM:
7289/1: vmlinux.lds.S: do not hardcode cacheline size as 32 bytes").

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/vmlinux.lds.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 1ee2c3937d4e..3388970fbc0f 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <asm-generic/vmlinux.lds.h>
> +#include <asm/cache.h>
>  #include <asm/kernel-pgtable.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
> @@ -140,7 +141,7 @@ SECTIONS
>  		ARM_EXIT_KEEP(EXIT_DATA)
>  	}
>  
> -	PERCPU_SECTION(64)
> +	PERCPU_SECTION(L1_CACHE_BYTES)
>  
>  	. = ALIGN(PAGE_SIZE);
>  	__init_end = .;
> -- 
> 1.9.1
> 
