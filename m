From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Sep 2013 14:12:07 +0100
Subject: [PATCH] ARM: l2x0: protect outer_cache_fns.sync pointer
 assignment with OUTER_CACHE_SYNC
In-Reply-To: <1379861550.88310.YahooMailNeo@web161601.mail.bf1.yahoo.com>
References: <1379861550.88310.YahooMailNeo@web161601.mail.bf1.yahoo.com>
Message-ID: <20130926131207.GA3467@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 22, 2013 at 03:52:30PM +0100, Eran Ben-Avi wrote:
> Outer cache sync pointer function should be assigned only if OUTER_CACHE_SYNC
> config option was selected, otherwise pointer is not valid.
> 
> Signed-off-by: Eran Ben-Avi <benavi@marvell.com>
> ---
> ?arch/arm/mm/cache-l2x0.c |?? 12 ++++++++++++
> ?1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 447da6f..d358573 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -128,6 +128,7 @@ static inline void l2x0_flush_line(unsigned long addr)
> ?}
> ?#endif
> ?
> +#ifdef CONFIG_OUTER_CACHE_SYNC
> ?static void l2x0_cache_sync(void)
> ?{
> ???? unsigned long flags;
> @@ -136,6 +137,7 @@ static void l2x0_cache_sync(void)
> ???? cache_sync();
> ???? raw_spin_unlock_irqrestore(&l2x0_lock, flags);
> ?}
> +#endif
> ?
> ?static void __l2x0_flush_all(void)
> ?{
> @@ -411,7 +413,9 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
> ???? ??? outer_cache.inv_range = l2x0_inv_range;
> ???? ??? outer_cache.clean_range = l2x0_clean_range;
> ???? ??? outer_cache.flush_range = l2x0_flush_range;
> +#ifdef CONFIG_OUTER_CACHE_SYNC
> ???? ??? outer_cache.sync = l2x0_cache_sync;
> +#endif

Since outer_cache.sync is conditionally defined, the patch makes sense.
Alternatively, we could leave the .sync member always defined and just
have a conditionally defined l2x0_cache_sync (NULL when
!OUTER_CACHE_SYNC).

-- 
Catalin
