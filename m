From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 15 Mar 2017 13:33:13 +0000
Subject: [PATCH 0/3] IOVA allocation improvements for iommu-dma
Message-ID: <cover.1489581865.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's the first bit of lock contention removal to chew on - feedback
welcome! Note that for the current users of the io-pgtable framework,
this is most likely to simply push more contention onto the io-pgtable
lock, so may not show a great improvement alone. Will and I both have
rough proof-of-concept implementations of lock-free io-pgtable code
which we need to sit down and agree on at some point, hopefullt fairly
soon.

I've taken the opportunity to do a bit of cleanup and refactoring
within the series to make the final state of the code nicer, but the
diffstat still turns out surprisingly reasonable in the end - it would
actually be negative but for the new comments!

Magnus, Shimoda-san, the first two patches should be of interest as they
constitute the allocation rework I mentioned a while back[1] - if you
still need to implement that scary workaround, this should make it
simple to hook IPMMU-specific calls into the alloc and free paths, and
let the driver take care of the details internally.

Robin.

[1]:https://lists.linuxfoundation.org/pipermail/iommu/2017-January/020189.html

Robin Murphy (3):
  iommu/dma: Convert to address-based allocation
  iommu/dma: Clean up MSI IOVA allocation
  iommu/dma: Plumb in the per-CPU IOVA caches

 drivers/iommu/dma-iommu.c | 176 ++++++++++++++++++++++++----------------------
 1 file changed, 90 insertions(+), 86 deletions(-)

-- 
2.11.0.dirty
