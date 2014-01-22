From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 11:38:55 +0000
Subject: [PATCH 1/3] ARM: Premit ioremap() to map reserved pages
In-Reply-To: <1390389916-8711-2-git-send-email-wangnan0@huawei.com>
References: <1390389916-8711-1-git-send-email-wangnan0@huawei.com>
 <1390389916-8711-2-git-send-email-wangnan0@huawei.com>
Message-ID: <20140122113855.GH1621@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 11:25:14AM +0000, Wang Nan wrote:
> This patch relaxes the restriction set by commit 309caa9cc, which
> prohibit ioremap() on all kernel managed pages.
> 
> Other architectures, such as x86 and (some specific platforms of) powerpc,
> allow such mapping.
> 
> ioremap() pages is an efficient way to avoid arm's mysterious cache control.
> This feature will be used for arm kexec support to ensure copied data goes into
> RAM even without cache flushing, because we found that flush_cache_xxx can't
> reliably flush code to memory.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: <stable@vger.kernel.org> # 3.4+
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geng Hui <hui.geng@huawei.com>
> ---
>  arch/arm/mm/ioremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index f123d6e..98b1c10 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -298,7 +298,7 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
>  	/*
>  	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
>  	 */
> -	if (WARN_ON(pfn_valid(pfn)))
> +	if (WARN_ON(pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn))))

Since reserved pages can still be mapped, how does this avoid the cacheable
alias issue fixed by 309caa9cc6ff ("ARM: Prohibit ioremap() on kernel
managed RAM")?

Will
