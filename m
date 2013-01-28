From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Jan 2013 17:18:31 +0000
Subject: [PATCH v2 06/16] ARM: bL_head.S: vlock-based first man election
In-Reply-To: <1359008879-9015-7-git-send-email-nicolas.pitre@linaro.org>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
 <1359008879-9015-7-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130128171831.GF23470@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 06:27:49AM +0000, Nicolas Pitre wrote:
> From: Dave Martin <dave.martin@linaro.org>
> 
> Instead of requiring the first man to be elected in advance (which
> can be suboptimal in some situations), this patch uses a per-
> cluster mutex to co-ordinate selection of the first man.
> 
> This should also make it more feasible to reuse this code path for
> asynchronous cluster resume (as in CPUidle scenarios).
> 
> We must ensure that the vlock data doesn't share a cacheline with
> anything else, or dirty cache eviction could corrupt it.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

[...]

> +
> +	.align	__CACHE_WRITEBACK_ORDER
> +	.type	first_man_locks, #object
> +first_man_locks:
> +	.space	VLOCK_SIZE * BL_MAX_CLUSTERS
> +	.align	__CACHE_WRITEBACK_ORDER
>  
>  	.type	bL_entry_vectors, #object
>  ENTRY(bL_entry_vectors)

I've just been chatting to Dave about this and __CACHE_WRITEBACK_ORDER
isn't really the correct solution here.

To summarise the problem: although vlocks are only accessed by CPUs with
their caches disabled, the lock structures could reside in the same
cacheline (at some level of cache) as cacheable data being written by
another CPU. This comes about because the vlock code has a cacheable alias
via the kernel linear mapping and means that when the cacheable data is
evicted, it clobbers the vlocks with stale values which are part of the
dirty cacheline.

Now, we also have this problem for DMA mappings, as mentioned here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/124276.html

It seems to me that we actually want a mechanism for allocating/managing
physically contiguous blocks of memory such that the cacheable alias is
removed from the linear mapping (perhaps we could use PAGE_NONE to avoid
confusing the mm code?).

Will
