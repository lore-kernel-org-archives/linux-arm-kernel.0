From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Feb 2012 17:30:27 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
Message-ID: <20120228173027.GB22082@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 09:44:22AM +0000, Bill Carson wrote:
> diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
> index 97b440c..3e6769a 100644
> --- a/arch/arm/include/asm/page.h
> +++ b/arch/arm/include/asm/page.h
> @@ -15,6 +15,21 @@
>  #define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
>  #define PAGE_MASK		(~(PAGE_SIZE-1))
>  
> +#ifdef CONFIG_HUGEPAGE_SIZE_2MB
> +/* we have 2MB hugepage for two 1MB section mapping */
> +#define HPAGE_SHIFT		(SECTION_SHIFT + 1)
> +#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
> +#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
> +#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
> +#endif
> +
> +#ifdef CONFIG_HUGEPAGE_SIZE_16MB
> +#define HPAGE_SHIFT		SUPERSECTION_SHIFT
> +#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
> +#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
> +#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
> +#endif

Ah, you still have these just config time options. Can you not make an
hpage_shift variable like PowerPC or IA-64?

(I haven't yet reviewed the rest of the code)

-- 
Catalin
