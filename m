From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 25 Nov 2014 17:27:24 +0000
Subject: [RFC PATCH 0/4] Genericise the IOVA allocator
Message-ID: <cover.1416931258.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've been implementing IOMMU DMA mapping for arm64, based on tidied-up
parts of the existing arch/arm/mm/dma-mapping.c with a clear divide
between the arch-specific parts and the general DMA-API to IOMMU-API layer
so that that can be shared; similar to what Ritesh started before and was
unable to complete[1], but working in the other direction.

The first part of that tidy-up involved ripping out the homebrewed IOVA
allocator and plumbing in iova.c, necessitating the changes presented here.
The rest is currently sat under arch/arm64 for the sake of getting it
working quickly with minimal impact - ideally I'd move it out and port
arch/arm before merging, but I don't know quite how impatient people are.
Regardless of that decision, this bit stands alone, so here it is.

Feel free to ignore patches 1 and 2, since I see Sakari has recently
posted a more thorough series for that[2], that frankly looks nicer ;)
I've merely left them in as context here.

[1]:http://thread.gmane.org/gmane.linux.ports.arm.kernel/331299
[2]:http://article.gmane.org/gmane.linux.kernel.iommu/7436

Robin Murphy (4):
  iommu: build iova.c for any IOMMU
  iommu: consolidate IOVA allocator code
  iommu: make IOVA domain low limit flexible
  iommu: make IOVA domain page size explicit

 drivers/iommu/Makefile      |  4 ++--
 drivers/iommu/intel-iommu.c | 45 ++++++++++-------------------------------
 drivers/iommu/iova.c        | 49 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/iova.h        | 41 +++++++++++++++++++++++++++++++++----
 4 files changed, 95 insertions(+), 44 deletions(-)

-- 
1.9.1
