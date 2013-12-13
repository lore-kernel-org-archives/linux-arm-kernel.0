From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 13 Dec 2013 12:41:31 +0000
Subject: [PATCH 2/2] arm: cacheflush: Fix user split-caching logic
In-Reply-To: <1386936391-30493-3-git-send-email-steve.capper@linaro.org>
References: <1386936391-30493-1-git-send-email-steve.capper@linaro.org>
 <1386936391-30493-3-git-send-email-steve.capper@linaro.org>
Message-ID: <20131213124130.GA31195@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 12:06:31PM +0000, Steve Capper wrote:
> The user split-caching logic in __do_cache_op divides the area to be
> flushed into interruptable chunks of size PAGE_SIZE. Unfortunately,
> there is no check to see whether or not the range to be flushed is
> smaller than the chunk size.
> 
> This can result cache flushes for larger ranges than intended,
> which can result in the flush failing with a -EFAULT. I've observed
> slowdown and failure with the icache-hygiene test from libhugetlbfs.
> 
> This patch fixes the problem by replacing chunk with the minimum of
> PAGE_SIZE or (end - start), thus we do not overflush.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Gah, apologies. The min should be placed within the loop not before
as one may not have an exact multiple of chunk size to flush.

Please ignore this patch, I'll resend an improved version.

Cheers,
--
Steve

> ---
>  arch/arm/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 8fcda14..5d3c455 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -503,7 +503,7 @@ static inline int
>  __do_cache_op(unsigned long start, unsigned long end)
>  {
>  	int ret;
> -	unsigned long chunk = PAGE_SIZE;
> +	unsigned long chunk = min(end - start, PAGE_SIZE);
>  
>  	do {
>  		if (signal_pending(current)) {
> -- 
> 1.8.1.4
> 
