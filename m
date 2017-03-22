From: nwatters@codeaurora.org (Nate Watterson)
Date: Wed, 22 Mar 2017 13:43:16 -0400
Subject: [PATCH 0/3] IOVA allocation improvements for iommu-dma
In-Reply-To: <cover.1489581865.git.robin.murphy@arm.com>
References: <cover.1489581865.git.robin.murphy@arm.com>
Message-ID: <b665e8511ef524fce0c7cc00b7920cba@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-03-15 09:33, Robin Murphy wrote:
> Hi all,
Hi Robin,
> 
> Here's the first bit of lock contention removal to chew on - feedback
> welcome! Note that for the current users of the io-pgtable framework,
> this is most likely to simply push more contention onto the io-pgtable
> lock, so may not show a great improvement alone. Will and I both have
> rough proof-of-concept implementations of lock-free io-pgtable code
> which we need to sit down and agree on at some point, hopefullt fairly
> soon.
> 
> I've taken the opportunity to do a bit of cleanup and refactoring
> within the series to make the final state of the code nicer, but the
> diffstat still turns out surprisingly reasonable in the end - it would
> actually be negative but for the new comments!
> 
> Magnus, Shimoda-san, the first two patches should be of interest as 
> they
> constitute the allocation rework I mentioned a while back[1] - if you
> still need to implement that scary workaround, this should make it
> simple to hook IPMMU-specific calls into the alloc and free paths, and
> let the driver take care of the details internally.

I've tested your patches on a QDF2400 platform and generally
see modest improvements in iperf/fio performance. As you
suspected would happen, contention has indeed moved to the
io-pgtable lock. I am looking forward to testing with the
lock-free io-pgtable implementation, however I suspect that
there will still be contention issues acquiring the (SMMUv3)
cmdq lock on the unmap path.

Reviewed/Tested-by: Nate Watterson <nwatters@codeaurora.org>
> 
> Robin.
> 
> [1]:https://lists.linuxfoundation.org/pipermail/iommu/2017-January/020189.html
> 
> Robin Murphy (3):
>   iommu/dma: Convert to address-based allocation
>   iommu/dma: Clean up MSI IOVA allocation
>   iommu/dma: Plumb in the per-CPU IOVA caches
> 
>  drivers/iommu/dma-iommu.c | 176 
> ++++++++++++++++++++++++----------------------
>  1 file changed, 90 insertions(+), 86 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux
Foundation Collaborative Project.
