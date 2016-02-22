From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Feb 2016 18:00:57 +0000
Subject: [PATCH v3 3/4] arm64: prevent potential circular header
 dependencies in asm/bug.h
In-Reply-To: <1455289046-21321-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1455289046-21321-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455289046-21321-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160222180056.GN31168@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 03:57:25PM +0100, Ard Biesheuvel wrote:
> Currently, using BUG_ON() in header files is cumbersome, due to the fact
> that asm/bug.h transitively includes a lot of other header files, resulting
> in the actual BUG_ON() invocation appearing before its definition in the
> preprocessor input. So let's reverse the #include dependency between
> asm/bug.h and asm/debug-monitors.h, by moving the definition of BUG_BRK_IMM
> from the latter to the former. Also fix up one user of asm/debug-monitors.h
> which relied on a transitive include.
> 
> Cc: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/bug.h            | 2 +-
>  arch/arm64/include/asm/debug-monitors.h | 2 +-
>  arch/arm64/kvm/hyp/debug-sr.c           | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
> index 4a748ce9ba1a..679d49221998 100644
> --- a/arch/arm64/include/asm/bug.h
> +++ b/arch/arm64/include/asm/bug.h
> @@ -18,7 +18,7 @@
>  #ifndef _ARCH_ARM64_ASM_BUG_H
>  #define _ARCH_ARM64_ASM_BUG_H
>  
> -#include <asm/debug-monitors.h>
> +#define BUG_BRK_IMM			0x800

I'd really like to keep all the BRK immediates together, otherwise it's
error-prone if/when we allocate new encodings. Maybe we could add a new
header file for them, if we really need to?

Alternatively, given that this is all behind DEBUG_VM, you could rewrite
the check as if (unlikely(...)) panic(...);

Will
