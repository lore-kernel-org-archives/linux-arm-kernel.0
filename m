From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Jul 2013 18:15:31 +0100
Subject: [PATCH v2] ARM: LPAE: don't reject mapping /dev/mem above 4GB
In-Reply-To: <1372780685-2528-1-git-send-email-dserrg@gmail.com>
References: <1372780685-2528-1-git-send-email-dserrg@gmail.com>
Message-ID: <20130702171530.GG24828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 04:58:05PM +0100, Sergey Dyasly wrote:
> With LPAE enabled, physical address space is larger than 4GB. Allow mapping any
> part of it via /dev/mem by utilizing the same check as in arm64.
> 
> PHYS_MASK covers 40 bits with LPAE enabled and 32 bits otherwise.
> 
> Signed-off-by: Sergey Dyasly <dserrg@gmail.com>
> ---
> 
> v2:
> - Removed #ifdef and changed original function as suggested by Catalin Marinas
> 
>  arch/arm/mm/mmap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 10062ce..09bab92 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -204,13 +204,11 @@ int valid_phys_addr_range(phys_addr_t addr, size_t size)
>  }
>  
>  /*
> - * We don't use supersection mappings for mmap() on /dev/mem, which
> - * means that we can't map the memory area above the 4G barrier into
> - * userspace.
> + * Do not allow /dev/mem mappings beyond the supported physical range.
>   */
>  int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
>  {
> -	return !(pfn + (size >> PAGE_SHIFT) > 0x00100000);
> +	return !(((pfn << PAGE_SHIFT) + size) & ~PHYS_MASK);

I don't think that's what I suggested. For classic MMU ~PHYS_MASK is 0.

-- 
Catalin
