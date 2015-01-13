From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 13 Jan 2015 15:45:52 +0000
Subject: CFT: move outer_cache_sync() out of line
In-Reply-To: <20150112163648.GL12302@n2100.arm.linux.org.uk>
References: <20150112163648.GL12302@n2100.arm.linux.org.uk>
Message-ID: <20150113154551.GF16524@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 04:36:48PM +0000, Russell King - ARM Linux wrote:
> The theory is that moving outer_cache_sync() out of line moves the
> conditional test from multiple sites to a single location, which
> in turn means that the branch predictor stands a better chance of
> making the correct decision.
[...]
> --- a/arch/arm/mm/l2c-common.c
> +++ b/arch/arm/mm/l2c-common.c
> @@ -7,9 +7,17 @@
>   * published by the Free Software Foundation.
>   */
>  #include <linux/bug.h>
> +#include <linux/export.h>
>  #include <linux/smp.h>
>  #include <asm/outercache.h>
>  
> +void outer_sync(void)
> +{
> +	if (outer_cache.sync)
> +		outer_cache.sync();
> +}

But don't you end up with two branches now? With an outer cache, I guess
the additional branch won't be noticed, especially if the prediction on
the outer_cache.sync() call is better (but that's not a simple
conditional branch prediction, it relies on predicting the value of the
pointer, not entirely sure how this works).

However, on SoCs without an outer cache (and single kernel image), we
end up with a permanent branch/return even though such branch would not
be needed.

-- 
Catalin
