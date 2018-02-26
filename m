From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Feb 2018 15:42:29 +0000
Subject: [RFC PATCH v2 07/12] arm64: lse: Include compiler_types.h and
 export.h for out-of-line LL/SC
In-Reply-To: <1519657500-15094-8-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
 <1519657500-15094-8-git-send-email-will.deacon@arm.com>
Message-ID: <20180226154229.ms6povjtyv4xt5ru@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 03:04:55PM +0000, Will Deacon wrote:
> When the LL/SC atomics are moved out-of-line, they are annotated as
> notrace and exported to modules. Ensure we pull in the relevant include
> files so that these macros are defined when we need them.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/lse.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
> index eec95768eaad..e612a6be113f 100644
> --- a/arch/arm64/include/asm/lse.h
> +++ b/arch/arm64/include/asm/lse.h
> @@ -4,6 +4,8 @@
>  
>  #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
>  
> +#include <linux/compiler_types.h>
> +#include <linux/export.h>
>  #include <linux/stringify.h>
>  #include <asm/alternative.h>

I think we should include <asm/cpucaps.h> since we explicitly use
ARM64_HAS_LSE_ATOMICS here.

Otherwise, I don't see that we need anything else here. With that, or if we
decide that <asm/alternative.h> will always include the definition of cpucaps:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
