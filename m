From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 17 Aug 2018 12:30:31 +0100
Subject: [PATCH 0/3] iommu: Avoid DMA ops domain refcount contention
In-Reply-To: <20180817072415.GA22241@infradead.org>
References: <cover.1534250425.git.robin.murphy@arm.com>
 <20180817072415.GA22241@infradead.org>
Message-ID: <74796f9d-5320-ea26-630a-207f4c537c55@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/08/18 08:24, Christoph Hellwig wrote:
> I plan to make the arm iommu dma ops generic and move them to
> drivers/iommu for the 4.20 merge window.

You mean 32-bit arm? The only place that code should move to is 
/dev/null ;) - the plan has always been to convert it to use groups and 
default domains so it can just plug iommu-dma in. The tricky bit is 
either weaning the users of the private arm_iommu_*() API onto generic 
IOMMU API usage, or at least implementing transitional wrappers in a way 
that doesn't break anything.

>  Because of that it would
> be great to create a stable branch or even pull this in through
> the dma-mapping tree entirely.

FWIW I might still need to tweak the first patch depending on how we 
choose to resolve the interaction between DMA ops and unmanaged 
domains[1] - if we want to add fallback paths to iommu-dma instead of 
swizzling device ops then the assumptions for this hook change and it 
will need to reference group->domain rather than group->default_domain.

Robin.


[1] 
https://www.mail-archive.com/dri-devel at lists.freedesktop.org/msg230275.html
