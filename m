From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Jul 2015 17:53:16 +0100
Subject: [PATCH v3 3/4] arm64: Add IOMMU dma_ops
In-Reply-To: <55A689EA.8030306@arm.com>
References: <cover.1436552949.git.robin.murphy@arm.com>
 <a074dfeffc8c8168bef2668de2499f072fdcfac7.1436552949.git.robin.murphy@arm.com>
 <20150715093128.GA20186@e104818-lin.cambridge.arm.com>
 <55A689EA.8030306@arm.com>
Message-ID: <20150715165316.GG20186@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 05:27:22PM +0100, Robin Murphy wrote:
> On 15/07/15 10:31, Catalin Marinas wrote:
> >On Fri, Jul 10, 2015 at 08:19:34PM +0100, Robin Murphy wrote:
> >>+			if (iommu_dma_mapping_error(dev, *handle)) {
> >>+				if (coherent)
> >>+					__free_pages(page, get_order(size));
> >>+				else
> >>+					__free_from_pool(addr, size);
> >>+				addr = NULL;
> >>+			}
> >>+		}
> >>+	}
> >>+	return addr;
> >>+}
> >
> >In the second case here (!__GFP_WAIT), do we do any cache maintenance? I
> >can't see it and it's needed for the !coherent case.
> 
> In the atomic non-coherent case, we're stealing from the atomic pool, so
> addr is already a non-cacheable alias (and alloc_from_pool does memset(0)
> through that). That shouldn't need anything extra, right?

You are right, we already flushed the cache for the atomic pool when we
allocated it in atomic_pool_init().

-- 
Catalin
