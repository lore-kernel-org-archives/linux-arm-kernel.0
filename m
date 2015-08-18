From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Aug 2015 11:00:27 +0100
Subject: [PATCH 2/2] arm64: set MAX_MEMBLOCK_ADDR according to linear
 region size
In-Reply-To: <1439890482-20798-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
 <1439890482-20798-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150818100018.GA11021@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 10:34:42AM +0100, Ard Biesheuvel wrote:
> The linear region size of a 39-bit VA kernel is only 256 GB, which
> may be insufficient to cover all of system RAM, even on platforms
> that have much less than 256 GB of memory but which is laid out
> very sparsely.
> 
> So make sure we clip the memory we will not be able to map before
> installing it into the memblock memory table, by setting
> MAX_MEMBLOCK_ADDR accordingly.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/memory.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index f800d45ea226..44a59c20e773 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -114,6 +114,14 @@ extern phys_addr_t		memstart_addr;
>  #define PHYS_OFFSET		({ memstart_addr; })
>  
>  /*
> + * The maximum physical address that the linear direct mapping
> + * of system RAM can cover. (PAGE_OFFSET can be interpreted as
> + * a 2's complement signed quantity and negated to derive the
> + * maximum size of the linear mapping.)
> + */
> +#define MAX_MEMBLOCK_ADDR	({ memstart_addr - PAGE_OFFSET - 1; })

If we initialised memory_limit to this value and changed early_mem to
use min (i.e. only restrict the limit further), would that avoid the
need to change the of code? It looks like PPC uses
memblock_enforce_memory_limit for similar reasons.

Will
