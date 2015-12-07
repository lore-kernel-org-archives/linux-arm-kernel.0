From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Dec 2015 11:09:39 +0000
Subject: [PATCH 3/5] iommu/arm-smmu: Invalidate TLBs properly
In-Reply-To: <2acaea8656f14a4421d7d466dd242fe5a3d0f6f6.1449246988.git.robin.murphy@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
 <2acaea8656f14a4421d7d466dd242fe5a3d0f6f6.1449246988.git.robin.murphy@arm.com>
Message-ID: <20151207110939.GB23430@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 05:53:00PM +0000, Robin Murphy wrote:
> When invalidating an IOVA range potentially spanning multiple pages,
> such as when removing an entire intermediate-level table, we currently
> only issue an invalidation for the first IOVA of that range. Since the
> architecture specifies that address-based TLB maintenance operations
> target a single entry, an SMMU could feasibly retain live entries for
> subsequent pages within that unmapped range, which is not good.
> 
> Make sure we hit every possible entry by iterating over the whole range
> at the granularity provided by the pagetable implementation.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Can you do something similar for arm-smmu-v3.c as well, please?

Will
