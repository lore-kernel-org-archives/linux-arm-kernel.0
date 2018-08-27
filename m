From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 27 Aug 2018 09:53:41 +0200
Subject: [RFC PATCH 09/11] asm-generic/tlb: Track which levels of the
 page tables have been cleared
In-Reply-To: <1535125966-7666-10-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-10-git-send-email-will.deacon@arm.com>
Message-ID: <20180827075341.GY24124@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 04:52:44PM +0100, Will Deacon wrote:
> +static inline unsigned long tlb_get_unmap_granule(struct mmu_gather *tlb)
> +{
> +	if (tlb->cleared_ptes)
> +		return PAGE_SIZE;
> +	if (tlb->cleared_pmds)
> +		return PMD_SIZE;
> +	if (tlb->cleared_puds)
> +		return PUD_SIZE;
> +	if (tlb->cleared_p4ds)
> +		return P4D_SIZE;
> +
> +	return PAGE_SIZE;
> +}

When doing the x86 patch; I found _SHIFT more useful than _SIZE.
