From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Feb 2016 11:49:08 +0000
Subject: [PATCH v2 3/3] arm64: prevent __va() translations before
 memstart_addr is assigned
In-Reply-To: <1455209282-9596-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1455209282-9596-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455209282-9596-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160212114908.GK25087@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 05:48:02PM +0100, Ard Biesheuvel wrote:
> Just a hack to check whether all early __va() calls are gone.
> ---
>  arch/arm64/include/asm/memory.h | 10 +++++++++-
>  arch/arm64/mm/init.c            |  2 +-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 083361531a61..0d4d1b3b9695 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -90,7 +90,9 @@
>  	__x >= PAGE_OFFSET ? (__x - PAGE_OFFSET + PHYS_OFFSET) :	\
>  			     (__x - kimage_voffset); })
>  
> -#define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
> +#define __phys_to_virt(x) ({						\
> +	assert_memstart_addr_assigned();				\
> +	(unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET); })
>  #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
>  
>  /*
> @@ -133,6 +135,12 @@ extern u64			kimage_vaddr;
>  /* the offset between the kernel virtual and physical mappings */
>  extern u64			kimage_voffset;
>  
> +static inline void assert_memstart_addr_assigned(void)
> +{
> +	if (unlikely(memstart_addr == (phys_addr_t)-1))
> +		asm("brk #%0" :: "I"(0x800));

Ok, I'll bite! Why isn't this just a BUG_ON?

Will
