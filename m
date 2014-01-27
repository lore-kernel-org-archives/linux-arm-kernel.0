From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Jan 2014 12:16:13 +0000
Subject: [PATCH] arm64: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <1390823984-23046-1-git-send-email-vkale@apm.com>
References: <1390823984-23046-1-git-send-email-vkale@apm.com>
Message-ID: <20140127121613.GB6547@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinayak,

On Mon, Jan 27, 2014 at 11:59:44AM +0000, Vinayak Kale wrote:
> Add DSB after icache flush operation.

Please elaborate a bit on what this achieves (i.e. completion of the
maintenance operation).

> Signed-off-by: Vinayak Kale <vkale@apm.com>
> ---
>  arch/arm64/include/asm/cacheflush.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index fea9ee3..88932498 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -116,6 +116,7 @@ extern void flush_dcache_page(struct page *);
>  static inline void __flush_icache_all(void)
>  {
>  	asm("ic	ialluis");

This needs a "memory" clobber to prevent re-ordering by GCC. We should
probably check the rest of the code for other occurrences of this too.

> +	dsb();

Can you make a corresponding change for arch/arm/ too, please? I think we're
missing the barrier there as well.

Will
