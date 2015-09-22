From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 22 Sep 2015 17:23:16 +0100
Subject: [PATCH v2] iommu/io-pgtable-arm: Don't use dma_to_phys()
In-Reply-To: <1442928308.17514.3.camel@mhfsdcap03>
References: <59f4ebbf06e75a6176a366495211afd16d0048a3.1442507940.git.robin.murphy@arm.com>
 <1442566550.8145.156.camel@mhfsdcap03> <55FBEFBA.6000606@arm.com>
 <1442928308.17514.3.camel@mhfsdcap03>
Message-ID: <56018074.2010104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/15 14:25, Yong Wu wrote:
[...]
> About here:
>> @@ -629,6 +626,11 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg
> *cfg)
>>        if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
>>                return NULL;
>>   
>> +     if (cfg->iommu_dev->dma_pfn_offset) {
> 
> Do we need change to :
> 	if (!selftest_running && cfg->iommu_dev->dma_pfn_offset) {
> 
> cfg->iommu_dev will be null while self test.

Urgh, you're absolutely right. Must have been one of those days when I
had loads of noisy debug in there and turned the self-tests off :(

Will; since the branch hasn't gone anywhere yet, are you OK to take the below?

Robin.

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Date: Tue, 22 Sep 2015 14:52:27 +0100
Subject: [PATCH] fixup! iommu/io-pgtable-arm: Don't use dma_to_phys()

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 1f08ce7..2ba2323 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -628,7 +628,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
        if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
                return NULL;
 
-       if (cfg->iommu_dev->dma_pfn_offset) {
+       if (!selftest_running && cfg->iommu_dev->dma_pfn_offset) {
                dev_err(cfg->iommu_dev, "Cannot accommodate DMA offset for IOMMU page tables\n");
                return NULL;
        }
