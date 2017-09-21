From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Sep 2017 16:26:39 +0200
Subject: [PATCH 3/4] iommu/arm-smmu-v3: Use NUMA memory allocations for
 stream tables and comamnd queues
In-Reply-To: <db28d6ff-77e5-ed59-c1b8-57c917564a68@arm.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
 <20170921085922.11659-4-ganapatrao.kulkarni@cavium.com>
 <db28d6ff-77e5-ed59-c1b8-57c917564a68@arm.com>
Message-ID: <20170921142639.GA18211@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 12:58:04PM +0100, Robin Murphy wrote:
> Christoph, Marek; how reasonable do you think it is to expect
> dma_alloc_coherent() to be inherently NUMA-aware on NUMA-capable
> systems? SWIOTLB looks fairly straightforward to fix up (for the simple
> allocation case; I'm not sure it's even worth it for bounce-buffering),
> but the likes of CMA might be a little trickier...

I think allocating data node local to dev is a good default.  I'm not
sure if we'd still need a version that takes an explicit node, though.

On the one hand devices like NVMe or RDMA nics have queues that are
assigned to specific cpus and thus have an inherent affinity to given
nodes.  On the other hand we'd still need to access the PCIe device,
so for it to make sense we'd need to access the dma memory a lot more
from the host than from the device, and I'm not sure if we ever have
devices where that is the case (which would not be optimal to start
with).
