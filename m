From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 15 May 2014 15:30:58 +0800
Subject: [PATCH] crash_dump: arm: crash dump kernel should use strict
 pfn_valid
In-Reply-To: <1400138070-24046-1-git-send-email-wangnan0@huawei.com>
References: <1400138070-24046-1-git-send-email-wangnan0@huawei.com>
Message-ID: <53746D32.4000708@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add kexec at lists.infradead.org to cc list.

On 2014/5/15 15:14, Wang Nan wrote:
> This patch makes crash dump kernel use arch pfn_valid defined in
> arch/arm/mm/init.c instead of the one in include/linux/mmzone.h.
> The goal of this patch is to remove some limitation when kexec loading
> crash kernel while SPARSEMEM is enabled.
> 
> Before this patch, if second kernel selects both CRASH_DUMP and
> SPARSEMEM, the second kernel will recongnize memorys at the same section
> with itself as valid memory, and prevents ioremap (see arm ioremap code,
> arm doesn't allow valid memory to be ioremapped again). Which introduces
> some limitations on positioning the crash kernel. For example:
> 
>   For a platform with SECTION_SIZE_BITS == 28 (256MiB) and
>   crashkernel=128M at 0x28000000 in kernel cmdline, the second
>   kernel is loaded at 0x28000000. Kexec puts elfcorehdr at
>   0x2ff00000, and passes 'elfcorehdr=0x2ff00000 mem=130048K' to
>   second kernel. When second kernel start, it tries to use
>   ioremap to retrive its elfcorehrd. In this case, elfcodehdr is at the
>   same section of the second kernel, pfn_valid will recongnize
>   the page as valid, so ioremap will refuse to map it.
> 
> Even if we put crash kernel at the boundary of two sections (such as
> 129MB at 0x0x28000000 in the above situation), 0x20000000-0x28000000 used
> by old kernel is still unable to retrived by crash kernel because they
> are at the same section.
> 
> This patch makes crash dump kernel use strict (and slow) version of
> pfn_valid(), which makes crash kernel recongnize memory correctly.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Geng Hui <hui.geng@huawei.com>
> Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> Cc: Simon Horman <horms@verge.net.au>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db3c541..795b1d4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1800,7 +1800,7 @@ config ARCH_SELECT_MEMORY_MODEL
>  	def_bool ARCH_SPARSEMEM_ENABLE
>  
>  config HAVE_ARCH_PFN_VALID
> -	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
> +	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM || CRASH_DUMP
>  
>  config HIGHMEM
>  	bool "High Memory Support"
> 
