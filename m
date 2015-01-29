From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 30 Jan 2015 09:58:45 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm-current tree
Message-ID: <20150130095845.260bd804@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mm/dma-mapping.c between commit c2273a185354 ("ARM: 8288/1:
dma-mapping: don't detach devices without an IOMMU during teardown")
from the arm-current tree and commit eab8d6530cc0 ("arm: dma-mapping:
Set DMA IOMMU ops in arm_iommu_attach_device()") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mm/dma-mapping.c
index f142ddd6c40a,a673c7f7e208..000000000000
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@@ -2025,10 -2048,7 +2048,10 @@@ static void arm_teardown_iommu_dma_ops(
  {
  	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
  
 +	if (!mapping)
 +		return;
 +
- 	arm_iommu_detach_device(dev);
+ 	__arm_iommu_detach_device(dev);
  	arm_iommu_release_mapping(mapping);
  }
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/ec7a8154/attachment.sig>
