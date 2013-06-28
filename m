From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Jun 2013 10:00:02 +0100
Subject: [PATCH] ARM: LPAE: don't reject mapping /dev/mem above 4GB
In-Reply-To: <1372353875-3262-1-git-send-email-dserrg@gmail.com>
References: <1372353875-3262-1-git-send-email-dserrg@gmail.com>
Message-ID: <20130628090001.GB4264@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 06:24:35PM +0100, Sergey Dyasly wrote:
> With LPAE enabled, physical address space is larger than 4GB. Allow mapping any
> part of it via /dev/mem by utilizing the same check as in arm64.
> 
> Reported-by: Vassili Karpov <av1474@comtv.ru>
> Tested-by: Vassili Karpov <av1474@comtv.ru>
> Signed-off-by: Sergey Dyasly <dserrg@gmail.com>
> ---
>  arch/arm/mm/mmap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 10062ce..8f1bbbc 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -203,6 +203,15 @@ int valid_phys_addr_range(phys_addr_t addr, size_t size)
>  	return 1;
>  }
>  
> +#ifdef CONFIG_ARM_LPAE
> +/*
> + * Do not allow /dev/mem mappings beyond the supported physical range.
> + */
> +int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
> +{
> +	return !(((pfn << PAGE_SHIFT) + size) & ~PHYS_MASK);
> +}
> +#else
>  /*
>   * We don't use supersection mappings for mmap() on /dev/mem, which
>   * means that we can't map the memory area above the 4G barrier into
> @@ -212,6 +221,7 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
>  {
>  	return !(pfn + (size >> PAGE_SHIFT) > 0x00100000);

BTW, I think you can use the original function with something like this:

	return !(pfn + (size >> PAGE_SHIFT) > (1 << (PHYS_MASK_SHIFT - PAGE_SHIFT)));

and define PHYS_MASK_SHIFT to 32 for classic MMU.

-- 
Catalin
