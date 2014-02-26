From: kirill.shutemov@linux.intel.com (Kirill A. Shutemov)
Date: Wed, 26 Feb 2014 16:00:40 +0200 (EET)
Subject: [PATCH] mm: disable split page table lock for !MMU
In-Reply-To: <1393422925-22108-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1393422925-22108-1-git-send-email-kirill.shutemov@linux.intel.com>
Message-ID: <20140226140040.8E07AE0098@blue.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Oops. CC: lists)

Kirill A. Shutemov wrote:
> There's no reason to enable split page table lock if don't have page
> tables.
> 
> It also triggers build error at least on ARM since we don't define
> pmd_page() for !MMU.
> 
> In file included from arch/arm/kernel/asm-offsets.c:14:0:
> include/linux/mm.h: In function 'pte_lockptr':
> include/linux/mm.h:1392:2: error: implicit declaration of function 'pmd_page' [-Werror=implicit-function-declaration]
> include/linux/mm.h:1392:2: warning: passing argument 1 of 'ptlock_ptr' makes pointer from integer without a cast [enabled by default]
> include/linux/mm.h:1384:27: note: expected 'struct page *' but argument is of type 'int'
> 
> Reported-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 2d9f1504d75e..90bd85ea6035 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -216,6 +216,7 @@ config PAGEFLAGS_EXTENDED
>  #
>  config SPLIT_PTLOCK_CPUS
>  	int
> +	default "999999" if !MMU
>  	default "999999" if ARM && !CPU_CACHE_VIPT
>  	default "999999" if PARISC && !PA20
>  	default "4"
> -- 
> 1.9.0

-- 
 Kirill A. Shutemov
