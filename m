From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Jun 2016 13:08:29 +0100
Subject: [PATCH] arm64: mm: only initialize swiotlb when necessary
In-Reply-To: <1465372426-4077-1-git-send-email-jszhang@marvell.com>
References: <1465372426-4077-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160608120829.GB16322@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 03:53:46PM +0800, Jisheng Zhang wrote:
>  static int __init arm64_dma_init(void)
>  {
> +	if (swiotlb_force || max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
> +		swiotlb = 1;
> +
>  	return atomic_pool_init();
>  }

So any platform with RAM larger than 4GB would still initialise swiotlb.
I wouldn't say it's an issue, 64MB is not a significant loss on such
systems.

An alternative would be to defer the freeing until we are aware of all
possible dma masks for the populated devices (e.g. from DT), though I'm
not sure that's enough, drivers may try to change such masks when
probed.

-- 
Catalin
