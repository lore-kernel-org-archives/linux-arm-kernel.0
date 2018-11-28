From: Robert.Richter@cavium.com (Richter, Robert)
Date: Wed, 28 Nov 2018 14:47:19 +0000
Subject: [PATCH 0/2] irqchip/gic-v3-its: Use CMA for its table allocation
In-Reply-To: <20181115215012.23922-1-rrichter@cavium.com>
References: <20181115215012.23922-1-rrichter@cavium.com>
Message-ID: <20181128144712.GI4262@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.11.18 22:50:57, Richter, Robert wrote:
> The gicv3-its device table may have a size of up to 16MB (Cavium
> ThunderX). With 4k pagesize the maximum size of memory allocation is
> 4MB. This series implements the use of CMA for allocation of large its
> tables. To achieve this we need to make an its node a kernel device
> (patch #1) and rework the its table allocation code (patch #2). Both
> can only be done after the arch_initcall and thus this patch series
> bases on my previous series that implements late its initialization:
> 
>       https://patchwork.kernel.org/cover/10673117/

I just sent out v2 of that series:

 https://patchwork.kernel.org/cover/10702781/

This series should be still compatible.

Any comments to this series?

Thanks,

-Robert

> 
> Using its nodes as kernel devices has the side effect to ease the
> release of resources (devres used) and device based messages (dev_*
> printk variants used).
> 
> The new its table allocator still uses the old scheme for small tables
> to allow a further rework that supports NUMA-aware its tables.
> 
> Robert Richter (2):
>   irqchip/gic-v3-its: Handle its nodes as kernel devices
>   irqchip/gic-v3-its: Use CMA for allocation of large device tables
> 
>  drivers/irqchip/irq-gic-v3-its.c | 224 +++++++++++++++++++++++----------------
>  1 file changed, 135 insertions(+), 89 deletions(-)
> 
> -- 
> 2.11.0
> 
