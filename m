From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Dec 2010 10:58:14 +0000
Subject: [PATCH 2/4] Optionally flush entire dcache from v6_dma_flush_range
In-Reply-To: <1292302659-1863-3-git-send-email-john.stultz@linaro.org>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-3-git-send-email-john.stultz@linaro.org>
Message-ID: <AANLkTimF2e6FNxUWHJYpnWMSWrnNKSeuqX=NXEk8w-A2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 December 2010 04:57, John Stultz <john.stultz@linaro.org> wrote:
> From: Arve Hj?nnev?g <arve@android.com>
>
> If CACHE_FLUSH_RANGE_LIMIT is defined, then the entire dcache will
> be flushed if the requested range is larger than this limit.
>
> CC: Nicolas Pitre <nicolas.pitre@linaro.org>
> CC: Russell King <linux@arm.linux.org.uk>
> Change-Id: I29277d645a9d6716b1952cf3b870c78496261dd0
> Signed-off-by: Arve Hj?nnev?g <arve@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> ?arch/arm/mm/cache-v6.S | ? 17 +++++++++++++++++
> ?1 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index 99fa688..92c66b4 100644
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -263,6 +263,11 @@ v6_dma_clean_range:
> ?* ? ? - end ? ? - virtual end address of region
> ?*/
> ?ENTRY(v6_dma_flush_range)
> +#ifdef CONFIG_CACHE_FLUSH_RANGE_LIMIT
> + ? ? ? sub ? ? r2, r1, r0
> + ? ? ? cmp ? ? r2, #CONFIG_CACHE_FLUSH_RANGE_LIMIT
> + ? ? ? bhi ? ? v6_dma_flush_dcache_all
> +#endif
> ? ? ? ?bic ? ? r0, r0, #D_CACHE_LINE_SIZE - 1
> ?1:
> ?#ifdef CONFIG_DMA_CACHE_RWFO

I'm not sure how CONFIG_CACHE_FLUSH_RANGE_LIMIT is defined but it
should depend on !CONFIG_DMA_CACHE_RWFO or just add this check to the
#ifdef. The D-cache flushing ops aren't broadcast on ARM11MPCore.

-- 
Catalin
